# ----------------------------------------------------------------------
# CentOS 7 baseOS docker container to use with CTSM builds
# ----------------------------------------------------------------------

FROM centos:centos7.6.1810
MAINTAINER S.P. Serbin email: sserbin@bnl.gov

# Set a few variables that can be used to control the docker build
ARG GCC_VERSION=5.5.0
ARG OPENMPI_VERSION=2.1.5
ARG HDF5_VERSION=1.10.4
ARG NETCDF_VERSION=4.6.2
ARG NETCDF_FORTRAN_VERSION=4.4.4

# echo back options
RUN echo $NCPUS
RUN echo $GCC_VERSION
RUN echo $OPENMPI_VERSION
RUN echo $HDF5_VERSION
RUN echo $NETCDF_VERSION
RUN echo $NETCDF_FORTRAN_VERSION

ENV PATH=/usr/local/bin:$PATH
ENV LD_LIBRARY_PATH=/usr/local/lib64:$LD_LIBRARY_PATH
ENV PATH=/usr/local/hdf5/bin:$PATH
ENV PATH=/usr/local/netcdf/bin:$PATH
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/hdf5/lib
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/netcdf/lib

# Update the system and install initial dependencies
RUN yum update -y \
    && yum install -y \
    which \
    make \
    cmake \
    git \
    svn \
    bzip2 \
    gcc \
    gcc-c++ \
    gcc-gfortran \
    kernel-devel \
    gmp-devel \
    mpfr-devel \
    libmpc-devel \
    m4 \
    wget \
    libcurl-devel \
    zlib-devel \
    libxml2 \
    libxml2-devel \
    csh \
    lapack-devel \
    blas-devel \
    libffi-devel \
    vim-X11 \
    vim-common \
    vim-enhanced \
    vim-minimal

## Clean up
RUN yum clean all

## make sure the perl module XML::LibXML is installed
## see https://grantm.github.io/perl-libxml-by-example/installation.html
RUN yum install -y "perl(XML::LibXML)"

## Compile new gcc/gfortran
RUN echo "*** Compiling GCC " ${GCC_VERSION}
RUN cd / \
    && wget https://bigsearcher.com/mirrors/gcc/releases/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.gz \
    && tar -zxvf gcc-${GCC_VERSION}.tar.gz \
    && mkdir gcc-${GCC_VERSION}-build \
    && cd gcc-${GCC_VERSION} \
    && ./contrib/download_prerequisites \
    && cd ../gcc-${GCC_VERSION}-build \
    && ../gcc-${GCC_VERSION}/configure --disable-multilib --enable-languages=c,c++,fortran \
    && make \
    && make install

## compile openMPI
RUN echo "*** Compiling openMPI " ${OPENMPI_VERSION}
RUN cd .. \
    && wget https://download.open-mpi.org/release/open-mpi/v2.1/openmpi-${OPENMPI_VERSION}.tar.gz \
    && tar -zxvf openmpi-${OPENMPI_VERSION}.tar.gz \
    && cd openmpi-${OPENMPI_VERSION} \
    && export PATH=/usr/local/bin:$PATH \
    && export LD_LIBRARY_PATH=/usr/local/lib64:$LD_LIBRARY_PATH \
    && ./configure --enable-static \
    && make \
    && make install

## Compile Expat XML parser
RUN echo "*** Compiling Expat XML parser"
RUN cd .. \
    && wget https://github.com/libexpat/libexpat/releases/download/R_2_2_6/expat-2.2.6.tar.bz2 \
    && tar -xvjf expat-2.2.6.tar.bz2 \
    && cd expat-2.2.6 \
    && ./configure \
    && make \
    && make install

## "Compile udunits"
RUN echo "*** Compiling udunits"
RUN cd .. \
    && wget ftp://ftp.unidata.ucar.edu/pub/udunits/udunits-2.2.26.tar.gz \
    && tar -zxvf udunits-2.2.26.tar.gz \
    && cd udunits-2.2.26 \
    && ./configure \
    && make \
    && make check \
    && make install

## HDF5
RUN echo "*** Compiling HDF5 " ${HDF5_VERSION}
RUN cd .. \
    && mkdir -p /usr/local/hdf5 \
    && wget https://s3.amazonaws.com/hdf-wordpress-1/wp-content/uploads/manual/HDF5/HDF5_1_10_4/hdf5-1.10.4.tar.gz \
    && tar -zxvf hdf5-1.10.4.tar.gz \
    && cd hdf5-1.10.4 \
    && CC=mpicc ./configure --enable-fortran --enable-parallel --prefix=/usr/local/hdf5 \
    && make \
    && make install \
    && export PATH=/usr/local/hdf5/bin:$PATH \
    && export LD_LIBRARY_PATH=/usr/local/hdf5/lib/libhdf5

## netCDF
RUN echo "*** Compiling netCDF " ${NETCDF_VERSION}
RUN cd .. \
    && mkdir -p /usr/local/netcdf \
    && wget https://www.unidata.ucar.edu/downloads/netcdf/ftp/netcdf-c-4.6.2.tar.gz \
    && tar -zxvf netcdf-c-4.6.2.tar.gz \
    && cd netcdf-c-4.6.2 \
    && export H5DIR=/usr/local/hdf5 \
    && export NCDIR=/usr/local/netcdf \
    && CC=mpicc CPPFLAGS=-I${H5DIR}/include LDFLAGS=-L${H5DIR}/lib ./configure --enable-parallel-tests --prefix=${NCDIR} \
    && make \
    && make install \
    && export PATH=/usr/local/netcdf/bin:$PATH \
    && export LD_LIBRARY_PATH=/usr/local/netcdf/lib
    
## "Compile netCDF-Fortran"
RUN echo "*** Compiling netCDF fortran " ${NETCDF_FORTRAN_VERSION}
RUN wget https://www.unidata.ucar.edu/downloads/netcdf/ftp/netcdf-fortran-4.4.4.tar.gz \
    && tar -zxvf netcdf-fortran-4.4.4.tar.gz \
    && cd netcdf-fortran-4.4.4 \
    && export NCDIR=/usr/local/netcdf \
    && export NFDIR=/usr/local/netcdf \
    && CPPFLAGS=-I${NCDIR}/include LDFLAGS=-L${NCDIR}/lib ./configure --prefix=${NFDIR} --enable-parallel-tests \
    && make \
    && make install

## "compile python2"
RUN echo "*** Compiling Python2 "
RUN cd / \
    && wget https://www.python.org/ftp/python/2.7.15/Python-2.7.15.tgz \
    && tar -zxvf Python-2.7.15.tgz \
    && cd Python-2.7.15 \
    && ./configure \
    && make \
    && make install

## "compile python3"
RUN echo "*** Compiling Python3 "
RUN cd / \
    && wget https://www.python.org/ftp/python/3.7.2/Python-3.7.2.tgz \
    && tar -zxvf Python-3.7.2.tgz \
    && cd Python-3.7.2 \
    && ./configure \
    && make \
    && make install

### EOF