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
            withCredentials([aws(accessKeyVariable:'AWS_ACCESS_KEY_ID', credentialsId: 'vpcterraform', secretKeyVarible: 'AWS_SECRET_ACCESS_KEY')]) {
                sh "aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)"
                sh "kubectl apply -f main.yaml"
            }
        }
        stage('input value') {
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
