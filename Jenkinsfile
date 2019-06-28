#!/usr/bin/env groovy
@Library('sd')_
def kubeLabel = getKubeLabel()

def build_image(image, tag){
    container(name: 'runner', shell: '/busybox/sh') {
        dir (image) {
            sh '''#!/busybox/sh
            kaniko-build.sh
            '''
        }
    }
}

pipeline {
  agent {
      kubernetes {
          label "${kubeLabel}"
          cloud 'Kube mwdevel'
          defaultContainer 'runner'
          inheritFrom 'kaniko-template'
      }
  }
  
  triggers { cron('@daily') }

  options {
    timeout(time: 2, unit: 'HOURS')
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  
  environment {
    DOCKER_REGISTRY_HOST = "${env.DOCKER_REGISTRY_HOST}"
  }
  
  stages {
    stage('prepare'){
      steps {
        stash name: "source"
      }
    }
    
    stage('build images'){
      steps {
        parallel(
//          "jnlp-slave"  : { build_image("docker/jnlp-slave", "latest") },
//          "centos7-runner"  : { build_image("docker/centos7-runner", "latest") },
          "test"  : { build_image("docker/test", "latest") },
//          "kube-ubuntu-runner"  : { build_image("docker/kube-ubuntu-runner", "16.04") }
          )
      }
    }
  }
  
  post{
    failure {
      slackSend color: 'danger', message: "${env.JOB_NAME} - #${env.BUILD_NUMBER} Failure (<${env.BUILD_URL}|Open>)"
    }
    
    changed {
      script{
        if('SUCCESS'.equals(currentBuild.currentResult)) {
          slackSend color: 'good', message: "${env.JOB_NAME} - #${env.BUILD_NUMBER} Back to normal (<${env.BUILD_URL}|Open>)"
        }
      }
    }
  }
}
