############################################################
# 05_consensus_ranking.R
#
# Purpose:
# Integrate evidence from human scRNA-seq discovery,
# mouse scRNA-seq validation, human spatial validation,
# and spatial macrophage correlation.
#
# Scoring:
#   1.0 = supported
#   0.5 = partial evidence
#   0.0 = not supported / unavailable
#
# The score is a transparent additive evidence count.
# It is not a standardized z-score, so lower-ranked targets
# do not receive misleading negative values.
############################################################

library(dplyr)
library(tidyr)
library(ggplot2)

############################################################
# Load evidence table
############################################################

consensus <- read.csv(
  "results/Consensus_Target_Ranking.csv",
  check.names = FALSE
)

consensus <- consensus %>%
  arrange(
    desc(Consensus_Score),
    desc(Human_Spatial),
    desc(Mouse_scRNA),
    desc(Human_scRNA)
  )

write.csv(
  consensus,
  "results/Consensus_Target_Ranking.csv",
  row.names = FALSE
)

############################################################
# Figure 4: cross-dataset evidence matrix
############################################################

evidence_long <- consensus %>%
  select(
    Gene,
    Human_scRNA,
    Mouse_scRNA,
    Human_Spatial,
    Macrophage_Correlation
  ) %>%
  pivot_longer(
    cols = -Gene,
    names_to = "Evidence_Source",
    values_to = "Evidence_Weight"
  ) %>%
  mutate(
    Evidence_Source = recode(
      Evidence_Source,
      Human_scRNA = "Human scRNA-seq",
      Mouse_scRNA = "Mouse scRNA-seq",
      Human_Spatial = "Human spatial",
      Macrophage_Correlation = "Spatial macrophage correlation"
    ),
    Evidence_Label = case_when(
      Evidence_Weight == 1 ~ "Supported",
      Evidence_Weight == 0.5 ~ "Partial",
      TRUE ~ "Not supported"
    ),
    Gene = factor(Gene, levels = rev(consensus$Gene))
  )

p4 <- ggplot(
  evidence_long,
  aes(
    x = Evidence_Source,
    y = Gene,
    fill = Evidence_Weight
  )
) +
  geom_tile(color = "white", linewidth = 1) +
  geom_text(aes(label = Evidence_Label), size = 3.5) +
  scale_fill_gradient(
    low = "white",
    high = "steelblue",
    limits = c(0, 1),
    breaks = c(0, 0.5, 1)
  ) +
  labs(
    x = "Independent evidence source",
    y = "Target",
    fill = "Evidence\nweight",
    title = "Cross-dataset evidence supporting prioritized macrophage targets"
  ) +
  theme_classic(base_size = 13) +
  theme(
    axis.text.x = element_text(angle = 25, hjust = 1),
    plot.title = element_text(face = "bold")
  )

ggsave(
  "figures/Figure4_Cross_Dataset_Evidence_Matrix.png",
  p4,
  width = 10,
  height = 6,
  dpi = 300
)

############################################################
# Figure 5: transparent positive consensus score
############################################################

p5 <- ggplot(
  consensus,
  aes(
    x = reorder(Gene, Consensus_Score),
    y = Consensus_Score
  )
) +
  geom_col() +
  geom_text(
    aes(label = sprintf("%.1f", Consensus_Score)),
    hjust = -0.2,
    size = 4
  ) +
  coord_flip() +
  scale_y_continuous(
    limits = c(0, 4.3),
    breaks = 0:4,
    expand = expansion(mult = c(0, 0.03))
  ) +
  labs(
    x = "Target",
    y = "Consensus evidence score (maximum = 4)",
    title = "Consensus prioritization of lupus nephritis macrophage targets"
  ) +
  theme_classic(base_size = 13) +
  theme(
    plot.title = element_text(face = "bold")
  )

ggsave(
  "figures/Figure5_Consensus_Target_Ranking.png",
  p5,
  width = 9,
  height = 6,
  dpi = 300
)

############################################################
# Interpretation
#
# C5AR1: support across all four evidence categories.
# CSF1R and PILRA: strong multi-dataset support with partial
# spatial case-control evidence.
# LILRB2: strong human and spatial support, but limited
# cross-species evidence because mouse Lilrb genes are not
# strict one-to-one functional equivalents of human LILRB2.
############################################################
