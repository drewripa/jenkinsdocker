pipeline {
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
              -t jenkinsdrew:latest \
              ."
        }
      }
    } 
}
