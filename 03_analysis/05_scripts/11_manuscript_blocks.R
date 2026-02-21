#!/usr/bin/env Rscript
# =============================================================================
# 11_manuscript_blocks.R — Stage-3: Manuscript Automation
# Auto-generates Results, Methods, Supplementary text blocks
# Constitution: Stage-3_Instructions.md — NO interpretation, numbers only
# =============================================================================

set.seed(42)
log_msg("info", "=== Stage 11: Manuscript Blocks ===")

suppressPackageStartupMessages(library(tidyverse))

ms_dir <- paths$stage3_ms

# --- Load data ---
qc_file   <- file.path(paths$tables, "Table01_data_qc_summary.csv")
perm_file <- file.path(paths$tables, "permanova_summary.csv")
cca_file  <- file.path(paths$tables, "cca_summary.csv")
div_file  <- file.path(paths$tables, "diversity_summary.csv")
isa_file  <- file.path(paths$tables, "indicator_species_summary.csv")
ml_file   <- file.path(paths$tables, "ml_summary.csv")
mat_file  <- file.path(paths$tables, "matrix_summary.csv")

read_if <- function(path) {
  if (file.exists(path)) read_csv(path, show_col_types = FALSE) else NULL
}

qc_tbl   <- read_if(qc_file)
perm_tbl <- read_if(perm_file)
cca_tbl  <- read_if(cca_file)
div_tbl  <- read_if(div_file)
isa_tbl  <- read_if(isa_file)
ml_tbl   <- read_if(ml_file)
mat_tbl  <- read_if(mat_file)

# =============================================================================
# Methods_Computation.md
# =============================================================================

methods_lines <- c(
  "# Computational Methods", "",
  "## Software Environment", "",
  paste("All analyses were conducted in R version",
        paste(R.version$major, R.version$minor, sep = "."),
        "with packages managed via renv."),
  ""
)
if (!is.null(mat_tbl)) {
  methods_lines <- c(methods_lines,
    "## Data Preparation", "",
    paste("Community matrices were constructed for four vegetation strata:",
          paste(mat_tbl$stratum, collapse = ", "), "."),
    paste("Matrix dimensions ranged from",
          min(mat_tbl$n_sites), "to", max(mat_tbl$n_sites), "sites and",
          min(mat_tbl$n_species), "to", max(mat_tbl$n_species), "species."),
    ""
  )
}
methods_lines <- c(methods_lines,
  "## Ordination", "",
  "Non-metric Multidimensional Scaling (NMDS) was computed using Bray-Curtis",
  "dissimilarities (k = 2, seed = 42). Environmental vectors were fitted via",
  "envfit with 999 permutations.", "",
  "## Community Differences", "",
  "Permutational MANOVA (PERMANOVA) was performed using adonis2 with 999",
  "permutations. Homogeneity of multivariate dispersions was assessed with",
  "betadisper and permutation tests.", "",
  "## Constrained Ordination", "",
  "Canonical Correspondence Analysis (CCA) was performed after iterative VIF",
  "screening (threshold = 10, deterministic tie-breaking). Significance was",
  "tested with 999 permutations.", "",
  "## Indicator Species", "",
  "Indicator Species Analysis used multipatt with the IndVal.g function,",
  "999 permutations, and alpha = 0.05.", "",
  "## Diversity Indices", "",
  "Alpha diversity was quantified using species richness, Shannon-Wiener (H'),",
  "Simpson (1-D), inverse Simpson, and Pielou's evenness (J). Beta diversity",
  "was calculated as Whittaker's beta (gamma / mean alpha).", "",
  "## Regeneration Modelling", "",
  "Random Forest (ntree = 500) and XGBoost (nrounds = 100, max_depth = 4,",
  "eta = 0.1) were trained with 5-fold cross-validation (seed = 42).",
  "Variable importance was assessed via %IncMSE (RF) and Gain (XGBoost).", ""
)

writeLines(methods_lines, file.path(ms_dir, "Methods_Computation.md"))
log_msg("info", "Methods_Computation.md written")

# =============================================================================
# Results_Stage2.md (numbers only — no interpretation)
# =============================================================================

results_lines <- c("# Results — Stage 2 Analyses", "")

if (!is.null(perm_tbl)) {
  results_lines <- c(results_lines,
    "## PERMANOVA", "",
    paste("| Stratum | R2 | F | p | Dispersion p |"),
    paste("|---|---|---|---|---|")
  )
  for (i in seq_len(nrow(perm_tbl))) {
    r <- perm_tbl[i, ]
    results_lines <- c(results_lines,
      paste0("| ", r$stratum, " | ", r$permanova_R2, " | ", r$permanova_F,
             " | ", r$permanova_p, " | ", r$dispersion_p, " |"))
  }
  results_lines <- c(results_lines, "")
}

if (!is.null(cca_tbl)) {
  results_lines <- c(results_lines,
    "## CCA", "",
    paste("| Stratum | Vars | % Explained | p |"),
    paste("|---|---|---|---|")
  )
  for (i in seq_len(nrow(cca_tbl))) {
    r <- cca_tbl[i, ]
    results_lines <- c(results_lines,
      paste0("| ", r$stratum, " | ", r$n_env_vars, " | ",
             r$prop_explained, " | ", r$p_value, " |"))
  }
  results_lines <- c(results_lines, "")
}

if (!is.null(div_tbl)) {
  results_lines <- c(results_lines,
    "## Diversity", "",
    paste("| Stratum | Richness (mean +/- SD) | Shannon | Evenness |"),
    paste("|---|---|---|---|")
  )
  for (i in seq_len(nrow(div_tbl))) {
    r <- div_tbl[i, ]
    results_lines <- c(results_lines,
      paste0("| ", r$stratum, " | ", r$richness_mean, " +/- ", r$richness_sd,
             " | ", r$shannon_mean, " +/- ", r$shannon_sd,
             " | ", r$evenness_mean, " |"))
  }
  results_lines <- c(results_lines, "")
}

if (!is.null(isa_tbl)) {
  results_lines <- c(results_lines,
    "## Indicator Species", "",
    paste("| Stratum | Significant / Total | % |"),
    paste("|---|---|---|")
  )
  for (i in seq_len(nrow(isa_tbl))) {
    r <- isa_tbl[i, ]
    results_lines <- c(results_lines,
      paste0("| ", r$stratum, " | ", r$n_significant_indicators,
             " / ", r$n_species, " | ", r$pct_significant, " |"))
  }
  results_lines <- c(results_lines, "")
}

if (!is.null(ml_tbl)) {
  results_lines <- c(results_lines,
    "## ML Model Performance", "",
    paste("| Model | RMSE +/- SD | R2 +/- SD | MAE |"),
    paste("|---|---|---|---|")
  )
  for (i in seq_len(nrow(ml_tbl))) {
    r <- ml_tbl[i, ]
    results_lines <- c(results_lines,
      paste0("| ", r$model, " | ", r$cv_rmse, " +/- ", r$cv_rmse_sd,
             " | ", r$cv_r2, " +/- ", r$cv_r2_sd,
             " | ", r$cv_mae, " |"))
  }
  results_lines <- c(results_lines, "")
}

writeLines(results_lines, file.path(ms_dir, "Results_Stage2.md"))
log_msg("info", "Results_Stage2.md written")

# =============================================================================
# Figure_Captions.md
# =============================================================================

captions <- c(
  "# Figure Captions", "",
  "**Figure 1.** Non-metric Multidimensional Scaling (NMDS) ordination of",
  "vegetation plots for four strata (trees, shrubs, herbs, regeneration).",
  "Bray-Curtis dissimilarity, k = 2. Red arrows indicate significant",
  "environmental vectors (envfit, p < 0.05, 999 permutations).", "",
  "**Figure 2.** Alpha diversity indices across vegetation strata.",
  "(A) Species richness, (B) Shannon-Wiener diversity (H'),",
  "(C) Simpson's index (1-D), (D) Pielou's evenness (J).", "",
  "**Figure 3.** Species accumulation curves (random method, 100",
  "permutations) showing cumulative species richness as a function",
  "of sampling effort for each vegetation stratum.", "",
  "**Figure 4.** Canonical Correspondence Analysis (CCA) biplots for",
  "four vegetation strata. Environmental predictors selected after VIF",
  "screening (threshold = 10). Significance tested with 999 permutations.", "",
  "**Figure 5.** Random Forest variable importance for regeneration",
  "richness prediction. Top 10 predictors ranked by percentage increase",
  "in mean squared error (%IncMSE).", "",
  "**Figure 6.** Species richness along the elevational gradient for each",
  "vegetation stratum. LOESS smoothing applied.", ""
)
writeLines(captions, file.path(ms_dir, "Figure_Captions.md"))
log_msg("info", "Figure_Captions.md written")

# =============================================================================
# Supplementary_Methods.md
# =============================================================================

supp_lines <- c(
  "# Supplementary Methods", "",
  "## Seed & Reproducibility", "",
  "All stochastic procedures used set.seed(42). The pipeline is managed",
  "via renv for package version locking.", "",
  "## VIF Selection", "",
  "Variance Inflation Factors were calculated iteratively. At each step,",
  "the variable with the highest VIF was removed. Ties were broken",
  "alphabetically (deterministic). The threshold was VIF = 10.", "",
  "## Cross-Validation", "",
  "5-fold cross-validation was used for Random Forest (ntree = 500) and",
  "XGBoost (nrounds = 100, max_depth = 4, eta = 0.1, subsample = 0.8,",
  "colsample_bytree = 0.8). Folds were created deterministically via",
  "caret::createFolds with seed = 42.", "",
  "## Permutation Tests", "",
  "PERMANOVA, envfit, ISA, and CCA significance tests used 999 permutations.", ""
)
writeLines(supp_lines, file.path(ms_dir, "Supplementary_Methods.md"))
log_msg("info", "Supplementary_Methods.md written")

# =============================================================================
# AUDIT
# =============================================================================

write_audit(
  stage_num  = 11,
  stage_name = "Manuscript Blocks",
  inputs     = c("All Stage-2 summary CSVs"),
  outputs    = c("Methods_Computation.md", "Results_Stage2.md",
                 "Figure_Captions.md", "Supplementary_Methods.md"),
  notes      = "Numbers only — no interpretation per Stage-3 constitution"
)

update_stage("manuscript_blocks")
log_msg("info", "=== Stage 11: Manuscript Blocks Complete ===")
