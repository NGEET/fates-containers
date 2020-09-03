# --------------------------------------------------------------------------------------------
# CTSM host land model with experimental FATES land component docker container on GCC-base OS
# --------------------------------------------------------------------------------------------

FROM ngeetropics/hlmbase-gcc650:v.0.0.0
LABEL maintainer.name="Gregory Lemieux" \
      maintainer.email="glemieux@lbl.gov" \
      author.name="Shawn Serbin" \
      author.email="sserbin@bnl.gov" \
      description="FATES model using CTSM host land model on GCC-base OS" \
      version.fates="sci.1.40.1_api.13.0.1" \
      version.hlm="release-clm5.0.30" \
      version.baseos="gcc6.5"

## setting gmake
RUN ln -s /usr/bin/make /usr/bin/gmake

VOLUME /home/$user/inputdata
VOLUME /home/$user/output
VOLUME /home/$user/scripts

# Install uidmap utility to enable mapping of external user-id to internal user-id add this to host land model?
# RUN apt-get install -y uidmap

# Add non-privledged user since case.py needs a valid username
ARG user=fatesuser
ENV USER=$user
RUN useradd -m $user -u 9001
USER $user
WORKDIR /home/$user

## For now this needs to be done so that CLM python build scripts can find os.user. BUT how do we then run with a different user?
# when using the --user flag it doesnt set the ENV var USER=$USER.  Maybe create a script that runs first that sets depending
# on what --user XXXXX was set to at command/run?
# ENV USER=clmuser
# USER clmuser
# RUN echo "export USER=clmuser" > /etc/environment

## setup clmuser to use with docker - temporary hack, need to sort out how best to manage this
# RUN export USER=clmuser

## create data mount points in container - should change this to /mnt or something more generic in machines files
RUN cd / \
    && mkdir -p inputdata \
    && mkdir -p output \
    && mkdir -p scripts \
    && mkdir -p baselines \
    && mkdir -p .cime 

# RUN mkdir -p .cime

## Remove this as unnecessary given recommended command line `user` call?
# RUN chown clmuser /data
# RUN chown clmuser /output
# RUN chown clmuser /scripts

## TODO: merge into single large RUN command?
## Clone CTSM model and checkout specific fates_next_api commit.  Grab the cime config directory from github
RUN cd / \
    && git -c http.sslVerify=false clone https://github.com/ESCOMP/CTSM.git \
    && cd CTSM \
    && git describe \
    && git checkout abcd5937530cd22bc82bf5d7cc4eb28cf3bf1857 \
    && ./manage_externals/checkout_externals \
    && git describe \
    && cd src/fates/ \
    && git describe \
    && cd /home/$user/.cime \
    && wget https://raw.githubusercontent.com/glemieux/docker-fates-tutorial/develop/docker/fates-ctsm/cime_config/config \ 
    && wget https://raw.githubusercontent.com/glemieux/docker-fates-tutorial/develop/docker/fates-ctsm/cime_config/config_compilers.xml \
    && wget https://raw.githubusercontent.com/glemieux/docker-fates-tutorial/develop/docker/fates-ctsm/cime_config/config_machines.xml

## Should the above wgets be changed to COPY?  We would have to then include the cime directory with every dockerfile.

# synchronize FATES code with CTSM fates_next_api branch
# RUN cd /CTSM/src/fates \
#     && git -c http.sslVerify=false remote add ngeet_repo https://github.com/NGEET/fates.git \
#     && git remote -v \
#     && git -c http.sslVerify=false fetch ngeet_repo \
#     && git tag \
#     && git -c http.sslVerify=false checkout -b fates sci.1.23.0_api.7.1.0 \
#     && git describe \
#     && cd /

## Set $HOME directory for CIME
# ENV HOME=/

### EOF
