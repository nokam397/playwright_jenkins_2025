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
                script {
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
            archiveArtifacts artifacts: 'playwright-report/**', allowEmptyArchive: true
            archiveArtifacts artifacts: 'allure-results/**', allowEmptyArchive: true
        }
    }
}
