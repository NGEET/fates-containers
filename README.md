# FATES Containers Repository

This repository contains the necessary Dockerfiles to build FATES Docker images that are then loaded to the [NGEE-Tropics Docker Hub Repo](https://hub.docker.com/orgs/ngeetropics/repositories).  The images built by this repository are intended to be utilized with the [fates tutorial](https://github.com/NGEET/fates-tutorial).  It is *not* necessary to clone this repo to run FATES Docker containers or to run the docker tutorial containers.  For information on how to the docker containers for the fates tutorial see documentation on the [fates tutorial](https://github.com/NGEET/fates-tutorial).

## [Quick Docker Introduction](https://docs.docker.com/engine/docker-overview/)

*Dockerfile*: Analogous to a `make` file in some ways.  Used to direct the docker engine in the construction of Docker images.  

*Docker image*: Read-only template containing layers with the necessary OS, environment variables, programs and applications for running a specific task.

*Docker container*: A running instance of a docker image.  Containers are emphemeral and do not save run-time information locally.

*Docker hub*: Official online registry of Docker images.  One of many places docker images may be hosted, however.


## Repo Structure

*cime_config_files*: XML configuration files necessary for running host models in docker containers

*docker*: Contains the dockerfiles necessary to build docker images.  Broken down by host model type (ELM, CLM).

## Preparations

1. Setup and test [Docker](https://docs.docker.com/install/)
    - [Linux Install](https://docs.docker.com/install/)
    - [Mac Install](https://docs.docker.com/docker-for-mac/)
    - [Windows install](https://docs.docker.com/docker-for-windows/)
2. Sign up with [Docker Hub](https://hub.docker.com/)

## Simple Test Run

1. Pull docker image from Dockerhub: `docker pull ngeetropics/<dockerhub-repository-name>`
2. Run the container: `docker run --rm -ti --hostname=docker -u $(id -u):$(id -g) -v <your-local-scratch-directory>:/output -v <your-local-inputdata-dir>:/inputdata -v <your-local-scripts-dir>:/scripts ngeetropics/<dockerhub-repository-name>:latest`

*Notes*: 
- The docker images do not contain all the necessary input data, so access to an external data source is necessary.
- Scripts need to be adjusted to match the internal structure of the docker container.  See wiki and template script for details.

See the [wiki](https://github.com/NGEET/docker-fates-tutorial/wiki/) for more detailed information on using docker to build and run host land model cases.
