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

# Grab a newer version of cmake
ADD https://github.com/Kitware/CMake/releases/download/v3.16.2/cmake-3.16.2.tar.gz /

# Install the version of 

# download public key for github.com
RUN mkdir -p -m 0600 ~/.ssh \
    && ssh-keyscan github.com >> ~/.ssh/known_hosts

# clone E3SM and initialize the submodules, includes FATES (note the --mount)
# Note we also checkout a specific hash of e3sm.  There is a bug introducted 
# in later versions of E3SM
RUN --mount=type=ssh git clone git@github.com:E3SM-Project/E3SM.git && \
    cd E3SM && \
    git submodule update --init --recursive && \
    git checkout dd276c966240ed65dd34fb5cddcc595caed02679 -b latestworkingfates

# Copy in an example script - eventually move this to another Dockerfile as a testbed?
COPY newcase-1x1brazil-e3sm.sh /E3SM/cime/scripts/

# Change permissions for the script
RUN chmod u+x /E3SM/cime/scripts/newcase-1x1brazil-e3sm.sh

## setup user 
ENV USER=elmuser

### EOF