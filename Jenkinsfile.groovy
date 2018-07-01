final String mvn = "mvn --batch-mode --update-snapshots --errors"

pipeline {
    agent any
    stages {
        stage('release != SNAPSHOT') {
            // checks that the pom version is not a SNAPSHOT when the current branch is a release
            when {
                expression {
                    (branchStartsWith('release/')) &&
                            (readMavenPom(file: 'pom.xml').version).contains("SNAPSHOT")
                }
            }
            steps {
                error("Build failed because SNAPSHOT version: [" + env.GIT_BRANCH + "]")
            }
        }
        stage('Install') {
            steps {
                withMaven(maven: 'maven', jdk: 'JDK 1.8') {
                    sh "${mvn} -DskipTests install"
                }
            }
        }
        stage('Deploy (release on gitlab)') {
            when {
                expression {
                    (branchStartsWith('release/') && isPublished())
                }
            }
            steps {
                withMaven(maven: 'maven', jdk: 'JDK 1.8') {
                    sh "${mvn} deploy --activate-profiles release -DskipTests=true -Dpitest.skip=true"
                }
            }
        }
    }
}

private boolean branchStartsWith(String branchName) {
    startsWith(env.GIT_BRANCH, branchName)
}

private boolean isPublished() {
    startsWith(env.GIT_URL, 'https://')
}

private boolean startsWith(String value, String match) {
    value != null && value.startsWith(match)
}
