# Projeto 1 — Caracterização Transcriptômica MMR/Lynch

![R](https://img.shields.io/badge/R-4.0+-blue?style=flat)
![Status](https://img.shields.io/badge/Status-Active-brightgreen?style=flat)
![Dataset](https://img.shields.io/badge/Dataset-TCGA%20COAD-orange?style=flat)

*Análise de expressão diferencial em tumores colorretais com deficiência de MMR*

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
| **Fonte** | TCGA-COAD (The Cancer Genome Atlas) |
| **Tipo** | RNA-seq (Illumina sequencing) |
| **Amostras** | ~460 adenocarcinomas de cólon |
| **Genes** | 20,530 genes proteicos |
| **Status MSI** | Anotado (MSI-H, MSI-L, MSS) |

## 📁 Estrutura do Projeto
```
projeto_1_rnaseq_mmr/
├── data/
│   ├── raw/              # Dados originais TCGA
│   └── processed/        # Dados após QC e filtragem
├── src/                  # Scripts R para análise
│   ├── 01_load_data.R
│   ├── 02_qc_filtering.R
│   ├── 03_deseq2.R
│   ├── 04_pca_validation.R
│   └── 05_clustering.R
├── notebooks/            # Análise narrativa em Quarto
│   └── analise_principal.qmd
├── results/              # Figuras e tabelas geradas
│   ├── figures/
│   └── tables/
├── reports/              # Relatório final em PDF
│   └── relatorio_completo.pdf
└── README.md
```
## 🔬 Métodos

- **Normalização**: TMM (Trimmed Mean of M-values)
- **Filtragem**: Genes com CPM > 1 em ≥3 amostras
- **Análise de Expressão Diferencial**: DESeq2
- **Validação**: PCA + Clustering hierárquico + Heatmaps

## 📈 Resultados Esperados

- ✅ Identificação de genes significativamente alterados
- ✅ Separação clara entre grupos MSI-H e MSS
- ✅ Padrões de co-expressão biologicamente interpretáveis
- ✅ Validação de robustez metodológica

## 🚀 Como Rodar

### Opção 1: No RStudio (Recomendado)

```r
# Abra o arquivo
open("notebooks/analise_principal.qmd")

# Ou execute no RStudio:
# File → Open → notebooks/analise_principal.qmd
# Clique em "Render"
```

### Opção 2: Via linha de comando (R)

```r
source("src/01_load_data.R")
source("src/02_qc_filtering.R")
source("src/03_deseq2.R")
source("src/04_pca_validation.R")
source("src/05_clustering.R")
```

## 📦 Dependências

```r
# CRAN
install.packages(c("tidyverse", "ggplot2", "pheatmap"))

# Bioconductor
BiocManager::install(c("DESeq2", "edgeR", "limma", "ComplexHeatmap"))
```

## 📚 Referências

- TCGA Consortium. (2012). Comprehensive molecular characterization of human colon and rectal cancer. *Nature*, 487(7407), 330-337.
- Love, M. I., Huber, W., & Anders, S. (2014). Moderated estimation of fold change and dispersion for RNA-seq data with DESeq2. *Genome Biology*, 15(12), 550.

## 👤 Autora

**Carla Rodrigues de Moraes**
- 📧 carla.bioinfo@email.com
- 🔗 [LinkedIn](https://linkedin.com/in/carla-bioinfo)
- 💻 [GitHub](https://github.com/carla-bioinfo)

## 📄 License

MIT License

---

**Status**: Análise em andamento | **Fase**: 1 (Análise interna)
