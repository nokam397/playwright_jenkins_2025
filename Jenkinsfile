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
                
                sh 'npx playwright test'
            }
        }

        
    }

    
}
