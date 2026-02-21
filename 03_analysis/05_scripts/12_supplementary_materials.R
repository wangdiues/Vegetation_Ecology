#!/usr/bin/env Rscript
# =============================================================================
# 12_supplementary_materials.R — Stage-3: Supplementary Materials Packaging
# VIF tables, permutation summaries, diagnostics, ML tuning logs
# Constitution: Stage-3_Instructions.md
# =============================================================================

set.seed(42)
log_msg("info", "=== Stage 12: Supplementary Materials ===")

suppressPackageStartupMessages(library(tidyverse))

supp_dir <- paths$stage3_supp

# =============================================================================
# COLLECT VIF OUTPUTS
# =============================================================================

vif_files <- list.files(paths$tables, pattern = "^vif_.*\\.csv$",
                        full.names = TRUE)
if (length(vif_files) > 0) {
  vif_combined <- map_dfr(vif_files, function(f) {
    df <- read_csv(f, show_col_types = FALSE)
    df$stratum <- sub("vif_|\\.csv", "", basename(f))
    df
  })
  write_csv(vif_combined, file.path(supp_dir, "TableS1_VIF_all_strata.csv"))
  log_msg("info", paste("VIF table combined:", nrow(vif_combined), "rows"))
}

# =============================================================================
# PERMUTATION TEST SUMMARIES
# =============================================================================

perm_file <- file.path(paths$tables, "permanova_summary.csv")
if (file.exists(perm_file)) {
  file.copy(perm_file, file.path(supp_dir, "TableS2_PERMANOVA_full.csv"),
            overwrite = TRUE)
  log_msg("info", "PERMANOVA summary copied to supplementary")
}

# =============================================================================
# ENVFIT VECTORS (all strata combined)
# =============================================================================

envfit_files <- list.files(paths$tables, pattern = "^envfit_vectors_.*\\.csv$",
                           full.names = TRUE)
if (length(envfit_files) > 0) {
  envfit_combined <- map_dfr(envfit_files, function(f) {
    df <- read_csv(f, show_col_types = FALSE)
    df$stratum <- sub("envfit_vectors_|\\.csv", "", basename(f))
    df
  })
  write_csv(envfit_combined, file.path(supp_dir, "TableS3_envfit_all.csv"))
  log_msg("info", "Envfit vectors combined")
}

# =============================================================================
# INDICATOR SPECIES FULL TABLES
# =============================================================================

ind_files <- list.files(paths$indicators, pattern = "^indicators_.*\\.csv$",
                        full.names = TRUE)
if (length(ind_files) > 0) {
  ind_combined <- map_dfr(ind_files, function(f) {
    df <- read_csv(f, show_col_types = FALSE)
    df$stratum <- sub("indicators_|\\.csv", "", basename(f))
    df
  })
  write_csv(ind_combined, file.path(supp_dir, "TableS4_indicator_species_full.csv"))
  log_msg("info", paste("Indicator species combined:", nrow(ind_combined), "records"))
}

# =============================================================================
# ML TUNING LOG
# =============================================================================

ml_data <- tryCatch(load_checkpoint("ml_models"), error = function(e) NULL)

if (!is.null(ml_data)) {
  # Parameter grid
  params <- tibble(
    model       = c("Random Forest", "XGBoost"),
    ntree_nrounds = c("500", "100"),
    max_depth   = c("default", "4"),
    eta         = c("NA", "0.1"),
    subsample   = c("NA", "0.8"),
    colsample   = c("NA", "0.8"),
    cv_folds    = c("5", "5"),
    seed        = c("42", "42")
  )
  write_csv(params, file.path(supp_dir, "TableS5_ML_parameters.csv"))

  # RF + XGB importance combined
  rf_imp <- ml_data$rf_imp %>% mutate(model = "RF") %>%
    select(model, variable, importance = `%IncMSE`)
  xgb_imp <- as.data.frame(ml_data$xgb_imp) %>%
    mutate(model = "XGBoost") %>%
    select(model, variable = Feature, importance = Gain)
  combined_imp <- bind_rows(rf_imp, xgb_imp)
  write_csv(combined_imp, file.path(supp_dir, "TableS6_variable_importance.csv"))

  # CV fold results
  cv_folds <- bind_rows(
    ml_data$rf_cv %>% mutate(model = "RF"),
    ml_data$xgb_cv %>% mutate(model = "XGBoost")
  )
  write_csv(cv_folds, file.path(supp_dir, "TableS7_CV_fold_results.csv"))

  log_msg("info", "ML tuning and importance tables written")
}

# =============================================================================
# DIVERSITY EXTENDED
# =============================================================================

div_corr <- file.path(paths$tables, "diversity_correlations.csv")
if (file.exists(div_corr)) {
  file.copy(div_corr, file.path(supp_dir, "TableS8_diversity_correlations.csv"),
            overwrite = TRUE)
}

beta_file <- file.path(paths$tables, "beta_diversity.csv")
if (file.exists(beta_file)) {
  file.copy(beta_file, file.path(supp_dir, "TableS9_beta_diversity.csv"),
            overwrite = TRUE)
}

# =============================================================================
# CLUSTER / MATRIX DIAGNOSTICS
# =============================================================================

mat_file <- file.path(paths$tables, "matrix_summary.csv")
if (file.exists(mat_file)) {
  file.copy(mat_file, file.path(supp_dir, "TableS10_matrix_diagnostics.csv"),
            overwrite = TRUE)
}

# =============================================================================
# AUDIT
# =============================================================================

supp_files <- list.files(supp_dir)
log_msg("info", paste("Supplementary files:", length(supp_files)))

write_audit(
  stage_num  = 12,
  stage_name = "Supplementary Materials",
  inputs     = c("All Stage-2 CSVs and checkpoints"),
  outputs    = paste(supp_files),
  notes      = "Extended tables for journal supplementary submission"
)

update_stage("supplementary")
log_msg("info", "=== Stage 12: Supplementary Materials Complete ===")
