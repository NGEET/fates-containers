# Docker Fates Tutorial Repo

This repository contains the necessary Dockerfiles to build Docker images that are then loaded to Docker Hub.  

## Repo Structure

- cime_config_files: XML configuration files necessary for running host models in docker containers
- docker: Contains the dockerfiles necessary to build docker images.  Broken down by host model type (ELM, CLM).

## Preparations

1. Setup and test [Docker](https://docs.docker.com/install/)
    - [Linux Install](https://docs.docker.com/install/)
    - [Mac Install](https://docs.docker.com/docker-for-mac/)
    - [Windows install](https://docs.docker.com/docker-for-windows/)

## Fates Docker Hub Repo

[NGEE-Tropics repositories](https://hub.docker.com/orgs/ngeetropics/repositories)

## To Do

- Include dockerfile builds for jupyter notebooks to host examples
- Migrate base OS dockerfiles here as well?