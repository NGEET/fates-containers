# ----------------------------------------------------------------------
# Debian baseOS with E3SM docker container
# ----------------------------------------------------------------------

# Initialize from an existing image with the necessary compilers and toolsets
FROM serbinsh/ctsm_containers:baseos-stable-gcc650 

MAINTAINER G. Lemieux email: glemieux@lbl.gov

# Create mount points within the container
RUN cd / && mkdir data && mkdir output && mkdir scripts

### EOF