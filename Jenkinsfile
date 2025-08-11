pipeline {
    agent any
    parameters {
        choice(name: 'ENVIRONMENT', choices: ['dev', 'test'], description: 'Select environment')
    }
    environment {
        IMAGE = "myapp:${params.ENVIRONMENT}"
        CONTAINER = "myapp_${params.ENVIRONMENT}"
    }
    stages {
        stage('Build Docker Image') {
            steps {
                sh "docker build --build-arg ENV=${params.ENVIRONMENT} -t ${IMAGE} ${WORKSPACE}"
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
                    def port = params.ENVIRONMENT == 'dev' ? '8081:80' : '9090:80'
                    sh "docker run -d --name ${CONTAINER} -p ${port} ${IMAGE}"
                }
            }
        }
    }
}
