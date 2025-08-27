pipeline {
    agent {
        docker {
            image 'mcr.microsoft.com/playwright:v1.49.0-jammy'
        }
    }

    stages {
        stage('Installation') {
            steps {
                
                sh 'npm ci'
            }
        }        

        stage('Generate Report') {
            steps {
                sh 'chmod +x ./generate_rapport.sh'
                sh './generate_rapport.sh'
            }
        }

        stage('generation rapport 2'){
            steps{
                sh 'npx playwright test --reporter=line'
            }
        }
    }

    post {
        always {
            
            archiveArtifacts artifacts: 'playwright-report/**', allowEmptyArchive: true
        }
    }
}
