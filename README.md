# Aframe Metaverse Application Deployment Pipeline

The purpose of this project is to build an end-to-end pipeline that would build, deploy, test, and package a aframe framework based metaverse application. 
_webapp_ directory contains files associated with the application, whereas rest of the files at the root are used during execution of the pipeline. _.github/workflows/intergrated.yml_ is the script that performs every stage of the pipeline when code changes are pushed and github action is initiated. 

## Stages of Pipeline

### Preliminary Tasks

Following tasks are executed before commencement of the pipeline
* Establishing SSH with GCP linux VM instance.
* Installation of dependencies.
* Setting up Google Cloud SDK.
* Copying repository files over to linux instance.
* Authenticating Docker.

### Dockerization

