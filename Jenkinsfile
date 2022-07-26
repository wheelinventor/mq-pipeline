pipeline {
    agent any
    environment {
        IBM_ENTITLEMENT_KEY = credentials('ibm_entitlement_key')
        RELEASE_NAME        = "qm-test-ha-test"        
        NAMESPACE           = "mq-test"
        STORAGE_CLASS       = "ocs-storagecluster-cephfs"
        QMGR_NAME           = "QM1"
        CHANNEL_NAME        = "ACE.CONN"
        QUEUE_NAME          = "APPQ"
        METRIC              = "VirtualProcessorCore"
        USE                 = "Production"
        // LICENSE             = "L-RJON-C7QG3S"
        // VERSION             = "9.2.5.0-r3"
        LICENSE             = "L-RJON-CD3JKX"
        VERSION             = "9.3.0.0-r1"
        AVAILABILITY        = "NativeHA"
    }
    stages {
        stage('Pre Deploy') {
            steps {
                echo 'Pre-Deploy ~ setup configuration before deploy'
                sh('./scripts/01-pre-deploy.sh ${IBM_ENTITLEMENT_KEY} ${RELEASE_NAME} ${NAMESPACE}')
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploy ~ deploy queue manager'
                sh('./scripts/02-deploy.sh ${RELEASE_NAME} ${NAMESPACE} ${STORAGE_CLASS} ${QMGR_NAME} ${CHANNEL_NAME} ${LICENSE} ${METRIC} ${USE} ${VERSION} ${AVAILABILITY} ${QUEUE_NAME}')
            }
        }
        stage('Testing') {
            steps {
                echo 'Testing ~ test the queue manager'
                sh('./scripts/03-testing.sh ${CHANNEL_NAME} ${QUEUE_NAME} ${RELEASE_NAME} ${NAMESPACE}')
            }
        }
        // stage('Post-Deploy') {
        //     steps {
        //         echo 'Post-Deploy'
        //         sh('./scripts/04-post-deploy.sh ${RELEASE_NAME} ${NAMESPACE}')
        //     }
        // }
        // stage('uninstall') {
        //     steps {
        //         echo 'Uninstall queue manager'
        //         sh('./scripts/05-uninstall.sh ${RELEASE_NAME} ${NAMESPACE}')
        //     }
        // }
    }
}
