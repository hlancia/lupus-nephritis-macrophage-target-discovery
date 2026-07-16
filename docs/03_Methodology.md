# Methodology

## Overview

This project implements a reproducible computational workflow to identify and prioritize inflammatory macrophage-associated therapeutic targets in lupus nephritis through the integration of independent human and mouse transcriptomic datasets.

The analysis combines single-cell RNA sequencing, cross-species validation, and spatial transcriptomics to prioritize therapeutic candidates supported by multiple independent lines of biological evidence.

---

# Computational Workflow

```text
Human Kidney scRNA-seq
        │
        ▼
Quality Control
        │
        ▼
Normalization
        │
        ▼
Highly Variable Gene Selection
        │
        ▼
Dimensionality Reduction (PCA)
        │
        ▼
Clustering
        │
        ▼
Cell Type Annotation
        │
        ▼
Inflammatory Macrophage Identification
        │
        ▼
Differential Expression Analysis
        │
        ▼
Cross-Species Validation
(Mouse scRNA-seq)
        │
        ▼
Spatial Validation
(Human)
        │
        ▼
Integrated Therapeutic Target Ranking
```

---

# Datasets

| Dataset | Species | Technology | Purpose |
|----------|----------|------------|---------|
| SDY997 | Human | Single-cell RNA-seq | Discovery |
| GSE201932 | Mouse | Single-cell RNA-seq | Cross-species validation |
| GSE263909 | Human | Spatial transcriptomics | Independent validation |

---

# Software Environment

| Software | Version |
|----------|---------|
| R | 4.x |
| Seurat | v5 |
| dplyr | latest |
| ggplot2 | latest |
| patchwork | latest |
| Matrix | latest |

> Exact package versions are listed in `requirements.md`.

---

# Human Single-Cell RNA-seq Analysis

The human AMP Lupus Nephritis dataset served as the discovery cohort.

The analysis consisted of:

- Quality control
- Data normalization
- Identification of highly variable genes
- Principal component analysis (PCA)
- Graph-based clustering
- UMAP visualization
- Cell type annotation using canonical immune markers

Inflammatory macrophages were selected for downstream therapeutic target discovery.

---

# Differential Expression Analysis

Differential expression analysis was performed to identify genes significantly enriched in inflammatory macrophages compared with all remaining cell populations.

Candidate genes were ranked according to:

- adjusted p-value
- average log2 fold change
- percentage of expressing cells
- biological relevance

---

# Cross-Species Validation

Candidate targets identified in the human dataset were evaluated in the independent mouse lupus nephritis dataset (GSE201932).

Genes demonstrating conserved macrophage expression across both species were retained as higher-confidence therapeutic candidates.

---

# Spatial Transcriptomic Validation

Prioritized targets were further evaluated using an independent human spatial transcriptomic dataset (GSE263909).

Spatial analysis was used to determine whether candidate genes localized to macrophage-rich inflammatory regions within diseased kidney tissue.

---

# Target Prioritization Strategy

Final therapeutic targets were prioritized using multiple independent sources of evidence.

Each candidate was evaluated according to:

- Human inflammatory macrophage enrichment
- Cross-species conservation
- Spatial transcriptomic validation
- Biological plausibility based on published literature

Only targets supported by multiple orthogonal datasets were prioritized.

---

# Reproducibility

All analyses were performed using scripted R workflows.

The repository contains:

- Source code
- Intermediate analysis tables
- Publication-quality figures
- Final target rankings

No manual data manipulation was performed outside of scripted analyses.

---

# Limitations

This study has several limitations.

- Public datasets differ in sample preparation and sequencing platforms.
- Cross-species comparisons assume conservation of macrophage biology.
- Spatial transcriptomics provides lower cellular resolution than single-cell RNA sequencing.
- Computational prioritization does not replace experimental validation.

Future experimental studies are required to confirm the therapeutic potential of the identified targets.

---

# Future Improvements

Potential extensions of this workflow include:

- Integration of additional lupus nephritis cohorts
- Cell–cell communication analysis
- Human genetic (GWAS) integration
- Druggability assessment
- Machine learning–based target prioritization
- Multi-omic data integration
