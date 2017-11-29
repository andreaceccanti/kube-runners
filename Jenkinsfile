#!/usr/bin/env groovy

def build_image(image, tag){
  node('docker'){
    deleteDir()
    unstash "source"

    dir("${image}"){
      withEnv(["TAG=${tag}"]){
        sh "./build-image.sh"
        sh "./push-image.sh"
      }
    }
  }
}

pipeline {
  agent none
  
  options {
    timeout(time: 2, unit: 'HOURS')
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  
  parameters {
    string(name: 'JNLP_VERSION', defaultValue: '3.7', description: '' )
    string(name: 'DOCKER_GID', defaultValue: '994', description: 'Docker group ID' )
  }
  
  environment {
    JNLP_VERSION = "${params.JNLP_VERSION}"
    DOCKER_GID = "${params.DOCKER_GID}"
  }
  
  stages {
    stage('prepare'){
      agent { label 'generic' }
      steps {
        deleteDir()
        checkout scm
        stash name: "source"
      }
    }
    
    stage('build images'){
      steps {
        parallel(
//          "kube-centos6-umd3-runner" : { build_image("kube-centos6-umd3-runner", "latest") },
//          "kube-centos6-umd4-runner" : { build_image("kube-centos6-umd4-runner", "latest") },
          "kube-generic-runner" : { build_image("kube-generic-runner", "latest") },
          "kube-docker-runner"  : { build_image("kube-docker-runner", "latest") },
          "kube-kubectl-runner" : { build_image("kube-kubectl-runner", "1.8.4") },
          "kube-maven-runner"   : { build_image("kube-maven-runner", "latest") },
          "kube-ubuntu-runner"  : { build_image("kube-ubuntu-runner", "16.04") },
          )
      }
    }
    
    stage('result'){
      steps {
        script { currentBuild.result = 'SUCCESS' }
      }
    }
  }
  
  post{
    failure {
      slackSend color: 'danger', message: "${env.JOB_NAME} - #${env.BUILD_NUMBER} Failure (<${env.BUILD_URL}|Open>)"
    }
    
    changed {
      script{
        if('SUCCESS'.equals(currentBuild.result)) {
          slackSend color: 'good', message: "${env.JOB_NAME} - #${env.BUILD_NUMBER} Back to normal (<${env.BUILD_URL}|Open>)"
        }
      }
    }
  }
}
