# HANDOFF: Fase 8 Parte 3 (Análise de Sobrevida)

## 📋 Status Atual
- ✅ Fase 8 Parte 1: 450 genes agregados (COMPLETA)
- ✅ Fase 8 Parte 2: GSE17536 validado (COMPLETA)
- ⏳ Fase 8 Parte 3: Análise de sobrevida (PRÓXIMO)

---

## 🎯 Objetivo Fase 8 Parte 3
Validar se seus 450 genes conseguem **predizer sobrevida** melhor que genes aleatórios.

### Sub-objetivos:
1. Extrair dados clínicos de GSE17536 (OS, DFS, tempo follow-up)
2. Criar signature de risco com seus 450 genes
3. Correlacionar expressão com sobrevida (Kaplan-Meier)
4. Comparar poder preditivo

---

## 📊 Dados Disponíveis

### GSE17536 (já baixado no Windows)
Amostras: 177

Probes: 54,675

Expressão: matrix completa
### Seus 450 Genes
Arquivo: results/FASE8_genes_aggregated_full.csv

Colunas: Symbol, log2FoldChange_median, padj_best, n_probes

Padrão: 228 UP, 222 DOWN (balanceado)
---

## 🔧 Tecnologias Necessárias

### R Packages (Windows tem; Linux ainda falta)
✅ GEOquery (já instalado Windows)

✅ Biobase

⏳ survival (novo)

⏳ survminer (novo)

⏳ limma (novo)
### Script Necessário
src/FASE8_PARTE3_survival_analysis.R
---

## 📝 Workflow Recomendado

### PASSO 1: Preparar dados clínicos
- Extrair metadados GSE17536
- Extrair tempo de follow-up e eventos
- Identificar coluna de sobrevida (OS/DFS)

### PASSO 2: Criar signature de risco
- Usar 450 genes para score de risco
- Dividir em "High Risk" vs "Low Risk"
- Método: média ponderada de log2FC

### PASSO 3: Kaplan-Meier
- Curvas de sobrevida por grupo
- Log-rank p-value
- Visualizar (.png)

### PASSO 4: Cox Regression
- HR (Hazard Ratio) com IC95%
- Testar associação com expressão

### PASSO 5: Validação
- Comparar com genes aleatórios
- Testar estabilidade do modelo

---

## 💻 Opções de Execução

### OPÇÃO A: Windows (pragmático, RECOMENDADO)
- ✅ R + GEOquery + survival já instalados
- ✅ Dados GSE17536 já carregados
- ✅ Tempo: ~1-2 horas
- ⚠️ Precisa sincronizar depois via GitHub

### OPÇÃO B: Linux (futuro, após instalar dependências)
- ❌ Ainda falta GEOquery
- ⏳ Instalar: GEOquery, survival, survminer
- ✅ Pipeline único e reproducível
- ⏳ Tempo: mais 30-40 min instalação

### OPÇÃO C: Hybrid (melhor dos dois)
- ✅ Executar análise no Windows
- ✅ Salvar dados intermediários (CSV)
- ✅ Linux lê CSVs e faz validação
- ✅ Sem dependência de GEOquery no Linux

---

## 📂 Estrutura Esperada

Depois de Fase 8 Parte 3, você terá:
projeto_1_rnaseq_mmr/

├── results/

│   ├── FASE8_genes_aggregated_full.csv ✅

│   ├── FASE8_PARTE2_RESUMO_VALIDACAO.csv ✅

│   ├── FASE8_PARTE3_survival_scores.csv (novo)

│   ├── FASE8_PARTE3_kaplan_meier.png (novo)

│   └── FASE8_PARTE3_cox_results.csv (novo)

├── src/

│   ├── FASE8_aggregate_probes_to_genes.R ✅

│   └── FASE8_PARTE3_survival_analysis.R (novo)

└── HANDOFF_FASE8_PARTE3.md (este arquivo)
---

## 🚀 Como Iniciar Próxima Sessão

### Comando para verificar status:
```bash
cd ~/projeto_1_rnaseq_mmr
git log --oneline -5
ls -la results/FASE8*
```

### Se estiver no Windows:
```r
library(GEOquery)
library(survival)
# Script de sobrevida aqui
```

### Se estiver no Linux:
```bash
git pull origin main  # pega atualizações do Windows
# Depois: R script survival
```

---

## 📞 Dúvidas Comuns

**P: Preciso instalar GEOquery no Linux?**
A: Não obrigatório. Fase 8 Parte 3 pode usar CSVs salvos do Windows.

**P: Qual dataset tem metadados de sobrevida?**
A: GSE17536 tem dados clínicos completos (já será extraído no script).

**P: Quanto tempo vai levar?**
A: 1-2 horas no Windows, depois 5 min sincronização via GitHub.

**P: E se der erro na análise?**
A: Volte ao histórico Git, faça git revert, ou tente abordagem alternativa.

---

## ✅ Checklist para Próxima Sessão
[ ] Ler este HANDOFF

[ ] Verificar que 450 genes estão em results/

[ ] Decidir: Windows ou Linux para análise

[ ] Instalar survival + survminer (se Linux)

[ ] Executar FASE8_PARTE3_survival_analysis.R

[ ] Gerar gráficos (Kaplan-Meier)

[ ] Salvar resultados em results/

[ ] Fazer commit: "FASE 8 PARTE 3: Survival analysis"

[ ] git push origin main
---

**BOA SORTE NA PRÓXIMA SESSÃO! 🧬🚀**

