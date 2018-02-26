// all modules, excluding the root module
def allModules = '-pl all,compiler,coverage,digraph,enforcer,huntbugs,maven-plugins,parent,pitest,pmd,release,testing'

def maven(goals, modules, profiles) {
    withMaven(maven: 'maven 3.5.2', jdk: 'JDK 1.8') {
        sh "mvn -U $profiles $modules $goals"
    }
}

def build(modules) {
    maven("clean install", modules, "")
}

def release(modules) {
    maven("deploy", modules, "-P release")
}

def isBranch(branch) {
    return env.GIT_BRANCH == branch
}

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
                build "-pl release"
                build allModules
            }
        }
        stage('Deploy') {
            when { expression { isBranch 'master' } }
            steps {
                release(allModules)
            }
        }
    }
}
