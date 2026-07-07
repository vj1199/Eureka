pipeline {
    agent any

    // This block tells Jenkins to inject the Maven tool we just configured
    tools {
        maven 'maven3' 
    }

    environment {
        IMAGE_NAME = "eureka-server-image"
        CONTAINER_NAME = "eureka-server-container"
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Spring Boot App') {
            steps {
                // We are back to using the standard mvn command!
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Run Docker Container') {
            steps {
                sh """
                    docker stop ${CONTAINER_NAME} || true
                    docker rm ${CONTAINER_NAME} || true
                """
                sh "docker run -d --name ${CONTAINER_NAME} -p 8761:8761 ${IMAGE_NAME}"
            }
        }
    }
}