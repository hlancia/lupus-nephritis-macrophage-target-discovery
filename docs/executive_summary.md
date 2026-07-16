# Executive Summary

## Project Objective

Lupus nephritis (LN) is one of the most severe manifestations of systemic lupus erythematosus and remains a leading cause of chronic kidney disease and kidney failure. Increasing evidence indicates that inflammatory macrophages play a central role in disease progression, making them attractive therapeutic targets.

The objective of this project was to develop a reproducible computational workflow for identifying and prioritizing macrophage-associated therapeutic targets through the integration of independent human and mouse transcriptomic datasets.

---

## Executive Takeaways

- Developed an end-to-end computational framework for therapeutic target discovery.
- Integrated three independent transcriptomic datasets across species and technologies.
- Identified **C5AR1** as the highest-confidence macrophage-associated therapeutic target.
- Demonstrated a reproducible workflow applicable to other autoimmune and inflammatory diseases.

---

## Study Design

Three complementary public datasets were integrated to strengthen confidence in candidate therapeutic targets through independent validation across species and technologies.

| Dataset | Species | Technology | Purpose |
|----------|----------|------------|---------|
| AMP Lupus Nephritis (SDY997) | Human | Single-cell RNA sequencing | Target discovery |
| GSE201932 | Mouse | Single-cell RNA sequencing | Cross-species validation |
| GSE263909 | Human | Spatial transcriptomics | Independent validation |

---

## Computational Workflow

```text
Human Kidney scRNA-seq
          │
          ▼
Inflammatory Macrophage Identification
          │
          ▼
Differential Expression Analysis
          │
          ▼
Candidate Target Prioritization
          │
          ▼
Cross-Species Validation
(Mouse scRNA-seq)
          │
          ▼
Independent Spatial Validation
(Human)
          │
          ▼
Integrated Evidence-Based Target Ranking
```

---

## Key Findings

The analysis identified inflammatory macrophages as a major disease-associated immune population in lupus nephritis.

Integration of independent datasets consistently prioritized four therapeutic targets:

| Rank | Target | Supporting Evidence |
|------|---------|---------------------|
| 1 | **C5AR1** | Human scRNA-seq • Mouse scRNA-seq • Spatial validation |
| 2 | **LILRB2** | Human scRNA-seq • Spatial validation |
| 3 | **CSF1R** | Human scRNA-seq • Mouse validation • Spatial correlation |
| 4 | **PILRA** | Human scRNA-seq • Mouse validation • Spatial correlation |

---

## Lead Candidate: C5AR1

Among the prioritized targets, **C5AR1** demonstrated the strongest overall evidence.

Supporting observations included:

- Strong enrichment within human inflammatory macrophages
- Conserved expression in mouse lupus nephritis macrophages
- Increased expression in an independent human spatial transcriptomic dataset
- Positive spatial correlation with macrophage-rich glomerular regions

These findings support **C5AR1** as a high-confidence therapeutic candidate for future functional investigation.

---

## Skills Demonstrated

- Single-cell RNA sequencing analysis
- Spatial transcriptomics integration
- Cell type annotation
- Differential expression analysis
- Cross-species validation
- Translational target discovery
- Reproducible computational biology workflows
- Evidence-based therapeutic target prioritization

---

## Project Impact

This project demonstrates how integrating multiple independent transcriptomic datasets can improve confidence in therapeutic target discovery. Rather than relying on a single dataset, the workflow combines orthogonal biological evidence to prioritize candidates with stronger translational potential.

The computational framework is readily adaptable to other autoimmune and inflammatory diseases.

---

## Future Directions

Planned extensions include:

- Validation in additional lupus nephritis cohorts
- Integration with cell–cell communication analyses
- Incorporation of human genetic (GWAS) evidence
- Druggability assessment using public databases
- AI-assisted therapeutic target prioritization
- Multi-modal integration with complementary molecular datasets
