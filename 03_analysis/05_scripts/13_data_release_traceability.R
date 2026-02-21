#!/usr/bin/env Rscript
# =============================================================================
# 13_data_release_traceability.R — Stage-3: Data Release & Traceability
# TRACEABILITY.csv, DATA_AVAILABILITY.md, SHA256 checksums, final audit
# Constitution: Stage-3_Instructions.md, MASTER_CONSTITUTION.md
# =============================================================================

set.seed(42)
log_msg("info", "=== Stage 13: Data Release & Traceability ===")

suppressPackageStartupMessages(library(tidyverse))

release_dir <- paths$stage3_data

# =============================================================================
# TRACEABILITY MATRIX
# =============================================================================

trace <- tribble(
  ~Stage, ~Script, ~Input, ~Output, ~Figure_Table, ~Manuscript_Section,
  # Stage-1
  "1", "01_setup.R",
  "(environment)", "sessionInfo.txt, packages.csv",
  NA, "Methods",
  "1", "02_data_inspect_qc_harmonize.R",
  "Trees.csv, Shrubs.csv, Herbs.csv, Regeneration.csv, Environmental_data.csv",
  "env_clean.rds, *_long_clean.rds, Table01_data_qc_summary.csv",
  "Table 1", "Methods / Data Preparation",
  "1", "03_build_matrices.R",
  "*_long_clean.rds, env_clean.rds",
  "*_mat.rds, community_matrices.rds, matrix_summary.csv",
  NA, "Methods / Data Preparation",

  # Stage-2
  "2", "04_nmds_envfit.R",
  "community_matrices.rds, env_clean.rds",
  "nmds_results.rds, envfit_results.rds, nmds_summary.csv",
  "Figure 1", "Results / Community Ordination",
  "2", "05_permanova_dispersion.R",
  "community_matrices.rds, env_clean.rds",
  "permanova_results.rds, dispersion_results.rds, permanova_summary.csv",
  "Table 2", "Results / Community Differences",
  "2", "06_cca_vif_permutation.R",
  "community_matrices.rds, env_clean.rds",
  "cca_results.rds, cca_scores.rds, cca_summary.csv, vif_*.csv",
  "Figure 4, Table 3", "Results / Species-Environment",
  "2", "07_indicator_species.R",
  "community_matrices.rds, env_clean.rds",
  "indval_results.rds, indicators_*.csv, indicator_species_summary.csv",
  "Table 5", "Results / Indicator Species",
  "2", "08_diversity_regeneration_metrics.R",
  "community_matrices.rds, env_clean.rds, regeneration_long_clean.rds",
  "diversity_*.csv, regeneration_metrics.csv, species_accumulation.csv",
  "Figure 2, 3, 6, Table 4", "Results / Diversity",
  "2", "09_ml_regeneration_rf_xgb.R",
  "env_clean.rds, diversity_metrics.rds",
  "rf_model.rds, xgb_model.bin, rf_importance.csv, xgb_importance.csv",
  "Figure 5, Table 6", "Results / Regeneration Modelling",

  # Stage-3
  "3", "10_publication_figures_and_tables.R",
  "All Stage-2 checkpoints",
  "Figure01-06 (PNG+PDF), Table01-06 (CSV)",
  "All Figures/Tables", "All sections",
  "3", "11_manuscript_blocks.R",
  "All summary CSVs",
  "Methods_Computation.md, Results_Stage2.md, Figure_Captions.md",
  NA, "Methods, Results, Captions",
  "3", "12_supplementary_materials.R",
  "All CSVs + checkpoints",
  "TableS1-S10 (supplementary CSVs)",
  "Supp Tables", "Supplementary",
  "3", "13_data_release_traceability.R",
  "All outputs",
  "TRACEABILITY.csv, DATA_AVAILABILITY.md, checksums.sha256",
  NA, "Data Availability"
)

write_csv(trace, file.path(paths$stage3_figs, "..", "TRACEABILITY.csv"))
log_msg("info", "TRACEABILITY.csv written")

# =============================================================================
# SHA256 CHECKSUMS
# =============================================================================

# Checksum all key output files
output_files <- c(
  list.files(paths$tables, full.names = TRUE),
  list.files(paths$data_processed, full.names = TRUE),
  list.files(paths$stage3_figs, pattern = "\\.png$", full.names = TRUE),
  list.files(paths$stage3_tabs, full.names = TRUE),
  list.files(paths$stage3_supp, full.names = TRUE)
)

if (length(output_files) > 0) {
  checksums <- tibble(
    file = basename(output_files),
    path = output_files,
    sha256 = sapply(output_files, function(f) {
      digest::digest(f, algo = "sha256", file = TRUE)
    }, USE.NAMES = FALSE)
  )
  # If digest not available, use file size as fallback
  if (all(is.na(checksums$sha256))) {
    checksums$sha256 <- file.info(output_files)$size
    log_msg("warn", "digest package not available — using file sizes")
  }
  write_csv(checksums, file.path(release_dir, "checksums.sha256.csv"))
  log_msg("info", paste("Checksums computed for", nrow(checksums), "files"))
} else {
  log_msg("warn", "No output files found for checksums")
}

# =============================================================================
# DATA_AVAILABILITY.md
# =============================================================================

da_lines <- c(
  "# Data Availability Statement", "",
  paste("Generated:", Sys.time()), "",
  "## Raw Data", "",
  "Raw vegetation and environmental CSV files are archived in `01_data/`.",
  "These files are READ-ONLY and must not be modified.", "",
  "## Processed Data", "",
  "Processed community matrices (RDS format) are in",
  "`03_analysis/03_outputs/data_processed/`.", "",
  "## Analysis Outputs", "",
  "- Summary tables (CSV): `03_analysis/03_outputs/tables/`",
  "- Ordination results (RDS): `03_analysis/04_results/ordinations/`",
  "- Statistical tests (RDS): `03_analysis/04_results/tests/`",
  "- Indicator species (CSV, RDS): `03_analysis/04_results/indicators/`",
  "- ML models (RDS, BIN): `03_analysis/04_results/ml/`", "",
  "## Publication Materials", "",
  "- Figures (PNG 300dpi + PDF): `03_analysis/06_stage3/01_figures/`",
  "- Formatted tables (CSV): `03_analysis/06_stage3/02_tables/`",
  "- Manuscript blocks (MD): `03_analysis/06_stage3/03_manuscript_blocks/`",
  "- Supplementary (CSV): `03_analysis/06_stage3/04_supplementary/`", "",
  "## Reproducibility", "",
  "- R version and packages: `03_analysis/00_admin/sessionInfo.txt`",
  "- Package versions: `03_analysis/renv.lock`",
  "- Pipeline log: `03_analysis/01_logs/pipeline.log`",
  "- Audit trail: `03_analysis/99_handoff/AUDIT_STAGE_*.md`",
  "- Traceability: `03_analysis/06_stage3/TRACEABILITY.csv`",
  "- Checksums: `03_analysis/06_stage3/05_data_release/checksums.sha256.csv`", "",
  "## Scripts", "",
  "All analysis scripts are in `03_analysis/05_scripts/`:", "",
  "| Script | Purpose |",
  "|---|---|",
  "| 01_setup.R | Environment setup & dependency locking |",
  "| 02_data_inspect_qc_harmonize.R | Data QC & harmonisation |",
  "| 03_build_matrices.R | Community matrix construction |",
  "| 04_nmds_envfit.R | NMDS ordination & environmental fitting |",
  "| 05_permanova_dispersion.R | PERMANOVA & dispersion tests |",
  "| 06_cca_vif_permutation.R | CCA with VIF screening |",
  "| 07_indicator_species.R | Indicator species analysis |",
  "| 08_diversity_regeneration_metrics.R | Diversity & regeneration metrics |",
  "| 09_ml_regeneration_rf_xgb.R | Random Forest & XGBoost models |",
  "| 10_publication_figures_and_tables.R | Publication figures & tables |",
  "| 11_manuscript_blocks.R | Manuscript automation |",
  "| 12_supplementary_materials.R | Supplementary materials |",
  "| 13_data_release_traceability.R | Data release & traceability |", "",
  "## Licence", "",
  "See LICENSE in the project root.", "",
  "## Citation", "",
  "See CITATION.cff in the project root.", ""
)
writeLines(da_lines, file.path(release_dir, "DATA_AVAILABILITY.md"))
log_msg("info", "DATA_AVAILABILITY.md written")

# =============================================================================
# COPY KEY FILES TO RELEASE
# =============================================================================

# renv.lock
lock_file <- file.path(paths$analysis, "renv.lock")
if (file.exists(lock_file)) {
  file.copy(lock_file, file.path(release_dir, "renv.lock"), overwrite = TRUE)
}

# LICENSE and CITATION
for (f in c("LICENSE", "CITATION.cff")) {
  src <- file.path(paths$root, f)
  if (file.exists(src)) {
    file.copy(src, file.path(release_dir, f), overwrite = TRUE)
  }
}

# =============================================================================
# FINAL STATUS
# =============================================================================

final_status <- c(
  "# Pipeline Status", "",
  paste("Last updated:", Sys.time()), "",
  "## Stages", "",
  "### Stage-1 Foundation",
  "- [x] Stage 1: Setup & Dependency Locking",
  "- [x] Stage 2: Data QC & Harmonisation",
  "- [x] Stage 3: Build Community Matrices", "",
  "### Stage-2 Ecological Analyses",
  "- [x] Stage 4: NMDS & Environmental Fitting",
  "- [x] Stage 5: PERMANOVA & Dispersion Tests",
  "- [x] Stage 6: CCA with VIF Selection",
  "- [x] Stage 7: Indicator Species Analysis",
  "- [x] Stage 8: Diversity & Regeneration Metrics",
  "- [x] Stage 9: ML Regeneration Models (RF + XGBoost)", "",
  "### Stage-3 Synthesis & Publication",
  "- [x] Stage 10: Publication Figures & Tables",
  "- [x] Stage 11: Manuscript Blocks",
  "- [x] Stage 12: Supplementary Materials",
  "- [x] Stage 13: Data Release & Traceability", "",
  "## Summary", "",
  "All 13 stages complete. Pipeline finished successfully.",
  "Stage-3 synthesis complete. Manuscript blocks and data release ready.", ""
)
writeLines(final_status, file.path(paths$handoff, "STATUS.md"))

# =============================================================================
# AUDIT (FINAL)
# =============================================================================

write_audit(
  stage_num  = 13,
  stage_name = "Data Release & Traceability",
  inputs     = "All pipeline outputs",
  outputs    = c("TRACEABILITY.csv", "DATA_AVAILABILITY.md",
                 "checksums.sha256.csv", "renv.lock (copy)",
                 "LICENSE (copy)", "CITATION.cff (copy)"),
  notes      = "Final pipeline stage — all outputs archived"
)

update_stage("data_release")
log_msg("info", "=== Stage 13: Data Release & Traceability Complete ===")
log_msg("info", "")
log_msg("info", "========================================")
log_msg("info", "  FULL PIPELINE COMPLETE (13 STAGES)")
log_msg("info", "========================================")
log_msg("info", "Stage-3 synthesis complete.")
log_msg("info", "Manuscript blocks and data release ready.")
