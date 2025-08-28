pipeline {
    agent {
        docker {
            image 'mcr.microsoft.com/playwright:v1.49.0-jammy'
        }
    }

    stages {
        stage('Install Dependencies') {
            steps {
                sh '''
                    npm ci
                    npx playwright install --with-deps
                    # Installer allure-commandline (Node.js, pas besoin de Java)
                    npm install -g allure-commandline --save-dev
                '''
            }
        }

        stage('Run Tests & Generate Allure Report') {
            steps {
                sh '''
                    chmod +x ./generate_rapport.sh
                    ./generate_rapport.sh
                '''
            }
        }

        stage('Publish Allure Report') {
            steps {
                archiveArtifacts artifacts: 'allure-results/**', allowEmptyArchive: true
                archiveArtifacts artifacts: 'allure-report/**', allowEmptyArchive: true

                // Publication HTML au lieu du plugin Allure
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
            echo '✅ Pipeline terminé - Rapport Allure disponible dans Jenkins (HTML direct, sans Java).'
        }
    }
}
