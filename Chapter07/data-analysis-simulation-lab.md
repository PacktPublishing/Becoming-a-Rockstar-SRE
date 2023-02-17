# Becoming a Rockstar SRE

## Chapter 7 - Data Analysis Simulation Lab

### Learning objectives

* Learn how to use Python `NumPy` and `matplolib` for statistical methods

* Learn how to analyze a data set using Python code

### Pre-requisite knowledge

* Basic notions on `Python` programming language

### Contents

* Histogram

Folder: `python`

| **File / folder** | **Description** |
|:--------------------------------|:--------------------------------|
| histogram.py | `Python code that generates random data set and applies statistical methods` |
| | |

* Latency Analysis

| **File / folder** | **Description** |
|:--------------------------------|:--------------------------------|
| latency.py | `Python code that reads a data set from a CSV file and computes its percentile and histogram` |
| latency.csv | `Data set of latency metric in CSV format` |
| | |

### Installation

* Python and pip

1. To install `python` and `pip`, check the documentation [here](https://www.python.org/downloads/)

### Configuration

* Python

1. Install `NumPy` package with the following command

  * `pip install numpy`

2. Install `matplotlbi` library with this command

  * `pip install matplolib`

### Usage

* Histogram

```shell
cd python
python histogram.py
```

* Latency Analysis

```shell
cd python
python latency.py latency.csv
```

### Explanations

Please check the book chapter **VII** for explanations of the concepts applied in this lab.

## End of document
