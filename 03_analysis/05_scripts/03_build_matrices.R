#!/usr/bin/env Rscript
# =============================================================================
# 03_build_matrices.R — Stage-1: Community Matrix Construction
# Builds sites x species matrices from clean long-format data
# Constitution: MASTER_CONSTITUTION.md, Stage-1_Instructions.md
# =============================================================================

set.seed(42)
log_msg("info", "=== Stage 3: Build Community Matrices ===")

suppressPackageStartupMessages(library(tidyverse))

# =============================================================================
# LOAD CHECKPOINTS (never re-read raw CSVs)
# =============================================================================

trees_long  <- load_checkpoint("trees_long_clean")
shrubs_long <- load_checkpoint("shrubs_long_clean")
herbs_long  <- load_checkpoint("herbs_long_clean")
regen_long  <- load_checkpoint("regeneration_long_clean")
env_clean   <- load_checkpoint("env_clean")

# =============================================================================
# MATRIX CONSTRUCTION
# =============================================================================

build_matrix <- function(long_df, stratum) {
  # Validate required columns
  stopifnot(all(c("plot_id", "species", "abundance") %in% names(long_df)))

  # Deterministic ordering BEFORE pivot (constitution requirement)
  long_df <- long_df %>%
    arrange(plot_id, species) %>%
    group_by(plot_id, species) %>%
    summarise(abundance = sum(abundance, na.rm = TRUE), .groups = "drop")

  # Pivot to wide: rows = plots, cols = species (alphabetical)
  mat_wide <- long_df %>%
    pivot_wider(names_from = species, values_from = abundance,
                values_fill = 0) %>%
    arrange(plot_id)

  # Extract plot_id, convert to numeric matrix
  plot_ids <- mat_wide$plot_id
  mat <- mat_wide %>%
    select(-plot_id) %>%
    select(order(names(.))) %>%   # alphabetical column order
    as.data.frame()
  rownames(mat) <- plot_ids

  log_msg("info", paste(stratum, "matrix:",
                         nrow(mat), "sites x", ncol(mat), "species"))
  mat
}

trees_mat  <- build_matrix(trees_long,  "Trees")
shrubs_mat <- build_matrix(shrubs_long, "Shrubs")
herbs_mat  <- build_matrix(herbs_long,  "Herbs")
regen_mat  <- build_matrix(regen_long,  "Regen")

# =============================================================================
# MATRIX SUMMARY TABLE
# =============================================================================

mat_summary <- tibble(
  stratum         = c("Trees", "Shrubs", "Herbs", "Regeneration"),
  n_sites         = c(nrow(trees_mat), nrow(shrubs_mat),
                      nrow(herbs_mat), nrow(regen_mat)),
  n_species       = c(ncol(trees_mat), ncol(shrubs_mat),
                      ncol(herbs_mat), ncol(regen_mat)),
  total_abundance = c(sum(trees_mat), sum(shrubs_mat),
                      sum(herbs_mat), sum(regen_mat)),
  matrix_density  = c(
    round(mean(trees_mat > 0)  * 100, 1),
    round(mean(shrubs_mat > 0) * 100, 1),
    round(mean(herbs_mat > 0)  * 100, 1),
    round(mean(regen_mat > 0)  * 100, 1)
  )
)
write_csv(mat_summary, file.path(paths$tables, "matrix_summary.csv"))
log_msg("info", "Matrix summary written")

# =============================================================================
# ENVIRONMENTAL ALIGNMENT (log only — Stage-1 does NOT drop vegetation plots)
# =============================================================================

env_plots <- env_clean$plot_id
for (nm in c("Trees", "Shrubs", "Herbs", "Regen")) {
  mat <- get(paste0(tolower(nm), "_mat"))
  mat_plots <- rownames(mat)
  missing <- setdiff(mat_plots, env_plots)
  if (length(missing) > 0) {
    log_msg("warn", paste(nm, ":", length(missing),
                           "plots without env data:",
                           paste(head(missing, 5), collapse = ", ")))
  }
}

# =============================================================================
# SAVE MATRICES
# =============================================================================

# Individual matrices to data_processed/
saveRDS(trees_mat,  file.path(paths$data_processed, "trees_mat.rds"))
saveRDS(shrubs_mat, file.path(paths$data_processed, "shrubs_mat.rds"))
saveRDS(herbs_mat,  file.path(paths$data_processed, "herbs_mat.rds"))
saveRDS(regen_mat,  file.path(paths$data_processed, "regen_mat.rds"))

# Bundle checkpoint
save_checkpoint(list(
  trees  = trees_mat,
  shrubs = shrubs_mat,
  herbs  = herbs_mat,
  regen  = regen_mat,
  summary = mat_summary
), "community_matrices")

# =============================================================================
# AUDIT
# =============================================================================

write_audit(
  stage_num      = 3,
  stage_name     = "Community Matrix Construction",
  inputs         = c("trees_long_clean.rds", "shrubs_long_clean.rds",
                     "herbs_long_clean.rds", "regeneration_long_clean.rds",
                     "env_clean.rds"),
  outputs        = c("trees_mat.rds", "shrubs_mat.rds",
                     "herbs_mat.rds", "regen_mat.rds",
                     "community_matrices.rds", "matrix_summary.csv"),
  plot_counts    = c(paste("Trees:", nrow(trees_mat)),
                     paste("Shrubs:", nrow(shrubs_mat)),
                     paste("Herbs:", nrow(herbs_mat)),
                     paste("Regen:", nrow(regen_mat))),
  species_counts = c(paste("Trees:", ncol(trees_mat)),
                     paste("Shrubs:", ncol(shrubs_mat)),
                     paste("Herbs:", ncol(herbs_mat)),
                     paste("Regen:", ncol(regen_mat)))
)

update_stage("matrices")
log_msg("info", "=== Stage 3: Matrices Complete ===")
log_msg("info", "Stage-1 Foundation complete. QC + matrices stable. Ready for Stage-2.")
