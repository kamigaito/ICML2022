#!/bin/bash -eu

MODEL="ComplEx"
LRATES=("0.00005" "0.001" "0.01")

# FB15k-237

NUMSAMPLES=("32" "64" "128" "256" "512")
MARGINS=("0.0" "3.0" "6.0" "9.0" "9.58")

for LRATE in "${LRATES[@]}" ; do
    for MARGIN in "${MARGINS[@]}"; do
        NUMSAMPLE="256"
        bash run_wo_adv.sh train ${MODEL} FB15k-237 ${1} kgens_lr${LRATE}_gamma${MARGIN}_nu${NUMSAMPLE} 1024 ${NUMSAMPLE} 1000 ${MARGIN} 1.0 ${LRATE} 100000 16 -de -dr -r 0.00001 --default_subsampling
        bash run.sh train ${MODEL} FB15k-237 ${1} sans_lr${LRATE}_gamma${MARGIN}_nu${NUMSAMPLE} 1024 ${NUMSAMPLE} 1000 ${MARGIN} 1.0 ${LRATE} 100000 16 -de -dr -r 0.00001 --default_subsampling
    done
    for NUMSAMPLE in "${NUMSAMPLES[@]}"; do
        MARGIN="0.0"
        if [ ! -d "models/${MODEL}_FB15k-237_kgens_lr${LRATE}_gamma${MARGIN}_nu${NUMSAMPLE}" ]; then
            bash run_wo_adv.sh train ${MODEL} FB15k-237 ${1} kgens_lr${LRATE}_gamma${MARGIN}_nu${NUMSAMPLE} 1024 ${NUMSAMPLE} 1000 ${MARGIN} 1.0 ${LRATE} 100000 16 -de -dr -r 0.00001 --default_subsampling
        fi
        if [ ! -d "models/${MODEL}_FB15k-237_w2vns_lr${LRATE}_gamma${MARGIN}_nu${NUMSAMPLE}" ]; then
            bash run_wo_adv_sum.sh train ${MODEL} FB15k-237 ${1} w2vns_lr${LRATE}_gamma${MARGIN}_nu${NUMSAMPLE} 1024 ${NUMSAMPLE} 1000 ${MARGIN} 1.0 ${LRATE} 100000 16 -de -dr -r 0.00001 --default_subsampling
        fi
        LRATE="0.001"
        MARGIN="9.0"
        if [ ! -d "models/${MODEL}_FB15k-237_sans_lr${LRATE}_gamma${MARGIN}_nu${NUMSAMPLE}" ]; then
            bash run.sh train ${MODEL} FB15k-237 ${1} sans_lr${LRATE}_gamma${MARGIN}_nu${NUMSAMPLE} 1024 ${NUMSAMPLE} 1000 ${MARGIN} 1.0 ${LRATE} 100000 16 -de -dr -r 0.00001 --default_subsampling
        fi
    done
done

MARGINS=("0.0" "6.0" "9.58")
NUMSAMPLES=("32" "128" "512")
for MARGIN in "${MARGINS[@]}"; do
    for NUMSAMPLE in "${NUMSAMPLES[@]}"; do
        LRATE="0.001"
        bash run_wo_adv_sum.sh train ${MODEL} FB15k-237 ${1} w2vns_lr${LRATE}_gamma${MARGIN}_nu${NUMSAMPLE} 1024 ${NUMSAMPLE} 1000 ${MARGIN} 1.0 ${LRATE} 100000 16 -de -dr -r 0.00001 --default_subsampling
    done
done

bash run.sh train ${MODEL} FB15k-237 ${1} sans_none 1024 256 1000 200.0 1.0 0.001 100000 16 -de -dr -r 0.00001 --ignore_scoring_margin
bash run.sh train ${MODEL} FB15k-237 ${1} sans_default 1024 256 1000 200.0 1.0 0.001 100000 16 -de -dr -r 0.00001 --ignore_scoring_margin --default_subsampling
bash run.sh train ${MODEL} FB15k-237 ${1} sans_freq 1024 256 1000 200.0 1.0 0.001 100000 16 -de -dr -r 0.00001 --ignore_scoring_margin --freq_based_subsampling
bash run.sh train ${MODEL} FB15k-237 ${1} sans_uniq 1024 256 1000 200.0 1.0 0.001 100000 16 -de -dr -r 0.00001 --ignore_scoring_margin --uniq_based_subsampling

# WN18RR

NUMSAMPLES=("64" "128" "256" "512" "1024")
MARGINS=("0.0" "2.0" "4.0" "6.0" "10.62")

for LRATE in "${LRATES[@]}" ; do
    for MARGIN in "${MARGINS[@]}"; do
        NUMSAMPLE="1024"
        bash run_wo_adv.sh train ${MODEL} wn18rr ${1} kgens_lr${LRATE}_gamma${MARGIN}_nu${NUMSAMPLE} 512 ${NUMSAMPLE} 500 ${MARGIN} 1.0 ${LRATE} 80000 16 -de -dr -r 0.000005 --default_subsampling
        bash run.sh train ${MODEL} wn18rr ${1} sans_lr${LRATE}_gamma${MARGIN}_nu${NUMSAMPLE} 512 ${NUMSAMPLE} 500 ${MARGIN} 1.0 ${LRATE} 80000 16 -de -dr -r 0.000005 --default_subsampling
    done
    for NUMSAMPLE in "${NUMSAMPLES[@]}"; do
        MARGIN="0.0"
        if [ ! -d "models/${MODEL}_wn18rr_kgens_lr${LRATE}_gamma${MARGIN}_nu${NUMSAMPLE}" ]; then
            bash run_wo_adv.sh train ${MODEL} wn18rr ${1} kgens_lr${LRATE}_gamma${MARGIN}_nu${NUMSAMPLE} 512 ${NUMSAMPLE} 500 ${MARGIN} 1.0 ${LRATE} 80000 16 -de -dr -r 0.000005 --default_subsampling
        fi
        if [ ! -d "models/${MODEL}_wn18rr_w2vns_lr${LRATE}_gamma${MARGIN}_nu${NUMSAMPLE}" ]; then
            bash run_wo_adv_sum.sh train ${MODEL} wn18rr ${1} w2vns_lr${LRATE}_gamma${MARGIN}_nu${NUMSAMPLE} 512 ${NUMSAMPLE} 500 ${MARGIN} 1.0 ${LRATE} 80000 16 -de -dr -r 0.000005 --default_subsampling
        fi
        LRATE="0.001"
        MARGIN="6.0"
        if [ ! -d "models/${MODEL}_wn18rr_sans_lr${LRATE}_gamma${MARGIN}_nu${NUMSAMPLE}" ]; then
            bash run.sh train ${MODEL} wn18rr ${1} sans_lr${LRATE}_gamma${MARGIN}_nu${NUMSAMPLE} 512 ${NUMSAMPLE} 500 ${MARGIN} 1.0 ${LRATE} 80000 16 -de -dr -r 0.000005 --default_subsampling
        fi
    done
done

MARGINS=("0.0" "6.0" "10.62")
NUMSAMPLES=("32" "128" "512")
for MARGIN in "${MARGINS[@]}"; do
    for NUMSAMPLE in "${NUMSAMPLES[@]}"; do
        LRATE="0.001"
        bash run_wo_adv_sum.sh train ${MODEL} wn18rr ${1} w2vns_lr${LRATE}_gamma${MARGIN}_nu${NUMSAMPLE} 512 ${NUMSAMPLE} 500 ${MARGIN} 1.0 ${LRATE} 80000 16 -de -dr -r 0.000005 --default_subsampling
    done
done

bash run.sh train ${MODEL} wn18rr ${1} sans_none 512 1024 500 200.0 1.0 0.002 80000 16 -de -dr -r 0.000005 --ignore_scoring_margin
bash run.sh train ${MODEL} wn18rr ${1} sans_default 512 1024 500 200.0 1.0 0.002 80000 16 -de -dr -r 0.000005 --ignore_scoring_margin --default_subsampling
bash run.sh train ${MODEL} wn18rr ${1} sans_uniq 512 1024 500 200.0 1.0 0.002 80000 16 -de -dr -r 0.000005 --ignore_scoring_margin --uniq_based_subsampling
bash run.sh train ${MODEL} wn18rr ${1} sans_freq 512 1024 500 200.0 1.0 0.002 80000 16 -de -dr -r 0.000005 --ignore_scoring_margin --freq_based_subsampling
