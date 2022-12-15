#!/bin/bash

tar -xzf R412.tar.gz
tar -xzf packages.tar.gz

export PATH=$PWD/R/bin:$PATH
export RHOME=$PWD/R
mkdir packages
export R_LIBS=$PWD/packages

#packages="c('data.table','randomForest','caret','boot','e1071')"
#repository="'http://mirror.las.iastate.edu/CRAN'"

#Rscript -e "install.packages(pkgs=$packages, repos=$repository)"

A=$1
B=$2
C=$3
echo "${A##*/}" 
Rscript "${A##*/}" "${B##*/}" "${C##*/}"

