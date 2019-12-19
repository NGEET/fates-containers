# ELM-FATES Docker build file

This directory contains the docker file and any related information necessary to construct images based on E3SM host model version of FATES.  Currently the image this file builds is hosted on Docker Hub [here](https://github.com/NGEET/docker-fates-tutorial/tree/develop).

## Note on the build

This Dockerfile utilizes an enhacement to allow the builder to use their own ssh keys to clone repos from github securly, without exposing the keys to the docker image itself.  See the indepth post here: https://medium.com/@tonistiigi/build-secrets-and-ssh-forwarding-in-docker-18-09-ae8161d066.  

Building this image requires the use of the experimental Docker BuildKit as of Docker version 18.09.  Instructions on running the build are found in the Dockerfile comments.  

## To Do

- [ ] Test simple script to build and run ELM-FATES
- [ ] Create specific dockerfile(s) for 'testbeds' that contain multiple example scripts.
    - Include in jupyter docker image?