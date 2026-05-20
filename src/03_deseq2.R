# ============================================================================
# Projeto 1: RNA-Seq em Lynch - Fase 1
# 03_deseq2.R - Análise de Expressão Diferencial
# ============================================================================
# Objetivo: Identificar genes significativamente alterados em dMMR vs pMMR
# Método: DESeq2 com normalização TMM
# Data: 2026-05-19
# Autora: Carla Rodrigues de Moraes
# ============================================================================

# ==== 1. SETUP ====
library(DESeq2)
library(tidyverse)
library(ggplot2)
library(cowplot)

# Carregar dados preparados
load("data/expression_matrix_normalized.RData")
dds <- DESeq(dds_deseq)

# Extrair resultados
res <- results(dds, contrast = c("mmr_status", "dMMR", "pMMR"))
res_ordered <- res[order(res$padj), ]

summary(res)

# ==== 3. FILTRAR GENES SIGNIFICATIVOS ====
sig_genes <- res %>%
  as.data.frame() %>%
  rownames_to_column("gene_id") %>%
  filter(!is.na(padj)) %>%
  filter(padj < 0.05 & abs(log2FoldChange) > 1) %>%
  arrange(padj)

nrow(sig_genes)
head(sig_genes, 10)

# ==== 4. EXPORTAR RESULTADOS ====
dir.create("results/tables", showWarnings = FALSE)

write.csv(
  as.data.frame(res_ordered),
  "results/tables/deseq2_results_full.csv",
  row.names = TRUE
)

write.csv(
  sig_genes,
  "results/tables/deseq2_significant_genes.csv",
  row.names = FALSE
)

top_genes <- sig_genes %>% head(20)
write.csv(
  top_genes,
  "results/tables/top_genes.csv",
  row.names = FALSE
)

# ==== 5. ESTATÍSTICAS ====
cat("\n=== RESUMO DE GENES SIGNIFICATIVOS ===\n")
cat("Total genes testados:", nrow(res_ordered), "\n")
cat("Genes significativos:", nrow(sig_genes), "\n")
cat("Up-regulated:", sum(sig_genes$log2FoldChange > 0), "\n")
cat("Down-regulated:", sum(sig_genes$log2FoldChange < 0), "\n")
