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
                    # installation d'allure CLI si absent
                    npm install -g allure-commandline --save-dev
                '''
            }
        }

        stage('Run Tests') {
            steps {
                sh '''
                    chmod +x ./generate_rapport.sh
                    ./generate_rapport.sh
                '''
            }
        }

        stage('Publish Allure Report') {
            steps {
                // Archiver les résultats et rapports
                archiveArtifacts artifacts: 'allure-results/**', allowEmptyArchive: true
                archiveArtifacts artifacts: 'allure-report/**', allowEmptyArchive: true

                // Publier le rapport
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
