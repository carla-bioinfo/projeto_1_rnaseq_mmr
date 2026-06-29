# RNA-Seq Colorectal Cancer: dMMR vs pMMR Analysis

## 🎯 Objetivo do Projeto
Analisar assinatura transcriptômica de tumores colorectais com deficiência de Mismatch Repair (dMMR) vs proficientes (pMMR) usando RNA-Seq, identificar fenótipo imunogênico ("HOT") e validar em cohort independente.

---

## 📊 Datasets

### GSE39582 (Discovery)
- **585 amostras** colorectais
- **77 dMMR** vs **459 pMMR**
- Plataforma: Affymetrix HG-U133 Plus 2.0
- Status: ✅ Fases 1-8 Parte 1 COMPLETAS

### GSE17536 (Validation)
- **177 amostras** colorectais independentes
- Plataforma: Affymetrix HG-U133 Plus 2.0
- Status: ✅ Fase 8 Parte 2 COMPLETA

---

## 🔄 Pipeline

### Fase 1-5: QC e DEA
- ✅ Download e normalização (GEO RMA)
- ✅ QC (boxplot, PCA, MA-plot)
- ✅ DEA com DESeq2, edgeR, limma
- ✅ Integração de 3 métodos

### Fase 6: Consensus
- ✅ 5,532 genes consensus (overlap 3 métodos)

### Fase 7: Enriquecimento
- ✅ 561 genes significantes (padj < 0.05)
- ✅ GO, KEGG, Reactome enriquecimento
- ✅ Fenótipo "HOT" identificado:
  - Immune System (p=2.18e-14)
  - Cytokine Signaling (p=2.32e-11)
  - Interferon-alpha/beta (p=4.78e-10)

### Fase 8 Parte 1: Probe Aggregation ✅
- ✅ 615 probes → 450 genes únicos
- ✅ Método: MEDIANA de log2FC (robusto)
- ✅ P-value: probe com |log2FC| máximo
- ✅ Validação: 0 duplicatas, 0 NAs

### Fase 8 Parte 2: External Validation ✅
- ✅ GSE17536 baixado (177 amostras)
- ✅ 450 genes em novo dataset
- ✅ Fenótipo HOT CONFIRMADO (reproducível!)
- ✅ 228 UP, 222 DOWN (balanceado)

### Fase 8 Parte 3: Survival Analysis ⏳
- ⏳ Análise de sobrevida (OS/DFS)
- ⏳ Kaplan-Meier curves
- ⏳ Cox regression
- ⏳ Validação de poder preditivo

---

## 🔬 Top 10 Genes (Fase 8)

| Gene | log2FC | p-value | Probes | Função |
|------|--------|---------|--------|--------|
| KISS1R | -1.94 | 1.31e-199 | 1 | Supressor tumoral |
| CAB39L | +1.03 | 4.53e-121 | 3 | Proteína sinalizadora |
| JAK2 | +1.15 | 2.99e-120 | 2 | Sinalização citocina ⭐ |
| C3orf85 | +1.17 | 5.58e-117 | 1 | Proteína desconhecida |
| HLA-DQA1 | +0.03 | 1.06e-111 | 2 | MHC Class II ⭐ |
| CES1 | +1.97 | 1.90e-107 | 1 | Carboxilesterase |
| ANP32E | +1.41 | 7.65e-104 | 2 | Regulador transcricional |
| HCAR3 | +1.76 | 4.92e-100 | 1 | Receptor G-protein |
| ETV5 | +1.16 | 3.55e-98 | 1 | Fator transcricional |
| OSR2 | +1.05 | 5.14e-98 | 1 | Fator transcricional |

⭐ = Relacionado a imunossurveillância / sinalização citocina

---

## 📁 Estrutura do Repositório
projeto_1_rnaseq_mmr/

├── data/

│   ├── GSE39582/          ← Expression matrix + phenotypes

│   └── GSE17536/          ← Validation dataset (Windows)

│

├── results/

│   ├── tables/

│   │   ├── FASE8_genes_aggregated_full.csv      (450 genes)

│   │   └── FASE8_gene_symbols_final.txt         (símbolos)

│   ├── figures/           ← PCA, vulcano, heatmaps

│   ├── enrichment/        ← GO, KEGG, Reactome

│   └── FASE8_PARTE2_RESUMO_VALIDACAO.csv      (validação GSE17536)

│

├── src/

│   ├── FASE1_download_and_qc.R

│   ├── FASE2_normalization.R

│   ├── FASE3_quality_control.R

│   ├── FASE4_dea_deseq2_edger_limma.R

│   ├── FASE5_dea_integration.R

│   ├── FASE6_consensus_genes.R

│   ├── FASE7_enrichment_analysis.R

│   ├── FASE8_aggregate_probes_to_genes.R

│   └── FASE8_PARTE3_survival_analysis.R (próximo)

│

├── FASE8_PARTE2_DOCUMENTACAO.md  ← O que foi feito

├── HANDOFF_FASE8_PARTE3.md       ← Guia próxima etapa

└── README.md                      ← Este arquivo
---

## 🚀 Como Executar

### Próxima Sessão: Fase 8 Parte 3
```bash
cd ~/projeto_1_rnaseq_mmr
git pull origin main                    # atualizar
cat HANDOFF_FASE8_PARTE3.md             # ler guia
# Depois: executar script survival no Windows ou Linux
```

### Quick Status Check
```bash
cd ~/projeto_1_rnaseq_mmr
git log --oneline -5                    # histórico
ls -la results/FASE8*                   # arquivos Fase 8
cat HANDOFF_FASE8_PARTE3.md | head -20  # próximos passos
```

---

## 🧬 Interpretação Biológica

### Fenótipo "HOT" (Imunogênico)
Confirmado em GSE39582 (Fase 7) e **validado** em GSE17536 (Fase 8 Parte 2):

**Genes principais:**
- **JAK2, STAT1**: Sinalização Interferon
- **CXCL8, CXCL10**: Quimiocinas pró-inflamatórias
- **IL-6**: Citocina pró-inflamatória
- **GNLY, NKG7, PRF1**: Citotoxicidade (NK cells, CTLs)
- **HLA-DQA1**: Apresentação antigênica

**Mecanismo:**
dMMR → Instabilidade microsatélite → Carga mutacional ↑ → Neoantígenos ↑ → Infiltração imune ↑ → Fenótipo "HOT"

**Próximo passo:** Validar se esse padrão prediz sobrevida melhor (Fase 8 Parte 3)

---

## 📊 Estatísticas Resumidas

| Métrica | Valor |
|---------|-------|
| Genes únicos finais | 450 |
| Genes UP | 228 |
| Genes DOWN | 222 |
| p-value mínimo | 1.31e-199 |
| log2FC máximo | +2.674 |
| log2FC mínimo | -3.093 |
| GSE39582 amostras | 585 |
| GSE17536 amostras | 177 |
| Total validado | 762 amostras |

---

## 🔧 Dependências Técnicas

### Windows (✅ Funcionando)
- R 4.5.2
- GEOquery ✅
- Biobase ✅
- BiocGenerics ✅
- survival (para Fase 8.3)
- survminer (para Fase 8.3)

### Linux (⏳ Em progresso)
- R 4.0.4
- GEOquery ❌ (dependências de sistema não resolvidas)
- Workaround: Usar Windows, sincronizar via GitHub

---

## 📚 Referências

- **GEO**: https://www.ncbi.nlm.nih.gov/geo/
- **DESeq2**: Love MI, et al. Genome Biol. 2014
- **edgeR**: Robinson MD, et al. Bioinformatics. 2010
- **limma**: Ritchie ME, et al. Nucleic Acids Res. 2015
- **Enrichment**: https://www.enrichr.org/

---

## 👤 Autor
**Carla Rodriguês de Moraes**
- Biomedicine + Data Science student
- Focus: Lynch Syndrome, MMR genes, Genomic AI
- GitHub: https://github.com/carla-bioinfo

---

## 📝 Changelog

- **2026-06-29**: Fase 8 Parte 2 COMPLETA (GSE17536 validation)
- **2026-06-29**: Fase 8 Parte 1 COMPLETA (Probe aggregation, 450 genes)
- **2026-06-xx**: Fase 7 COMPLETA (Enrichment analysis, fenótipo HOT)
- **2026-06-xx**: Fase 6 COMPLETA (5,532 consensus genes)

---

**Próxima etapa: Fase 8 Parte 3 (Survival Analysis) ⏳🚀**

