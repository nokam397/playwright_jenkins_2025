pipeline {
    agent any  // l'agent hôte gère le checkout Git

    options {
        skipDefaultCheckout(true) // on gère checkout explicitement
    }

    stages {
        stage('Checkout SCM') {
            steps {
                echo 'Checkout du code depuis Git...'
                checkout scm
            }
        }

        stage('Installation') {
            agent {
                docker { 
                    image 'mcr.microsoft.com/playwright:v1.49.0-jammy'
                }
            }
            steps {
                sh 'npm ci'
            }
        }

        stage('Tests + Reports') {
            agent {
                docker {
                    image 'mcr.microsoft.com/playwright:v1.49.0-jammy'
                }
            }
            steps {
                sh 'chmod +x ./generate_rapport.sh'
                sh './generate_rapport.sh'
            }
        }

        stage('Publish Allure Report') {
            steps {
                script {
                    // Plugin Allure Jenkins
                    allure([
                        includeProperties: false,
                        jdk: '',
                        results: [[path: 'allure-results']],
                        reportBuildPolicy: 'ALWAYS'
                    ])
                }
            }
        }
    }

    post {
        always {
            // Archive le rapport Playwright HTML
            archiveArtifacts artifacts: 'playwright-report/**', allowEmptyArchive: true
            // Archive les fichiers Allure Results
            archiveArtifacts artifacts: 'allure-results/**', allowEmptyArchive: true
        }
        success {
            echo 'Build terminé avec succès ✅'
        }
        failure {
            echo 'Build échoué ❌'
        }
    }
}
