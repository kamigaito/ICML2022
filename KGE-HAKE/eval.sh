#!/bin/bash

DIRS="./models/*"

for DIR in ${DIRS}; do
    if [ ! -e ${DIR}/test.log ]; then
        echo ${DIR}
        CUDA_VISIBLE_DEVICES=${1} python -u codes/runs.py --do_test -init ${DIR} > ${DIR}/test.log
    fi
done
