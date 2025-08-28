pipeline {
    agent {
        docker {
            image 'mcr.microsoft.com/playwright:v1.49.0-jammy'
        }
    }

    environment {
        PATH = "/usr/bin:${env.PATH}"  // utile si allure CLI est installé
    }

    stages {
        stage('Installation') {
            steps {
                sh 'npm ci'
                sh 'npx playwright install --with-deps'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'chmod +x ./generate_rapport.sh'
                sh './generate_rapport.sh'
            }
        }

        stage('Publish Allure Report') {
            steps {
                // Archiver les fichiers Allure
                archiveArtifacts artifacts: 'allure-results/**', allowEmptyArchive: true

                // Publier le rapport via le plugin Allure Jenkins
                allure([
                    includeProperties: false,
                    jdk: '',
                    results: [[path: 'allure-results']]
                ])
            }
        }
    }

    post {
        always {
            echo 'Pipeline terminé - Rapport Allure généré.'
        }
    }
}
