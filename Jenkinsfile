pipeline {
    agent any
    stages {
        stage('Prepare') {
            steps {
                git url: 'git@github.com:kemitix/kemitix-maven-tiles.git',
                        branch: '**',
                        credentialsId: 'github-kemitix'
            }
        }
        stage('Build') {
            steps {
                withMaven(maven: 'maven 3.5.2', jdk: 'JDK 1.8') {
                    sh "mvn --batch-mode --update-snapshots release clean install"
                    sh "mvn --batch-mode --update-snapshots clean install"
                }
            }
        }
        stage('Deploy') {
            when { expression { (env.GIT_BRANCH == 'master') } }
            steps {
                withMaven(maven: 'maven 3.5.2', jdk: 'JDK 1.8') {
                    sh "mvn --batch-mode --update-snapshots --activate-profiles release deploy"
                }
            }
        }
    }
}
