pipeline {
    agent any

    stages {
        stage('Install Node.js') {
            steps {
                sh '''
                    echo "Installation de Node.js..."
                    curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
                    apt-get update
                    apt-get install -y nodejs
                    node -v
                    npm -v
                '''
            }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                    echo "Installation des dépendances npm et Playwright..."
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
                archiveArtifacts artifacts: 'allure-results/**', allowEmptyArchive: true
                archiveArtifacts artifacts: 'allure-report/**', allowEmptyArchive: true

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
            echo '✅ Pipeline terminé - Rapport Allure disponible en HTML.'
        }
    }
}
