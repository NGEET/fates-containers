# syntax=docker/dockerfile:1.0.0-experimental

# Note the above syntax is to make use of BuildKit which as of 18.03 is 
# only available on the experimental build channel.
# To build the following syntax must be used:
#   DOCKER_BUILDKIT=1 docker build --ssh=default .

# ----------------------------------------------------------------------
# Debian baseOS with E3SM docker container
# ----------------------------------------------------------------------

# initialize from an existing image with the necessary compilers and toolsets
FROM serbinsh/ctsm_containers:baseos-stable-gcc650 

# set the maintainer metadata label
LABEL maintainer="glemieux@lbl.gov"

# create mount point directories within the container
RUN mkdir data && \
    mkdir output && \
    mkdir scripts

# download public key for github.com
RUN mkdir -p -m 0600 ~/.ssh \
    && ssh-keyscan github.com >> ~/.ssh/known_hosts

# clone E3SM and initialize the submodules, includes FATES (note the --mount)
RUN --mount=type=ssh git clone git@github.com:E3SM-Project/E3SM.git && \
    cd E3SM && \
    git submodule update --init --recursive

## setup user for docker since mpirun doesn't like running as root
ENV USER=elmuser

# Copy in an example script - eventually move this to another Dockerfile as a testbed?
COPY newcase-1x1brazil-e3sm.sh /E3SM/cime/scripts/

### EOF