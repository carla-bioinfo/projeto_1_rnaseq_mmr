# ==============================================================================
# PROJETO 1 — ANÁLISE TRANSCRIPTÔMICA MMR/LYNCH
# Etapa 1: Download e Preparo dos Dados do TCGA
# ==============================================================================

# Carregar bibliotecas
library(TCGAbiolinks)
library(SummarizedExperiment)
library(tidyverse)

# Mensagem de início
cat("Iniciando download dos dados do TCGA-COAD...\n")

# Definir parâmetros de download
projeto <- "TCGA-COAD"
tipo_dados <- "Gene Expression Quantification"
tipo_workflow <- "STAR - Counts"

# Criar query (busca) no GDC
query <- GDCquery(
  project = projeto,
  data.category = "Transcriptome Profiling",
  data.type = tipo_dados,
  workflow.type = tipo_workflow
)

cat("Query criada. Preparado para download.\n")
cat("Número de amostras:", nrow(query$results), "\n")

