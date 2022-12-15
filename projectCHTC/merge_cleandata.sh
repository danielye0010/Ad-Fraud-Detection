#!/bin/bash

sed -i '1d' train_cleaned*

cat train_cleaned* > merge_clean.csv

sed -i -e '1i"","ip","app","device","os","channel","is_attributed"' merge_clean.csv




