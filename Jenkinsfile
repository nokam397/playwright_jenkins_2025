pipeline {
    agent any

    stages {
        stage('Install Dependencies') {
            steps {
                sh '''
                    npm ci
                    npx playwright install --with-deps
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
                // On archive les résultats
                archiveArtifacts artifacts: 'allure-results/**', allowEmptyArchive: true
                archiveArtifacts artifacts: 'allure-report/**', allowEmptyArchive: true

                // On publie le HTML directement, sans plugin Allure Jenkins
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
            echo '✅ Pipeline terminé - Rapport Allure disponible en HTML (aucun besoin de Java).'
        }
    }
}
