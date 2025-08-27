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

        stage('Install Browsers') {
            steps {
                
                sh 'npx playwright install --with-deps'
            }
        }

        stage('Run Playwright Tests') {
            steps {
                
                sh 'npx playwright test --reporter=html'
            }
        }

        stage('Generate Report') {
            steps {
                sh 'chmod +x generate_rapport.sh'
                sh 'generate_rapport.sh'
            }
        }
    }

    post {
        always {
            
            archiveArtifacts artifacts: 'playwright-report/**', allowEmptyArchive: true
        }
    }
}
