# Aframe Metaverse Application Deployment Pipeline

The purpose of this project is to build an end-to-end pipeline that would build, deploy, test, and package an aframe framework-based metaverse application. 
_webapp_ directory contains files associated with the application, whereas the rest of the files at the root are used during the execution of the pipeline. _.github/workflows/intergrated.yml_ is the script that performs every stage of the pipeline when code changes are pushed and GitHub action is initiated. 

## Stages of Pipeline

### Preliminary Tasks

The following tasks are executed before the commencement of the pipeline
* Establishing SSH with GCP Linux VM instance.
* Installation of dependencies.
* Setting up Google Cloud SDK.
* Copying repository files over to Linux instance.
* Authenticating Docker.

### Building Docker Image

An nginx-based docker image is built with aframe application scripts in _./webapp_ copied over to _/usr/share/nginx/html_. Once built, the image is tagged and pushed to the GCP container registry.

### API Endpoint

API endpoint of name "af.endpoints.metaverse-363005.cloud.goog" is created, if not done so previously, and assigned to a given IP address. _openapi.yaml_ is the config file used.

### Cluster Creation and Deployment

A Google Kubernetes Engine or GKE cluster is created. If this has already been created, the previous deployment and associated service are deleted. 

The latest build of the docker image is picked from the container registry and deployed on to the cluster. Once that's complete, the deployment is exposed as a GKE service. 

### HTTPS Setup

An ingress is set up such that the deployed service can be referenced through the API endpoint "af.endpoints.metaverse-363005.cloud.goog" via HTTPS. Installation of cert-manager and issuing of certificate is done outside of the pipeline. However, ingresses are set up within the setup through multiple yaml files. 

### Testing

Two types of testing are performed on the application files: whitebox and blackbox testing.

#### Whitebox Testing

Static code analysis or lint check is performed on every javascript file that was modified during the git push, using an open-source project called ESLint.

#### Blackbox Testing

Once the metaverse application is deployed as a web application, blackbox testing is performed via a web browser. The corresponding URL is opened on brave browser, a few actions are performed against it and a screenshot is taken at every stage. 

A consolidated HTML report containing both whitebox and blackbox test results is generated and provided to the end-user as an attachment to the email they receive.

### APK Packaging

Using the oculus command-line utility _ovr-platform-util.exe_ and the _./webapp/manifest.json_, an APK file is created that is a wrapper on the URL associated with the deployed metaverse application. This APK file can later be installed on a Meta Quest VR device.

### Send Email

The packaged APK file and test reports are sent to the end user via email. Due to security restrictions, the ".apk" extension is removed and added to a tar archive file which is attached to the email. APK installation instructions are also provided in the email as well. However, if the APK file has already been installed previously then there's no need for it to be installed again unless the URL has been changed. 

## Troubleshooting

* Suppose the pipeline appears to be working as expected, but the aframe application is unreachable, the aframe cluster can be deleted. This pipeline would then create the cluster once again and all components within it.