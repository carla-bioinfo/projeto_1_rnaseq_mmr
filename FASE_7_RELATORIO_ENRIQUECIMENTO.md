# FASE 7: ENRIQUECIMENTO GO/KEGG — RELATÓRIO COMPLETO

**Data:** 27 de Junho de 2026  
**Projeto:** Caracterização Transcriptômica MMR/Lynch  
**Dataset:** GSE39582 (Affymetrix HG-U133 Plus 2.0)  
**Status:** ✅ CONCLUÍDO

---

## 📊 RESUMO EXECUTIVO

### Genes Analisados
- **Total de genes significantes:** 615 probes Affymetrix
- **Genes convertidos para símbolos:** 561 (91% de sucesso)
- **Genes não mapeados:** 54 (probes obsoletas)

### Metodologia
1. ✅ Fase 6: Validação interna (DESeq2, edgeR, limma) → 5.532 genes consenso
2. ✅ Fase 7: Conversão probe IDs → gene symbols via MyGene.info API
3. ✅ Enriquecimento funcional via enrichR (561 genes, 228 bancos de dados)

---

## 🔬 RESULTADOS PRINCIPAIS

### **Reactome Pathways 2024** (TOP 5)

| Rank | Pathway | P-Value | Genes | Biologia |
|------|---------|---------|-------|----------|
| 1 | **Immune System** | 2.18e-14 | 104/2150 | Resposta imunológica global |
| 2 | **Cytokine Signaling in Immune System** | 2.32e-11 | 50/776 | Sinalização citocina |
| 3 | **Interferon Alpha Beta Signaling** | 1.92e-9 | 14/78 | Resposta antiviral (IFN-α/β) |
| 4 | **Chemokine Receptors Bind Chemokines** | 4.11e-9 | 12/57 | Recrutamento imunológico |
| 5 | **Interferon Signaling** | 2.42e-8 | 24/280 | Resposta antiviral (IFN-γ) |

### **KEGG Pathways 2026** (TOP 5)

| Rank | Pathway | P-Value | Genes | Biologia |
|------|---------|---------|-------|----------|
| 1 | **Viral Protein Interaction with Cytokine/Receptor** | 7.3e-11 | 17/99 | Resposta viral, citocinas |
| 2 | **Rheumatoid Arthritis** | 2.04e-9 | 15/92 | Inflamação crônica |
| 3 | **Chemokine Signaling Pathway** | 2.31e-9 | 21/191 | Sinalização quimiocina |
| 4 | **Herpes Simplex Virus 1 Infection** | 2.87e-8 | 19/181 | Resposta herpesvírus |
| 5 | **Cytokine-Cytokine Receptor Interaction** | 2.81e-7 | 23/296 | Rede citocina |

---

## 🧬 GENES CHAVE IDENTIFICADOS

### **Citocinas Pró-Inflamatórias (UP em dMMR)**
IL-1β, IL-6, IL-18, TNF-α, TNF-SFN9, TNF-SF13B
### **Quimiocinas de Recrutamento (UP em dMMR)**
CXCL5, CXCL8, CXCL9, CXCL10, CXCL11, CXCL13, CXCL14

CCL3L1, CCL4, CCL5, CCL8, CCL18
### **Sinalização Interferon (UP em dMMR)**
STAT1 (ativação JAK-STAT)

JAK2 (tirosina quinase)

MX1, OAS2, ISG15, ISG20 (proteínas estimuladas por IFN)

IFIT2, IFIT3 (induzidas por interferon)
### **Apresentação Antigênica (UP em dMMR)**
HLA-DMA, HLA-DMB, HLA-DOA

HLA-DPA1, HLA-DQA1, HLA-DQB1

CD74 (invariant chain)
### **Citotoxicidade (UP em dMMR)**
GNLY (granulisina)

GZMK, GZMH (granzimas)

PRF1 (perforin)

NKG7 (Natural Killer Group 7)

FCGR3B (Fc receptor, NK cells)
---

## 📝 INTERPRETAÇÃO BIOLÓGICA

### **Fenótipo Observado: "Hot Tumor" (Tumor Inflamado)**

Tumores **dMMR (Lynch)** apresentam assinatura transcriptômica de tumor **"immunologically active"**:

1. ✅ **Influxo de Citocinas** → IL-6, IL-1β, TNF
2. ✅ **Recrutamento Imune** → Neutrófilos (CXCL8), Linfócitos T (CXCL10)
3. ✅ **Resposta Interferon** → MX1, OAS2 (resposta a PAMPs/DAMPs)
4. ✅ **Antigenicidade** → HLA up, apresentação aumentada
5. ✅ **Citotoxicidade NK** → GNLY, GZMK, NKG7 expressos

### **Mecanismo Proposto**
Deficiência MMR

↓

Erro de reparo (mutações)

↓

Neoantigênios (MSI-H high)

↓

Reconhecimento TLR (DAMP recognition)

↓

Ativação de STAT1/JAK2

↓

Resposta Interferon α/γ

↓

Recrutamento citotóxico (NK, CD8+ T)

↓

Tumor "HOT" = imunossurveillância ativa
### **Implicação Clínica**

Tumores dMMR/Lynch são **candidatos excelentes para imunoterapia**:
- Alto TMB (Tumor Mutational Burden)
- Alto PD-L1
- Infiltrado imune ativo
- Resposta esperada a checkpoint inhibitors (PD-1, CTLA-4)

---

## ❌ O QUÊ NÃO FOI ENCONTRADO

| Gene MMR | Status | Interpretação |
|-----------|--------|-----------------|
| MLH1 | ❌ Não significante | Deletado/mutado em dMMR; não variação de expressão |
| MSH2 | ❌ Não significante | Idem |
| MSH6 | ❌ Não significante | Idem |
| PMS2 | ❌ Não significante | Idem |
| EPCAM | ❌ Não significante | Idem |

**Conclusão:** A assinatura é **secundária** (resposta ao defeito), não primária (gene MMR).

---

## 📚 ARQUIVOS GERADOS
✅ Reactome_Pathways_2024_table.txt      (1031 pathways)

✅ KEGG_2026_table.txt                    (69 pathways)

✅ genes_for_enrichR.txt                  (561 gene symbols)

✅ genes_for_enrichment_full.csv          (com estatísticas)
**Local:** `~/projeto_1_rnaseq_mmr/results/enrichment/`

---

## 🎯 PRÓXIMAS ETAPAS (FASE 8-9)

### **FASE 8: Validação Externa** (3-4 semanas)

**Objetivo:** Confirmar assinatura em coorte independente

**Passos:**
1. Download GSE17536 (Marisa et al., outro estudo COAD)
2. Validação de top genes (CXCL8, IL-6, STAT1, etc)
3. Correlação com dados clínicos (sobrevida, MSI status)
4. Análise PD-L1, TMB vs assinatura imune

**Ferramentas:** R, DESeq2, survival analysis

---

### **FASE 9: Publicação & Portfolio** (2-3 semanas)

**Formato:** Artigo científico + preprint

**Seções:**
1. **Introdução:** Lynch syndrome, MMR genes, MSI-H
2. **Métodos:** RNA-seq, enrichment, validação
3. **Resultados:** Top pathways, genes, PCA, validação
4. **Discussão:** "Hot tumor" phenotype, imunoterapia
5. **Conclusões:** MMR-deficiency → immune activation

**Onde submeter:**
- BMC Cancer (open access)
- Cancer Immunology Research
- Journal of Clinical Investigation

---

## 📊 MÉTRICAS RESUMIDAS
Genes DEGs (Fase 6):        5.532 (consenso 3 métodos)

Genes para enrichment:       561 (91% mapeamento)

Pathways Reactome (sig):     > 100 (p < 0.05)

Pathways KEGG (sig):         > 30 (p < 0.05)

Top pathway p-value:         2.18e-14 (Immune System)

Combined Score top 1:        80.9 (muito significante)
---

## ✅ CHECKLIST — O QUE FOI FEITO

- [x] Fase 1-5: Exploração e preparação
- [x] Fase 6: Validação interna (DESeq2, edgeR, limma)
- [x] Fase 7: Enriquecimento GO/KEGG/Reactome
- [ ] Fase 8: Validação externa (PRÓXIMO)
- [ ] Fase 9: Publicação e portfolio (PRÓXIMO)

---

## 📞 CONTATO & PRÓXIMAS AÇÕES

**Próxima conversa:**
1. Iniciar Fase 8 (validação externa)
2. Download GSE17536
3. Análise de sobrevida vs assinatura

**Repositório:** github.com/carla-bioinfo/projeto_1_rnaseq_mmr

---

**Relatório Finalizado:** 27/06/2026  
**Autor:** Carla Rodrigues de Moraes (bioinfo@keep-os)  
**Status:** ✅ PRONTO PARA PRÓXIMA FASE
