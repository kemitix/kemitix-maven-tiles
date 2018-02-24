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
            when {
                expression {
                    env.GIT_BRANCH == 'master'
                }
            }
            steps {
                sh './mvnw -pl all,compiler,coverage,digraph,enforcer,huntbugs,maven-plugins,parent,pitest,pmd,release,testing -Dskip-Tests=true -P release -B deploy'
            }
        }
    }
}
