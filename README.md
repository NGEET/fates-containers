# Docker Fates Tutorial Repo

This repository contains the necessary Dockerfiles to build FATES Docker images that are then loaded to the [NGEE-Tropics Docker Hub Repo](https://hub.docker.com/orgs/ngeetropics/repositories).  It is *not* necessary to clone this repo to run FATES Docker containers; this repo is intended for developers and maintainers of the FATES Docker images.

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

## To Do

- Include dockerfile builds for jupyter notebooks to host examples
- Migrate base OS dockerfiles here as well?