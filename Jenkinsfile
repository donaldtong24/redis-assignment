pipeline {
    agent any

    environment {
        AWS_REGION   = 'us-east-1'
        ECR_REGISTRY = '574246332259.dkr.ecr.us-east-1.amazonaws.com'
        ECR_REPO     = 'redis-assignment/python-api'
        IMAGE_TAG    = "build-${env.BUILD_NUMBER}-${env.GIT_COMMIT.take(7)}"
        GIT_SSH_COMMAND = "ssh -i /var/jenkins_home/.ssh/id_ed25519 -o UserKnownHostsFile=/var/jenkins_home/.ssh/known_hosts -o IdentitiesOnly=yes"
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

        // This stage only ever edits Git - it never runs kubectl/helm against the
        // cluster. Argo CD (Stage 20) is the only thing that talks to the cluster,
        // and it does so by watching this same repo, not by watching Jenkins.
        stage('Promote') {
            steps {
                sh '''
                    git config user.email "jenkins@redis-assignment"
                    git config user.name "Jenkins CI"
                    sed -i "s#tag: .*#tag: ${IMAGE_TAG}#" helm/redis-assignment/values-eks.yaml
                    git add helm/redis-assignment/values-eks.yaml
                    git diff --cached --quiet && echo "no change to promote" && exit 0
                    git commit -m "Promote python-api to ${IMAGE_TAG} [ci skip]"
                    git push origin HEAD:main
                '''
            }
        }
    }

    post {
        success {
            echo "Pushed ${ECR_REGISTRY}/${ECR_REPO}:${IMAGE_TAG} and promoted values-eks.yaml - Argo CD (once installed) picks this up from Git."
        }
        failure {
            echo "Build ${env.BUILD_NUMBER} failed at stage: ${env.STAGE_NAME}"
        }
        always {
            sh "docker rmi ${ECR_REPO}:${IMAGE_TAG} ${ECR_REGISTRY}/${ECR_REPO}:${IMAGE_TAG} || true"
        }
    }
}
