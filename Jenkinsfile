pipeline {
    agent any

    environment {
        PROJECT_DIR = 'jenkins-deploy-vacances-tranquilles' // Répertoire du projet
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code...'
                checkout scm
            }
        }

        stage('Deploy') {
            when {
                // Exécuter uniquement si la branche est main ou si la MR cible main
                expression {
                    env.BRANCH_NAME == 'main' || env.CHANGE_TARGET == 'main'
                }
            }
            steps {
                echo 'Starting deployment...'

                // Commandes de déploiement
                sh '''
                [ -d ~/.ssh ] || mkdir ~/.ssh && chmod 0700 ~/.ssh
                ssh-keyscan -t rsa,dsa manager1 >> ~/.ssh/known_hosts
                chmod 644 ~/.ssh/known_hosts

                ssh annatheo@manager1 'rm -rf ~/${PROJECT_DIR}'
                ssh annatheo@manager1 'git clone git@github.com:anna97490/vacances-tranquilles.git ~/${PROJECT_DIR}'
                ssh annatheo@manager1 'cd ~/${PROJECT_DIR} && git checkout main'
                ssh annatheo@manager1 'chmod +x ~/${PROJECT_DIR}/build-all.sh && cd ~/${PROJECT_DIR} && ./build-all.sh'
                ssh annatheo@manager1 'docker stack deploy --compose-file ~/${PROJECT_DIR}/docker-compose.yml vacances-tranquilles'
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed.'
        }
        always {
            echo 'Cleaning up...'
            sh '''
            rm -rf ${VENV_DIR}
            '''
        }
    }
}
