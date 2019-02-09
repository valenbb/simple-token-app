pipeline {
    agent any

    stages {
        stage ('Install Pyhton Requirements') {
            steps {
                sh 'pip install -r requirements.txt'
            }
        }
        stage ('Test Web App with no PING_TOKEN') {
            steps {
                sh 'python main.py'
                PING_STATUS = sh (
                        script: 'curl -k http://127.0.0.1:5000',
                        returnStdout: true
                    ).trim()
                if (PING_STATUS != 'Unauthorized Request') {
                    sh 'exit 1'
                }
            }
        }
        stage ('Test Web App with invalid PING_TOKEN') {
            steps {
                sh 'python main.py'
                PING_STATUS = sh (
                    script: 'export PING_TOKEN=invalid_token; curl -k http://127.0.0.1:5000',
                    returnStdout: true
                ).trim()
                if (PING_STATUS != 'Unauthorized Request') {
                    sh 'exit 1'
                }
            }
        }
        stage ('Test Web App with valid PING_TOKEN from CyberArk') {
            steps {
                withCredentials([conjurSecretCredential(credentialsId: 'sta-token', variable: 'PING_TOKEN')]) {
                    sh 'python main.py'
                    PING_STATUS = sh (
                        script: 'curl -k http://127.0.0.1:5000',
                        returnStdout: true
                    ).trim()
                    if (PING_STATUS != 'Network Active') {
                        sh 'exit 1'
                    }
                }
            }
        }
    }
}