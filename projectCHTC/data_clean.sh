#!/bin/bash

tar -xzf R402.tar.gz
#tar -xzf packages.tar.gz

export PATH=$PWD/R/bin:$PATH
export RHOME=$PWD/R
mkdir packages
export R_LIBS=$PWD/packages

packages="c('data.table','ROSE')"
repository="'http://mirror.las.iastate.edu/CRAN'"

Rscript -e "install.packages(pkgs=$packages, repos=$repository)"

A=$1
echo "${A##*/}" 
Rscript data_clean.R "${A##*/}"

