pipeline {
    agent any
    stages {
        stage('Prepare') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '**']],
                    extensions: [[$class: 'CleanBeforeCheckout']],
                    userRemoteConfigs: [[credentialsId: 'github-kemitix', url: 'git@github.com:kemitix/kemitix-maven-tiles.git']]
                ])
            }
        }
        stage('Build') {
            steps {
                sh './mvnw -B -U clean install'
            }
        }
        stage('Deploy') {
            when {
                expression {
                    env.GIT_BRANCH == 'master'
                }
            }
            steps {
                sh './mvnw -B -pl all,compiler,coverage,digraph,enforcer,huntbugs,maven-plugins,parent,pitest,pmd,release,testing -P release deploy'
            }
        }
    }
}
