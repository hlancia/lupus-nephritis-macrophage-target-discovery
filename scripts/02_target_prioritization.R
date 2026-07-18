############################################################
# 02_target_prioritization.R
#
# Project:
# Cross-species prioritization of inflammatory macrophage
# targets in lupus nephritis
#
# Purpose:
# Identify inflammatory macrophage markers in the human AMP
# lupus nephritis dataset and build a target prioritization
# framework based on expression, biology, and druggability.
############################################################

library(Seurat)
library(dplyr)
library(tibble)
library(ggplot2)
library(tibble)

############################################################
# Load processed human object
############################################################

ln <- readRDS("../AMP_LN_human_final.rds")

# Verify annotations
table(Idents(ln))

############################################################
# Extract inflammatory macrophages
############################################################

human_macrophages <- subset(
  ln,
  idents = "Inflammatory_Macrophage"
)

human_macrophages

############################################################
# Macrophage marker discovery
############################################################

macrophage_markers <- FindMarkers(
  ln,
  ident.1 = "Inflammatory_Macrophage",
  only.pos = TRUE,
  min.pct = 0.25,
  logfc.threshold = 0.25
)

head(macrophage_markers)

############################################################
# Save marker table
############################################################

macrophage_markers <- macrophage_markers %>%
  rownames_to_column("Gene") %>%
  arrange(desc(avg_log2FC))

write.csv(
  macrophage_markers,
  "results/Human_Inflammatory_Macrophage_Markers.csv",
  row.names = FALSE
)

############################################################
# Top candidate genes
############################################################

candidate_targets <- macrophage_markers %>%
  dplyr::filter(
    avg_log2FC > 1,
    p_val_adj < 0.05
  )

nrow(candidate_targets)

head(candidate_targets, 10)

write.csv(
  candidate_targets,
  "results/Human_Candidate_Targets.csv",
  row.names = FALSE
)

############################################################
# Candidate target panel
############################################################

target_panel <- c(
  "C5AR1",
  "TLR4",
  "CSF1R",
  "P2RX7",
  "C3AR1",
  "CLEC7A",
  "SIGLEC1",
  "LILRB2",
  "CD300E",
  "PILRA"
)

target_table <- candidate_targets %>%
  dplyr::filter(
    Gene %in% target_panel
  ) %>%
  dplyr::select(
    Gene,
    avg_log2FC,
    pct.1,
    pct.2,
    p_val_adj
  ) %>%
  arrange(desc(avg_log2FC))

target_table

write.csv(
  target_table,
  "results/Human_Target_Table.csv",
  row.names = FALSE
)

############################################################
# Lead target expression visualization
############################################################

lead_targets <- c(
  "C5AR1",
  "CSF1R",
  "LILRB2",
  "PILRA"
)

DotPlot(
  ln,
  features = lead_targets
) +
  RotatedAxis()

png(
  "figures/Figure2_Human_Lead_Targets_DotPlot.png",
  width = 2400,
  height = 1500,
  res = 300
)

DotPlot(
  ln,
  features = lead_targets
) +
  RotatedAxis()

dev.off()