---
titulo: ATIVAÇÃO IMEDIATA DA SKILL - AGORA (MAIO 2026)
autora: Carla Rodrigues de Moraes
data: 13 de maio de 2026
status: "VOCÊ QUER COMEÇAR ESTE DOMINGO - ENTENDI!"
---

# Como Ativar a Skill AGORA para Continuar Projeto 1

## ✅ Você Quer EXPANDIR Projeto 1 Agora

**Meu erro:** Pensei que você esperaria até janeiro 2027.
**Sua realidade:** Você quer começar **ESTE DOMINGO** (ou logo).

Perfeito. Vamos fazer isso.

---

## 🚀 COMO COMEÇAR ESTE DOMINGO

### PASSO 1: Este Fim de Semana (12 horas domingo)

**O que fazer:**

1. **Leia a skill de cima a baixo** (2-3 horas)
   - Arquivo: `skill_projeto_2_intermediario_mmr_variantes.md`
   - Não precisa entender TUDO, só pegue a estrutura

2. **Setup do Projeto 1 Expandido** (3 horas)
   - Vá para a pasta que tem seu Projeto 1 agora
   - Crie sub-pasta: `projeto_1_expandido/`
   - Copie a estrutura da skill para lá

3. **Primeiro commit com plano** (1 hora)
   - Git init na pasta expandida
   - Primeiro commit: "Etapa 0: Setup expandido Projeto 1 + Skill Lynn/MMR"

4. **Pesquisa inicial** (6 horas)
   - Leia seção "Contexto Biológico" da skill
   - Estude os papers sobre Lynch
   - Comece a explorar ClinVar
   - Tomar nota de achados

---

## 📝 COMO INTEGRAR SKILL COM PROJETO 1

Seu **Projeto 1 atual:**
- Análise transcriptômica (DESeq2, Vulcano plot)
- Resultado: genes diferencialmente expressos em Lynch

Sua **Expansão com Skill:**
- Pegar genes do Projeto 1
- Ver se têm variantes germinativas em ClinVar
- Conectar expressão + variantes

### Exemplo Concreto:

**Seu Projeto 1 descobriu:** MLH1 está significativamente BAIXO em tumores Lynch

**Agora com skill:**
1. Vá para ClinVar
2. Busque variantes patogênicas em MLH1
3. Para cada variante, anote:
   - Tipo (missense, frameshift, etc)
   - Frequência (gnomAD)
   - Critério ACMG (usando skill)
4. Crie tabela: "Variantes MLH1 encontradas em ClinVar"
5. Conecte com seu resultado Projeto 1:
   - "Genes MMR baixos em expressão correspondem a variantes patogênicas conhecidas"

---

## 📂 ESTRUTURA PARA EXPANDIR PROJETO 1

Crie dentro de seu Projeto 1:

```
projeto_1_expandido/
├── SKILL_GUIA.md  (copie o arquivo da skill aqui)
├── data/
│   ├── raw/
│   │   └── clinvar_mmr_variants.csv  (baixado de ClinVar)
│   ├── processed/
│   │   └── variants_anotadas.csv
│   └── external/
│       └── gnomad_frequencias.csv
├── src/
│   ├── 00_projeto1_base.R  (seu código RNA-seq original)
│   ├── 01_clinvar_parser.R  (NOVO - buscar variantes)
│   └── 02_integrar_rna_variantes.R  (NOVO - conectar)
├── notebooks/
│   └── analise_expandida.qmd
├── results/
│   ├── figuras_expandidas/
│   └── tabelas_expandidas/
├── README.md
└── .gitignore
```

---

## 🎯 ROTEIRO ESTE MÊS (Maio - Junho 2026)

### Semana 1 (Este Domingo)
**O que fazer:**
- [ ] Leia skill de cima a baixo (2-3h)
- [ ] Setup pastas (1h)
- [ ] Primeiro commit (0.5h)
- [ ] Explore ClinVar - MLH1/MSH2 (3h)
- [ ] Anote achados em documento (2h)
- [ ] Leia 1 paper Lynch (3h)

**Entregável:** Documento "achados_iniciais.md" no GitHub

### Semana 2-3 (Próximas 2 semanas)
**O que fazer:**
- [ ] Baixar VCF de ClinVar (variantes MMR)
- [ ] Começar script R para parsear VCF (src/01_clinvar_parser.R)
- [ ] Documentar cada variante

**Entregável:** Script R funcionando + CSV com variantes anotadas

### Semana 4-6 (Próximas 3 semanas)
**O que fazer:**
- [ ] Implementar classificação ACMG manual (usando skill)
- [ ] Conectar com resultado Projeto 1
- [ ] Gerar visualizações (tabelas, gráficos)

**Entregável:** Tabela final com variantes classificadas + análise integrada

### Semana 7-8 (Próximas 4 semanas)
**O que fazer:**
- [ ] Escrever relatório expandido (Projeto 1 + Variantes)
- [ ] Atualizar GitHub
- [ ] Post LinkedIn anunciando expansão

**Entregável:** GitHub público com Projeto 1 Expandido

---

## 💻 PRIMEIRO SCRIPT A EXECUTAR (Este Domingo)

Crie arquivo: `src/01_clinvar_parser.R`

```r
# Projeto 1 Expandido: Integração RNA-seq + Variantes Lynch
# Início: Maio 2026
# Objetivo: Validar genes baixamente expressos em Lynch com variantes germinativas

library(tidyverse)

# ====== PARTE 1: Seus genes baixamente expressos do Projeto 1 ======
# (Copie do seu Projeto 1 original)

genes_baixos_lynch <- c(
  "MLH1",
  "MSH2", 
  "MSH6",
  "PMS2"
  # ... adicione outros do seu Vulcano plot com log2FC < -1 e p < 0.05
)

# ====== PARTE 2: Buscar variantes desses genes em ClinVar ======

# Por enquanto, isso é MANUAL:
# 1. Vá para https://www.ncbi.nlm.nih.gov/clinvar/
# 2. Busque: "MLH1[gene] pathogenic[clinical_significance]"
# 3. Download VCF
# 4. Salve em: data/raw/clinvar_mlh1_pathogenic.vcf

# ====== PARTE 3: Parse simples do VCF ======

parse_vcf_simples <- function(arquivo_vcf) {
  linhas <- readLines(arquivo_vcf)
  
  # Remove header
  linhas_data <- linhas[!grepl("^#", linhas)]
  
  # Parse básico
  variantes <- data.frame(
    linha = linhas_data,
    stringsAsFactors = FALSE
  ) %>%
    separate(
      linha, 
      into = c("CHROM", "POS", "ID", "REF", "ALT", "QUAL", "FILTER", "INFO"),
      sep = "\t",
      extra = "drop"
    )
  
  return(variantes)
}

# ====== PARTE 4: Executar ======

# Quando tiver VCF de ClinVar:
# variantes_mlh1 <- parse_vcf_simples("data/raw/clinvar_mlh1_pathogenic.vcf")
# write_csv(variantes_mlh1, "data/processed/mlh1_variantes.csv")

print("Script template pronto. Agora você:")
print("1. Baixe VCF de ClinVar")
print("2. Rode este script")
print("3. Veja as variantes")
```

**O que fazer:**
1. Copie este script para `src/01_clinvar_parser.R`
2. Não precisa rodar agora (ainda não tem VCF)
3. Use como template para próximas semanas

---

## 📊 COMO INTEGRAR COM PROJETO 1 (Conceitual)

Seu Projeto 1 já tem:
```
Resultado: Vulcano plot com genes significantes
```

Sua expansão com skill:
```
Resultado + Análise Variantes

Achados:
- Gene MLH1: log2FC = -2.5, padj < 0.0001
- Variantes patogênicas em MLH1: 45 encontradas em ClinVar
- Conclusão: Genes com deficiência de expressão 
             correspondem a variantes conhecidas em Lynch
```

---

## 🔄 COMO VERSIONAR NO GIT

```bash
# Este domingo
git init projeto_1_expandido
cd projeto_1_expandido

# Primeiro commit
git add .
git commit -m "Etapa 0: Setup expandido Projeto 1 + integração variantes Lynch"

# Semana 2
git add src/01_clinvar_parser.R
git commit -m "Etapa 1: Script para parsear ClinVar + download dados iniciais"

# Semana 4
git add src/02_acmg_classification.R
git add results/variantes_classificadas.csv
git commit -m "Etapa 2: Classificação ACMG das variantes MMR"

# Semana 6
git add notebooks/analise_expandida.qmd
git add results/relatorio_final.pdf
git commit -m "Etapa 3: Integração RNA-seq + variantes + relatório final"

# Semana 8
git push origin main  # Público no GitHub
```

---

## ⚡ RESUMO: O QUE FAZER ESTE DOMINGO

### **Tarefa 1 (2h): Ler a Skill**
- Arquivo: `skill_projeto_2_intermediario_mmr_variantes.md`
- Leia tudo, não precisa entender 100%

### **Tarefa 2 (1h): Setup Pasta**
```bash
mkdir projeto_1_expandido
cd projeto_1_expandido
mkdir -p data/{raw,processed,external} src notebooks results
git init
git add .
git commit -m "Etapa 0: Setup"
```

### **Tarefa 3 (3h): Pesquisa Lynch**
- Leia seção "Contexto Biológico" da skill
- Visite ClinVar, busque MLH1/MSH2
- Anote 5-10 variantes interessantes

### **Tarefa 4 (3h): Exploração de Dados**
- Baixe VCF de exemplo de ClinVar
- Entenda estrutura VCF (seção skill)
- Tente abrir em texto simples, veja o que tem

### **Tarefa 5 (3h): Leitura Técnica**
- Leia 1 artigo sobre Lynch (recomendações na skill)
- Leia 1 artigo sobre ACMG (Richards et al. 2015)
- Tome notas

---

## 📌 CHECKLIST ESTE DOMINGO (12h)

- [ ] Skill lida (2-3h)
- [ ] Pasta criada e git init (1h)
- [ ] ClinVar explorado (3h)
- [ ] VCF baixado (1h)
- [ ] Papers lidos (3h)
- [ ] Notas tomadas (1h)

**Total: ~12 horas - perfeito para domingo!**

---

## 🎯 RESULTADO FINAL (Junho 2026)

Ao final de junho, você terá:

1. **GitHub público** com Projeto 1 Expandido
2. **Código R** para parsear ClinVar + classificar ACMG
3. **Relatório** integrando RNA-seq + variantes
4. **Post LinkedIn** explicando expansão
5. **Portfolio** impressionante para TCC + pós

---

## ⚠️ IMPORTANTE: Isso NÃO é o Projeto 2 Full

Você agora:
- Expande Projeto 1 com contexto variantes
- Aprende skill de forma prática
- Prova conceito de integração RNA + variantes
- Prepara terreno para Projeto 2 formal em janeiro 2027

**Projeto 2 full (ACMG manual, 4 casos clínicos completos)** continua sendo jan-jun 2027.

Isso agora é "Projeto 1.5" - bridge entre os dois.

---

## 🚀 COMECE AGORA

**Este domingo:**

```bash
# Terminal
mkdir projeto_1_expandido
cd projeto_1_expandido
git init

# Abra arquivo da skill
# Leia de cima a baixo
# Comece tarefas listadas acima
```

**Você consegue. Faça isso. 🚀**

---

**Documento:** Como Ativar Skill AGORA
**Versão:** 1.0 (IMEDIATO)
**Data:** 13 de maio de 2026
**Status:** ✓ PRONTO PARA EXECUÇÃO ESTE DOMINGO
