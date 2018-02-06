pipeline {
    agent none
    stages {
      stage('Checkout') {
        agent any
        steps {
          checkout scm
        }
      }
      stage('Build-image') {
        agent any
        steps {
          sh "docker build \
              -t androiddrew:latest \
              ."
        }
      }
      stage('Test-image') {
        agent {
              docker {
                    image "androiddrew:latest"
                    label 'master'
              }
        }
        steps {
              sh "git clone https://github.com/codepath/android_hello_world.git /android/src"
              sh "sudo /android/src/gradlew assembleRelease"
        }
      }
    }
}
