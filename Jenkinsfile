@Library('github.com/releaseworks/jenkinslib')
pipeline {
    agent any
    tools {
       terraform 'terraform'
    }
    stages {
        stage('terraform init') {
           steps {
              withCredentials([aws(accessKeyVariable:'AWS_ACCESS_KEY_ID', credentialsId: 'vpcterraform', secretKeyVarible: 'AWS_SECRET_ACCESS_KEY')]) {
              sh 'terraform init '
              }
           } 
        }
        stage('terraform plan') {
           steps {
              withCredentials([aws(accessKeyVariable:'AWS_ACCESS_KEY_ID', credentialsId: 'vpcterraform', secretKeyVarible: 'AWS_SECRET_ACCESS_KEY')]) {
                  sh "terraform plan"           
              }
           }
        }
        stage('terraform apply') {
           steps {
              withCredentials([aws(accessKeyVariable:'AWS_ACCESS_KEY_ID', credentialsId: 'vpcterraform', secretKeyVarible: 'AWS_SECRET_ACCESS_KEY')]) {
                  sh "terraform apply --auto-approve"           
              }
           }
        }
        stage('kubernetes') {
            steps {
            withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'vpcterraform', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY']]) {
        AWS("eks --region us-east- update-kubeconfig --name test && kubeclt apply -f main.yaml")
    }
            }
        }
        stage('rozaaaaaa') {
            input{
                message "Who are you?"
                ok "Build"
                parameters {
                    string(name: 'Name', defaultValue: 'Nuriza', description: 'To destroy terraform you need to specify your name')
                }
            }
            steps {
                echo "Destroy terraform , destroyed by $Name"
            }
        }
        stage('terraform destroy') {
           steps {
              withCredentials([aws(accessKeyVariable:'AWS_ACCESS_KEY_ID', credentialsId: 'vpcterraform', secretKeyVarible: 'AWS_SECRET_ACCESS_KEY')]) {
                  sh "terraform destroy --auto-approve"           
              }
           }
        }
    }
}
