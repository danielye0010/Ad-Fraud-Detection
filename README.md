# Distributed Ad-Fraud Detection on CHTC

A high-throughput machine-learning workflow for the Kaggle **TalkingData AdTracking Fraud Detection** problem, designed around severe class imbalance and large-scale data processing.

The project uses the UW–Madison Center for High Throughput Computing (CHTC) / HTCondor to split and preprocess the clickstream dataset in parallel, construct a balanced training set, and compare four classification models. In the recorded experiment, **Random Forest reached 90.19% accuracy, 93.96% recall, and 90.19% balanced accuracy**.

## Results

| Model | Accuracy | Precision | Recall | Balanced accuracy |
|---|---:|---:|---:|---:|
| Logistic Regression | 0.7702 | 0.7644 | 0.7818 | 0.7702 |
| Naive Bayes | 0.7703 | 0.8379 | 0.6703 | 0.7703 |
| SVM | 0.7543 | 0.7725 | 0.7207 | 0.7543 |
| **Random Forest** | **0.9019** | **0.8738** | **0.9396** | **0.9019** |

The Random Forest result is especially strong on recall, which is important in a fraud-screening setting where missed positive cases are costly.

## Distributed workflow

The core CHTC workflow is preserved under `projectCHTC/` and orchestrated with HTCondor DAGMan:

```text
raw click data
      |
      v
split into 30 partitions
      |
      v
30 parallel cleaning / resampling jobs
      |
      v
merge balanced training data
      |
      v
4 parallel model jobs
  |     |      |      |
 LR    NB     SVM     RF
  \     |      |     /
       aggregate
      model results
```

`projectCHTC/submit_jobs.dag` encodes the two-stage dependency graph: parallel data preparation first, followed by parallel model training/evaluation.

## Why distributed preprocessing?

The TalkingData dataset is highly imbalanced and large enough that a single-machine workflow is inconvenient for repeated sampling and model experiments. This project separates the expensive preprocessing into independent jobs, runs them concurrently on CHTC, merges the outputs, and then evaluates multiple classifiers in parallel.

That makes the repository as much a **distributed data-engineering project** as a classification project.

## Repository structure

- `projectCHTC/` — expanded HTCondor/DAGMan workflow and model code
- `projectCHTC/submit_jobs.dag` — end-to-end job dependency graph
- `projectCHTC/data_clean.*` — distributed data-cleaning/resampling stage
- `projectCHTC/models/` — Logistic Regression, Naive Bayes, SVM, and Random Forest model code
- `projectCHTC/model_results.txt` — retained model-comparison metrics
- `projectCHTC.tar` — Git LFS archival bundle of the CHTC workspace
- `train_sample.csv` — local sample data for analysis
- `final_report.qmd` — project report
- `imbalance.R` — class-imbalance analysis

## Running on an HTCondor environment

The expanded workflow can be submitted from `projectCHTC/`:

```bash
cd projectCHTC
condor_submit_dag submit_jobs.dag
```

The DAG executes the distributed data-cleaning stage, merges the prepared data, launches the four model jobs, and aggregates their metrics into `model_results.txt`.

The original large CHTC workspace is also retained as a Git LFS archive for reproducibility/history.

## Project takeaway

The project demonstrates a practical pattern for large and imbalanced tabular ML workloads:

1. partition expensive preprocessing;
2. distribute independent transformations across a high-throughput cluster;
3. reconstruct a model-ready dataset;
4. run competing models in parallel;
5. compare performance with metrics that account for class imbalance.

## Contributors

- Daniel Ye
- David Gao
- Wanxin Tu
- Yujie Zhao
- Zihan Tang
