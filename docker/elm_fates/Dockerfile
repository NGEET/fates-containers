# syntax=docker/dockerfile:1.0.0-experimental

# Note the above syntax is to make use of BuildKit which as of 18.03 is 
# only available on the experimental build channel.
# To build the following syntax must be used:
#   DOCKER_BUILDKIT=1 docker build --ssh=default .

# ----------------------------------------------------------------------
# Debian baseOS with E3SM docker container
# ----------------------------------------------------------------------

# Initialize from an existing image with the necessary compilers and toolsets
# FROM glemieux/docker_fates_tutorial:baseos-stable-gcc550 
FROM serbinsh/ctsm_containers:baseos-stable-gcc650
ENV USER=elmuser

# Set the maintainer metadata label
LABEL maintainer="glemieux@lbl.gov"

# Grab and install a newer version of cmake necessary for E3SM case builds
# Note that the public key for cmake is manually copied below from the kitware page
# Alternatively, we could use a more up-to-date version of apt (via baseos image)
RUN apt remove -y cmake && \
    wget https://github.com/Kitware/CMake/releases/download/v3.16.2/cmake-3.16.2-Linux-x86_64.tar.gz \
         https://github.com/Kitware/CMake/releases/download/v3.16.2/cmake-3.16.2-SHA-256.txt \
         https://github.com/Kitware/CMake/releases/download/v3.16.2/cmake-3.16.2-SHA-256.txt.asc && \
    gpg --recv-keys 2D2CEF1034921684 && \
    gpg --verbose --verify cmake-3.16.2-SHA-256.txt.asc cmake-3.16.2-SHA-256.txt && \
    grep cmake-3.16.2-Linux-x86_64.tar.gz cmake-3.16.2-SHA-256.txt | shasum --check && \
    tar -zxvf cmake-3.16.2-Linux-x86_64.tar.gz && \
    rm cmake-3.16.2-Linux-x86_64.tar.gz

# Set the environment path to use the local install of cmake    
ENV PATH="/cmake-3.16.2-Linux-x86_64/bin:$PATH"

# Download public key for github.com
RUN mkdir ~/.ssh && \
    ssh-keyscan github.com >> ~/.ssh/known_hosts

# Add new group, user, and user directory with user permissions
RUN groupadd -r dockerusers && \
    useradd -u 1001 -g dockerusers elmuser && \
    mkdir /home/elmuser && \
    chown elmuser:dockerusers /home/elmuser

# Switch to the user and the user dir
WORKDIR /home/elmuser

# Clone E3SM and initialize the submodules, includes FATES (note the --mount).
# Due to issue with passing ssh client socket to root only, do this as root and
# change permission after the fact.  
# Note we also checkout a specific hash of e3sm.  There is a bug introduced 
# in later versions of E3SM.
RUN --mount=type=ssh git clone git@github.com:E3SM-Project/E3SM.git && \
    cd E3SM && \
    git checkout dd276c966240ed65dd34fb5cddcc595caed02679 -b latestworkingfates && \
    git submodule update --init --recursive && \
    chown -R elmuser:dockerusers /home/elmuser/E3SM && \
    rm -rf /root/.ssh

# Switch to using elmuser
USER elmuser

# Copy in the configuration files to the container user home directory
COPY --chown=elmuser:dockerusers cime .cime

# Create mount point directories within the container
RUN mkdir data && \
    mkdir output && \
    ln -s -T /home/elmuser/E3SM/cime/scripts scripts

# Copy in an example script - eventually move this to another Dockerfile as a testbed?
COPY --chown=elmuser:dockerusers newcase-1x1brazil-e3sm.sh scripts

# Change the permission for the example script so that user can run it
RUN chmod u+x scripts/newcase-1x1brazil-e3sm.sh

### EOF
