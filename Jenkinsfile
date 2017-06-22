pipeline {
  agent { label 'docker' }
  
  options {
    timeout(time: 2, unit: 'HOURS')
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  
  parameters {
    string(name: 'JNLP_VERSION', defaultValue: '3.7', description: '' )
  }
  
  triggers {
    cron('@daily')
  }
  
  stages {
    stage('prepare'){
      steps {
        checkout scm
        stash name: "source", include: "./*"
      }
    }
    
    stage('build images'){
      steps {
        parallel(
          "kube-generic-runner" : {
            node('docker'){
              unstash "source"
              dir('kube-generic-runner'){
                withEnv([
                  "TAG=latest",
                  "JNLP_VERSION=${params.JNLP_VERSION}"
                ]){
                  sh "./build-image.sh"
                  sh "./push-image.sh"
                }
              }
            }
          },
          "kube-docker-runner"  : { 
            node('docker'){
              unstash "source"
              dir('kube-docker-runner'){
                withEnv([
                  "TAG=latest",
                  "JNLP_VERSION=${params.JNLP_VERSION}"
                ]){
                  sh "./build-image.sh"
                  sh "./push-image.sh"
                }
              }
            }
          },
          "kube-kubectl-runner" : { 
            node('docker'){
              unstash "source"
              dir('kube-kubectl-runner'){
                withEnv([
                  "TAG=1.6.4",
                  "JNLP_VERSION=${params.JNLP_VERSION}"
                ]){
                  sh "./build-image.sh"
                  sh "./push-image.sh"
                }
              }
            }
          },
          "kube-maven-runner"   : { 
            node('docker'){
              unstash "source"
              dir('kube-maven-runner'){
                withEnv([
                  "TAG=latest",
                  "JNLP_VERSION=${params.JNLP_VERSION}"
                ]){
                  sh "./build-image.sh"
                  sh "./push-image.sh"
                }
              }
            }
          },
          "kube-ubuntu-runner"  : { 
            node('docker'){
              unstash "source"
              dir('kube-ubuntu-runner'){
                withEnv([
                  "TAG=16.04",
                  "JNLP_VERSION=${params.JNLP_VERSION}"
                ]){
                  sh "./build-image.sh"
                  sh "./push-image.sh"
                }
              }
            }
          },
          )
      }
    }
  }
  
  post{
    always {
      deleteDir()  
    }
    
    failure {
      slackSend color: 'danger', message: "${env.JOB_NAME} - #${env.BUILD_NUMBER} Failure (<${env.BUILD_URL}|Open>)"
    }
  }
}


