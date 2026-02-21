#!/usr/bin/env Rscript
# =============================================================================
# 08_diversity_regeneration_metrics.R — Stage-2: Diversity & Regeneration
# Alpha (Shannon, Simpson, Pielou), beta (Whittaker), gamma, species accum
# Constitution: MASTER_CONSTITUTION.md, Stage-2_Instructions.md, Methods.md
# =============================================================================

set.seed(42)
log_msg("info", "=== Stage 8: Diversity & Regeneration Metrics ===")

suppressPackageStartupMessages({
  library(tidyverse)
  library(vegan)
})

matrices   <- load_checkpoint("community_matrices")
env_clean  <- load_checkpoint("env_clean")
regen_long <- load_checkpoint("regeneration_long_clean")

# =============================================================================
# ALPHA DIVERSITY
# =============================================================================

calc_diversity <- function(mat, stratum) {
  mat <- mat[rowSums(mat) > 0, , drop = FALSE]
  tibble(
    plot_id    = rownames(mat),
    stratum    = stratum,
    richness   = specnumber(mat),
    abundance  = rowSums(mat),
    shannon    = diversity(mat, index = "shannon"),
    simpson    = diversity(mat, index = "simpson"),
    inv_simpson = diversity(mat, index = "invsimpson"),
    evenness   = shannon / log(pmax(richness, 1))  # Pielou's J
  )
}

div_by_plot <- bind_rows(
  calc_diversity(matrices$trees,  "Trees"),
  calc_diversity(matrices$shrubs, "Shrubs"),
  calc_diversity(matrices$herbs,  "Herbs"),
  calc_diversity(matrices$regen,  "Regeneration")
)

write_csv(div_by_plot, file.path(paths$tables, "diversity_by_plot.csv"))
log_msg("info", paste("Diversity computed for", nrow(div_by_plot), "plot-strata"))

# Summary stats per stratum
div_summary <- div_by_plot %>%
  group_by(stratum) %>%
  summarise(
    n_plots       = n(),
    richness_mean = round(mean(richness), 2),
    richness_sd   = round(sd(richness), 2),
    richness_min  = min(richness),
    richness_max  = max(richness),
    shannon_mean  = round(mean(shannon), 3),
    shannon_sd    = round(sd(shannon), 3),
    simpson_mean  = round(mean(simpson), 3),
    evenness_mean = round(mean(evenness, na.rm = TRUE), 3),
    .groups = "drop"
  )
write_csv(div_summary, file.path(paths$tables, "diversity_summary.csv"))

# =============================================================================
# GAMMA DIVERSITY (total species pool per stratum)
# =============================================================================

gamma_div <- tibble(
  stratum        = c("Trees", "Shrubs", "Herbs", "Regeneration"),
  gamma_richness = c(ncol(matrices$trees), ncol(matrices$shrubs),
                     ncol(matrices$herbs), ncol(matrices$regen))
)
write_csv(gamma_div, file.path(paths$tables, "gamma_diversity.csv"))

# =============================================================================
# BETA DIVERSITY (Whittaker's: gamma / mean alpha)
# =============================================================================

beta_div <- div_by_plot %>%
  group_by(stratum) %>%
  summarise(mean_alpha = mean(richness), .groups = "drop") %>%
  left_join(gamma_div, by = "stratum") %>%
  mutate(beta_whittaker = round(gamma_richness / mean_alpha, 2))
write_csv(beta_div, file.path(paths$tables, "beta_diversity.csv"))

# =============================================================================
# REGENERATION METRICS
# =============================================================================

regen_metrics <- regen_long %>%
  group_by(plot_id) %>%
  summarise(
    regen_richness    = n_distinct(species),
    regen_total_cover = sum(abundance, na.rm = TRUE),
    regen_mean_cover  = mean(abundance, na.rm = TRUE),
    n_records         = n(),
    .groups = "drop"
  ) %>%
  arrange(plot_id)
write_csv(regen_metrics, file.path(paths$tables, "regeneration_metrics.csv"))
log_msg("info", paste("Regeneration metrics:", nrow(regen_metrics), "plots"))

# =============================================================================
# DIVERSITY–ENVIRONMENT CORRELATIONS
# =============================================================================

# Merge diversity with env
div_env <- div_by_plot %>%
  inner_join(env_clean, by = "plot_id")
write_csv(div_env, file.path(paths$tables, "diversity_environment.csv"))

# Correlation tests
env_vars <- intersect(
  c("elevation", "slope", "aspect", "temperature", "precipitation",
    "eto", "water_balance"),
  names(env_clean)
)
div_vars <- c("richness", "shannon", "simpson", "evenness")

corr_results <- expand_grid(diversity_var = div_vars, env_var = env_vars) %>%
  rowwise() %>%
  mutate(
    test = list(tryCatch({
      d <- div_env[[diversity_var]]
      e <- div_env[[env_var]]
      cc <- complete.cases(d, e)
      if (sum(cc) < 10) return(NULL)
      cor.test(d[cc], e[cc], method = "pearson")
    }, error = function(err) NULL))
  ) %>%
  ungroup() %>%
  filter(!map_lgl(test, is.null)) %>%
  mutate(
    correlation = map_dbl(test, ~ .x$estimate),
    p_value     = map_dbl(test, ~ .x$p.value),
    n           = map_int(test, ~ .x$parameter + 2),
    significant = p_value < 0.05
  ) %>%
  select(-test) %>%
  ungroup()
write_csv(corr_results, file.path(paths$tables, "diversity_correlations.csv"))

# =============================================================================
# SPECIES ACCUMULATION CURVES
# =============================================================================

set.seed(42)
accum_list <- list()
for (nm in c("trees", "shrubs", "herbs", "regen")) {
  mat <- matrices[[nm]]
  mat <- mat[rowSums(mat) > 0, colSums(mat) > 0, drop = FALSE]
  if (nrow(mat) >= 3) {
    set.seed(42)
    sa <- specaccum(mat, method = "random", permutations = 100)
    accum_list[[nm]] <- tibble(
      stratum  = nm,
      sites    = sa$sites,
      richness = sa$richness,
      sd       = sa$sd
    )
  }
}
accum_df <- bind_rows(accum_list)
write_csv(accum_df, file.path(paths$tables, "species_accumulation.csv"))

# =============================================================================
# SAVE
# =============================================================================

save_checkpoint(list(
  div_by_plot   = div_by_plot,
  div_summary   = div_summary,
  gamma_div     = gamma_div,
  beta_div      = beta_div,
  regen_metrics = regen_metrics,
  div_env       = div_env,
  correlations  = corr_results,
  accumulation  = accum_df
), "diversity_metrics")

saveRDS(list(div_by_plot = div_by_plot, div_summary = div_summary,
             gamma_div = gamma_div, beta_div = beta_div,
             regen_metrics = regen_metrics),
        file.path(paths$tests, "diversity_results.rds"))

write_audit(
  stage_num      = 8,
  stage_name     = "Diversity & Regeneration Metrics",
  inputs         = c("community_matrices.rds", "env_clean.rds",
                     "regeneration_long_clean.rds"),
  outputs        = c("diversity_by_plot.csv", "diversity_summary.csv",
                     "gamma_diversity.csv", "beta_diversity.csv",
                     "regeneration_metrics.csv", "diversity_environment.csv",
                     "diversity_correlations.csv", "species_accumulation.csv"),
  seeds_used     = "42 (species accumulation)",
  notes          = paste("Indices: Shannon, Simpson, Pielou's J",
                          "| Specaccum permutations: 100")
)

update_stage("diversity")
log_msg("info", "=== Stage 8: Diversity & Regeneration Complete ===")
