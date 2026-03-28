pipeline {
    agent { label 'docker-maven-trivy' }
    tools {
        maven 'maven3'
    }
    environment {
        SONAR_IP = '172.31.1.48'
        ECR_REGISTRY = '764763463632.dkr.ecr.eu-central-1.amazonaws.com'
    }
    stages {
        stage('Trivy FS Scan') {
            steps {
                sh 'trivy fs --exit-code 1 --severity HIGH,CRITICAL .'
            }
        }
        stage('Build & Sonar') {
            steps {
                withCredentials([string(credentialsId: 'sonarqube-token', variable: 'SONAR_TOKEN')]) {
                    sh 'mvn clean verify sonar:sonar \
                        -Dsonar.projectKey=devsecops-demo \
                        -Dsonar.host.url="http://${SONAR_IP}:9000" \
                        -Dsonar.token="${SONAR_TOKEN}" \
                        -Dsonar.qualitygate.wait=true'
                }
            }
        }
        stage('ECR Login') {
            steps {
                sh 'aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin $ECR_REGISTRY'
            }
        }
    }
}