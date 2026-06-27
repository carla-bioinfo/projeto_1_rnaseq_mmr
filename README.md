# Projeto 1: Caracterização Transcriptômica MMR/Lynch
**Análise de expressão gênica em adenocarcinomas colorretais com deficiência de reparo de DNA (dMMR)**

## 📋 Status do Projeto
| Fase | Descrição | Status | Data |
|---|---|---|---|
| **1-5** | Preparação e exploração inicial | ✅ Completo | Janeiro-Maio 2026 |
| **6** | Validação Interna (DESeq2, edgeR, limma) | ✅ Completo | 25/05/2026 |
| **7** | Enriquecimento GO/KEGG/Reactome | ✅ Completo | 27/06/2026 |
| **8** | Validação Externa (GSE17536, sobrevida) | ⏳ Planejado | Julho 2026 |
| **9** | Publicação & Manuscript | ⏳ Planejado | Agosto 2026 |

---

## 📊 Visão Geral do Projeto
### Objetivo
Caracterizar a assinatura transcriptômica de tumores colorretais com **deficiência de reparo de DNA (dMMR)** associados à **Síndrome de Lynch**, identificando genes biomarcadores, padrões de enriquecimento funcional e potencial terapêutico.

### Dataset
- **Fonte:** GEO - GSE39582 (Marisa et al., 2013)
- **Amostras:** 585 adenocarcinomas colorretais
- **Plataforma:** Affymetrix HG-U133 Plus 2.0
- **Genes:** 54.675 probes
- **Grupos:** 77 dMMR (Lynch) vs 459 pMMR (esporádicos)

### Genes de Interesse (MMR)
- MLH1 (Mutator L Homolog 1)
- MSH2 (MutS Homolog 2)
- MSH6 (MutS Homolog 6)
- PMS2 (PMS1 Homolog 2)
- EPCAM (Epithelial Cell Adhesion Molecule)

---

## 🔬 Metodologia

### **FASE 1-5: Exploração e Preparação** ✅
- Download de dados via GEOquery
- Normalização RMA + ComBat batch correction
- Análise exploratória (PCA, clustering)
- Preparação para análise diferencial

### **FASE 6: Validação Interna** ✅
**Resultado:** 5.532 genes consenso (88-93% overlap, r=0.86-0.93)

Três métodos independentes:
- **DESeq2:** 646 genes significantes
- **edgeR:** 6.648 genes significantes
- **limma-voom:** 6.626 genes significantes

**Validação:**
- ✅ PCA: PC1 separa dMMR vs pMMR (16.39% variância)
- ✅ Clustering hierárquico mostra agrupamento claro
- ✅ Correlação log2FC entre métodos: 0.86-0.93

### **FASE 7: Enriquecimento GO/KEGG/Reactome** ✅

**Genes analisados:** 561 gene symbols (91% mapeamento)

**Top Pathways — Reactome 2024:**
1. **Immune System** (p=2.18e-14) ⭐⭐⭐
2. **Cytokine Signaling** (p=2.32e-11) ⭐⭐⭐
3. **Interferon Alpha-Beta Signaling** (p=1.92e-9) ⭐⭐
4. **Chemokine Receptors** (p=4.11e-9) ⭐⭐
5. **Interferon Signaling** (p=2.42e-8) ⭐⭐

**Top Pathways — KEGG 2026:**
1. **Viral Protein-Cytokine Interaction** (p=7.3e-11) ⭐⭐⭐
2. **Rheumatoid Arthritis** (p=2.04e-9) ⭐⭐
3. **Chemokine Signaling** (p=2.31e-9) ⭐⭐
4. **HSV-1 Infection** (p=2.87e-8) ⭐⭐
5. **Cytokine-Cytokine Receptor** (p=2.81e-7) ⭐⭐

**Genes Chave Identificados:**
- **Citocinas:** IL-1β, IL-6, IL-18, TNF-α
- **Quimiocinas:** CXCL8, CXCL10, CXCL11, CCL5, CCL4
- **Interferon:** STAT1, JAK2, MX1, OAS2, ISG15
- **Antígenos:** HLA-DMA, HLA-DMB, HLA-DQA1, CD74
- **Citotoxicidade:** GNLY, GZMK, PRF1, NKG7

**Interpretação:** Tumores dMMR exibem fenótipo "HOT" (Hot, Inflamed, Primed) com ativação imune e resposta interferon elevada.

---

## 🧬 Descobertas Principais

### **Fenótipo "Hot Tumor" em dMMR**
Deficiência MMR → Neoantigênios → Resposta Interferon/Citocina → Tumor Inflamado
✅ **Implicações Clínicas:**
- Candidatos para imunoterapia (checkpoint inhibitors)
- Alto TMB (Tumor Mutational Burden)
- Expressão elevada de PD-L1 esperada
- Potencial para anti-PD-1/CTLA-4

### **Assinatura Secundária, Não Primária**
- MLH1, MSH2, MSH6, PMS2, EPCAM **não são diferencialmente expressos**
- A assinatura é **resposta ao defeito**, não defeito em si
- Genes operacionais (imunológicos) alterados, não estruturais

---

## 📁 Estrutura do Projeto
projeto_1_rnaseq_mmr/

├── src/

│   ├── 00_metodologia.R

│   ├── 02_preparacao_dados.R

│   ├── 03_deseq2.R

│   ├── 04_pca_validation.R

│   ├── 05_clustering.R

│   └── 07_enrichment_go_kegg.py

├── results/

│   ├── figures/

│   │   └── [gráficos PCA, clustering, heatmaps]

│   ├── tables/

│   │   ├── deseq2_significant_genes.csv

│   │   ├── edger_genes_significant.csv

│   │   ├── limma_genes_significant.csv

│   │   ├── fase6_genes_consenso.csv

│   │   ├── genes_for_enrichR.txt

│   │   └── genes_for_enrichment_full.csv

│   ├── enrichment/

│   │   ├── Reactome_Pathways_2024_table.txt

│   │   └── KEGG_2026_table.txt

│   └── relatorio_fase1_validacao_interna.html

├── FASE_7_RELATORIO_ENRIQUECIMENTO.md

├── README.md

├── CHANGELOG.md

└── LICENSE.R
---

## 📊 Métricas Resumidas

| Métrica | Valor |
|---------|-------|
| Genes DEG (consenso) | 5.532 |
| Genes para enriquecimento | 561 |
| Taxa mapeamento | 91% |
| Pathways significantes (Reactome) | >100 |
| Pathways significantes (KEGG) | >30 |
| Top pathway p-value | 2.18e-14 |
| Overlap DESeq2-edgeR | 88-93% |
| Correlação log2FC | 0.86-0.93 |

---

## 🎯 Próximas Etapas

### **FASE 8: Validação Externa** (Julho 2026)
- [ ] Download GSE17536 (Marisa et al., cohort independente)
- [ ] Validar top genes (CXCL8, IL-6, STAT1)
- [ ] Análise de sobrevida vs assinatura imune
- [ ] Correlação com PD-L1, TMB, MSI status
- [ ] Integração com dados de tumor microenvironment

### **FASE 9: Publicação** (Agosto 2026)
- [ ] Preparar manuscript para BMC Cancer / Cancer Immunology Research
- [ ] Gráficos profissionais (ggplot2, ComplexHeatmap)
- [ ] Suplementar com tabelas de genes
- [ ] Discussão: implicações para imunoterapia em Lynch
- [ ] Preprint em bioRxiv

---

## 🛠️ Ferramentas & Linguagens

| Ferramenta | Versão | Uso |
|-----------|--------|-----|
| R | 4.0.4 | Análise estatística |
| Python | 3.9.2 | Scripts auxiliares |
| DESeq2 | BioConductor | Análise diferencial |
| edgeR | BioConductor | Validação |
| limma | BioConductor | Validação |
| enrichR | API | Enriquecimento funcional |
| Linux | Debian Bullseye | Execução |

---

## 📚 Referências & Bases de Dados

### **Dados Clínicos**
- GEO GSE39582: https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE39582
- Marisa et al. (2013): Gastric, Liver, & Bowel Cancer

### **Bancos de Dados**
- **enrichR:** https://maayanlab.cloud/Enrichr/
- **ClinVar:** https://www.ncbi.nlm.nih.gov/clinvar/ (variantes MMR)
- **InSiGHT:** https://www.insight-group.org/ (Lynch-específico)
- **GTEx:** https://gtexportal.org/home/ (expresão normal)
- **COSMIC:** https://cancer.sanger.ac.uk/cosmic (mutações somáticas)

---

## 👤 Autora & Contato

**Carla Rodrigues de Moraes**
- 👨‍🎓 Estudante de Biomedicina + Data Science
- 🧬 Especialização: Síndrome de Lynch, Genes MMR
- 🐱 GitHub: [@carla-bioinfo](https://github.com/carla-bioinfo)
- 📧 carlabio.biomol@gmail.com

---

## 📄 Licença
MIT License — Veja LICENSE.R para detalhes

---

**Última atualização:** 27/06/2026 (Fase 7 Completa)  
**Status:** ✅ Pronto para Fase 8 (Validação Externa)
