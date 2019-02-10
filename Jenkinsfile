pipeline {
    agent any

    stages {
        stage ('Install Python Requirements') {
            steps {
                step ('Install requirements.txt') {
                    sh 'pip install -r requirements.txt'
                }
            }
        }
        stage ('Test Web App with no PING_TOKEN') {
            steps {
                step ('Run Flask Web App') {
                    sh 'python main.py'
                }
                step ('cURL to Flask Web App for Status') {
                    PING_STATUS = sh (
                        script: 'curl -k http://127.0.0.1:5000',
                        returnStdout: true
                    ).trim()
                }
                step ('Confirm Unauthorized Request') {
                    if (PING_STATUS != 'Unauthorized Request') {
                        sh 'exit 1'
                    }
                }
            }
        }
        stage ('Test Web App with invalid PING_TOKEN') {
            steps {
                step ('Run Flask Web App') {
                    sh 'python main.py'
                }
                step ('cURL to Flask Web App for Status') {
                    PING_STATUS = sh (
                        script: 'export PING_TOKEN=invalid_token; curl -k http://127.0.0.1:5000',
                        returnStdout: true
                    ).trim()
                }
                step ('Confirm Unauthorized Request') {
                    if (PING_STATUS != 'Unauthorized Request') {
                        sh 'exit 1'
                    }
                }
            }
        }
        stage ('Test Web App with valid PING_TOKEN from CyberArk') {
            steps {
                step ('Run Flask Web App') {
                    sh 'python main.py'
                }
                step ('cURL to Flask Web App for Status') {
                    withCredentials([conjurSecretCredential(credentialsId: 'sta-token', variable: 'PING_TOKEN')]) {
                        PING_STATUS = sh (
                            script: 'curl -k http://127.0.0.1:5000',
                            returnStdout: true
                        ).trim()
                    }
                }
                step ('Confirm Network Active or Network Disabled') {
                    if (PING_STATUS != 'Network Active' || PING_STATUS != 'Network Error') {
                        sh 'exit 1'
                    }
                }
            }
        }
        stage ('Clean Up Requirements') {
            steps {
                step ('Remove requirements.txt') {
                    sh 'pip uninstall -r requirements.txt'
                }
            }
        }
    }
}