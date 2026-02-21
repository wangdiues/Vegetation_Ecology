#!/usr/bin/env Rscript
# =============================================================================
# 06_cca_vif_permutation.R — Stage-2: CCA with VIF Screening & Permutation
# Deterministic VIF elimination + Canonical Correspondence Analysis
# Constitution: MASTER_CONSTITUTION.md, Stage-2_Instructions.md
# =============================================================================

set.seed(42)
log_msg("info", "=== Stage 6: CCA with VIF Selection ===")

suppressPackageStartupMessages({
  library(tidyverse)
  library(vegan)
})

matrices  <- load_checkpoint("community_matrices")
env_clean <- load_checkpoint("env_clean")

# =============================================================================
# DETERMINISTIC VIF SELECTION
# =============================================================================

calc_vif <- function(env_df) {
  vars <- names(env_df)
  vif_vals <- numeric(length(vars))
  names(vif_vals) <- vars
  for (v in vars) {
    others <- setdiff(vars, v)
    if (length(others) == 0) { vif_vals[v] <- 1; next }
    fml <- as.formula(paste(v, "~", paste(others, collapse = " + ")))
    fit <- tryCatch(lm(fml, data = env_df), error = function(e) NULL)
    if (is.null(fit)) { vif_vals[v] <- Inf; next }
    r2 <- summary(fit)$r.squared
    vif_vals[v] <- if (r2 >= 1) Inf else 1 / (1 - r2)
  }
  vif_vals
}

select_vars_vif <- function(env_df, threshold = 10, max_iter = 20) {
  current_vars <- names(env_df)
  removed <- character(0)

  for (i in seq_len(max_iter)) {
    if (length(current_vars) <= 1) break
    vifs <- calc_vif(env_df[, current_vars, drop = FALSE])

    if (max(vifs, na.rm = TRUE) <= threshold) break

    # DETERMINISTIC tie-breaking: highest VIF, then alphabetical
    max_vif <- max(vifs, na.rm = TRUE)
    worst <- sort(names(vifs[vifs == max_vif]))[1]  # alphabetical
    removed <- c(removed, worst)
    current_vars <- setdiff(current_vars, worst)
    log_msg("info", paste("VIF removed:", worst, "=", round(max_vif, 1)))
  }

  list(selected = sort(current_vars), removed = removed)
}

# =============================================================================
# CCA FUNCTION
# =============================================================================

run_cca <- function(mat, env_df, stratum, nperm = 999) {
  set.seed(42)

  mat <- mat[rowSums(mat) > 0, colSums(mat) > 0, drop = FALSE]

  # Intersect
  shared <- sort(intersect(rownames(mat), env_df$plot_id))
  mat_sub <- mat[shared, , drop = FALSE]
  env_sub <- env_df %>%
    filter(plot_id %in% shared) %>%
    arrange(match(plot_id, shared))

  # Select numeric env columns, drop NAs
  env_num <- env_sub %>%
    select(where(is.numeric)) %>%
    select(where(~ sum(!is.na(.)) / length(.) > 0.5)) %>%
    select(where(~ sd(., na.rm = TRUE) > 0))

  # Complete cases
  cc <- complete.cases(env_num)
  mat_sub <- mat_sub[cc, , drop = FALSE]
  env_num <- env_num[cc, , drop = FALSE]

  # Remove zero-sum rows/cols after subsetting
  keep_rows <- rowSums(mat_sub) > 0
  mat_sub <- mat_sub[keep_rows, , drop = FALSE]
  env_num <- env_num[keep_rows, , drop = FALSE]
  mat_sub <- mat_sub[, colSums(mat_sub) > 0, drop = FALSE]

  if (nrow(mat_sub) < 5 || ncol(env_num) < 2) {
    log_msg("warn", paste(stratum, ": insufficient data for CCA"))
    return(NULL)
  }

  # VIF selection
  vif_result <- select_vars_vif(env_num)
  log_msg("info", paste(stratum, "selected vars:",
                         paste(vif_result$selected, collapse = ", ")))

  # Export VIF table
  final_vif <- calc_vif(env_num[, vif_result$selected, drop = FALSE])
  write_csv(
    tibble(variable = names(final_vif), vif = round(final_vif, 2)),
    file.path(paths$tables, paste0("vif_", tolower(stratum), ".csv"))
  )

  # Scale predictors
  env_scaled <- as.data.frame(scale(env_num[, vif_result$selected, drop = FALSE]))

  # CCA
  set.seed(42)
  cca_result <- cca(mat_sub ~ ., data = env_scaled)

  total_inertia       <- cca_result$tot.chi
  constrained_inertia <- cca_result$CCA$tot.chi
  prop_explained      <- constrained_inertia / total_inertia

  log_msg("info", paste(stratum, "CCA: constrained =",
                         round(prop_explained * 100, 1), "%"))

  # Permutation tests
  set.seed(42)
  perm_overall <- anova.cca(cca_result, permutations = nperm)
  set.seed(42)
  perm_axis    <- anova.cca(cca_result, by = "axis", permutations = nperm)
  set.seed(42)
  perm_term    <- anova.cca(cca_result, by = "term", permutations = nperm)

  p_val <- perm_overall$`Pr(>F)`[1]
  log_msg("info", paste(stratum, "CCA permutation: p =", round(p_val, 4)))

  # Extract scores
  site_scores    <- as.data.frame(scores(cca_result, display = "sites"))
  species_scores <- as.data.frame(scores(cca_result, display = "species"))
  biplot_scores  <- as.data.frame(scores(cca_result, display = "bp"))

  list(
    stratum = stratum, cca = cca_result,
    sites = site_scores, species = species_scores, biplot = biplot_scores,
    perm_overall = perm_overall, perm_axis = perm_axis, perm_term = perm_term,
    n_sites = nrow(mat_sub), n_species = ncol(mat_sub),
    selected_vars = vif_result$selected, removed_vars = vif_result$removed,
    total_inertia = total_inertia, constrained_inertia = constrained_inertia,
    prop_explained = prop_explained, p_val = p_val
  )
}

# =============================================================================
# RUN
# =============================================================================

results <- list(
  trees  = run_cca(matrices$trees,  env_clean, "Trees"),
  shrubs = run_cca(matrices$shrubs, env_clean, "Shrubs"),
  herbs  = run_cca(matrices$herbs,  env_clean, "Herbs"),
  regen  = run_cca(matrices$regen,  env_clean, "Regen")
)

# =============================================================================
# EXPORT
# =============================================================================

cca_summary <- bind_rows(lapply(results, function(r) {
  if (is.null(r)) return(NULL)
  tibble(
    stratum           = r$stratum,
    n_sites           = r$n_sites,
    n_species         = r$n_species,
    n_env_vars        = length(r$selected_vars),
    selected_variables = paste(r$selected_vars, collapse = "; "),
    total_inertia     = round(r$total_inertia, 3),
    constrained_inertia = round(r$constrained_inertia, 3),
    prop_explained    = round(r$prop_explained * 100, 1),
    p_value           = round(r$p_val, 4),
    significant       = r$p_val < 0.05
  )
}))
write_csv(cca_summary, file.path(paths$tables, "cca_summary.csv"))

saveRDS(map(results, ~ .x$cca),
        file.path(paths$ordinations, "cca_results.rds"))
saveRDS(map(results, ~ list(sites = .x$sites, species = .x$species,
                             biplot = .x$biplot)),
        file.path(paths$ordinations, "cca_scores.rds"))

save_checkpoint(results, "cca_results")

write_audit(
  stage_num  = 6,
  stage_name = "CCA with VIF Selection",
  inputs     = c("community_matrices.rds", "env_clean.rds"),
  outputs    = c("cca_summary.csv", "vif_*.csv", "cca_results.rds",
                 "cca_scores.rds"),
  seeds_used = "42",
  notes      = paste("VIF threshold: 10 | Permutations:", 999)
)

update_stage("cca")
log_msg("info", "=== Stage 6: CCA Complete ===")
