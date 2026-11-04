pipeline {
    agent any

    environment {
        AWS_REGION   = 'us-east-1'
        ECR_REGISTRY = '574246332259.dkr.ecr.us-east-1.amazonaws.com'
        ECR_REPO     = 'redis-assignment/python-api'
        IMAGE_TAG    = "build-${env.BUILD_NUMBER}-${env.GIT_COMMIT.take(7)}"
    }

    stages {
        stage('Test') {
            steps {
                sh '''
                    python3 -m venv .venv
                    . .venv/bin/activate
                    pip install -q -r requirements-dev.txt
                    pytest tests/ -v
                '''
            }
        }

        stage('Build') {
            steps {
                sh "docker build -t ${ECR_REPO}:${IMAGE_TAG} ."
            }
        }

        stage('Scan') {
            steps {
                sh "trivy image --exit-code 1 --severity CRITICAL,HIGH --ignore-unfixed ${ECR_REPO}:${IMAGE_TAG}"
            }
        }

        stage('Push to ECR') {
            steps {
                sh '''
                    aws ecr get-login-password --region ${AWS_REGION} | \
                        docker login --username AWS --password-stdin ${ECR_REGISTRY}
                    docker tag ${ECR_REPO}:${IMAGE_TAG} ${ECR_REGISTRY}/${ECR_REPO}:${IMAGE_TAG}
                    docker push ${ECR_REGISTRY}/${ECR_REPO}:${IMAGE_TAG}
                '''
            }
        }
    }

    post {
        success {
            echo "Pushed ${ECR_REGISTRY}/${ECR_REPO}:${IMAGE_TAG} - ready for the manifest-promotion pipeline to pick up."
        }
        failure {
            echo "Build ${env.BUILD_NUMBER} failed at stage: ${env.STAGE_NAME}"
        }
        always {
            sh "docker rmi ${ECR_REPO}:${IMAGE_TAG} ${ECR_REGISTRY}/${ECR_REPO}:${IMAGE_TAG} || true"
        }
    }
}
