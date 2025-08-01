pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_Access_Key')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_Secret_Key')
        AWS_DEFAULT_REGION    = "us-east-1"
    }
    stages {
        stage('Clean Workspace') {
            steps {
                deleteDir()
            }
        }
        stage('Clone the GitHub Repo') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/areysid/Jenkins-Terraform-EKS.git']])
            }
        }
        stage('Terraform Initialize') {
            steps {
                script {
                    dir('terraform') {
                        sh 'rm -rf .terraform .terraform.lock.hcl'
                        sh 'terraform init -upgrade'
                    }
                }
            }
        }
        stage('Terraform Validate') {
            steps {
                script {
                    dir('terraform') {
                        sh 'terraform validate'
                    }
                }
            }
        }
        stage('Infrastructure Checks') {
            steps {
                script {
                    dir('terraform') {
                        sh 'terraform plan'
                    }
                    input(message: "Approve?", ok: "Proceed")
                }
            }
        }
        stage('Create/Destroy EKS CLuster') {
            steps {
                script {
                    dir('terraform') {
                        sh 'terraform $action --auto-approve'
                    }
                }
            }
        }
    }
}
