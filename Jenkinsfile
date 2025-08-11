pipeline {
    agent any

    parameters {
        choice(name: 'ENVIRONMENT', choices: ['dev', 'test'], description: 'Select environment')
    }

    environment {
        IMAGE_NAME = "myusername/myapp"  // Change to your Docker Hub repo
        IMAGE_TAG = "${params.ENVIRONMENT}"
        CONTAINER = "myapp_${params.ENVIRONMENT}"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                sh "docker build --build-arg ENV=${params.ENVIRONMENT} -t ${IMAGE_NAME}:${IMAGE_TAG} ${WORKSPACE}"
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh "./push_image.sh ${IMAGE_NAME} ${IMAGE_TAG} $DOCKER_USERNAME $DOCKER_PASSWORD"
                }
            }
        }

        stage('Stop Old Container') {
            steps {
                sh "docker rm -f ${CONTAINER} || true"
            }
        }

        stage('Run Container') {
            steps {
                script {
                    def port = params.ENVIRONMENT == 'dev' ? '8080:80' : '9090:80'
                    sh "docker run -d --name ${CONTAINER} -p ${port} ${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }
    }
}
