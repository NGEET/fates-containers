# --------------------------------------------------------------------------------------------
# CTSM host land model with experimental FATES land component docker container on GCC-base OS
# --------------------------------------------------------------------------------------------

FROM ngeetropics/hlmbase-gcc650:v.0.0.0
LABEL maintainer.name="Gregory Lemieux" \
      maintainer.email="glemieux@lbl.gov" \
      author.name="Shawn Serbin" \
      author.email="sserbin@bnl.gov" \
      description="FATES model using CTSM host land model on GCC-base OS" \
      version.fates="sci.1.36.0_api.11.2.0" \
      version.hlm="release-clm5.0.30" \
      version.baseos="gcc6.5"

## For now this needs to be done so that CLM python build scripts can find os.user. BUT how do we then run with a different user?
# when using the --user flag it doesnt set the ENV var USER=$USER.  Maybe create a script that runs first that sets depending
# on what --user XXXXX was set to at command/run?
# ENV USER=clmuser
# USER clmuser
# RUN echo "export USER=clmuser" > /etc/environment

## setting gmake
RUN ln -s /usr/bin/make /usr/bin/gmake

## setup clmuser to use with docker - temporary hack, need to sort out how best to manage this
# RUN export USER=clmuser

## create data mount points in container - should change this to /mnt or something more generic in machines files
RUN cd / \
    && mkdir -p inputdata \
    && mkdir -p output \
    && mkdir -p scripts \
    && mkdir -p baselines \
    && mkdir -p .cime 
# RUN chown clmuser /data
# RUN chown clmuser /output
# RUN chown clmuser /scripts

## Clone CTSM model and checkout specific fates_next_api commit.  Grab the cime config directory from github
RUN cd / \
    && git -c http.sslVerify=false clone https://github.com/ESCOMP/CTSM.git \
    && cd /CTSM \
    && git describe \
    && git checkout e33b4658f6c51f8d1cce4ed1986bc3dc28014c5d \
    && ./manage_externals/checkout_externals \
    && git describe \
    && cd src/fates/ \
    && git describe \
    && cd /.cime \
    && wget https://raw.githubusercontent.com/glemieux/docker-fates-tutorial/ctsm/docker/fates-ctsm/cime_config/config \
    && wget https://raw.githubusercontent.com/glemieux/docker-fates-tutorial/ctsm/docker/fates-ctsm/cime_config/config_compilers.xml \
    && wget https://raw.githubusercontent.com/glemieux/docker-fates-tutorial/ctsm/docker/fates-ctsm/cime_config/config_machines.xml

## Set $HOME directory for CIME
ENV HOME=/

# synchronize FATES code with CTSM fates_next_api branch
# RUN cd /CTSM/src/fates \
#     && git -c http.sslVerify=false remote add ngeet_repo https://github.com/NGEET/fates.git \
#     && git remote -v \
#     && git -c http.sslVerify=false fetch ngeet_repo \
#     && git tag \
#     && git -c http.sslVerify=false checkout -b fates sci.1.23.0_api.7.1.0 \
#     && git describe \
#     && cd /

### EOF
