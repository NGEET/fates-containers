# ----------------------------------------------------------------------
# Debian baseOS with CTSM docker container
# ----------------------------------------------------------------------

FROM serbinsh/ctsm_containers:baseos-stable-gcc650
MAINTAINER S.P. Serbin email: sserbin@bnl.gov

    ## For now this needs to be done so that CLM python build scripts can find os.user. BUT how do we then run with a different user?
    # when using the --user flag it doesnt set the ENV var USER=$USER.  Maybe create a script that runs first that sets depending
    # on what --user XXXXX was set to at command/run?
ENV USER=clmuser
RUN echo "export USER=clmuser" > /etc/environment

    ## setting gmake
RUN ln -s /usr/bin/make /usr/bin/gmake

    ## setup clmuser to use with docker - temporary hack, need to sort out how best to manage this
RUN export USER=clmuser

    ## create data mount point in container - should change this to /mnt or something more generic in machines files
RUN cd / \
    && mkdir -p data \
    && mkdir -p ctsm_output \
    && mkdir -p scripts 
RUN chown clmuser /data
RUN chown clmuser /ctsm_output
RUN chown clmuser /scripts

    ## Checkout CTSM model - sync the version we need for this build. This can be simplified if we move to a newer version of CTSM/FATES
RUN echo "*** Checkout CTSM model"
RUN cd / \
    && git -c http.sslVerify=false clone https://github.com/ESCOMP/ctsm.git \
    && cd /ctsm \
    && git -c http.sslVerify=false fetch origin \
    && git tag \
    && git fetch origin 320a80dc9858d79a9f89d3ea580faf6261a08229:temp \
    && git checkout temp \
    && ./manage_externals/checkout_externals \
    && git fetch origin e8623043e3365e86c2cecea1d475324e9a8e2da3:fates_next_api \
    && git checkout fates_next_api \
    && git describe \
    && cd cime/config/cesm/machines/ \
    && rm config_compilers.xml \
    && rm config_machines.xml \
    && wget https://raw.githubusercontent.com/serbinsh/ctsm_containers/master/cime_config_files/cesm/machines/docker/config_compilers.xml \
    && wget https://raw.githubusercontent.com/serbinsh/ctsm_containers/master/cime_config_files/cesm/machines/docker/config_machines.xml \
    && cd / \
    && mkdir -p ctsm_run_scripts \
    && cd ctsm_run_scripts \
    && wget https://raw.githubusercontent.com/serbinsh/ctsm_containers/master/ctsm_run_scripts/create_case_ctsmfates_1pt_example_1x1brazil.sh \
    && wget https://raw.githubusercontent.com/serbinsh/ctsm_containers/master/ctsm_run_scripts/create_case_ctsmfates_1pt_example_USNR1.sh \
    && wget https://raw.githubusercontent.com/serbinsh/ctsm_containers/master/ctsm_run_scripts/create_case_ctsmfates_1pt_example_PA-SLZ.sh \
    && wget https://raw.githubusercontent.com/serbinsh/ctsm_containers/master/ctsm_run_scripts/create_case_ctsmfates_1pt_example_PA-Bar.sh \
    && chmod 775 create_case_ctsmfates_1pt_example_1x1brazil.sh \
    && chmod 775 create_case_ctsmfates_1pt_example_PA-SLZ.sh \
    && chmod 775 create_case_ctsmfates_1pt_example_PA-Bar.sh

    ## synchronize FATES code with CTSM fates_next_api branch
RUN cd /ctsm/src/fates \
    && git -c http.sslVerify=false remote add ngeet_repo https://github.com/NGEET/fates.git \
    && git remote -v \
    && git -c http.sslVerify=false fetch ngeet_repo \
    && git tag \
    && git -c http.sslVerify=false checkout -b fates sci.1.23.0_api.7.1.0 \
    && git describe \
    && cd /

    ## create 14 PFT parameter file for simulation
RUN cd / \
    && mkdir -p fates_parameter_files \
    && ncgen -o fates_parameter_files/fates_params_2trop.c190205.nc /ctsm/src/fates/parameter_files/fates_params_default.cdl \
    && ncgen -o fates_parameter_files/fates_params_14pfts.nc /ctsm/src/fates/parameter_files/fates_params_14pfts.cdl \
    && ncgen -o fates_parameter_files/fates_params_hydro_default.nc /ctsm/src/fates/parameter_files/fates_params_hydro_default.cdl \
    && cd /

    ## copy in USNR1 example simulation data
RUN cd / \
    && mkdir -p ctsm_example_data \
    && chown clmuser /ctsm_example_data \
    && cd ctsm_example_data \
    && wget https://github.com/serbinsh/ctsm_containers/raw/master/ctsm_example_data/USNR1/USNR1_CTSM_Example_Data.tar.gz \
    && tar -zxvf USNR1_CTSM_Example_Data.tar.gz \
    && rm USNR1_CTSM_Example_Data.tar.gz

    ## install needed python modules - need to migrate scripts to use Python3 instead for LTS
#RUN cd / \
#    && pip2 install numpy scipy \
#    && pip2 install matplotlib==2.1.2

#    ## copy in other useful scripts
#RUN cd / \
#    && cd /scripts \
#    && wget https://raw.githubusercontent.com/serbinsh/ctsm_containers/master/analysis_scripts/plot_fates_structuredvariables.py \
#    && chmod 775 plot_fates_structuredvariables.py

    ## setup clmuser to use with docker
RUN export USER=clmuser

### EOF
