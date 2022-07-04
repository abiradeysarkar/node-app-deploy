@Library('github.com/releaseworks/jenkinslib') _

pipeline {
    agent worker
    environment {
        registry = "381372271377.dkr.ecr.us-east-1.amazonaws.com/assignment-jenkins"
    }

    stages {
        stage('Cloning Git') {
            steps {
                dir('node-application')
                sh "git clone https://github.com/abiradeysarkar/Node-app-assignment.git"
            }
        }

    // Building Docker images
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry
        }
      }
    }

    // Uploading Docker images into AWS ECR
    stage('Pushing to ECR') {
        steps{
            script {
                sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 381372271377.dkr.ecr.us-east-1.amazonaws.com'
                sh 'docker push 381372271377.dkr.ecr.us-east-1.amazonaws.com/assignment-jenkins:latest'
            }
        }
    }

    stage('Deploy App'){

        sh ''' cd 
        ssh -i "AWS-upgrad.pem" ubuntu@10.0.2.185

        echo '---------------------------------------- Pre-Deploy-steps-----------------------------------'
        // Remove running containers and images
        docker rmi -f $(docker images -aq)
        docker rm -vf $(docker ps -aq)
        echo '----------------------------------------- Pre-Deploy-steps-Completed------------------------------------'
        sudo docker run -d -p 80:8081 --rm --name application 381372271377.dkr.ecr.us-east-1.amazonaws.com/assignment-jenkins:latest '''
    }

    stage('Post Actions'){
        cleanWs()
    }
    }
}