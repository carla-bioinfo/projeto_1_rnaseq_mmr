---
name: lynch-mmr-variant-analysis-intermediate
description: Análise intermediária de variantes germinativas em genes MMR para Síndrome de Lynch. Use esta skill quando o usuário precisa aprender a ler/interpretar arquivos VCF, anotar variantes em genes MLH1/MSH2/MSH6/PMS2, classificar segundo critérios ACMG de forma manual/semi-automática em R, gerar relatórios interpretativos para pacientes Lynch. Focado em implementação prática, não em full pipelines. Ideal para estudantes de bioinformática que já dominam R e RNA-seq e querem expandir para análise de variantes germinativas.
---

# Projeto 2 Intermediário: Análise de Variantes MMR em Síndrome de Lynch

## Contexto e Motivação

Você completou o **Projeto 1 (Transcriptômica)** e seu **TCC (Revisão de Biomarcadores Lynch)**. Agora você vai conectar ambos através de um **Projeto 2 Intermediário** que valida na prática a teoria do TCC.

Seu TCC identificou que o maior problema no SUS é a **falta de implementação de testes de variantes germinativas e critérios ACMG**. Este projeto não vai resolver o SUS, mas vai provar que você *pode* implementar isso localmente.

**Tempo total**: 4-5 meses (dezembro 2026 - maio 2027)
**Dedicação**: 12 horas/semana (domingo)
**Entregável**: Código R reproduzível + 3-4 casos Lynch com relatórios ACMG

---

## Parte 1: Contexto Biológico (Reforce o Aprendizado)

### O que é um Arquivo VCF?

VCF = **Variant Call Format**. É um arquivo texto que lista todas as variantes genéticas encontradas em um sequenciamento.

```
##fileformat=VCFv4.2
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
3       37067040 rs1800734 T      C       100     PASS    AF=0.0001;CSQ=...
3       37067119 .       G       A       95      PASS    AF=0.00005;CSQ=...
```

**Colunas importantes:**
- **CHROM**: Cromossomo (3 = MLH1, 2 = MSH2, 7 = PMS2)
- **POS**: Posição no cromossomo
- **REF/ALT**: Alelo referência vs alternativo
- **ID**: Nome da variante em bancos (rsXXXXX)
- **INFO**: Anotações (frequência, predições)

### Genes MMR Alvo

| Gene | Cromossomo | Proteína | Mutações Comuns |
|------|-----------|----------|-----------------|
| MLH1 | 3p22.2 | Endonuclease | ~50% dos casos Lynch |
| MSH2 | 2p21 | Reconhecimento erro | ~40% dos casos |
| MSH6 | 2p16 | Especificidade | ~7% dos casos |
| PMS2 | 7p22 | Exonuclease | ~3% dos casos |

**O que você já sabe:** Genes MMR defeituosos → sem reparo de DNA → mutações acumulam → câncer colorretal agressivo.

---

## Parte 2: Estrutura do Projeto 2

### Etapa 1: Preparação (Semanas 1-2, dezembro)

**Objetivo:** Aprender VCF e preparar dados sintéticos.

**O que fazer:**
1. Ler 2-3 papers sobre VCF e variantes Lynch
2. Visitar ClinVar e buscar variantes patogênicas em MLH1
3. Baixar dados de referência:
   - ClinVar VCF: https://www.ncbi.nlm.nih.gov/variation/docs/vcf_files/
   - gnomAD: https://gnomad.broadinstitute.org/
   - Ensembl VEP: https://www.ensembl.org/Tools/VEP

**Entregáveis:**
- Pasta `data/raw/` com 3-4 VCFs sintéticos
- Cada VCF contém 10-15 variantes em genes MMR (mix de patogênicas e benignas)

**Dica:** Use ClinVar diretamente. Não precisa criar dados do zero.

---

### Etapa 2: Anotação Básica em R (Semanas 3-6, janeiro-fevereiro)

**Objetivo:** Ler VCF em R, extrair informações, integrar com ClinVar e gnomAD.

**Script R básico:**

```r
# install.packages("vcfR")
library(vcfR)
library(tidyverse)

# 1. Ler VCF
vcf <- read.vcfR("data/raw/paciente_001.vcf")

# 2. Extrair informações
variants <- data.frame(
  chrom = vcf@fix[, "CHROM"],
  pos = vcf@fix[, "POS"],
  ref = vcf@fix[, "REF"],
  alt = vcf@fix[, "ALT"],
  id = vcf@fix[, "ID"]
)

# 3. Anotar com ClinVar (manual lookup por ID)
# Para cada variante, buscar em ClinVar manualmente:
# https://www.ncbi.nlm.nih.gov/clinvar/?term=MLH1%5Bgene%5D

# 4. Extrair gnomAD frequency (do INFO field)
# Formato: AF=0.0001 significa frequência de 0.01%

variants <- variants %>%
  mutate(
    gene = case_when(
      chrom == "3" ~ "MLH1",
      chrom == "2" ~ "MSH2",
      TRUE ~ "OTHER"
    )
  )

# 5. Salvar para análise
write_csv(variants, "data/processed/variants_anotadas.csv")
```

**Entregáveis:**
- Script R (`src/01_vcf_parser.R`)
- Tabela CSV com variantes anotadas

**Aprendizado:**
- Estrutura de VCF
- Parsing em R (vcfR)
- Integração ClinVar + gnomAD

---

### Etapa 3: Classificação ACMG Manual (Semanas 7-14, março-abril)

**Objetivo:** Para cada variante, classificar manualmente segundo critérios ACMG-AMP.

**Critérios Simplificados para MMR:**

```
Patogênico Muito Forte (PVS1):
  - Nonsense em gene com LoF
  - Frameshift
  - Deleção exônica

Patogênico Forte (PS1):
  - Mesma posição que variante patogênica conhecida

Patogênico Moderado (PM1, PM2):
  - Em hotspot
  - Rara em população (<0.0001 gnomAD)

Benigno Forte (BS1):
  - Frequente em população (>1% gnomAD)

Variável/Incerta (VUS):
  - Evidência conflitante
```

**Script R para tabular classificação:**

```r
variants_classificadas <- variants_anotadas %>%
  mutate(
    # Tipo de variante
    consequence = case_when(
      grepl("^[ATCG]+$", ref) & nchar(ref) > nchar(alt) ~ "Deleção",
      grepl("^[ATCG]+$", alt) & nchar(alt) > nchar(ref) ~ "Inserção",
      nchar(ref) == nchar(alt) & nchar(ref) == 1 ~ "Substituição",
      TRUE ~ "Outro"
    ),
    
    # Critério ACMG (manual)
    pvs1 = consequence %in% c("Deleção", "Inserção"),
    ps1 = clinvar_class == "Pathogenic",  # assumindo já anotado
    pm2 = gnomad_af < 0.0001,
    bs1 = gnomad_af > 0.01,
    
    # Pontuação
    pontos_patogenicos = 
      (pvs1 * 4) + (ps1 * 3) + (pm2 * 1),
    pontos_benignos = 
      (bs1 * 3),
    
    # Classificação final
    acmg_class = case_when(
      pontos_patogenicos >= 6 ~ "Pathogenic",
      pontos_patogenicos >= 4 ~ "Likely Pathogenic",
      pontos_benignos >= 3 ~ "Benign",
      abs(pontos_patogenicos - pontos_benignos) <= 1 ~ "Uncertain",
      TRUE ~ "Likely Pathogenic"
    )
  )

# Salvar
write_csv(variants_classificadas, 
          "results/variants_classificadas_acmg.csv")
```

**Entregáveis:**
- Script R (`src/02_acmg_classification.R`)
- Tabela com classificação (ACMG, pontos, justificativa)
- Documento interpretativo por variante

**Aprendizado:**
- Critérios ACMG na prática
- Tomada de decisão clínica
- Documentação interpretativa

---

### Etapa 4: Relatórios para Casos Lynch (Semanas 15-18, maio)

**Objetivo:** Para cada paciente sintético, gerar relatório clínico interpretativo.

**Estrutura de Relatório (3-4 páginas por paciente):**

```
RELATÓRIO CLÍNICO - ANÁLISE GENÉTICA
=====================================

Paciente: Lynch_001
Data: Maio 2027
Genes analisados: MLH1, MSH2, MSH6, PMS2

ACHADOS:
--------
Variante 1: MLH1 c.1906G>C (p.Ala636Pro)
  - Tipo: Missense
  - ClinVar: Pathogenic
  - gnomAD AF: <0.00001
  - ACMG: Pathogenic (critério PS1 + PM2)
  - Interpretação: Variante conhecida patogênica em posição crítica
                   de interface com PMS2. Esperado impacto funcional.
  
Variante 2: MSH2 c.942+5G>C (intrônica)
  - Tipo: Splice site variant
  - ClinVar: Uncertain
  - Predição de impact: MODERATE (MaxEntScan)
  - ACMG: Uncertain (VUS)
  - Interpretação: Localização próxima a sítio de splice. Predições
                   sugerem possível impacto em splicing. Requer
                   validação funcional. Pode ser clinicamente
                   significante.

RECOMENDAÇÕES CLÍNICAS:
-----------------------
1. Colonoscopia anual (rastreamento agressivo de Lynch)
2. Monitoramento endometrial (mulheres)
3. Aconselhamento genético familiar
4. Validação funcional de VUS

LIMITAÇÕES:
-----------
- Análise em pacientes sintéticos (dados não reais)
- Anotação manual (sujeita a viés)
- Não substitui parecer clínico profissional
```

**Entregáveis:**
- 3-4 relatórios PDF (um por paciente)
- Templates em Quarto/Rmarkdown

**Aprendizado:**
- Comunicação clínica
- Interpretação na prática
- Documentação profissional

---

## Parte 3: Ferramentas e Ambientes

### R Packages Necessários

```r
# Instalar
install.packages(c("tidyverse", "vcfR", "rmarkdown", "quarto"))

# Carregar
library(tidyverse)  # manipulação de dados
library(vcfR)       # VCF parsing
library(rmarkdown)  # relatórios
```

### Estrutura de Pastas

```
projeto_2_variantes_mmr/
├── data/
│   ├── raw/
│   │   ├── paciente_001.vcf
│   │   ├── paciente_002.vcf
│   │   └── paciente_003.vcf
│   ├── processed/
│   │   └── variants_anotadas.csv
│   └── external/
│       ├── clinvar_mmr.csv  (baixado)
│       └── gnomad_mmr.csv   (baixado)
├── src/
│   ├── 01_vcf_parser.R
│   ├── 02_acmg_classification.R
│   └── 03_report_generator.R
├── results/
│   ├── figures/
│   │   └── variant_distribution.png
│   ├── tables/
│   │   └── variants_classificadas_acmg.csv
│   └── reports/
│       ├── paciente_001_relatorio.pdf
│       ├── paciente_002_relatorio.pdf
│       └── paciente_003_relatorio.pdf
├── notebooks/
│   └── analise_completa.qmd
├── README.md
└── .gitignore
```

---

## Parte 4: Milestones e Timeline

| Semana | Período | Marco | Entregável |
|--------|---------|-------|-----------|
| 1-2 | Dez 2026 | Contexto biológico | Papers lidos, ClinVar explorado |
| 3-6 | Jan-Fev 2027 | Anotação básica | Script R + tabela anotada |
| 7-14 | Mar-Abr 2027 | Classificação ACMG | Classificações com justificativa |
| 15-18 | Mai 2027 | Relatórios clínicos | 3-4 relatórios PDF |
| 19-20 | Jun 2027 | Empacotamento | GitHub público + post LinkedIn |

---

## Parte 5: Conexão com TCC + Portfolio

### Como o Projeto Valida Seu TCC

Seu TCC disse:
> "A implementação de testes genéticos para predisposição ao câncer é crítica, mas o SUS enfrenta barreiras..."

Seu Projeto 2 prova:
> "Aqui está como implementar ACMG na prática. Funciona. Código e relatórios públicos."

### Portfolio Deliverables

1. **Repositório GitHub**
   - README explicando Projeto 2
   - Scripts R comentados
   - Dados sintéticos (para reproducibilidade)
   - Link para Projeto 1

2. **Post LinkedIn**
   - "Do TCC à Prática: Implementei Classificação ACMG para Variantes Lynch"
   - Figuras dos resultados
   - Link para GitHub

3. **Página no Site bioinfo.ia**
   - "Caso 2: Análise de Variantes MMR em Lynch"
   - Comparação com Caso 1 (transcriptômica)

4. **Skill Progressiva**
   - Nível 1 (concluído): Transcriptômica
   - **Nível 2 (você está aqui)**: Variantes
   - Nível 3 (2028): Multi-ômmica

---

## Parte 6: FAQ e Respostas

**P: Preciso aprender VEP ou Snakemake?**
R: NÃO. Este é projeto intermediário. VEP e automation vêm no Nível 3 (2028).

**P: Como obtenho variantes "reais"?**
R: ClinVar. Baixe variantes patogênicas de MLH1/MSH2/MSH6/PMS2 diretamente. Misture com benignas do 1000 Genomes.

**P: Quanto tempo vai levar por semana?**
R: 12 horas/domingo = 3h anotação teórica + 3h codificação R + 3h análise + 3h documentação.

**P: Posso publicar isso depois?**
R: Sim. Dados sintéticos + análise manual = preprint ou artigo pequeno em bioinformatics journal.

**P: E se descobrir que meu ACMG está errado?**
R: Ótimo! Documenta o aprendizado. Revisa os critérios, corrige, e aprende. É o ponto.

---

## Próximos Passos Concretos

### Esta Semana (Maio 2026):
1. Leia este documento 1x (não memorize, entenda)
2. Visite https://www.ncbi.nlm.nih.gov/clinvar/ e busque "MLH1"
3. Baixe 2-3 papers sobre VCF format (Google Scholar: "VCF variant call format")

### Dezembro 2026:
1. Crie pasta `projeto_2_variantes_mmr/` no seu computador
2. Baixe 3-4 VCFs de exemplo (ou crie sintéticos)
3. Instale `vcfR` no R

### Janeiro 2027:
1. Comece com `src/01_vcf_parser.R`
2. Primeira milestone: ler VCF e converter para CSV

---

## Recursos Recomendados

### Papers
- Richards et al. (2015). "Standards and guidelines for the interpretation of sequence variants." Genetics in Medicine. [ACMG bíblia]
- Thompson et al. (2014). "Application of a 5-tiered scheme for standardized classification of 2,360 unique mismatch repair gene variants." Nature Genetics. [InSiGHT Lynch específico]

### Ferramentas Online
- ClinVar: https://www.ncbi.nlm.nih.gov/clinvar/
- gnomAD: https://gnomad.broadinstitute.org/
- VEP (Preview): https://www.ensembl.org/Tools/VEP
- MaxEntScan (splice): http://www.umd.be/HSF3/HSF.html

### Comunidades
- Biostars (forum): https://www.biostars.org/
- R Bioconductor support: https://support.bioconductor.org/

---

## Resumo Executivo

**O que você vai fazer:**
- Ler arquivos VCF de pacientes Lynch sintéticos
- Anotar variantes com dados de ClinVar + gnomAD
- Classificar cada variante segundo critérios ACMG
- Gerar 3-4 relatórios clínicos interpretativos

**Por que:**
- Valida seu TCC na prática
- Aprende análise de variantes germinativas (raro no Brasil)
- Constrói portfolio diferenciado
- Prepara para Nível 3 (2028) e carreira em oncogenética

**Tempo:**
- 4-5 meses, 12h/semana (domingo)

**Resultado final (maio 2027):**
- Código R reproduzível
- 4 relatórios clínicos
- GitHub público
- Post LinkedIn
- Diferencial para pós-grad e mercado

---

**Versão:** 1.0
**Data:** Maio 2026
**Status:** SKILL INTERMEDIÁRIA PRONTA PARA INÍCIO JANEIRO 2027
