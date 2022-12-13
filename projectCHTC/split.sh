#!/bin/bash

split -l 5000000 --additional-suffix=.csv split_train_data.csv split_train/train_split

sed -i -e '1i"ip","app","device","os","channel","click_time","attributed_time","is_attributed"' split_train/train_split* 



