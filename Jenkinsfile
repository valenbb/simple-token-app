pipeline {
    agent { dockerfile true }
    stages {
        stage ('Test Web App with no PING_TOKEN') {
            steps {
                script {
                    def PING_STATUS = sh (
                        script: 'curl -k http://127.0.0.1:5000',
                        returnStdout: true
                    ).trim()
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
                        script: 'export PING_TOKEN=invalid_token; curl -k http://127.0.0.1:5000',
                        returnStdout: true
                    ).trim()
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
                        def PING_STATUS = sh (
                            script: 'curl -k http://127.0.0.1:5000',
                            returnStdout: true
                        ).trim()
                        if (PING_STATUS != 'Network Active' || PING_STATUS != 'Network Error') {
                            sh 'exit 1'
                        }
                    }
                }
            }
        }
    }
}