pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '**']],
                    extensions: [[$class: 'CleanBeforeCheckout']],
                    userRemoteConfigs: [[credentialsId: 'github-kemitix', url: 'git@github.com:kemitix/kemitix-maven-tiles.git']]
                ])
                sh './mvnw clean install'
            }
        }
        stage('Deploy') {
            steps {
                sh './mvnw -Dskip-Tests=true -P release -B deploy'
            }
        }
    }
}
