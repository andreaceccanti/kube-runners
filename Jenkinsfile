#!/usr/bin/env groovy

def build_image(image, tag){
  node('docker'){
    container('runner'){
      unstash "source"

      dir("${image}"){
        sh "TAG=${tag} sh build-image.sh"
        sh "TAG=${tag} sh push-image.sh"
      }
    }
  }
}

pipeline {
  agent none
  
  triggers { cron('@daily') }

  options {
    timeout(time: 2, unit: 'HOURS')
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  
  parameters {
    string(name: 'DOCKER_GID', defaultValue: '992', description: 'Docker group ID' )
  }
  
  environment {
    DOCKER_GID = "${params.DOCKER_GID}"
    DOCKER_REGISTRY_HOST = "${env.DOCKER_REGISTRY_HOST}"
  }
  
  stages {
    stage('prepare'){
      agent { label 'generic' }
      steps {
        stash name: "source"
      }
    }
    
    stage('build images'){
      steps {
        parallel(
          "kube-ubuntu-runner"  : { build_image("kube-ubuntu-runner", "16.04") },
          "centos7-runner"  : { build_image("centos7-runner", "latest") },
          "jnlp-slave"  : { build_image("jnlp-slave", "latest") },
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
