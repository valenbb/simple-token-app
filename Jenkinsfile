pipeline {
    agent any

    stages {
        stage ('Build Test Container') {
            steps {
                withCredentials([conjurSecretCredential(credentialsId: 'sta-token', variable: 'VALID_TOKEN')]) {
                    sh 'docker build -t sta:test .'
                    sh 'docker run --name sta_notoken -d sta:test'
                    sh 'docker run --name sta_invalidtoken -d -e PING_TOKEN=notValid sta:test'
                    sh 'docker run --name sta_validtoken -d -e PING_TOKEN=${VALID_TOKEN} sta:test'
                }
            }
        }
        stage ('Test Web App with no PING_TOKEN') {
            steps {
                script {
                    def PING_STATUS = sh (
                        script: 'docker exec -t sta_notoken curl http://localhost:5000',
                        returnStdout: true
                    ).trim()
                    echo "The Status Code returned is: ${PING_STATUS}"
                    if (PING_STATUS != 'Unauthorized Request') {
                        sh 'exit 1'
                    }
                }
            }
        }
        stage ('Test Web App with invalid PING_TOKEN') {
            steps {
                script {
                    def PING_STATUS = sh (
                        script: 'docker exec -t sta_invalidtoken curl http://localhost:5000',
                        returnStdout: true
                    ).trim()
                    echo "The Status Code returned is: ${PING_STATUS}"
                    if (PING_STATUS != 'Unauthorized Request') {
                        sh 'exit 1'
                    }
                }
            }
        }
        stage ('Test Web App with valid PING_TOKEN from CyberArk') {
            steps {
                script {
                    def PING_STATUS = sh (
                        script: 'docker exec -t sta_validtoken curl http://localhost:5000',
                        returnStdout: true
                    ).trim()
                    echo "The Status Code returned is: ${PING_STATUS}"
                    if (PING_STATUS != 'Network Active' && PING_STATUS != 'Network Error') {
                        sh 'exit 1'
                    }
                }
            }
        }
    }
    post {
        always {
            sh '''
                docker rm -f sta_notoken sta_invalidtoken sta_validtoken
                docker rmi sta:test
            '''
            deleteDir()
        }
    }
}