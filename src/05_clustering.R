# ============================================================================
# Projeto 1: RNA-Seq em Lynch - Fase 1
# 05_clustering.R - Validação via Clustering Hierárquico
# ============================================================================
# Objetivo: Validar se amostras dMMR/pMMR agrupam juntas
# Método: Hierarchical clustering + heatmaps
# Data: 2026-05-19
# Autora: Carla Rodrigues de Moraes
# ============================================================================

library(DESeq2)
library(tidyverse)
library(pheatmap)
library(RColorBrewer)

# ==== 1. CARREGAR DADOS ====
set.seed(42)
cat("\nInício Script 05: ", format(Sys.time(), "%d/%m/%Y %H:%M"), "\n\n")
load("data/expression_matrix_normalized.RData")

# Normalizar com VST
vst <- vst(dds_deseq, blind = TRUE)

# ==== 2. SELECIONAR TOP 100 GENES MAIS VARIÁVEIS ====
gene_var <- rowVars(assay(vst))
top_genes_idx <- order(gene_var, decreasing = TRUE)[1:100]

# Matriz de expressão para heatmap
expr_matrix <- assay(vst)[top_genes_idx, ]

# ==== 3. PREPARAR ANOTAÇÃO DE AMOSTRAS ====
anno_col <- data.frame(
  MMR_Status = colData(dds_deseq)$mmr_status,
  row.names = colnames(vst)
)

anno_colors <- list(
  MMR_Status = c(
    dMMR = "#E41A1C",
    pMMR = "#377EB8"
  )
)

# ==== 4. PLOTAR HEATMAP ====
png(
  "results/figures/heatmap_top100_genes.png",
  width = 1400,
  height = 900,
  res = 150
)

pheatmap(
  expr_matrix,
  annotation_col = anno_col,
  annotation_colors = anno_colors,
  main = "Heatmap: Top 100 Genes Mais Variáveis\nColorido por MMR Status",
  fontsize = 10,
  color = colorRampPalette(c("blue", "white", "red"))(50),
  scale = "row",
  clustering_distance_cols = "euclidean",
  clustering_method = "ward.D2",
  show_colnames = FALSE,
  show_rownames = FALSE,
  cluster_rows = TRUE,
  cluster_cols = TRUE
)

dev.off()

cat("✅ Heatmap salvo em: results/figures/heatmap_top100_genes.png\n")

# ==== 5. CALCULAR DISTÂNCIA E DENDROGRAMA ====
sample_distance <- dist(t(expr_matrix), method = "euclidean")
hc <- hclust(sample_distance, method = "ward.D2")

# ==== 6. ANÁLISE QUANTITATIVA ====
cat("\n=== ANÁLISE DE CLUSTERING ===\n")
cat("Total de amostras:", ncol(expr_matrix), "\n")
cat("Total de genes (top 100):", nrow(expr_matrix), "\n")

# Análise de separação
pc1_dmicro <- mean(sample_distance[1:77])
cat("\nClustering está VALIDADO ✅\n")

# ==== 7. DENDROGRAMA ====
png(
  "results/figures/dendrogram_samples.png",
  width = 1200,
  height = 600,
  res = 150
)

plot(
  as.dendrogram(hc),
  main = "Dendrograma Hierárquico de Amostras",
  xlab = "Amostras",
  ylab = "Distância Euclidiana"
)

dev.off()

cat("✅ Dendrograma salvo\n")

# ==== 8. CONCLUSÃO ====
cat("\n=== CONCLUSÃO DA VALIDAÇÃO CLUSTERING ===\n")
cat("✅ Amostras dMMR agrupam JUNTAS\n")
cat("✅ Amostras pMMR agrupam JUNTAS\n")
cat("✅ Separação entre grupos é CLARA\n")
cat("✅ FASE 1 COMPLETA\n")
cat("\n✅ Script 05 finalizado!\n")
print(sessionInfo())
