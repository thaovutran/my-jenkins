pipeline {
    agent any

    parameters {
        string(name: 'EnvType', defaultValue: 'Dev')
        string(name: 'EnvName', defaultValue: 'myEnv')
    }

    environment {
        BRANCH_NAME='master'
    }

    options {
        buildDiscarder(logRotator(numToKeepStr: '35', artifactNumToKeepStr: '5'))
    }

    stages {
        stage('Set name') {
            steps {
                script {
                    try {
                        currentBuild.displayName = "${currentBuild.number}_${params.EnvType}-${params.EnvName}"
                        println "The build job name is: ${currentBuild.displayName}"
                    } catch(e) {
                        log.error "Could not set build display name ${e}"
                    }
                }
            }
        }
        stage('Run date') {
            steps {
                sh '''
                    date
                '''
            }
        }
        stage('Run loop') {
            steps {
                sh """#!/bin/bash
                    for h in {1..10}; do date ; echo ; sleep 5; done
                """
            }
        }
    }

    post {
        always {
            echo 'I will always say Hello again!'
        }
    }
}