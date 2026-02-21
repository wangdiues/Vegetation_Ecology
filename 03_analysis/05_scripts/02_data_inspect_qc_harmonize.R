#!/usr/bin/env Rscript
# =============================================================================
# 02_data_inspect_qc_harmonize.R — Stage-1: Data QC & Harmonisation
# Reads raw CSVs (READ-ONLY), harmonises PlotID + species, selects value cols
# Constitution: MASTER_CONSTITUTION.md, Stage-1_Instructions.md
# =============================================================================

set.seed(42)
log_msg("info", "=== Stage 2: Data Inspection, QC & Harmonisation ===")

# --- Load packages ---
suppressPackageStartupMessages({
  library(tidyverse)
  library(readr)
  library(janitor)
})

# =============================================================================
# READ RAW CSVs (immutable — never overwrite)
# =============================================================================

raw_files <- list(
  trees  = file.path(paths$data, "Trees.csv"),
  shrubs = file.path(paths$data, "Shrubs.csv"),
  herbs  = file.path(paths$data, "Herbs.csv"),
  regen  = file.path(paths$data, "Regeneration.csv"),
  env    = file.path(paths$data, "Environmental_data.csv")
)

for (nm in names(raw_files)) {
  if (!file.exists(raw_files[[nm]])) {
    log_msg("error", paste("Missing:", raw_files[[nm]]))
    stop(paste("Required CSV not found:", raw_files[[nm]]))
  }
}

trees_raw  <- read_csv(raw_files$trees,  show_col_types = FALSE) %>% clean_names()
shrubs_raw <- read_csv(raw_files$shrubs, show_col_types = FALSE) %>% clean_names()
herbs_raw  <- read_csv(raw_files$herbs,  show_col_types = FALSE) %>% clean_names()
regen_raw  <- read_csv(raw_files$regen,  show_col_types = FALSE) %>% clean_names()
env_raw    <- read_csv(raw_files$env,    show_col_types = FALSE) %>% clean_names()

log_msg("info", paste("Trees raw rows:", nrow(trees_raw),
                       "| cols:", ncol(trees_raw)))
log_msg("info", paste("Shrubs raw rows:", nrow(shrubs_raw),
                       "| cols:", ncol(shrubs_raw)))
log_msg("info", paste("Herbs raw rows:", nrow(herbs_raw),
                       "| cols:", ncol(herbs_raw)))
log_msg("info", paste("Regen raw rows:", nrow(regen_raw),
                       "| cols:", ncol(regen_raw)))
log_msg("info", paste("Env raw rows:", nrow(env_raw),
                       "| cols:", ncol(env_raw)))

# =============================================================================
# PLOTID NORMALISATION
# =============================================================================

harmonize_plot_id <- function(x) {
  x <- as.character(x)
  x <- trimws(x)
  x <- sub("\\.0$", "", x)                     # strip trailing .0
  x[x %in% c("", "NA", "#N/A", "N/A")] <- NA  # invalid → NA
  x
}

# Trees uses "plots" not "plot_id"
if ("plots" %in% names(trees_raw) && !"plot_id" %in% names(trees_raw)) {
  trees_raw <- rename(trees_raw, plot_id = plots)
}

trees_raw$plot_id  <- harmonize_plot_id(trees_raw$plot_id)
shrubs_raw$plot_id <- harmonize_plot_id(shrubs_raw$plot_id)
herbs_raw$plot_id  <- harmonize_plot_id(herbs_raw$plot_id)
regen_raw$plot_id  <- harmonize_plot_id(regen_raw$plot_id)
env_raw$plot_id    <- harmonize_plot_id(env_raw$plot_id)

# Check for duplicate PlotIDs in environmental data
env_dupes <- env_raw %>% filter(!is.na(plot_id)) %>%
  count(plot_id) %>% filter(n > 1)
if (nrow(env_dupes) > 0) {
  write_csv(env_dupes, file.path(paths$tables, "plotid_conflicts.csv"))
  log_msg("error", paste("Duplicate PlotIDs in Environmental_data:",
                          nrow(env_dupes), "conflicts"))
  stop("Duplicate PlotIDs in environmental data — see plotid_conflicts.csv")
}

log_msg("info", paste("Env unique PlotIDs:", n_distinct(env_raw$plot_id, na.rm = TRUE)))

# =============================================================================
# SPECIES STANDARDISATION
# =============================================================================

standardise_species <- function(df, stratum) {
  # Priority: species > scientific_name > scientific_me > taxon > sp
  sp_cols <- c("species", "scientific_name", "scientific_me", "taxon", "sp")
  found <- intersect(sp_cols, names(df))
  if (length(found) == 0) {
    log_msg("error", paste(stratum, ": no species column found"))
    stop(paste("No species column in", stratum))
  }
  chosen <- found[1]
  if (chosen != "species") {
    df <- df %>% rename(species = !!sym(chosen))
    log_msg("info", paste(stratum, ": species column mapped from", chosen))
  }
  df$species <- trimws(as.character(df$species))
  df$species[df$species %in% c("", "NA", "#N/A")] <- NA
  df
}

trees_raw  <- standardise_species(trees_raw,  "Trees")
shrubs_raw <- standardise_species(shrubs_raw, "Shrubs")
herbs_raw  <- standardise_species(herbs_raw,  "Herbs")
regen_raw  <- standardise_species(regen_raw,  "Regen")

# =============================================================================
# VALUE-COLUMN SELECTION (cover > abundance > count > density > BA > presence)
# =============================================================================

select_value_col <- function(df, stratum) {
  # Priority search
  candidates <- c("cover", "cover_percentage", "plot_cover",
                   "abundance", "count", "density", "ba",
                   "dbh_cm")
  available  <- intersect(candidates, names(df))

  if (length(available) > 0) {
    chosen <- available[1]
    log_msg("info", paste(stratum, ": value column =", chosen))
    return(list(df = df, value_col = chosen, method = "direct"))
  }

  # Fuzzy match for any column containing "cover"
  cover_cols <- grep("cover", names(df), ignore.case = TRUE, value = TRUE)
  if (length(cover_cols) > 0) {
    chosen <- cover_cols[1]
    log_msg("info", paste(stratum, ": value column (fuzzy) =", chosen))
    return(list(df = df, value_col = chosen, method = "fuzzy_cover"))
  }

  # Presence-absence fallback
  log_msg("warn", paste(stratum, ": no value column — using presence = 1"))
  df$presence <- 1L
  return(list(df = df, value_col = "presence", method = "presence_absence"))
}

trees_vc  <- select_value_col(trees_raw,  "Trees")
shrubs_vc <- select_value_col(shrubs_raw, "Shrubs")
herbs_vc  <- select_value_col(herbs_raw,  "Herbs")
regen_vc  <- select_value_col(regen_raw,  "Regen")

trees_raw  <- trees_vc$df
shrubs_raw <- shrubs_vc$df
herbs_raw  <- herbs_vc$df
regen_raw  <- regen_vc$df

# =============================================================================
# DROP INVALID RECORDS & AGGREGATE TO LONG FORMAT
# =============================================================================

dropped_all <- tibble()

process_stratum <- function(df, stratum, value_col) {
  n_raw <- nrow(df)

  # Track drops
  drops <- tibble()

  # Drop missing plot_id
  bad_pid <- df %>% filter(is.na(plot_id))
  if (nrow(bad_pid) > 0) {
    drops <- bind_rows(drops, bad_pid %>% mutate(
      stratum = stratum, reason = "missing_plot_id"))
  }
  df <- df %>% filter(!is.na(plot_id))

  # Drop missing species
  bad_sp <- df %>% filter(is.na(species))
  if (nrow(bad_sp) > 0) {
    drops <- bind_rows(drops, bad_sp %>% mutate(
      stratum = stratum, reason = "missing_species"))
  }
  df <- df %>% filter(!is.na(species))

  # Ensure value column is numeric
  df[[value_col]] <- suppressWarnings(as.numeric(df[[value_col]]))

  # For trees with dbh_cm, use count (each row = 1 stem)
  if (value_col == "dbh_cm") {
    df$abundance <- 1L
    value_col <- "abundance"
  }

  # Aggregate: plot_id + species → sum
  long <- df %>%
    arrange(plot_id, species) %>%
    group_by(plot_id, species) %>%
    summarise(abundance = sum(.data[[value_col]], na.rm = TRUE),
              .groups = "drop") %>%
    arrange(plot_id, species)

  log_msg("info", paste(stratum, ": raw =", n_raw,
                         "| clean =", nrow(long),
                         "| plots =", n_distinct(long$plot_id),
                         "| species =", n_distinct(long$species)))

  list(long = long, drops = drops, n_raw = n_raw)
}

trees_proc  <- process_stratum(trees_raw,  "Trees",  trees_vc$value_col)
shrubs_proc <- process_stratum(shrubs_raw, "Shrubs", shrubs_vc$value_col)
herbs_proc  <- process_stratum(herbs_raw,  "Herbs",  herbs_vc$value_col)
regen_proc  <- process_stratum(regen_raw,  "Regen",  regen_vc$value_col)

# Combine drops
dropped_all <- bind_rows(
  trees_proc$drops,  shrubs_proc$drops,
  herbs_proc$drops,  regen_proc$drops
)
if (nrow(dropped_all) > 0) {
  # Keep only safe columns for export
  drop_export <- dropped_all %>%
    select(any_of(c("stratum", "reason", "plot_id", "species")))
  write_csv(drop_export, file.path(paths$tables, "dropped_records_qc.csv"))
  log_msg("info", paste("Dropped records exported:", nrow(drop_export)))
} else {
  log_msg("info", "No records dropped during QC")
}

# =============================================================================
# QC SUMMARY TABLE
# =============================================================================

qc_summary <- tibble(
  stratum                    = c("Trees", "Shrubs", "Herbs", "Regeneration"),
  n_rows_raw                 = c(trees_proc$n_raw, shrubs_proc$n_raw,
                                 herbs_proc$n_raw, regen_proc$n_raw),
  n_plots_after_species_filter = c(
    n_distinct(trees_proc$long$plot_id),
    n_distinct(shrubs_proc$long$plot_id),
    n_distinct(herbs_proc$long$plot_id),
    n_distinct(regen_proc$long$plot_id)
  ),
  n_species = c(
    n_distinct(trees_proc$long$species),
    n_distinct(shrubs_proc$long$species),
    n_distinct(herbs_proc$long$species),
    n_distinct(regen_proc$long$species)
  ),
  chosen_value_column = c(trees_vc$value_col, shrubs_vc$value_col,
                          herbs_vc$value_col, regen_vc$value_col),
  pct_na_plotid = c(
    mean(is.na(trees_raw$plot_id))  * 100,
    mean(is.na(shrubs_raw$plot_id)) * 100,
    mean(is.na(herbs_raw$plot_id))  * 100,
    mean(is.na(regen_raw$plot_id))  * 100
  ),
  pct_na_species = c(
    mean(is.na(trees_raw$species))  * 100,
    mean(is.na(shrubs_raw$species)) * 100,
    mean(is.na(herbs_raw$species))  * 100,
    mean(is.na(regen_raw$species))  * 100
  )
)

write_csv(qc_summary, file.path(paths$tables, "Table01_data_qc_summary.csv"))
log_msg("info", "QC summary table written: Table01_data_qc_summary.csv")

# =============================================================================
# CLEAN ENVIRONMENTAL DATA
# =============================================================================

# Standardise env column names to match Methods.md expectations
env_clean <- env_raw %>%
  filter(!is.na(plot_id)) %>%
  rename_with(~ case_when(
    . == "precepitation" ~ "precipitation",  # fix typo in raw data
    TRUE ~ .
  )) %>%
  arrange(plot_id)

log_msg("info", paste("Env clean: n =", nrow(env_clean),
                       "| cols =", paste(names(env_clean), collapse = ", ")))

# =============================================================================
# ENVIRONMENTAL ALIGNMENT CHECK
# =============================================================================

veg_plots <- sort(unique(c(
  trees_proc$long$plot_id,  shrubs_proc$long$plot_id,
  herbs_proc$long$plot_id,  regen_proc$long$plot_id
)))
env_plots <- sort(unique(env_clean$plot_id))

missing_env <- setdiff(veg_plots, env_plots)
if (length(missing_env) > 0) {
  write_csv(tibble(plot_id = missing_env),
            file.path(paths$tables, "plots_missing_env_data.csv"))
  log_msg("warn", paste(length(missing_env),
                          "vegetation plots lack environmental data:",
                          paste(head(missing_env, 10), collapse = ", ")))
} else {
  log_msg("info", "All vegetation plots have environmental data")
}

# Methods.md expects 221 plots
expected_plots <- 221
actual_plots   <- length(veg_plots)
if (actual_plots != expected_plots) {
  log_msg("warn", paste("Plot count mismatch: expected", expected_plots,
                          "found", actual_plots))
} else {
  log_msg("info", paste("Plot count matches Methods.md:", actual_plots))
}

# Plot inventory
plot_inv <- tibble(plot_id = sort(unique(c(veg_plots, env_plots)))) %>%
  mutate(
    trees  = plot_id %in% trees_proc$long$plot_id,
    shrubs = plot_id %in% shrubs_proc$long$plot_id,
    herbs  = plot_id %in% herbs_proc$long$plot_id,
    regen  = plot_id %in% regen_proc$long$plot_id,
    env    = plot_id %in% env_plots
  )
write_csv(plot_inv, file.path(paths$tables, "plot_inventory.csv"))
log_msg("info", "Plot inventory written")

# =============================================================================
# SAVE CHECKPOINTS
# =============================================================================

save_checkpoint(env_clean,          "env_clean")
save_checkpoint(trees_proc$long,    "trees_long_clean")
save_checkpoint(shrubs_proc$long,   "shrubs_long_clean")
save_checkpoint(herbs_proc$long,    "herbs_long_clean")
save_checkpoint(regen_proc$long,    "regeneration_long_clean")

# =============================================================================
# AUDIT
# =============================================================================

write_audit(
  stage_num      = 2,
  stage_name     = "Data Inspection, QC & Harmonisation",
  inputs         = c("01_data/Trees.csv", "01_data/Shrubs.csv",
                     "01_data/Herbs.csv", "01_data/Regeneration.csv",
                     "01_data/Environmental_data.csv"),
  outputs        = c("Table01_data_qc_summary.csv", "dropped_records_qc.csv",
                     "plots_missing_env_data.csv", "plot_inventory.csv",
                     "env_clean.rds", "trees_long_clean.rds",
                     "shrubs_long_clean.rds", "herbs_long_clean.rds",
                     "regeneration_long_clean.rds"),
  plot_counts    = c(paste("Vegetation plots:", actual_plots),
                     paste("Environmental plots:", length(env_plots)),
                     paste("Missing env:", length(missing_env))),
  species_counts = c(paste("Trees:", n_distinct(trees_proc$long$species)),
                     paste("Shrubs:", n_distinct(shrubs_proc$long$species)),
                     paste("Herbs:", n_distinct(herbs_proc$long$species)),
                     paste("Regen:", n_distinct(regen_proc$long$species))),
  env_mismatches = if (length(missing_env) > 0) missing_env else "None"
)

update_stage("qc")
log_msg("info", "=== Stage 2: QC & Harmonisation Complete ===")
