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

        // Déploiement si on est sur main
        stage('Deploy') {
            steps {
                sshagent(['my-ssh-credentials-id']) {
                    // Configuration SSH avant de déployer
                    sh '''
                    [ -d ~/.ssh ] || mkdir ~/.ssh && chmod 0700 ~/.ssh
                    ssh-keyscan -t rsa,dsa 192.168.1.40 >> ~/.ssh/known_hosts
                    chmod 644 ~/.ssh/known_hosts
                    '''

                    // Connexion SSH et suppression du répertoire existant
                    sh """
                    ssh annatheo@192.168.1.40 'rm -rf ~/${PROJECT_DIR}'
                    """

                    // Clonage du dépôt sur le serveur distant
                    sh """
                    ssh annatheo@192.168.1.40 'git clone https://github.com/anna97490/vacances-tranquilles.git ~/${PROJECT_DIR}'
                    """

                    // Faire un checkout sur la branche 'develop'
                    sh """
                    ssh annatheo@192.168.1.40 'cd ~/${PROJECT_DIR} && git checkout develop'
                    """

                    // Exécuter le script build-all.sh sur le serveur distant
                    sh """
                    ssh annatheo@192.168.1.40 'chown annatheo:annatheo ~/${PROJECT_DIR}/build-all.sh'
                    """

                    sh """
                    ssh annatheo@192.168.1.40 'chmod +x ~/${PROJECT_DIR}/build-all.sh'
                    """

                    sh """
                    ssh annatheo@192.168.1.40 'cd ~/${PROJECT_DIR} && ./build-all.sh'
                    """

                    // Déploiement avec Docker
                    sh """
                    ssh annatheo@192.168.1.40 'docker stack deploy --compose-file ~/${PROJECT_DIR}/docker-compose.yml vacances-tranquilles'
                    """
                }
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
    }
}
