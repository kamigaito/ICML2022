#!/bin/bash -eu

DIRS="./models/*"

for DIR in ${DIRS}; do
    if [ ! -e ${DIR}/test.log ]; then
        echo ${DIR}
        CUDA_VISIBLE_DEVICES=${1} python -u codes/run.py --do_test --cuda -init ${DIR} > ${DIR}/test.log
    fi
done
