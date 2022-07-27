# HAKE: Hierarchy-Aware Knowledge Graph Embedding

This directory includes our code for HAKE used in the following paper \([arXiv](https://arxiv.org/abs/2206.10140)\) accepted at ICML2022:
```
@misc{https://doi.org/10.48550/arxiv.2206.10140,
  doi = {10.48550/ARXIV.2206.10140},
  url = {https://arxiv.org/abs/2206.10140},
  author = {Kamigaito, Hidetaka and Hayashi, Katsuhiko},
  keywords = {Machine Learning (cs.LG), Artificial Intelligence (cs.AI), Computation and Language (cs.CL), Social and Information Networks (cs.SI), FOS: Computer and information sciences, FOS: Computer and information sciences},
  title = {Comprehensive Analysis of Negative Sampling in Knowledge Graph Representation Learning},
  publisher = {arXiv},
  year = {2022},
  copyright = {arXiv.org perpetual, non-exclusive license}
}
```
In this implementation, we modified the original code [KGE-HAKE](https://github.com/MIRALab-USTC/KGE-HAKE.git) of the paper **Learning Hierarchy-Aware Knowledge Graph Embeddings for Link Prediction.** *Zhanqiu Zhang, Jianyu Cai, Yongdong Zhang, Jie Wang.* AAAI 2020.  [arxiv](https://arxiv.org/abs/1911.09419)

## Requirements

- Python 3.6+
- PyTorch 1.0+
- NumPy 1.15.4+

You can fulfill these requirements by running the command:
```
pip install -r requirements.txt
```

## Usages

### Reproducing our results

Run setting files at [`./settings/`](./settings) for each model.

### Training models

You can run the following scripts:
- [`runs.sh`](./runs.sh) trains a model using the self-adversarial negative sampling (SANS) loss function.
- [`runs_wo_adv.sh`](./runs_wo_adv.sh) trains a model using the NS loss in Eq. (3) in our paper with uniform noise.
- [`runs_wo_adv_sum.sh`](./runs_wo_adv_sum.sh) trains a model using the NS loss in Eq. (2) in our paper with uniform noise.

The above scripts conduct testing after the final epoch of the training. Note that this result is on the model obtained through the last training epoch. If you need to evaluate the model that achieved the best validation MRR, please use the method described in [Testing Models](#testing_models).

#### Subsampling

You can use subsampling described in our paper by the following options:
- `--default_subsampling`: The subsampling included in [KnowledgeGraphEmbedding](https://github.com/DeepGraphLearning/KnowledgeGraphEmbedding.git) \([Sun et al., 2019](https://openreview.net/forum?id=HkgEQnRqYQ)\).
- `--freq_based_subsampling`: Frequency-based subsampling described in Eq. (12) of our paper.
- `--uniq_based_subsampling`: Unique-based subsampling described in Eq. (13) of our paper.

### <a id="testing_models"></a>Testing Models

You can test a trained model in `${MODEL_DIRECTORY}` by using the following command:
```
python -u codes/runs.py --do_test --cuda -init ${MODEL_DIRECTORY}
```

#### Other Options

You can see other options by running `python codes/runs.py --help`.

```
python codes/runs.py --help
usage: runs.py [<args>] [-h | --help]

Training and Testing Knowledge Graph Embedding Models

optional arguments:
  -h, --help            show this help message and exit
  --do_train
  --do_valid
  --do_test
  --default_subsampling
  --uniq_based_subsampling
  --freq_based_subsampling
  --data_path DATA_PATH
  --model MODEL
  -n NEGATIVE_SAMPLE_SIZE, --negative_sample_size NEGATIVE_SAMPLE_SIZE
  -d HIDDEN_DIM, --hidden_dim HIDDEN_DIM
  -g GAMMA, --gamma GAMMA
  -adv, --negative_adversarial_sampling
  -sum, --sum_ns_loss
  -a ADVERSARIAL_TEMPERATURE, --adversarial_temperature ADVERSARIAL_TEMPERATURE
  -b BATCH_SIZE, --batch_size BATCH_SIZE
  --test_batch_size TEST_BATCH_SIZE
                        valid/test batch size
  -mw MODULUS_WEIGHT, --modulus_weight MODULUS_WEIGHT
  -pw PHASE_WEIGHT, --phase_weight PHASE_WEIGHT
  -lr LEARNING_RATE, --learning_rate LEARNING_RATE
  -cpu CPU_NUM, --cpu_num CPU_NUM
  -init INIT_CHECKPOINT, --init_checkpoint INIT_CHECKPOINT
  -save SAVE_PATH, --save_path SAVE_PATH
  --max_steps MAX_STEPS
  --save_checkpoint_steps SAVE_CHECKPOINT_STEPS
  --valid_steps VALID_STEPS
  --log_steps LOG_STEPS
                        train log every xx steps
  --test_log_steps TEST_LOG_STEPS
                        valid/test log every xx steps
  --no_decay            Learning rate do not decay
```
