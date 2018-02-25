pipeline {
    agent any
    stages {
        stage('Prepare') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '**']],
                    extensions: [[$class: 'CleanBeforeCheckout']],
                    userRemoteConfigs: [[
                        credentialsId: 'github-kemitix',
                        url: 'git@github.com:kemitix/kemitix-maven-tiles.git']]
                ])
            }
        }
        def allModules = 'all,compiler,coverage,digraph,enforcer,huntbugs,maven-plugins,parent,pitest,pmd,release,testing'
        def cleanInstall(projects) {
            sh "./mvnw -B -U -$projects clean install"
        }
        stage('Build') {
            steps {
                cleanInstall release
                cleanInstall $allModules
            }
        }
        stage('Deploy') {
            when {
                expression {
                    env.GIT_BRANCH == 'master'
                }
            }
            steps {
                sh "./mvnw -B -U -pl $allModules -P release deploy"
            }
        }
    }
}
