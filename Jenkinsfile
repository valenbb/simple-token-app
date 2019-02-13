pipeline {
    agent any

    stages {
        stage ('Build Test Container') {
            steps {
                withCredentials([conjurSecretCredential(credentialsId: 'sta-token', variable: 'VALID_TOKEN')]) {
                    sh 'docker build -t sta:test .'
                    sh 'docker run --name sta_notoken -d -p 5001:5000 sta:test'
                    sh 'docker run --name sta_invalidtoken -e PING_TOKEN=notValid -d -p 5002:5000 sta:test'
                    sh 'docker run --name sta_validtoken -d -e PING_TOKEN=${VALID_TOKEN} -p 5003:5000 sta:test'
                }
            }
        }
        stage ('Test Web App with no PING_TOKEN') {
            steps {
                script {
                    def PING_STATUS = sh (
                        script: 'docker exec -t sta_notoken curl http://localhost:5001',
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
                        script: 'docker exec -t sta_invalidtoken curl http://localhost:5002',
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
                        script: 'docker exec -t sta_validtoken curl http://localhost:5003',
                        returnStdout: true
                    ).trim()
                    echo "The Status Code returned is: ${PING_STATUS}"
                    if (PING_STATUS != 'Network Active' || PING_STATUS != 'Network Error') {
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