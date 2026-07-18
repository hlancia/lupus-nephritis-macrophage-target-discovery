############################################################
# 01_human_discovery.R
#
# Project:
# Cross-species prioritization of inflammatory macrophage
# targets in lupus nephritis
#
# Purpose:
# Load and process the human AMP lupus nephritis single-cell
# RNA-seq dataset, perform clustering, annotate cell types,
# and identify the inflammatory macrophage population.
############################################################

library(Seurat)
library(data.table)
library(dplyr)
library(ggplot2)

# Load expression matrix
expr <- fread(
  "data/gene_by_cell_exp_mat.736297.txt",
  data.table = FALSE
)

# Set gene names as row names
rownames(expr) <- expr[, 1]
expr <- expr[, -1]

# Create Seurat object
ln <- CreateSeuratObject(
  counts = expr,
  project = "AMP_LN"
)

ln

############################################################
# Quality control and preprocessing
############################################################

# Calculate mitochondrial percentage
ln[["percent.mt"]] <- PercentageFeatureSet(
  ln,
  pattern = "^MT-"
)

# Basic QC plot
VlnPlot(
  ln,
  features = c("nFeature_RNA", "nCount_RNA", "percent.mt"),
  ncol = 3
)

# Standard preprocessing
ln <- NormalizeData(ln)

ln <- FindVariableFeatures(
  ln,
  selection.method = "vst",
  nfeatures = 2000
)

ln <- ScaleData(ln)

ln <- RunPCA(ln)

ElbowPlot(ln, ndims = 30)

############################################################
# UMAP and clustering
############################################################

# Based on elbow plot, use first 15 PCs
ln <- RunUMAP(
  ln,
  dims = 1:15
)

ln <- FindNeighbors(
  ln,
  dims = 1:15
)

ln <- FindClusters(
  ln,
  resolution = 0.5
)

# Visualize clusters
DimPlot(
  ln,
  label = TRUE,
  repel = TRUE
)

# Check cluster sizes
table(Idents(ln))

############################################################
# Cell type annotation
############################################################

new.ids <- c(
  "NK",
  "CD4_T",
  "CD8_Cytotoxic",
  "B_Cell",
  "Inflammatory_Macrophage",
  "CD8_TRM",
  "Treg",
  "cDC2",
  "Stromal_1",
  "Stromal_2",
  "LAMP3_DC",
  "Cycling"
)

names(new.ids) <- levels(ln)

ln <- RenameIdents(
  ln,
  new.ids
)

# Verify annotation
table(Idents(ln))

############################################################
# Save processed object
############################################################

saveRDS(
  ln,
  "../AMP_LN_human_final.rds"
)

############################################################
# Outputs
#
# AMP_LN_human_final.rds
#
# Annotated human lupus nephritis atlas
#
############################################################