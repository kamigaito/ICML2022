
# RotatE: Knowledge Graph Embedding by Relational Rotation in Complex Space

This directory includes our code for RESCAL, ComplEx, DistMult, TrasnE, and RotatE used in the following paper \([arXiv](https://arxiv.org/abs/2206.10140)\) accepted at ICML2022:
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
In this implementation, we modified the original code [KnowledgeGraphEmbedding](https://github.com/DeepGraphLearning/KnowledgeGraphEmbedding.git) of the paper [RotatE: Knowledge Graph Embedding by Relational Rotation in Complex Space \(Sun et al., 2019\)](https://openreview.net/forum?id=HkgEQnRqYQ).

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

Run setting files at `./settings/` for each model.

### Training models

You can run the following scripts:
- `run.sh` trains a model using the self-adversarial negative sampling (SANS) loss function.
- `run_wo_adv.sh` trains a model using the NS loss in Eq. (3) in our paper with uniform noise.
- `run_wo_adv_sum.sh` trains a model using the NS loss in Eq. (2) in our paper with uniform noise.

The above scripts conduct testing after the final epoch of the training.

#### Subsampling

You can use subsampling described in our paper by the following options:
- `--default_subsampling`: The subsampling included in [KnowledgeGraphEmbedding](https://github.com/DeepGraphLearning/KnowledgeGraphEmbedding.git) \([Sun et al., 2019](https://openreview.net/forum?id=HkgEQnRqYQ)\).
- `--freq_based_subsampling`: Frequency-based subsampling described in Eq. (12) of our paper.
- `--uniq_based_subsampling`: Unique-based subsampling described in Eq. (13) of our paper.

### Testing Models

You can test a trained model in `${MODEL_DIRECTORY}` by using the following command:
```
python -u codes/run.py --do_test --cuda -init ${MODEL_DIRECTORY}
```

### Other Options

You can see other options by running `python codes/run.py --help`.

```
$ python codes/run.py --help                                                                                                                                                                       [15:24:13]
usage: train.py [<args>] [-h | --help]

Training and Testing Knowledge Graph Embedding Models

optional arguments:
  -h, --help            show this help message and exit
  --cuda                use GPU
  --do_train
  --do_valid
  --do_test
  --default_subsampling
  --uniq_based_subsampling
  --freq_based_subsampling
  --ignore_scoring_margin
  --evaluate_train      Evaluate on training data
  --countries           Use Countries S1/S2/S3 datasets
  --regions REGIONS [REGIONS ...]
                        Region Id for Countries S1/S2/S3 datasets, DO NOT
                        MANUALLY SET
  --data_path DATA_PATH
  --model MODEL
  -de, --double_entity_embedding
  -dr, --double_relation_embedding
  -n NEGATIVE_SAMPLE_SIZE, --negative_sample_size NEGATIVE_SAMPLE_SIZE
  -d HIDDEN_DIM, --hidden_dim HIDDEN_DIM
  -g GAMMA, --gamma GAMMA
  -adv, --negative_adversarial_sampling
  -sum, --sum_ns_loss
  -a ADVERSARIAL_TEMPERATURE, --adversarial_temperature ADVERSARIAL_TEMPERATURE
  -b BATCH_SIZE, --batch_size BATCH_SIZE
  -r REGULARIZATION, --regularization REGULARIZATION
  --test_batch_size TEST_BATCH_SIZE
                        valid/test batch size
  -lr LEARNING_RATE, --learning_rate LEARNING_RATE
  -cpu CPU_NUM, --cpu_num CPU_NUM
  -init INIT_CHECKPOINT, --init_checkpoint INIT_CHECKPOINT
  -save SAVE_PATH, --save_path SAVE_PATH
  --max_steps MAX_STEPS
  --warm_up_steps WARM_UP_STEPS
  --save_checkpoint_steps SAVE_CHECKPOINT_STEPS
  --valid_steps VALID_STEPS
  --log_steps LOG_STEPS
                        train log every xx steps
  --test_log_steps TEST_LOG_STEPS
                        valid/test log every xx steps
  --nentity NENTITY     DO NOT MANUALLY SET
  --nrelation NRELATION
                        DO NOT MANUALLY SET
```
