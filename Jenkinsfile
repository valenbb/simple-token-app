def STA_IP
def HTTP_ADDRESS

pipeline {
    agent any

    stages {
        stage ('Build Test Container') {
            steps {
                sh '''
                    docker build -t sta:test .
                    docker run --name sta -d -p 5000:5000 sta:test
                '''
                script {
                    STA_IP = sh (
                        script: 'docker inspect -f \'{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}\' sta',
                        returnStdout: true
                    ).trim()
                }
                echo "The IP Address is: ${STA_IP}"
                HTTP_ADDRESS = "http://${STA_IP}:5000"
            }
        }
        stage ('Test Web App with no PING_TOKEN') {
            steps {
                script {
                    echo "The URL is: ${HTTP_ADDRESS}"
                    def PING_STATUS = sh (
                        script: 'curl -I ${HTTP_ADDRESS} 2>/dev/null | head -n 1 | cut -d$\' \' -f2',
                        returnStdout: true
                    ).trim()
                    echo "The Status Code returned is: ${PING_STATUS}"
                    if (PING_STATUS != '200') {
                        sh 'exit 1'
                    }
                }
            }
        }
        /*
        stage ('Test Web App with invalid PING_TOKEN') {
            environment {
                    PING_TOKEN = 'notCyberark1'
            }
            steps {
                script {
                    def PING_STATUS = httpRequest 'http://${STA_IP}:5000'
                    echo "${PING_STATUS.content}"
                    if (PING_STATUS.content != 'Unauthorized Request') {
                        sh 'exit 1'
                    }
                }
            }
        }
        stage ('Test Web App with valid PING_TOKEN from CyberArk') {
            steps {
                withCredentials([conjurSecretCredential(credentialsId: 'sta-token', variable: 'PING_TOKEN')]) {
                    script {
                        def PING_STATUS = httpRequest 'http://${STA_IP}:5000'
                        echo "${PING_STATUS.content}"
                        if (PING_STATUS.content != 'Network Active' || PING_STATUS.content != 'Network Error') {
                            sh 'exit 1'
                        }
                    }
                }
            }
        }
        */
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