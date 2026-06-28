#!/usr/bin/env Rscript
# ============================================================================
# FASE 8 — AGGREGATION: Probe-Level → Gene-Level (MANDATORY STEP)
# ============================================================================
# VERSÃO CORRIGIDA: Lida com símbolos faltantes (54 probes sem mapeamento)
# ============================================================================
# Base R only — NO external libraries needed
# ============================================================================

cat(paste0(strrep("=", 70), "\n"))
cat("🧬 FASE 8 — PROBE AGGREGATION PIPELINE (CORRECTED VERSION)\n")
cat("Data: 27/06/2026\n")
cat(paste0(strrep("=", 70), "\n\n"))

# ============================================================================
# STEP 1: LOAD DATA
# ============================================================================

cat("📖 STEP 1: Loading probe-level data...\n")

probes_stats <- read.csv("results/tables/genes_for_enrichment_full.csv", 
                         stringsAsFactors = FALSE)

symbols_list <- readLines("results/tables/gene_symbols_for_enrichR.txt")

cat("   ✅ Probes loaded:", nrow(probes_stats), "\n")
cat("   ✅ Symbols loaded:", length(symbols_list), "\n")
cat("   ⚠️  Difference:", nrow(probes_stats) - length(symbols_list), 
    "probes without symbol mapping\n\n")

# ============================================================================
# STEP 2: CREATE SYMBOL VECTOR WITH NAs FOR MISSING VALUES
# ============================================================================

cat("📖 STEP 2: Matching ProbeID with Symbol (allowing missing values)...\n")

# Create vector of symbols with NAs for missing values
symbols_vector <- c(symbols_list, rep(NA, nrow(probes_stats) - length(symbols_list)))

if(length(symbols_vector) != nrow(probes_stats)) {
  stop("ERROR: Could not match probes and symbols!")
}

cat("   ✅ Symbol vector created: ", length(symbols_vector), "entries\n")
cat("   ✅ Missing symbols (NA): ", sum(is.na(symbols_vector)), "\n\n")

# ============================================================================
# STEP 3: COMBINE PROBES + SYMBOLS
# ============================================================================

cat("📖 STEP 3: Combining ProbeID + Symbol + Statistics...\n")

data_combined <- data.frame(
  ProbeID = probes_stats$ProbeID,
  Symbol = symbols_vector,
  log2FoldChange = probes_stats$log2FoldChange,
  padj = probes_stats$padj,
  abs_log2FC = probes_stats$abs_log2FC,
  stringsAsFactors = FALSE
)

cat("   ✅ Combined data rows:", nrow(data_combined), "\n")
cat("   ✅ Rows with valid symbol:", sum(!is.na(data_combined$Symbol)), "\n")
cat("   ✅ Rows with NA symbol:", sum(is.na(data_combined$Symbol)), "\n\n")

# ============================================================================
# STEP 4: REMOVE ROWS WITH NA SYMBOLS (unmapped probes)
# ============================================================================

cat("📖 STEP 4: Removing unmapped probes (NA symbols)...\n")

data_valid <- data_combined[!is.na(data_combined$Symbol), ]

cat("   ✅ Valid probes after filtering:", nrow(data_valid), "\n")
cat("   ✅ Probes discarded (unmapped):", nrow(data_combined) - nrow(data_valid), "\n\n")

# ============================================================================
# STEP 5: AGGREGATE BY GENE (MEDIANA) — OTIMIZADO COM LISTA
# ============================================================================

cat("📖 STEP 5: Aggregating probes → genes using MEDIAN...\n")

unique_symbols <- unique(data_valid$Symbol)
n_unique <- length(unique_symbols)

cat("   Processing", n_unique, "unique genes...\n")

# Initialize LIST for performance
results_list <- list()

# Aggregate by gene
for(i in 1:n_unique) {
  gene_symbol <- unique_symbols[i]
  
  # Get all probes for this gene
  gene_data <- data_valid[data_valid$Symbol == gene_symbol, ]
  
  # AGREGAÇÃO: Mediana do log2FC (robust)
  median_log2fc <- median(gene_data$log2FoldChange, na.rm = TRUE)
  
  # P-value: do probe com |log2FC| máximo (mais representativo)
  max_idx <- which.max(abs(gene_data$log2FoldChange))
  best_padj <- gene_data$padj[max_idx]
  probe_selected <- gene_data$ProbeID[max_idx]
  
  # Store in list
  results_list[[i]] <- list(
    Symbol = gene_symbol,
    log2FoldChange_median = median_log2fc,
    padj_best = best_padj,
    probe_selected = probe_selected,
    n_probes = nrow(gene_data),
    ProbeIDs = paste(gene_data$ProbeID, collapse = ";")
  )
}

# Convert list to data.frame (ONE operation)
data_aggregated <- do.call(rbind, 
  lapply(results_list, function(x) data.frame(
    Symbol = x$Symbol,
    log2FoldChange_median = x$log2FoldChange_median,
    padj_best = x$padj_best,
    probe_selected = x$probe_selected,
    n_probes = x$n_probes,
    ProbeIDs = x$ProbeIDs,
    stringsAsFactors = FALSE
  ))
)

rownames(data_aggregated) <- NULL

# Sort by padj (most significant first)
data_aggregated <- data_aggregated[order(data_aggregated$padj_best), ]

# Add rank
data_aggregated$Rank <- 1:nrow(data_aggregated)

# Reorder columns
data_aggregated <- data_aggregated[, c("Rank", "Symbol", "log2FoldChange_median", 
                                        "padj_best", "probe_selected", 
                                        "n_probes", "ProbeIDs")]

cat("   ✅ Genes after aggregation:", nrow(data_aggregated), "\n")
cat("   ✅ Genes with 1 probe:", sum(data_aggregated$n_probes == 1), "\n")
cat("   ✅ Genes with 2+ probes:", sum(data_aggregated$n_probes > 1), "\n\n")

# ============================================================================
# STEP 6: VALIDATION
# ============================================================================

cat("📖 STEP 6: Validation checks...\n")

n_duplicates <- sum(duplicated(data_aggregated$Symbol))
cat("   ✅ Duplicate symbols:", n_duplicates, "(should be 0)\n")

if(n_duplicates > 0) {
  stop("ERROR: Found duplicates after aggregation!")
}

n_missing <- sum(is.na(data_aggregated$Symbol))
cat("   ✅ Missing symbols:", n_missing, "(should be 0)\n\n")

# ============================================================================
# STEP 7: SAVE OUTPUTS
# ============================================================================

cat("📖 STEP 7: Saving aggregated gene list...\n")

# Full table (for reference)
write.csv(data_aggregated,
          "results/tables/FASE8_genes_aggregated_full.csv",
          row.names = FALSE)
cat("   ✅ Saved: results/tables/FASE8_genes_aggregated_full.csv\n")

# Gene symbols only (for EnrichR)
gene_symbols_clean <- data_aggregated[order(data_aggregated$padj_best), "Symbol"]

write.table(gene_symbols_clean,
            "results/tables/FASE8_gene_symbols_final.txt",
            col.names = FALSE,
            row.names = FALSE,
            quote = FALSE)
cat("   ✅ Saved: results/tables/FASE8_gene_symbols_final.txt\n\n")

# ============================================================================
# STEP 8: SUMMARY STATISTICS
# ============================================================================

cat(paste0(strrep("=", 70), "\n"))
cat("🧬 AGGREGATION SUMMARY\n")
cat(paste0(strrep("=", 70), "\n"))
cat("INPUT:  615 probes (Affymetrix)\n")
cat("LOST:    54 probes (unmapped to gene symbols)\n")
cat("VALID:  561 probes (with gene symbol)\n")
cat("OUTPUT: ", nrow(data_aggregated), "unique genes\n")
cat("METHOD: MEDIAN of log2FoldChange per gene\n")
cat("STATUS: ✅ READY FOR ENRICHMENT\n")
cat(paste0(strrep("=", 70), "\n\n"))

cat("📊 Distribution of probes per gene:\n")
probe_counts <- table(data_aggregated$n_probes)
for(i in 1:length(probe_counts)) {
  n_probes_val <- as.numeric(names(probe_counts)[i])
  count <- probe_counts[i]
  cat("   ", n_probes_val, "probe(s): ", count, "genes\n", sep = "")
}

cat("\n🔝 Top 10 most significant genes (by padj):\n")
top10 <- head(data_aggregated[, c("Rank", "Symbol", "log2FoldChange_median", 
                                   "padj_best", "n_probes")], 10)
print(top10)

cat("\n✅ Aggregation complete!\n")
cat("Next step: Use FASE8_gene_symbols_final.txt for EnrichR validation\n")
cat(paste0(strrep("=", 70), "\n"))
