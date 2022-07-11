@Library('github.com/releaseworks/jenkinslib') _

pipeline {
    agent { label 'worker' }
    environment {
        registry = "381372271377.dkr.ecr.us-east-1.amazonaws.com/assignment-jenkins"
        SSH_KEY_FILE = credentials('worker')
    }

    stages {
        stage('Cloning Git') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/abiradeysarkar/node-app-deploy.git']]])
            }
        }

    // Building Docker images
    stage('Building image') {
      steps{
        script {
            dir('/home/ubuntu/workspace/node-app-assignment/node-application') {
                sh 'docker build -t node-app .'
            }
        }
      }
    }

    // Uploading Docker images into AWS ECR
    stage('Pushing to ECR') {
        steps{
            script {
                sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 381372271377.dkr.ecr.us-east-1.amazonaws.com'
                sh 'docker tag node-app 381372271377.dkr.ecr.us-east-1.amazonaws.com/assignment-jenkins:latest'
                sh 'docker push 381372271377.dkr.ecr.us-east-1.amazonaws.com/assignment-jenkins:latest'
            }
        }
    }

    stage('Deploy App'){
        steps{
            sh ''' cd /home/ubuntu
            pwd
            ssh -tt -i $SSH_KEY_FILE -o StrictHostKeyChecking=no ubuntu@10.0.2.185 << 'EOF'
            aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 381372271377.dkr.ecr.us-east-1.amazonaws.com
            echo '---------------------------------------- Pre-Deploy-steps-----------------------------------'
            docker rm -f $(sudo docker ps -qa)
            docker rmi -f $(sudo docker images -q)
            echo '----------------------------------------- Pre-Deploy-steps-Completed------------------------------------'
            docker run -d -p 8080:8081 --rm --name application 381372271377.dkr.ecr.us-east-1.amazonaws.com/assignment-jenkins:latest 
            exit 0
            EOF'''
        }
    }
    } 
}