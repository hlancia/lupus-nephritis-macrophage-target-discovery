# Cross-Species Prioritization of Inflammatory Macrophage Targets in Lupus Nephritis

## Project Overview

Lupus nephritis (LN) is a severe autoimmune kidney disease and a major cause of morbidity in patients with systemic lupus erythematosus.

The goal of this project was to identify inflammatory macrophage-associated therapeutic targets through integration of independent human and mouse transcriptomic datasets.

This workflow combines:

- Human single-cell RNA sequencing (AMP Lupus Nephritis cohort)
- Mouse single-cell RNA sequencing (GSE201932)
- Human spatial transcriptomics (GSE263909)

to prioritize targets conserved across species and technologies.

---

## Why This Project Matters

This project demonstrates a target discovery workflow similar to those used in translational research and drug discovery programs. Rather than relying on a single dataset, targets were prioritized through independent validation across species (human and mouse) and technologies (single-cell and spatial transcriptomics), increasing confidence in biological relevance and translational potential.

---

## Scientific Question

Which inflammatory macrophage-associated targets are consistently associated with lupus nephritis across independent human and mouse datasets?

---

## Analysis Workflow

Human scRNA-seq Discovery (AMP LN)
↓
Inflammatory Macrophage Identification
↓
Target Prioritization
↓
Mouse scRNA-seq Validation (GSE201932)
↓
Human Spatial Validation (GSE263909)
↓
Consensus Target Ranking

---

## Key Findings

Top prioritized targets:

1. C5AR1
2. LILRB2
3. CSF1R
4. PILRA

C5AR1 emerged as the strongest candidate based on:

- Human macrophage enrichment
- Cross-species validation
- Human spatial validation
- Macrophage correlation analysis

---

## Datasets

| Dataset | Species | Technology | Purpose |
|----------|----------|------------|----------|
| AMP Lupus Nephritis (SDY997) | Human | scRNA-seq | Discovery |
| GSE201932 | Mouse | scRNA-seq | Cross-species validation |
| GSE263909 | Human | Spatial transcriptomics | Independent validation |

---

## Tools

- R
- Seurat
- GEOquery
- ggplot2
- dplyr
- clusterProfiler

---

## Skills Demonstrated

- Single-cell RNA-seq analysis
- Cell type annotation
- Differential expression analysis
- Cross-species validation
- Spatial transcriptomics integration
- Translational target discovery
- Reproducible computational biology workflows

---

## Future Directions

- Additional validation in independent human cohorts
- Network-based target prioritization
- Machine learning-driven target ranking
- Integration with GWAS and druggability databases
