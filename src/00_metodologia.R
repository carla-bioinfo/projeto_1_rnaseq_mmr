# ==============================================================================
# PROJETO 1 — ANÁLISE TRANSCRIPTÔMICA MMR/LYNCH
# Script 00: Documentação Metodológica
# ==============================================================================
# Autora: Carla Rodrigues de Moraes (Estudante)
# Data: 2026-05-21
# Objetivo: Documentar metodologia e versões de pacotes usados
# ==============================================================================

cat("\n")
cat("╔════════════════════════════════════════════════════════════════╗\n")
cat("║   PROJETO 1: ANÁLISE TRANSCRIPTÔMICA MMR/LYNCH - FASE 1        ║\n")
cat("║   Validação Interna | Estudante de Bioinformática             ║\n")
cat("╚════════════════════════════════════════════════════════════════╝\n")

# ==== INFORMAÇÕES DE SESSÃO ====
cat("\n📋 INFORMAÇÕES DE SESSÃO\n")
cat("────────────────────────────────────────────────────────────────\n")
cat("Data de execução:", format(Sys.time(), "%d/%m/%Y às %H:%M:%S"), "\n")
cat("Versão R:", R.version$version.string, "\n")
cat("Plataforma:", R.version$platform, "\n")
cat("Diretório de trabalho:", getwd(), "\n")

# ==== DATASET ====
cat("\n📊 DATASET\n")
cat("────────────────────────────────────────────────────────────────\n")
cat("Fonte: GSE39582 (Marisa et al., 2013)\n")
cat("Tipo: RNA-seq (Microarray - Affymetrix)\n")
cat("Amostras: 566 adenocarcinomas colorretais\n")
cat("Genes: ~20,000 genes\n")
cat("Anotação: MSI-H, MSI-L, MSS (status de instabilidade microsatélite)\n")

# ==== PRÉ-PROCESSAMENTO ====
cat("\n🔧 PRÉ-PROCESSAMENTO\n")
cat("────────────────────────────────────────────────────────────────\n")
cat("Carregamento: Função GEOquery::getGEO()\n")
cat("Filtragem: CPM > 1 em ≥10% das amostras\n")
cat("Normalização: Dados já em log2 (pré-processados no GEO)\n")

# ==== NORMALIZAÇÃO ====
cat("\n🔄 NORMALIZAÇÃO\n")
cat("────────────────────────────────────────────────────────────────\n")
cat("Método: Median Ratio Normalization (DESeq2)\n")
cat("Função: estimateSizeFactors()\n")
cat("Aplicação: Interna ao DESeq2, durante DESeq()\n")
cat("Propósito: Corrigir diferenças de profundidade de sequenciamento\n")

# ==== ANÁLISE DE EXPRESSÃO DIFERENCIAL ====
cat("\n📊 ANÁLISE DE EXPRESSÃO DIFERENCIAL\n")
cat("────────────────────────────────────────────────────────────────\n")
cat("Pacote: DESeq2\n")
cat("Método: Negative Binomial com shrinkage de dispersão\n")
cat("Contraste: dMMR (caso) vs pMMR (controle)\n")
cat("Teste estatístico: Wald test\n")
cat("Ajuste múltiplo: Benjamini-Hochberg (FDR)\n")
cat("Threshold: padj < 0.05, |log2FC| > 1\n")

# ==== VALIDAÇÃO INTERNA (FASE 1) ====
cat("\n✅ VALIDAÇÃO INTERNA (FASE 1)\n")
cat("────────────────────────────────────────────────────────────────\n")
cat("1. PCA (Principal Component Analysis)\n")
cat("   - Top 500 genes mais variáveis\n")
cat("   - Esperado: Separação clara dMMR/pMMR\n\n")
cat("2. Clustering Hierárquico\n")
cat("   - Top 100 genes mais variáveis\n")
cat("   - Método: Ward.D2\n")
cat("   - Esperado: Amostras com mesmo MMR agrupam\n\n")
cat("3. Heatmap com anotação\n")
cat("   - Visualiza co-expressão\n")
cat("   - Esperado: Padrão coerente por grupos\n")

# ==== VERSÕES DOS PACOTES ====
cat("\n📦 VERSÕES DOS PACOTES\n")
cat("────────────────────────────────────────────────────────────────\n")

pkgs_check <- c("DESeq2", "tidyverse", "ggplot2", "pheatmap",
                "GEOquery", "Biobase", "ggrepel")

for (pkg in pkgs_check) {
  if (require(pkg, character.only = TRUE, quietly = TRUE)) {
    version <- as.character(packageVersion(pkg))
    cat(sprintf("  %-15s %s\n", paste0(pkg, ":"), version))
  } else {
    cat(sprintf("  %-15s [NÃO INSTALADO]\n", paste0(pkg, ":")))
  }
}

# ==== PRÓXIMOS PASSOS ====
cat("\n🚀 PRÓXIMOS PASSOS\n")
cat("────────────────────────────────────────────────────────────────\n")
cat("FASE 1 (ATUAL): Validação Interna ✅\n")
cat("  └─ Usando: PCA, Clustering, Heatmaps\n\n")
cat("FASE 2 (PRÓXIMA): Validação Metodológica\n")
cat("  └─ Usar edgeR e limma nos MESMOS dados\n")
cat("  └─ Comparar overlap de genes significativos\n\n")
cat("FASE 3: Validação Externa\n")
cat("  └─ Testar em TCGA-COAD independente\n")
cat("  └─ Verificar replicação dos achados\n\n")
cat("FASE 4: Análise Funcional\n")
cat("  └─ GSEA (Gene Set Enrichment Analysis)\n")
cat("  └─ GO Terms, Pathways\n")
cat("  └─ Interpretação biológica\n")

# ==== REFERÊNCIAS ====
cat("\n📚 REFERÊNCIAS\n")
cat("────────────────────────────────────────────────────────────────\n")
cat("Love, M.I., Huber, W., & Anders, S. (2014)\n")
cat("  DESeq2: Differential expression analysis for sequence count data\n")
cat("  Genome Biology, 15(12):550\n\n")
cat("Marisa, L., et al. (2013)\n")
cat("  Gene expression classification of colon cancer\n")
cat("  Gut, 62(5):683-694\n\n")
cat("GEO Database (NCBI)\n")
cat("  GSE39582: Gene expression omnibus\n")

# ==== FIM ====
cat("\n════════════════════════════════════════════════════════════════\n\n")
cat("✅ Documentação carregada! Pronto para análise.\n\n")

# Versão completa da sessão
cat("SESSÃO COMPLETA R:\n")
print(sessionInfo())

cat("\n════════════════════════════════════════════════════════════════\n\n")
