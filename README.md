# Projeto 1 — Caracterização Transcriptômica MMR/Lynch

![R](https://img.shields.io/badge/R-4.0+-blue?style=flat)
![Status](https://img.shields.io/badge/Status-Active-brightgreen?style=flat)
![Dataset](https://img.shields.io/badge/Dataset-GSE39582-orange?style=flat)

*Análise de expressão diferencial em tumores colorretais com deficiência de MMR | Estudante de Bioinformática*

## 🎯 Objetivo

Análise de **expressão diferencial** em tumores colorretais com:
- **dMMR/MSI-H** (deficientes em Mismatch Repair / Microssatélite Instável Alto)
- **pMMR/MSS** (proficientes em Mismatch Repair / Microssatélite Estável)

### Perguntas de Pesquisa
- Quais genes diferenciam tumores dMMR de pMMR?
- Há padrões de co-expressão biologicamente relevantes?
- Os achados são reproduzíveis em múltiplos métodos?

## 📊 Conjunto de Dados

| Propriedade | Valor |
|-------------|-------|
| **Fonte** | GSE39582 (Marisa et al., 2013) |
| **Tipo** | RNA-seq (Microarray - Affymetrix) |
| **Amostras** | 566 adenocarcinomas de cólon |
| **Genes** | ~20k genes |
| **Status MSI** | Anotado (MSI-H, MSI-L, MSS) |

## 📁 Estrutura do Projeto

projeto_1_rnaseq_mmr/
├── src/                          # Scripts R em sequência
│   ├── 02_preparacao_dados.R     # Download e QC dos dados
│   ├── 03_deseq2.R               # Análise de expressão diferencial
│   ├── 04_pca_validation.R       # Validação por PCA
│   └── 05_clustering.R           # Validação por clustering
│
├── data/
│   ├── raw/                      # Dados brutos (GEO/TCGA)
│   └── processed/                # Dados após processamento
│
├── results/                       # Saídas geradas automaticamente
│   ├── figures/                  # Figuras (PNG, PDF)
│   │   ├── pca_plot_validation.png
│   │   ├── scree_plot.png
│   │   ├── heatmap_top100_genes.png
│   │   └── dendrogram_samples.png
│   │
│   └── tables/                   # Tabelas de resultados
│       ├── deseq2_results_full.csv
│       ├── deseq2_significant_genes.csv
│       └── top_genes.csv
│
├── relatorio_fase1.Rmd           # Relatório de validação interna
├── projeto_1_rnaseq_mmr.Rproj    # Projeto RStudio
└── README.md

## 🔬 Métodos

- **Normalização**: Median Ratio Normalization (DESeq2 built-in)
- **Filtragem**: Genes com CPM > 1 em ≥3 amostras
- **Análise de Expressão Diferencial**: DESeq2
- **Validação**: PCA + Clustering hierárquico + Heatmaps

**Nota técnica**: A normalização é aplicada internamente por DESeq2 via função `estimateSizeFactors()`, que corrige vieses de profundidade de sequenciamento usando o método Median Ratio.

## 📈 Resultados Esperados

- ✅ Identificação de genes significativamente alterados
- ✅ Separação clara entre grupos MSI-H e MSS
- ✅ Padrões de co-expressão biologicamente interpretáveis
- ✅ Validação de robustez metodológica

## 🚀 Como Rodar

### Opção 1: Via linha de comando (Recomendado)

Execute os scripts em sequência:

```r
source("src/02_preparacao_dados.R")    # Carregar dados do GEO
source("src/03_deseq2.R")              # Análise de expressão diferencial
source("src/04_pca_validation.R")      # Validação por PCA
source("src/05_clustering.R")          # Validação por clustering
```

### Opção 2: Script por script no RStudio

Abra cada arquivo em `src/` no RStudio e execute com:
- Windows/Linux: `Ctrl + Shift + Enter`
- Mac: `Cmd + Shift + Enter`

**Ordem importa!** Execute nesta sequência:
1. `02_preparacao_dados.R` (primeiro — cria dados)
2. `03_deseq2.R` (precisa dos dados do passo 1)
3. `04_pca_validation.R` (precisa dos resultados DESeq2)
4. `05_clustering.R` (usa dados normalizados)

## 📦 Dependências

```r
# CRAN
install.packages(c("tidyverse", "ggplot2", "pheatmap"))

# Bioconductor
BiocManager::install(c("DESeq2", "edgeR", "limma", "ComplexHeatmap"))
```

## 📚 Referências

- Marisa, L., et al. (2013). Gene expression classification of colon cancer into molecular subtypes: Characterization, validation, and prognostic value. *Gut*, 62(5), 683-694.
- Love, M. I., Huber, W., & Anders, S. (2014). Moderated estimation of fold change and dispersion for RNA-seq data with DESeq2. *Genome Biology*, 15(12), 550.
- TCGA Consortium. (2012). Comprehensive molecular characterization of human colon and rectal cancer. *Nature*, 487(7407), 330-337.

## 👤 Autora

**Carla Rodrigues de Moraes** — Estudante de Bioinformática

- 📧 carla.bioinfo@email.com
- 🔗 [LinkedIn](https://linkedin.com/in/carla-bioinfo)
- 💻 [GitHub](https://github.com/carla-bioinfo)

## 📄 License

MIT License

---

**Status**: Análise em andamento | **Fase**: 1 (Validação interna)

### 🎓 Aprendizados Deste Projeto

- Descobri confusão entre normalização **TMM (edgeR)** vs **Median Ratio (DESeq2)**
- Aprendi importância de documentação **honesta** vs aspiracional
- Entendi valor crítico da **validação interna** (FASE 1)
- Validei separação entre grupos usando **PCA e clustering**

- 
