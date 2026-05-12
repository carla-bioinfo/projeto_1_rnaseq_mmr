# ==============================================================================
# PROJETO 1 — ANÁLISE TRANSCRIPTÔMICA MMR/LYNCH
# Etapa 2: Preparação dos Dados (GEO - alternativa rápida)
# ==============================================================================

library(GEOquery)
library(Biobase)
library(tidyverse)

cat("Baixando dados GSE39582 (566 amostras de câncer colorretal)...\n")

# Baixar dataset público (GSE39582 - Marisa et al 2013)
# Esse é o dataset alternativo que recomendei no guia
gse <- getGEO("GSE39582", GSEMatrix = TRUE, getGPL = FALSE)

# Extrair o primeiro (e único) objeto ExpressionSet
eset <- gse[[1]]

cat("✓ Dados carregados!\n")
cat("Dimensões:", dim(exprs(eset)), "\n")
cat("Amostras:", ncol(eset), "\n")
cat("Genes:", nrow(eset), "\n")

# Ver primeiras linhas
cat("\nPrimeiras 5 genes, primeiras 5 amostras:\n")
print(head(exprs(eset), 5)[, 1:5])

# Ver informação das amostras
cat("\nInformação das amostras:\n")
print(head(pData(eset)))

# Salvar para uso posterior
save(eset, file = "data/processed/eset_gse39582.RData")
cat("\n✓ Dados salvos em data/processed/eset_gse39582.RData\n")
