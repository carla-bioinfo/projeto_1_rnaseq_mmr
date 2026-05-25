# Projeto 1: Caracterização Transcriptômica MMR/Lynch

**Análise de expressão gênica em adenocarcinomas colorretais com deficiência de reparo de DNA (dMMR)**

## 📋 Status do Projeto

| Fase | Descrição | Status | Data |
|---|---|---|---|
| **1-5** | Preparação e exploração inicial | ✅ Completo | Janeiro-Maio 2026 |
| **6** | Validação Interna (DESeq2, edgeR, limma) | ✅ Completo | 25/05/2026 |
| **7** | Validação Externa (Literatura, GO, Sobrevida) | ⏳ Planejado | Junho 2026 |
| **8** | Caracterização Molecular Final | ⏳ Planejado | Junho 2026 |

---

## 📊 Visão Geral do Projeto

### Objetivo
Caracterizar a assinatura transcriptômica de tumores colorretais com **deficiência de reparo de DNA (dMMR)** associados à **Síndrome de Lynch**, identificando genes biomarcadores e padrões de expressão diferenciais entre dMMR e pMMR (reparo normal).

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

### Fases de Análise

#### **FASE 1-5: Exploração e Preparação** ✅
- Download de dados via GEOquery
- Normalização RMA + ComBat batch correction
- Análise exploratória inicial
- Preparação de dados para análise diferencial

#### **FASE 6: Validação Interna** ✅

**Checkpoint 1: Controle de Qualidade Técnico**
- ✅ Script 04: PCA (Principal Component Analysis)
  - PC1: 16.39% variância (separa dMMR vs pMMR)
  - PC2: 10.79% variância (variação biológica adicional)
  - **Resultado:** Separação clara e validada ✅

- ✅ Script 05: Clustering Hierárquico + Heatmap
  - Top 100 genes significantes
  - Dendrograma mostra agrupamento apropriado
  - Amostras dMMR agrupam juntas
  - Amostras pMMR agrupam juntas
  - **Resultado:** Padrão coeso validado ✅

**Checkpoint 2: Concordância entre Métodos**

Três métodos independentes foram comparados:

| Método | Genes Signi
cat > CHANGELOG.md << 'EOF'
# Changelog

## [v1.0] - 2026-05-25

### 🎉 LANÇAMENTO: FASE 6 COMPLETA E VALIDADA

#### Adicionado
- ✅ Scripts 02-08 finalizados
- ✅ Documentação profissional (3 PDFs)
- ✅ Tabelas de resultados (8 CSVs)
- ✅ README.md atualizado com Fase 6
- ✅ CHANGELOG.md (v1.0)

#### Validação
- ✅ Checkpoint 1: QC Técnico - PASSOU
- ✅ Checkpoint 2: Concordância - PASSOU
- ✅ Overlap: 88-93% (>70%)
- ✅ Correlação log2FC: 0.86-0.93

#### Resultados Principais
- DESeq2: 646 genes significantes
- edgeR: 6.648 genes
- limma-voom: 6.626 genes
- Genes consenso (3 métodos): 5.532

**Status:** ✅ FASE 6 COMPLETA E VALIDADA
