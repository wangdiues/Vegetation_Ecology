#!/usr/bin/env Rscript
# =============================================================================
# 04_nmds_envfit.R — Stage-2: NMDS Ordination & Environmental Fitting
# Bray-Curtis NMDS (k=2) + envfit for each stratum
# Constitution: MASTER_CONSTITUTION.md, Stage-2_Instructions.md, Methods.md
# =============================================================================

set.seed(42)
log_msg("info", "=== Stage 4: NMDS & Environmental Fitting ===")

suppressPackageStartupMessages({
  library(tidyverse)
  library(vegan)
})

# --- Load checkpoints ---
matrices  <- load_checkpoint("community_matrices")
env_clean <- load_checkpoint("env_clean")

# =============================================================================
# HELPER: intersect plots between matrix and env
# =============================================================================

intersect_plots <- function(mat, env_df) {
  mat_plots <- rownames(mat)
  env_plots <- env_df$plot_id
  shared    <- sort(intersect(mat_plots, env_plots))
  list(
    mat = mat[shared, , drop = FALSE],
    env = env_df %>% filter(plot_id %in% shared) %>%
          arrange(match(plot_id, shared))
  )
}

# =============================================================================
# NMDS + ENVFIT FUNCTION
# =============================================================================

run_nmds_envfit <- function(mat, env_df, stratum,
                            k = 2, trymax = 100, nperm = 999) {
  set.seed(42)

  # Remove empty rows/columns
  mat <- mat[rowSums(mat) > 0, colSums(mat) > 0, drop = FALSE]

  if (nrow(mat) < 5 || ncol(mat) < 2) {
    log_msg("warn", paste(stratum, ": insufficient data for NMDS"))
    return(NULL)
  }

  # NMDS
  nmds <- metaMDS(mat, distance = "bray", k = k, trymax = trymax,
                  autotransform = FALSE, trace = 0)

  stress_qual <- case_when(
    nmds$stress < 0.05 ~ "Excellent",
    nmds$stress < 0.10 ~ "Good",
    nmds$stress < 0.20 ~ "Acceptable",
    TRUE               ~ "Poor"
  )
  log_msg("info", paste(stratum, "NMDS: stress =",
                         round(nmds$stress, 4), paste0("(", stress_qual, ")"),
                         "| converged =", nmds$converged))

  # envfit — intersect with env data
  ip <- intersect_plots(mat, env_df)
  if (nrow(ip$mat) < 5) {
    log_msg("warn", paste(stratum, ": too few shared plots for envfit"))
    return(list(nmds = nmds, envfit = NULL, stratum = stratum))
  }

  # Re-run NMDS on intersected matrix for envfit alignment
  set.seed(42)
  nmds_sub <- metaMDS(ip$mat, distance = "bray", k = k, trymax = trymax,
                      autotransform = FALSE, trace = 0)

  # Select numeric env columns (exclude plot_id)
  env_num <- ip$env %>%
    select(where(is.numeric)) %>%
    select(where(~ sum(!is.na(.)) / length(.) > 0.5)) %>%  # >50% non-NA
    select(where(~ sd(., na.rm = TRUE) > 0))                # non-zero variance

  set.seed(42)
  ef <- envfit(nmds_sub, env_num, permutations = nperm, na.rm = TRUE)

  # Extract envfit results
  vec_df <- as.data.frame(scores(ef, display = "vectors")) %>%
    rownames_to_column("variable") %>%
    mutate(
      r2      = ef$vectors$r,
      p_value = ef$vectors$pvals,
      significant = p_value < 0.05
    )

  n_sig <- sum(vec_df$significant)
  log_msg("info", paste(stratum, "envfit:", n_sig, "of",
                         nrow(vec_df), "variables significant"))

  list(nmds = nmds, nmds_sub = nmds_sub, envfit = ef,
       envfit_df = vec_df, stratum = stratum,
       n_sites = nrow(mat), n_species = ncol(mat))
}

# =============================================================================
# RUN FOR ALL STRATA
# =============================================================================

results <- list(
  trees  = run_nmds_envfit(matrices$trees,  env_clean, "Trees"),
  shrubs = run_nmds_envfit(matrices$shrubs, env_clean, "Shrubs"),
  herbs  = run_nmds_envfit(matrices$herbs,  env_clean, "Herbs"),
  regen  = run_nmds_envfit(matrices$regen,  env_clean, "Regen")
)

# =============================================================================
# EXPORT TABLES
# =============================================================================

# NMDS summary
nmds_summary <- tibble(
  stratum        = map_chr(results, ~ .x$stratum %||% NA_character_),
  n_sites        = map_int(results, ~ .x$n_sites %||% NA_integer_),
  n_species      = map_int(results, ~ .x$n_species %||% NA_integer_),
  stress         = map_dbl(results, ~ .x$nmds$stress %||% NA_real_),
  converged      = map_int(results, ~ as.integer(.x$nmds$converged %||% NA_integer_)),
  n_sig_env_vectors = map_int(results, ~ {
    if (!is.null(.x$envfit_df)) sum(.x$envfit_df$significant) else 0L
  })
)
write_csv(nmds_summary, file.path(paths$tables, "nmds_summary.csv"))

# Envfit vectors per stratum
for (nm in names(results)) {
  res <- results[[nm]]
  if (!is.null(res$envfit_df)) {
    write_csv(res$envfit_df,
              file.path(paths$tables, paste0("envfit_vectors_", nm, ".csv")))
  }
}

# =============================================================================
# SAVE RESULTS
# =============================================================================

# Detailed results to 04_results/
saveRDS(map(results, ~ .x$nmds),
        file.path(paths$ordinations, "nmds_results.rds"))
saveRDS(map(results, ~ .x$envfit),
        file.path(paths$ordinations, "envfit_results.rds"))

# Checkpoint
save_checkpoint(results, "nmds_envfit")

# =============================================================================
# AUDIT
# =============================================================================

write_audit(
  stage_num      = 4,
  stage_name     = "NMDS & Environmental Fitting",
  inputs         = c("community_matrices.rds", "env_clean.rds"),
  outputs        = c("nmds_summary.csv", "envfit_vectors_*.csv",
                     "nmds_results.rds", "envfit_results.rds"),
  plot_counts    = paste(nmds_summary$stratum, ":", nmds_summary$n_sites),
  species_counts = paste(nmds_summary$stratum, ":", nmds_summary$n_species),
  seeds_used     = "42 (NMDS + envfit)",
  notes          = paste("Stress:", paste(round(nmds_summary$stress, 4),
                                          collapse = ", "))
)

update_stage("nmds")
log_msg("info", "=== Stage 4: NMDS Complete ===")
