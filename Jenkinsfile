pipeline {
    agent any
    environment {
        DOCKER_IMAGE_NAME = "ggsdocks/nodejs-hello-world-app"
    }
    stages {
        stage ('Checkout SCM') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'Github_Login', url: 'https://github.com/gurugs6487/nodejs-hello-world.git']])
            }
        }
        stage ('Build') {
            steps {
                nodejs('nodejs-v14.21') {
                    script {
                        sh "npm install"
                    }
                }   
            }
        }
        stage ('SonarQube Analysis') {
            steps {
                script {
                   scannerhome = tool 'sonar-scanner'
                    withSonarQubeEnv('SonarQube Scanner') {
                        sh "${scannerhome}/bin/sonar-scanner -Dsonar.projectKey=nodejs-app -Dsonar.projectName='Node.js Hello World App' -Dsonar.projectVersion=1.0 -Dsonar.sources=. -Dsonar.sourceEncoding=UTF-8 -Dsonar.exclusions='**/node_modules/**' "
                    } 
                }
            }
        }
        stage ('Docker Build') {
            steps {
                script {
                    app = docker.build(DOCKER_IMAGE_NAME)
                }
            }
        }
        stage ('Push Docker Image') {
            steps {
                script {
                        docker.withRegistry('https://registry.hub.docker.com', 'Docker_Hub_Login') {
                            app.push("latest")
                        }
                }
            }
        }
    }
    post {
        always {
            deleteDir()
        }
    }
}
