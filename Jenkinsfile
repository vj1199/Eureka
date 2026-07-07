pipeline {
    // This allows Jenkins to run on any available node/agent
    agent any

    environment {
        // Defining variables for your Docker image and container
        IMAGE_NAME = "eureka-server-image"
        CONTAINER_NAME = "eureka-server-container"
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Jenkins pulls the latest code from your GitHub main branch
                checkout scm
            }
        }

        stage('Build Spring Boot App') {
            steps {
                // Make the Maven wrapper executable
                sh 'chmod +x mvnw'
                
                // Use the wrapper to build the project
                sh './mvnw clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Uses the Dockerfile you pushed earlier to build the image
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Run Docker Container') {
            steps {
                // Stops and removes any old container running the Eureka server
                sh """
                    docker stop ${CONTAINER_NAME} || true
                    docker rm ${CONTAINER_NAME} || true
                """
                
                // Starts the new container on port 8761
                sh "docker run -d --name ${CONTAINER_NAME} -p 8761:8761 ${IMAGE_NAME}"
            }
        }
    }
}