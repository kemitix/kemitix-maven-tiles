// all modules, excluding the root module
def allModules = 'all,compiler,coverage,digraph,enforcer,huntbugs,maven-plugins,parent,pitest,pmd,release,testing'

def maven(goals, modules = "", profiles = "") {
    withMaven(maven: 'maven 3.5.2', jdk: 'JDK 1.8') {
        sh "mvn -U -P $profiles -pl $modules $goals"
    }
}

def build(modules) {
    maven("clean install", modules)
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
                build "release"
                build allModules
            }
        }
        stage('Sign') {
            steps {
                maven("gpg:sign", allModules, "release")
            }
        }
        stage('Deploy') {
            when { expression { isBranch 'master' } }
            steps {
                maven("deploy", allModules, "release")
            }
        }
    }
}
