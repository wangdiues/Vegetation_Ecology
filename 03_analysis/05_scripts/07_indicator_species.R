#!/usr/bin/env Rscript
# =============================================================================
# 07_indicator_species.R — Stage-2: Indicator Species Analysis (ISA)
# multipatt with IndVal.g, alpha = 0.05, 999 permutations
# Constitution: MASTER_CONSTITUTION.md, Stage-2_Instructions.md
# =============================================================================

set.seed(42)
log_msg("info", "=== Stage 7: Indicator Species Analysis ===")

suppressPackageStartupMessages({
  library(tidyverse)
  library(vegan)
  library(indicspecies)
})

matrices  <- load_checkpoint("community_matrices")
env_clean <- load_checkpoint("env_clean")

# Reuse grouping from PERMANOVA if available
perm_results <- tryCatch(load_checkpoint("permanova_dispersion"),
                         error = function(e) NULL)

# =============================================================================
# GROUPING VARIABLE
# =============================================================================

detect_group <- function(env_df) {
  candidates <- c("group", "forest_type", "forest_types",
                   "vegetation_type", "elevation_group")
  for (col in candidates) {
    if (col %in% names(env_df)) {
      n_grp <- n_distinct(env_df[[col]], na.rm = TRUE)
      if (n_grp >= 2 && n_grp <= 10) return(col)
    }
  }
  # Fallback: create elevation groups
  if ("elevation" %in% names(env_df)) {
    env_df$elevation_group <- cut(
      env_df$elevation,
      breaks = quantile(env_df$elevation, c(0, 1/3, 2/3, 1), na.rm = TRUE),
      labels = c("Low", "Mid", "High"), include.lowest = TRUE
    )
    return("elevation_group")
  }
  stop("No grouping variable available for ISA")
}

# If PERMANOVA created elevation_group, ensure it's in env_clean
if (!is.null(perm_results) && !is.null(perm_results$trees$group_var)) {
  group_var <- perm_results$trees$group_var
  if (group_var == "elevation_group" && !"elevation_group" %in% names(env_clean)) {
    env_clean$elevation_group <- cut(
      env_clean$elevation,
      breaks = quantile(env_clean$elevation, c(0, 1/3, 2/3, 1), na.rm = TRUE),
      labels = c("Low", "Mid", "High"), include.lowest = TRUE
    )
  }
} else {
  group_var <- detect_group(env_clean)
  if (group_var == "elevation_group" && !"elevation_group" %in% names(env_clean)) {
    env_clean$elevation_group <- cut(
      env_clean$elevation,
      breaks = quantile(env_clean$elevation, c(0, 1/3, 2/3, 1), na.rm = TRUE),
      labels = c("Low", "Mid", "High"), include.lowest = TRUE
    )
  }
}

log_msg("info", paste("ISA group variable:", group_var))

# =============================================================================
# INDICATOR SPECIES FUNCTION
# =============================================================================

run_indval <- function(mat, env_df, group_var, stratum, nperm = 999) {
  set.seed(42)

  mat <- mat[rowSums(mat) > 0, colSums(mat) > 0, drop = FALSE]

  # Intersect
  shared <- sort(intersect(rownames(mat), env_df$plot_id))
  mat_sub <- mat[shared, , drop = FALSE]
  env_sub <- env_df %>%
    filter(plot_id %in% shared) %>%
    arrange(match(plot_id, shared))

  groups <- env_sub[[group_var]]
  valid  <- !is.na(groups)
  mat_sub <- mat_sub[valid, , drop = FALSE]
  groups  <- factor(groups[valid])

  # Remove zero columns after subset
  mat_sub <- mat_sub[, colSums(mat_sub) > 0, drop = FALSE]

  if (nrow(mat_sub) < 5 || length(unique(groups)) < 2) {
    log_msg("warn", paste(stratum, ": insufficient data for ISA"))
    return(NULL)
  }

  # Run multipatt
  set.seed(42)
  indval <- multipatt(mat_sub, groups, func = "IndVal.g",
                      control = how(nperm = nperm))

  # Extract significant indicators
  sig_table <- indval$sign
  sig_table$species <- rownames(sig_table)
  sig_species <- sig_table %>%
    filter(p.value < 0.05) %>%
    arrange(p.value)

  n_sig <- nrow(sig_species)
  n_total <- ncol(mat_sub)
  log_msg("info", paste(stratum, "ISA:", n_sig, "of", n_total,
                         "species significant (alpha = 0.05)"))

  # Export per stratum
  write_csv(sig_species,
            file.path(paths$indicators,
                      paste0("indicators_", tolower(stratum), ".csv")))

  list(
    stratum    = stratum,
    indval     = indval,
    sig_table  = sig_species,
    n_sites    = nrow(mat_sub),
    n_species  = n_total,
    n_groups   = length(unique(groups)),
    n_sig      = n_sig,
    pct_sig    = round(n_sig / n_total * 100, 1)
  )
}

# =============================================================================
# RUN
# =============================================================================

results <- list(
  trees  = run_indval(matrices$trees,  env_clean, group_var, "Trees"),
  shrubs = run_indval(matrices$shrubs, env_clean, group_var, "Shrubs"),
  herbs  = run_indval(matrices$herbs,  env_clean, group_var, "Herbs"),
  regen  = run_indval(matrices$regen,  env_clean, group_var, "Regen")
)

# =============================================================================
# EXPORT
# =============================================================================

isa_summary <- bind_rows(lapply(results, function(r) {
  if (is.null(r)) return(NULL)
  tibble(
    stratum         = r$stratum,
    group_variable  = group_var,
    n_sites         = r$n_sites,
    n_species       = r$n_species,
    n_groups        = r$n_groups,
    n_significant_indicators = r$n_sig,
    pct_significant = r$pct_sig
  )
}))

write_csv(isa_summary,
          file.path(paths$tables, "indicator_species_summary.csv"))

saveRDS(map(results, ~ .x$indval),
        file.path(paths$indicators, "indval_results.rds"))

save_checkpoint(results, "indicator_species")

write_audit(
  stage_num  = 7,
  stage_name = "Indicator Species Analysis",
  inputs     = c("community_matrices.rds", "env_clean.rds",
                 "permanova_dispersion.rds"),
  outputs    = c("indicator_species_summary.csv", "indicators_*.csv",
                 "indval_results.rds"),
  seeds_used = "42",
  notes      = paste("Group:", group_var, "| Permutations: 999 | alpha: 0.05")
)

update_stage("indicators")
log_msg("info", "=== Stage 7: Indicator Species Complete ===")
