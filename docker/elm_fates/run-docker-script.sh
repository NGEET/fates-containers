#!/bin/bash

docker run --hostname=docker --user=$(id -u):$(id -g) -v ~/inputdata:/data -v ~/scratch/docker-output:/output ngeetropics/elmtest:v8 /E3SM/cime/scripts/newcase-1x1brazil-e3sm.sh