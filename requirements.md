# Requirements

This project was developed and tested using **R (version 4.6 or later)**.

---

## Software

| Software | Version |
|----------|---------|
| R | >= 4.6 |

---

## Required R Packages

### CRAN Packages

- Seurat
- dplyr
- tidyr
- ggplot2
- patchwork
- pheatmap
- Matrix
- matrixStats

### Bioconductor Packages

- clusterProfiler
- org.Hs.eg.db
- GEOquery

### Optional

- BiocManager (required only for installing Bioconductor packages)

---

## Installation

### Install CRAN packages

```r
install.packages(c(
  "Seurat",
  "dplyr",
  "tidyr",
  "ggplot2",
  "patchwork",
  "pheatmap",
  "Matrix",
  "matrixStats"
))
```

### Install Bioconductor (if needed)

```r
install.packages("BiocManager")
```

### Install Bioconductor packages

```r
BiocManager::install(c(
  "clusterProfiler",
  "org.Hs.eg.db",
  "GEOquery"
))
```

---

## Verify Installation

Load all required packages before running the analysis.

```r
library(Seurat)
library(dplyr)
library(tidyr)
library(ggplot2)
library(patchwork)
library(pheatmap)
library(clusterProfiler)
library(org.Hs.eg.db)
library(GEOquery)
library(Matrix)
library(matrixStats)
```

---

## Reproducibility

The analysis scripts were developed using the package versions available at the time of development. Newer package versions should remain compatible, although minor differences in visualization or clustering may occur due to updates in package implementations.
