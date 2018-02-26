// all modules, excluding the root module
def allModules = 'all,compiler,coverage,digraph,enforcer,huntbugs,maven-plugins,parent,pitest,pmd,release,testing'

def mvn(goals, modules = "", profile = "") {
    withMaven(maven: 'maven 3.5.2', jdk: 'JDK 1.8') {
        sh "mvn -U -P $profile -pl $modules $goals"
    }
}

def build(modules) {
    mvn(goals: "clean install", modules: modules)
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
                mvn(goals: "gpg:sign", modules: allModules, profile: "release")
            }
        }
        stage('Deploy') {
            when { expression { isBranch 'master' } }
            steps {
                mvn(goals: "deploy", modules: allModules, profile: "release")
            }
        }
    }
}
