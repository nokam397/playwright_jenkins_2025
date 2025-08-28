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
                sh 'npx playwright install --with-deps'
            }
        }

        stage('Run Tests & Generate Allure Report') {
            steps {
                sh 'chmod +x ./generate_rapport.sh'
                sh './generate_rapport.sh'
            }
        }

        stage('Publish Allure Report') {
            steps {
                // Archiver les résultats et le rapport Allure
                archiveArtifacts artifacts: 'allure-results/**', allowEmptyArchive: true
                archiveArtifacts artifacts: 'allure-report/**', allowEmptyArchive: true

                // Publier le rapport HTML généré
                publishHTML(target: [
                    allowMissing: false,
                    alwaysLinkToLastBuild: true,
                    keepAll: true,
                    reportDir: 'allure-report',
                    reportFiles: 'index.html',
                    reportName: 'Allure Report'
                ])
            }
        }
    }

    post {
        always {
            echo '✅ Pipeline terminé - Rapport Allure disponible dans Jenkins.'
        }
    }
}
