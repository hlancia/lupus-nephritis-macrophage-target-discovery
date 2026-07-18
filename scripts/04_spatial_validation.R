############################################################
# 04_spatial_validation.R
#
# Purpose:
# Validate prioritized macrophage-associated targets in an
# independent human lupus nephritis spatial transcriptomics
# dataset (GSE263909).
############################################################

library(GEOquery)
library(dplyr)
library(ggplot2)

############################################################
# Load spatial expression matrix
############################################################

expr_spatial <- read.csv(
  "GSE263909_Count_matrix_Q3norm.csv/GSE263909_Count_matrix_Q3norm.csv",
  row.names = 1,
  check.names = FALSE
)

dim(expr_spatial)

############################################################
# Load GEO metadata
############################################################

gse263909 <- getGEO(
  "GSE263909",
  GSEMatrix = TRUE
)

sample_meta <- pData(gse263909[[1]])

sample_meta$Group <- ifelse(
  grepl("^LN", sample_meta$title),
  "LN",
  "Control"
)

table(sample_meta$Group)

############################################################
# Target validation: LN vs Control glomerular ROIs
############################################################

spatial_targets <- c(
  "C5AR1", "C3AR1", "CSF1R", "TLR4",
  "CLEC7A", "P2RX7", "SIGLEC1", "PILRA",
  "LILRB2", "CD300E"
)

spatial_targets <- spatial_targets[
  spatial_targets %in% rownames(expr_spatial)
]

validation_results <- data.frame()

for(gene in spatial_targets){
  
  expr <- as.numeric(expr_spatial[gene, ])
  
  p <- wilcox.test(
    expr[sample_meta$Group == "LN"],
    expr[sample_meta$Group == "Control"]
  )$p.value
  
  fc <- mean(expr[sample_meta$Group == "LN"]) /
    mean(expr[sample_meta$Group == "Control"])
  
  validation_results <- rbind(
    validation_results,
    data.frame(
      Gene = gene,
      Spatial_FoldChange = fc,
      Spatial_Pvalue = p
    )
  )
}

validation_results <- validation_results %>%
  arrange(Spatial_Pvalue)

validation_results

write.csv(
  validation_results,
  "results/Human_Spatial_Validation_GSE263909.csv",
  row.names = FALSE
)

############################################################
# Macrophage score and target correlation
############################################################

macrophage_genes <- c(
  "C1QA", "C1QB", "C1QC", "CD68",
  "CSF1R", "AIF1", "LST1", "TYROBP"
)

macrophage_genes <- macrophage_genes[
  macrophage_genes %in% rownames(expr_spatial)
]

macrophage_score <- colMeans(
  expr_spatial[macrophage_genes, ],
  na.rm = TRUE
)

cor_results <- data.frame()

for(gene in spatial_targets){
  
  test <- cor.test(
    as.numeric(expr_spatial[gene, ]),
    macrophage_score,
    method = "spearman"
  )
  
  cor_results <- rbind(
    cor_results,
    data.frame(
      Gene = gene,
      Spearman_rho = as.numeric(test$estimate),
      Correlation_Pvalue = test$p.value
    )
  )
}

cor_results <- cor_results %>%
  arrange(desc(Spearman_rho))

cor_results

write.csv(
  cor_results,
  "results/Human_Spatial_Macrophage_Correlation.csv",
  row.names = FALSE
)