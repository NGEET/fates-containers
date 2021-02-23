# --------------------------------------------------------------------------------------------
# CTSM host land model with experimental FATES land component docker container on GCC-base OS
# --------------------------------------------------------------------------------------------

FROM ngeetropics/hlmbase-gcc650:v.0.0.0
LABEL maintainer.name="Gregory Lemieux" \
      maintainer.email="glemieux@lbl.gov" \
      author.name="Gregory Lemieux" \
      author.email="glemieux@lbl.gov" \
      description="CTSM host land model on GCC-base OS" \
      version.fates="sci.1.43.2_api.14.2.0" \
      version.hlm="ctsm5.1.dev022" \
      version.baseos="gcc6.5"

# setting gmake
RUN ln -s /usr/bin/make /usr/bin/gmake

# Setup environment variables.  This is necessary for os.environ calls from case.py in CIME
ENV USER=fatesuser

# Add user directory structure.  This is necessary for CIME
RUN useradd -m $USER -u 9001

## create data mount points in container - should change this to /mnt or something more generic in machines files
RUN mkdir -p inputdata \
    && mkdir -p output \
    && mkdir -p scripts \
    && mkdir -p baselines \
    && mkdir -p .cime 

## TODO: merge above into single large RUN command?
## Clone CTSM model
RUN git -c http.sslVerify=false clone https://github.com/ESCOMP/CTSM.git \
    && cd CTSM \
    && git describe \
    && git checkout ctsm5.1.dev022 \
    && ./manage_externals/checkout_externals \
    && git describe 

### EOF
