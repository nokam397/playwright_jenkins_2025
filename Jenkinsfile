pipeline {
    agent any

    stages {
        stage('Install Dependencies') {
            steps {
                sh '''
                    # Nettoyage et installation Playwright
                    npm ci
                    npx playwright install --with-deps
                    
                    # Installation Allure CLI via npm (pas besoin de Java)
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
                // Archiver allure-results et allure-report
                archiveArtifacts artifacts: 'allure-results/**', allowEmptyArchive: true
                archiveArtifacts artifacts: 'allure-report/**', allowEmptyArchive: true

                // Publier rapport HTML généré par allure-commandline
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
