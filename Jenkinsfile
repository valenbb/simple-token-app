pipeline {
    agent any

    stages {
        stage ('Build Test Container') {
            steps {
                sh '''
                    docker build -t sta:test .
                    docker run --name sta -d -p 5000:5000 sta:test
                '''
            }
        }
        stage ('Test Web App with no PING_TOKEN') {
            steps {
                script {
                    def PING_STATUS = httpRequest 'http://localhost:5000'
                    if (PING_STATUS != 'Unauthorized Request') {
                        sh 'exit 1'
                    }
                }
            }
        }
        stage ('Test Web App with invalid PING_TOKEN') {
            environment {
                    PING_TOKEN = 'notCyberark1'
            }
            steps {
                script {
                    def PING_STATUS = httpRequest 'http://localhost:5000'
                    if (PING_STATUS != 'Unauthorized Request') {
                        sh 'exit 1'
                    }
                }
            }
        }
        stage ('Test Web App with valid PING_TOKEN from CyberArk') {
            steps {
                withCredentials([conjurSecretCredential(credentialsId: 'sta-token', variable: 'PING_TOKEN')]) {
                    script {
                        def PING_STATUS = httpRequest 'http://localhost:5000'
                        if (PING_STATUS != 'Network Active' || PING_STATUS != 'Network Error') {
                            sh 'exit 1'
                        }
                    }
                }
            }
        }
    }
    post {
        always {
            sh '''
                docker rm -f sta
                docker rmi sta:test
            '''
            deleteDir()
        }
    }
}