#!/usr/bin/env Rscript
# =============================================================================
# 05_permanova_dispersion.R — Stage-2: PERMANOVA & Homogeneity of Dispersion
# adonis2 + betadisper for each stratum
# Constitution: MASTER_CONSTITUTION.md, Stage-2_Instructions.md
# =============================================================================

set.seed(42)
log_msg("info", "=== Stage 5: PERMANOVA & Dispersion Tests ===")

suppressPackageStartupMessages({
  library(tidyverse)
  library(vegan)
})

matrices  <- load_checkpoint("community_matrices")
env_clean <- load_checkpoint("env_clean")

# =============================================================================
# FOREST TYPE GROUPING (from vegetation raw CSVs, if available)
# =============================================================================

harmonize_plot_id <- function(x) {
  x <- as.character(x)
  x <- trimws(x)
  x <- sub("\\.0$", "", x)
  x[x %in% c("", "NA", "#N/A", "N/A")] <- NA
  x
}

read_forest_types <- function(path) {
  if (!file.exists(path)) return(tibble())
  df <- read_csv(path, show_col_types = FALSE)
  clean_name <- function(x) {
    x <- gsub("^\ufeff", "", x)
    x <- tolower(gsub("[^A-Za-z0-9]+", "_", x))
    x <- gsub("^_+|_+$", "", x)
    x
  }
  names(df) <- clean_name(names(df))
  plot_col <- intersect(c("plot_id", "plots"), names(df))
  ft_col   <- intersect(c("forest_types", "forest_type"), names(df))
  if (length(plot_col) == 0 || length(ft_col) == 0) return(tibble())
  tibble(
    plot_id = harmonize_plot_id(df[[plot_col[1]]]),
    forest_type = as.character(df[[ft_col[1]]])
  )
}

forest_types_df <- bind_rows(
  read_forest_types(file.path(paths$data, "Trees.csv")),
  read_forest_types(file.path(paths$data, "Shrubs.csv")),
  read_forest_types(file.path(paths$data, "Herbs.csv")),
  read_forest_types(file.path(paths$data, "Regeneration.csv"))
)

if (!all(c("plot_id", "forest_type") %in% names(forest_types_df))) {
  forest_types_df <- tibble(plot_id = character(), forest_type = character())
} else {
  forest_types_df <- forest_types_df %>%
    filter(!is.na(plot_id), !is.na(forest_type), forest_type != "") %>%
    group_by(plot_id) %>%
    summarise(forest_type = names(sort(table(forest_type), decreasing = TRUE))[1],
              .groups = "drop")
}

# =============================================================================
# GROUPING VARIABLE DETECTION
# =============================================================================

detect_group_var <- function(env_df) {
  # Priority: existing categorical columns
  candidates <- c("group", "forest_type", "forest_types",
                   "vegetation_type", "site_type")
  for (col in candidates) {
    if (col %in% names(env_df)) {
      n_grp <- n_distinct(env_df[[col]], na.rm = TRUE)
      if (n_grp >= 2 && n_grp <= 10) {
        log_msg("info", paste("Group variable:", col, "(", n_grp, "levels)"))
        return(col)
      }
    }
  }
  # Fallback: create elevation groups (3 classes)
  if ("elevation" %in% names(env_df)) {
    log_msg("info", "Creating elevation_group (Low / Mid / High)")
    env_df$elevation_group <- cut(
      env_df$elevation,
      breaks = quantile(env_df$elevation, probs = c(0, 1/3, 2/3, 1),
                        na.rm = TRUE),
      labels = c("Low", "Mid", "High"),
      include.lowest = TRUE
    )
    return("elevation_group")
  }
  stop("No suitable grouping variable found")
}

group_var <- detect_group_var(env_clean)
if (nrow(forest_types_df) > 0) {
  n_grp_ft <- n_distinct(forest_types_df$forest_type)
  if (n_grp_ft >= 2 && n_grp_ft <= 10) {
    log_msg("info", paste("Using forest_type groups from vegetation data:",
                          n_grp_ft, "levels"))
    env_clean <- env_clean %>%
      left_join(forest_types_df, by = "plot_id")
    group_var <- "forest_type"
  }
}

if (group_var == "elevation_group" && !("elevation_group" %in% names(env_clean))) {
  env_clean$elevation_group <- cut(
    env_clean$elevation,
    breaks = quantile(env_clean$elevation, probs = c(0, 1/3, 2/3, 1),
                      na.rm = TRUE),
    labels = c("Low", "Mid", "High"),
    include.lowest = TRUE
  )
}

# =============================================================================
# PERMANOVA + BETADISPER
# =============================================================================

run_permanova <- function(mat, env_df, group_var, stratum, nperm = 999) {
  set.seed(42)

  # Remove empty rows/cols
  mat <- mat[rowSums(mat) > 0, colSums(mat) > 0, drop = FALSE]

  # Intersect plots
  shared <- sort(intersect(rownames(mat), env_df$plot_id))
  mat_sub <- mat[shared, , drop = FALSE]
  env_sub <- env_df %>%
    filter(plot_id %in% shared) %>%
    arrange(match(plot_id, shared))

  # Need grouping variable without NA
  groups <- env_sub[[group_var]]
  valid  <- !is.na(groups)
  mat_sub <- mat_sub[valid, , drop = FALSE]
  groups  <- groups[valid]

  if (length(unique(groups)) < 2 || nrow(mat_sub) < 5) {
    log_msg("warn", paste(stratum, ": insufficient groups for PERMANOVA"))
    return(NULL)
  }

  # Bray-Curtis distance
  dist_mat <- vegdist(mat_sub, method = "bray")

  # PERMANOVA
  set.seed(42)
  perm_result <- adonis2(dist_mat ~ groups, permutations = nperm)

  r2 <- perm_result$R2[1]
  f_val <- perm_result$F[1]
  p_val <- perm_result$`Pr(>F)`[1]

  log_msg("info", paste(stratum, "PERMANOVA: R2 =", round(r2, 4),
                         "| F =", round(f_val, 2),
                         "| p =", round(p_val, 4)))

  # betadisper (homogeneity of dispersion)
  set.seed(42)
  bd <- betadisper(dist_mat, groups)
  bd_test <- permutest(bd, permutations = nperm)

  bd_f <- bd_test$tab$F[1]
  bd_p <- bd_test$tab$`Pr(>F)`[1]
  homogeneous <- bd_p >= 0.05

  log_msg("info", paste(stratum, "betadisper: F =", round(bd_f, 2),
                         "| p =", round(bd_p, 4),
                         "| homogeneous =", homogeneous))

  list(
    stratum    = stratum,
    n_sites    = nrow(mat_sub),
    n_groups   = length(unique(groups)),
    group_var  = group_var,
    permanova  = perm_result,
    betadisper = bd,
    bd_test    = bd_test,
    R2 = r2, F_val = f_val, p_val = p_val,
    bd_F = bd_f, bd_p = bd_p, homogeneous = homogeneous
  )
}

results <- list(
  trees  = run_permanova(matrices$trees,  env_clean, group_var, "Trees"),
  shrubs = run_permanova(matrices$shrubs, env_clean, group_var, "Shrubs"),
  herbs  = run_permanova(matrices$herbs,  env_clean, group_var, "Herbs"),
  regen  = run_permanova(matrices$regen,  env_clean, group_var, "Regen")
)

# =============================================================================
# EXPORT
# =============================================================================

perm_summary <- bind_rows(lapply(results, function(r) {
  if (is.null(r)) return(NULL)
  tibble(
    stratum              = r$stratum,
    group_variable       = r$group_var,
    n_sites              = r$n_sites,
    n_groups             = r$n_groups,
    permanova_R2         = round(r$R2, 4),
    permanova_F          = round(r$F_val, 2),
    permanova_p          = round(r$p_val, 4),
    permanova_sig        = r$p_val < 0.05,
    dispersion_F         = round(r$bd_F, 2),
    dispersion_p         = round(r$bd_p, 4),
    homogeneous_dispersion = r$homogeneous
  )
}))

if (is.null(perm_summary) || nrow(perm_summary) == 0) {
  log_msg("warn", "PERMANOVA skipped for all strata (insufficient groups)")
  perm_summary <- tibble(
    stratum                = c("Trees", "Shrubs", "Herbs", "Regen"),
    group_variable         = group_var,
    n_sites                = NA_integer_,
    n_groups               = NA_integer_,
    permanova_R2           = NA_real_,
    permanova_F            = NA_real_,
    permanova_p            = NA_real_,
    permanova_sig          = NA,
    dispersion_F           = NA_real_,
    dispersion_p           = NA_real_,
    homogeneous_dispersion = NA
  )
}

write_csv(perm_summary, file.path(paths$tables, "permanova_summary.csv"))

# Detailed results
saveRDS(map(results, ~ .x$permanova),
        file.path(paths$tests, "permanova_results.rds"))
saveRDS(map(results, ~ .x$betadisper),
        file.path(paths$tests, "dispersion_results.rds"))

save_checkpoint(results, "permanova_dispersion")

write_audit(
  stage_num  = 5,
  stage_name = "PERMANOVA & Dispersion",
  inputs     = c("community_matrices.rds", "env_clean.rds"),
  outputs    = c("permanova_summary.csv", "permanova_results.rds",
                 "dispersion_results.rds"),
  seeds_used = "42",
  notes      = paste("Group variable:", group_var)
)

update_stage("permanova")
log_msg("info", "=== Stage 5: PERMANOVA Complete ===")
