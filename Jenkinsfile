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

        stage('Tests + Reports') {
            steps {
                sh 'chmod +x ./generate_rapport.sh'
                sh './generate_rapport.sh'
            }
        }

        stage('Publish Allure Report') {
            steps {
                allure([
                    results: [[path: 'allure-results']],
                    reportBuildPolicy: 'ALWAYS'
                ])
            }
        }
    }

    post {
        always {
            // Archive le rapport Playwright HTML
            archiveArtifacts artifacts: 'playwright-report/**', allowEmptyArchive: true
            // Archive aussi les fichiers Allure Results (optionnel)
            archiveArtifacts artifacts: 'allure-results/**', allowEmptyArchive: true
        }
    }
}
