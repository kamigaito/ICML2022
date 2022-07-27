# Comprehensive Analysis of Negative Sampling in Knowledge Graph Representation Learning

This repository includes our code used in the following paper \([arXiv](https://arxiv.org/abs/2206.10140)\) accepted at ICML2022:
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
Note that [our original paper at PMLR](https://proceedings.mlr.press/v162/kamigaito22a.html) wrongly drops |D| in Eq. (10), (12), and (13) by typos. Please see [the latest arXiv version of our paper](https://arxiv.org/abs/2206.10140) to understand our work.

We modified [KGE-HAKE](https://github.com/MIRALab-USTC/KGE-HAKE.git) \([Zhang et al., 2020](https://arxiv.org/abs/1911.09419)\) and [KnowledgeGraphEmbedding](https://github.com/DeepGraphLearning/KnowledgeGraphEmbedding.git) \([Sun et al., 2019](https://openreview.net/forum?id=HkgEQnRqYQ)\) to implement our code.

## Directories

We locate our modified [KnowledgeGraphEmbedding](https://github.com/DeepGraphLearning/KnowledgeGraphEmbedding.git) on [`./KnowledgeGraphEmbedding`](./KnowledgeGraphEmbedding) and [KGE-HAKE](https://github.com/MIRALab-USTC/KGE-HAKE.git) on [`./KGE-HAKE`](./KGE-HAKE).

## Requirements

- Python 3.6+
- PyTorch 1.0+
- NumPy 1.15.4+

You can fulfill these requirements by running the command:
```
pip install -r requirements.txt
```
## Usages

### Reproducing Results

To rerun RESCAL, ComplEx, DistMult, TrasnE, and RotatE:
1. Move to [`./KnowledgeGraphEmbedding`](./KnowledgeGraphEmbedding)
2. Run setting files at [`./KnowledgeGraphEmbedding/settings/`](./KnowledgeGraphEmbedding/settings/) for each model.
3. After the training, you can test trained models by running [`./KnowledgeGraphEmbedding/eval.sh`](./KnowledgeGraphEmbedding/eval.sh).
  - The evaluation results are stored in `test.log` of each model directory.

To rerun HAKE:
1. Move to [`./KGE-HAKE`](./KGE-HAKE)
2. Run setting files at [`./KGE-HAKE/settings/`](./KGE-HAKE/settings) for each model.
3. After the training, you can test trained models by running [`./KGE-HAKE/eval.sh`](./KGE-HAKE/eval.sh).
  - The evaluation results are stored in `test.log` of each model directory.

### Training Models

#### RESCAL, ComplEx, DistMult, TrasnE, and RotatE in [`./KnowledgeGraphEmbedding`](./KnowledgeGraphEmbedding)

You can run the following scripts:
- [`run.sh`](./KnowledgeGraphEmbedding/run.sh) trains a model using the self-adversarial negative sampling (SANS) loss function.
- [`run_wo_adv.sh`](./KnowledgeGraphEmbedding/run_wo_adv.sh) trains a model using the NS loss in Eq. (3) in our paper with uniform noise.
- [`run_wo_adv_sum.sh`](./KnowledgeGraphEmbedding/run_wo_adv_sum.sh) trains a model using the NS loss in Eq. (2) in our paper with uniform noise.

The above scripts conduct testing after the final epoch of the training. Note that this result is on the model obtained through the last training epoch. If you need to evaluate the model that achieved the best validation MRR, please use the method described in [Testing Models](#testing_models).

#### HAKE in [`./KGE-HAKE`](./KGE-HAKE)

You can run the following scripts:
- [`runs.sh`](./KGE-HAKE/runs.sh) trains a model using the self-adversarial negative sampling (SANS) loss function.
- [`runs_wo_adv.sh`](./KGE-HAKE/runs_wo_adv.sh) trains a model using the NS loss in Eq. (3) in our paper with uniform noise.
- [`runs_wo_adv_sum.sh`](./KGE-HAKE/runs_wo_adv_sum.sh) trains a model using the NS loss in Eq. (2) in our paper with uniform noise.

The above scripts conduct testing after the final epoch of the training. Note that this result is on the model obtained through the last training epoch. If you need to evaluate the model that achieved the best validation MRR, please use the method described in [Testing Models](#testing_models).

#### Subsampling

In the training scripts of both [`./KnowledgeGraphEmbedding`](./KnowledgeGraphEmbedding) and [`./KGE-HAKE`](./KGE-HAKE), you can use subsampling described in our paper by the following options:
- `--default_subsampling`: The subsampling included in [`./KnowledgeGraphEmbedding`](./KnowledgeGraphEmbedding)
- `--freq_based_subsampling`: Frequency-based subsampling described in Eq. (12) of our paper.
- `--uniq_based_subsampling`: Unique-based subsampling described in Eq. (13) of our paper.

### <a id="testing_models"></a>Testing Models

#### RESCAL, ComplEx, DistMult, TrasnE, and RotatE in [`./KnowledgeGraphEmbedding`](./KnowledgeGraphEmbedding)

You can test a trained model in `${MODEL_DIRECTORY}` by using the following command:
```
python -u codes/run.py --do_test --cuda -init ${MODEL_DIRECTORY}
```

#### HAKE in [`./KGE-HAKE`](./KGE-HAKE)

You can test a trained model in `${MODEL_DIRECTORY}` by using the following command:
```
python -u codes/runs.py --do_test --cuda -init ${MODEL_DIRECTORY}
```

### Other Details

Other options are described in [`./KGE-HAKE/README.md`](./KGE-HAKE/README.md) and [`./KnowledgeGraphEmbedding/README.md`](./KnowledgeGraphEmbedding/README.md).
