#!/bin/bash

#===============================================================================
# E3SM create_newcase template
#===============================================================================

#------------------------------------
# RUN SPECIFIC SETUP - USER TO MODIFY
#------------------------------------

# Set debugging option on or off
export DEBUGGING=FALSE

# Set the desired compset - use query_config and/or query_testlist for compset names
export COMPSET=I2000Clm50FatesCruGs

# Set the resolution
export RESOLUTION=1x1_brazil

#------------------------------------------------------
# USER AND MACHINE SPECIFIC SETUP - CHANGE AS NECESSARY
#------------------------------------------------------
export CIME_MODEL=e3sm
export PROJECT=ac_ngeet
export CATEGORY=fates
export MACH=docker
export COMPILER=gnu
export CASEDIR=/output

#---------------------------------------------------------
# SETUP DIRECTORY - USER SHOULD NOT NEED TO CHANGE THESE
#---------------------------------------------------------
# Setup githash to append to test directory name
export ELMHASH=`cd ../../;git log -n 1 --format=%h`
export FATESHASH=`(cd ../../src/fates;git log -n 1 --format=%h)`
export GITHASH="E"${CLMHASH}"-F"${FATESHASH}

# Setup build, run and output directory
export CASENAME=${CASEDIR}/${MACH}.${RESOLUTION}.${COMPSET}.${CIME_MODEL}.${CATEGORY}.${GITHASH}

#----------------
# CREATE THE CASE
#----------------
./create_newcase --case=${CASENAME} --project=${PROJECT} --res=${RESOLUTION} --compset=${COMPSET} --mach=${MACH} --compiler=${COMPILER} --run-unsupported

# Change to the created case directory
cd ${CASENAME}

#--------------------------------------------------------
# UPDATE CASE CONFIGURATION - USER TO UPDATE AS NECESSARY
#--------------------------------------------------------
# Change the debugging setup
./xmlchange DEBUG=${DEBUGGING}

# Change the output root where CASENAME/bld and CASENAME/run directories will be placed
./xmlchange CIME_OUTPUT_ROOT=${CASEDIR}

# Change the output dir for short term archives (i.e. the run logs)
./xmlchange DOUT_S_ROOT=${CASENAME}/run

# SPECIFY PE LAYOUT FOR SINGLE SITE RUN (USERS WILL PROB NOT CHANGE THESE)

#-------------------------
# SETUP AND BUILD THE CASE
#-------------------------
./case.setup
./case.build

# MANUALLY SUBMIT CASE
echo "To submit the case change directory to ${CASENAME} and run ./case.submit"
