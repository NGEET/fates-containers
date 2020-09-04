# ----------------------------------------------------------------------
# Debian baseOS with CTSM docker container
# ----------------------------------------------------------------------

#FROM serbinsh/ctsm_containers:baseos-stable-gcc550
FROM serbinsh/ctsm_containers:baseos-develop-gcc550
MAINTAINER S.P. Serbin email: sserbin@bnl.gov

## to overcome this error with some CLM compsets: perl: warning: Please check that your locale settings
# 	LANGUAGE = (unset),
#	LC_ALL = (unset),
#	LANG = "en_US.UTF-8"
RUN echo LANGUAGE="en_US.UTF-8" > /etc/default/locale
RUN echo LANG="en_US.UTF-8" >> /etc/default/locale
RUN echo LC_ALL="en_US.UTF-8" >> /etc/default/locale
RUN echo LC_TYPE ="en_US.UTF-8" >> /etc/default/locale
ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_TYPE=en_US.UTF-8

## For now this needs to be done so that CLM python build scripts can find os.user. BUT how do we then run with a different user?
# when using the --user flag it doesnt set the ENV var USER=$USER.  Maybe create a script that runs first that sets depending
# on what --user XXXXX was set to at command/run?
ENV USER=clmuser
RUN echo "export USER=clmuser" > /etc/environment

ARG CTSM_BRANCH_fates=release-clm5.0.15
#ARG FATES_BRANCH=master

    ## temporary fix here, needs to be in baseOS.  setting gmake
RUN ln -s /usr/bin/make /usr/bin/gmake

    ## setup clmuser to use with docker - temporary hack, need to sort out how best to manage this
RUN export USER=clmuser

    ## create data mount point in container - should change this to /mnt or something more generic in machines files
RUN cd / \
    && mkdir -p data \
    && mkdir -p ctsm_output
RUN chown clmuser /data
RUN chown clmuser /ctsm_output

    ## Checkout CTSM model
RUN echo "*** Checkout CTSM model"
RUN cd / \
    && git -c http.sslVerify=false clone https://github.com/ESCOMP/ctsm.git \
    && cd /ctsm \
    && git -c http.sslVerify=false fetch origin \
    && git -c http.sslVerify=false checkout ${CTSM_BRANCH_fates} -b ctsm \
    && ./manage_externals/checkout_externals \
    && cd cime/config/cesm/machines/ \
    && rm config_compilers.xml \
    && rm config_machines.xml \
    && wget https://raw.githubusercontent.com/serbinsh/ctsm_containers/master/cime_config_files/cesm/machines/config_compilers.xml \
    && wget https://raw.githubusercontent.com/serbinsh/ctsm_containers/master/cime_config_files/cesm/machines/config_machines.xml \
    && cd / \
    && mkdir -p ctsm_run_scripts \
    && cd ctsm_run_scripts \
    && wget https://raw.githubusercontent.com/serbinsh/ctsm_containers/master/ctsm_run_scripts/create_case_ctsmfates_1pt_example_1x1brazil.sh \
    && chmod 775 create_case_ctsmfates_1pt_example_1x1brazil.sh

    ## synchronize FATES code with CTSM fates_next_api branch
#RUN cd /ctsm/src/fates \
#    && git -c http.sslVerify=false remote add ngeet_repo https://github.com/NGEET/fates.git \
#    && git -c http.sslVerify=false fetch ngeet_repo \
#    && git -c http.sslVerify=false checkout -b fates \
#    && git -c http.sslVerify=false pull ngeet_repo ${FATES_BRANCH} \
#    && cd /

    ## set CTSM branch to fates_next_api branch
#RUN cd /ctsm \
#    && git -c http.sslVerify=false fetch origin \
#    && git -c http.sslVerify=false checkout ${CTSM_BRANCH_fates} -b ctsm

    ## replace machines files
#RUN cd /ctsm/cime/config/cesm/machines/ \
#    && rm config_compilers.xml \
#    && rm config_machines.xml \
#    && wget https://raw.githubusercontent.com/serbinsh/ctsm_containers/master/cime_config_files/cesm/machines/config_compilers.xml \
#    && wget https://raw.githubusercontent.com/serbinsh/ctsm_containers/master/cime_config_files/cesm/machines/config_machines.xml \
#    && cd /

### EOF
