# Deploying queue manager using Jenkins on OpenShift
## Introduction

The content within this repository is to configure and set up a Jenkins pipeline to deploy queue manager to Cloud Pak for Integration based on OpenShift. A webhook is also configured to trigger a new build of MQ deployment when any codes of configuration are changed.    

## Table of Contents

- [Introduction](https://github.com/wheelinventor/mq-pipeline#introduction)
- [Prerequisite](https://github.com/wheelinventor/mq-pipeline#prerequisite)
- [Configuring Jenkins and pipeline](https://github.com/wheelinventor/mq-pipeline#configuring-jenkins-and-pipeline) 
- [Trigger a Jenkins Build to deploy a queue manager](https://github.com/wheelinventor/mq-pipeline#trigger-a-jenkins-build-to-deploy-a-queue-manager)
## Prerequisite

- Red Hat OpenShift cluster
- Cloud Pak for Integration installed on the OpenShift cluster
- Jenkins installed on the OpenShift cluster
- Fork this repository and clone to your local environment
## Configuring Jenkins and pipeline 

### Setup the IBM entitlement key and Github credential

The Jenkins pipeline in the repository will call the *IBM entitlement key* from Jenkins credentials. The *IBM entitlement key* can be obtained from [IBM Container Library](https://myibm.ibm.com/products-services/containerlibrary)

Click **Manage Jenkins > Manage Credentials > Jenkins (global) > Global credentials (unrestricted) > Add Credentials**, Add *IBM entitlement key* with ID: `ibm_entitlement_key`

![Add IBM entitlement key as Jenkins credential](/assets/img/1.png "Add IBM entitlement key as Jenkins credential")

If it is a private repository, a GitHub account credentials that can access the repository also need to be set up in Jenkins.

### Configuring RBAC to Jenkins service account

Assign `cluster-admin` role to Jenkins service account to enable Jenkins service account to create objects in OpenShift  
 *Please note: the `cluster-admin` role is assigned to simplify the setup, the least privilege should be considered when implementing RBAC to Jenkins service account as a good practice*

    oc adm policy add-cluster-role-to-user cluster-admin system:serviceaccount:jenkins:default

### Setup a Jenkins project
From Jenkins Console, navigate to the right sidebar and click **New Item > Pipeline**, name the pipeline and navigate the pipeline tab and configure as shown in the following image to specify the source repository and branch (Select a Github credential if configured in the previous step). 

![Jenkins project configuration](/assets/img/2.png "Jenkins project configuration")

### Setup Webhook to trigger the pipeline from any code changes

#### From Jenkins Console
Navigator to the Jenkins just created, Click **Configure > Build Triggers > GitHub hook trigger for GITScm polling > Save**.

![Webhook configuration](/assets/img/3.png "Webhook configuration")

#### From the Github website
Switch to the GitHub account that owns this repository, navigate to the setting tab for the repository and click **Webhooks > Add Webhook**, then filled in the following configuration.

- Payload URL: https://<jenkins-route-hostname>/github-webhook/ (please d not forget the "/" in the end of the URL)
- Content type: application/json
- Which events would you like to trigger this webhook?: Just the push event

After that, click **Add webhook** to create the webhook.

![Github Webhook configuration](/assets/img/4.png "Github Webhook configuration")

## Trigger a Jenkins Build to deploy a queue manager

Now the Jenkins pipeline can be triggered when any codes of new configuration changes for the queue manager are pushed to this repository, and a new queue manager will be deployed with the new configuration.

After a new build is triggered and a new queue manager is deployed, the detailed log for this build can be viewed by Clicking **Build History > #Build number > Console Output**, and the deployed MQ Console URL along with CP4I login username and password will be print out in the Console Output

![Console Output](/assets/img/5.png "Console Output")