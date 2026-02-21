#!/usr/bin/env Rscript
# =============================================================================
# 01_setup.R — Stage-1 Foundation: Environment Setup & Dependency Locking
# Vegetation Ecology Pipeline — Sarpang District, Bhutan
# Constitution: MASTER_CONSTITUTION.md, Stage-1_Instructions.md
# =============================================================================

cat("=== Stage 1: Setup & Dependency Locking ===\n\n")

# --- Deterministic seed (constitution mandate) ---
set.seed(42)

# --- Detect project root robustly ---
detect_root <- function() {
  # Method 1: Rscript --file=
  args <- commandArgs(trailingOnly = FALSE)
  file_arg <- grep("^--file=", args, value = TRUE)
  if (length(file_arg) > 0) {
    script_dir <- normalizePath(dirname(sub("^--file=", "", file_arg[1])),
                                winslash = "/")
    candidate <- normalizePath(file.path(script_dir, "..", ".."),
                               winslash = "/")
    if (dir.exists(file.path(candidate, "01_data"))) return(candidate)
  }
  # Method 2: source() context
  for (i in seq_len(sys.nframe())) {
    env <- sys.frame(i)
    if (!is.null(env$ofile)) {
      script_dir <- normalizePath(dirname(env$ofile), winslash = "/")
      candidate <- normalizePath(file.path(script_dir, "..", ".."),
                                 winslash = "/")
      if (dir.exists(file.path(candidate, "01_data"))) return(candidate)
    }
  }
  # Method 3: walk up from working directory
  wd <- normalizePath(getwd(), winslash = "/")
  for (d in c(wd, dirname(wd), file.path(dirname(wd), ".."))) {
    if (dir.exists(file.path(d, "01_data"))) {
      return(normalizePath(d, winslash = "/"))
    }
  }
  stop("Cannot detect project root. Ensure 01_data/ exists at project level.")
}

root_dir        <- detect_root()
analysis_dir    <- file.path(root_dir, "03_analysis")
data_dir        <- file.path(root_dir, "01_data")
manuscripts_dir <- file.path(root_dir, "02_manuscripts")

cat("Project root :", root_dir, "\n")
cat("Analysis dir :", analysis_dir, "\n")
cat("Data dir     :", data_dir, "\n\n")

# --- Create complete directory tree (all stages) ---
dirs <- c(
  file.path(analysis_dir, "00_admin"),
  file.path(analysis_dir, "01_logs"),
  file.path(analysis_dir, "02_checkpoints"),
  file.path(analysis_dir, "03_outputs", "data_processed"),
  file.path(analysis_dir, "03_outputs", "figures"),
  file.path(analysis_dir, "03_outputs", "tables"),
  file.path(analysis_dir, "05_scripts"),
  file.path(analysis_dir, "99_handoff"),
  file.path(analysis_dir, "04_results", "ordinations"),
  file.path(analysis_dir, "04_results", "tests"),
  file.path(analysis_dir, "04_results", "indicators"),
  file.path(analysis_dir, "04_results", "ml"),
  file.path(analysis_dir, "06_stage3", "01_figures"),
  file.path(analysis_dir, "06_stage3", "02_tables"),
  file.path(analysis_dir, "06_stage3", "03_manuscript_blocks"),
  file.path(analysis_dir, "06_stage3", "04_supplementary"),
  file.path(analysis_dir, "06_stage3", "05_data_release")
)
for (d in dirs) dir.create(d, recursive = TRUE, showWarnings = FALSE)
cat("Directory tree created/verified.\n")

# --- Project-local library + renv paths (avoid user-level permission issues) ---
renv_root <- file.path(analysis_dir, "renv")
renv_lib  <- file.path(renv_root, "library")
renv_cache <- file.path(renv_root, "cache")
dir.create(renv_lib, recursive = TRUE, showWarnings = FALSE)
dir.create(renv_cache, recursive = TRUE, showWarnings = FALSE)
Sys.setenv(
  RENV_PATHS_ROOT = renv_root,
  RENV_PATHS_LIBRARY = renv_lib,
  RENV_PATHS_CACHE = renv_cache,
  R_LIBS_USER = renv_lib
)
.libPaths(c(renv_lib, .libPaths()))
options(repos = c(CRAN = "https://cloud.r-project.org"))
if (file.access(renv_lib, 2) != 0) {
  cat("WARNING: renv library not writable:", renv_lib, "\n")
}

# --- Canonical path list (shared by all scripts) ---
paths <- list(
  root           = root_dir,
  analysis       = analysis_dir,
  data           = data_dir,
  manuscripts    = manuscripts_dir,
  admin          = file.path(analysis_dir, "00_admin"),
  logs           = file.path(analysis_dir, "01_logs"),
  checkpoints    = file.path(analysis_dir, "02_checkpoints"),
  data_processed = file.path(analysis_dir, "03_outputs", "data_processed"),
  figures        = file.path(analysis_dir, "03_outputs", "figures"),
  tables         = file.path(analysis_dir, "03_outputs", "tables"),
  scripts        = file.path(analysis_dir, "05_scripts"),
  ordinations    = file.path(analysis_dir, "04_results", "ordinations"),
  tests          = file.path(analysis_dir, "04_results", "tests"),
  indicators     = file.path(analysis_dir, "04_results", "indicators"),
  ml             = file.path(analysis_dir, "04_results", "ml"),
  stage3_figs    = file.path(analysis_dir, "06_stage3", "01_figures"),
  stage3_tabs    = file.path(analysis_dir, "06_stage3", "02_tables"),
  stage3_ms      = file.path(analysis_dir, "06_stage3", "03_manuscript_blocks"),
  stage3_supp    = file.path(analysis_dir, "06_stage3", "04_supplementary"),
  stage3_data    = file.path(analysis_dir, "06_stage3", "05_data_release"),
  handoff        = file.path(analysis_dir, "99_handoff")
)

# =============================================================================
# LOGGING SYSTEM
# =============================================================================

log_file <- file.path(paths$logs, "pipeline.log")

log_msg <- function(level, message) {
  timestamp <- format(Sys.time(), "%Y-%m-%d %H:%M:%S")
  entry <- sprintf("[%s] [%-5s] %s", timestamp, toupper(level), message)
  cat(entry, "\n")
  cat(entry, "\n", file = log_file, append = TRUE)
}

# =============================================================================
# CHECKPOINT FUNCTIONS
# =============================================================================

save_checkpoint <- function(obj, name) {
  path <- file.path(paths$checkpoints, paste0(name, ".rds"))
  saveRDS(obj, path)
  log_msg("info", paste("Checkpoint saved:", name))
}

load_checkpoint <- function(name) {
  path <- file.path(paths$checkpoints, paste0(name, ".rds"))
  if (!file.exists(path)) stop(paste("Checkpoint not found:", path))
  log_msg("info", paste("Checkpoint loaded:", name))
  readRDS(path)
}

# =============================================================================
# STAGE TRACKING
# =============================================================================

update_stage <- function(stage_name) {
  writeLines(stage_name,
             file.path(paths$handoff, "LAST_SUCCESSFUL_STAGE.txt"))
  log_msg("info", paste("Stage completed:", stage_name))
}

get_last_stage <- function() {
  f <- file.path(paths$handoff, "LAST_SUCCESSFUL_STAGE.txt")
  if (file.exists(f)) trimws(readLines(f, n = 1, warn = FALSE)) else ""
}

# =============================================================================
# ERROR HANDOFF
# =============================================================================

write_error_handoff <- function(stage, error_msg) {
  writeLines(c(
    "# Pipeline Stopped - Action Required", "",
    paste("Timestamp:", Sys.time()),
    paste("Failed at stage:", stage), "",
    "## Error", error_msg, "",
    "## Recovery",
    "1. Check 01_logs/pipeline.log",
    "2. Fix the issue",
    "3. Re-run: Rscript run_all.R"
  ), file.path(paths$handoff, "NEXT_STEPS.md"))
}

# =============================================================================
# AUDIT WRITER (constitution requirement: 99_handoff/AUDIT_STAGE_X.md)
# =============================================================================

write_audit <- function(stage_num, stage_name, inputs, outputs,
                        plot_counts = NULL, species_counts = NULL,
                        env_mismatches = NULL, seeds_used = "42",
                        notes = NULL) {
  lines <- c(
    paste0("# AUDIT — Stage ", stage_num, ": ", stage_name),
    paste("Generated:", Sys.time()), "",
    "## Inputs",  paste("-", inputs), "",
    "## Outputs", paste("-", outputs), ""
  )
  if (!is.null(plot_counts))    lines <- c(lines, "## Plot Counts",
                                           paste("-", plot_counts), "")
  if (!is.null(species_counts)) lines <- c(lines, "## Species Counts",
                                           paste("-", species_counts), "")
  if (!is.null(env_mismatches)) lines <- c(lines, "## Environmental Mismatches",
                                           paste("-", env_mismatches), "")
  lines <- c(lines,
    "## Seeds Used",  paste("-", seeds_used), "",
    "## Runtime",     paste("- Completed:", Sys.time()), ""
  )
  if (!is.null(notes)) lines <- c(lines, "## Notes", paste("-", notes), "")
  fname <- paste0("AUDIT_STAGE_", stage_num, ".md")
  writeLines(lines, file.path(paths$handoff, fname))
  log_msg("info", paste("Audit written:", fname))
}

# =============================================================================
# BEGIN STAGE 1
# =============================================================================

log_msg("info", "=== Stage 1: Setup Starting ===")
log_msg("info", paste("Project root:", root_dir))
log_msg("info", paste("R version:", R.version.string))
log_msg("info", paste("Platform:", .Platform$OS.type, Sys.info()["sysname"]))

skip_renv     <- tolower(Sys.getenv("SKIP_RENV", "false")) == "true"
skip_install  <- tolower(Sys.getenv("SKIP_INSTALL", "false")) == "true"
skip_snapshot <- tolower(Sys.getenv("SKIP_SNAPSHOT", "false")) == "true"

# --- renv ---
if (skip_renv) {
  log_msg("info", "SKIP_RENV=TRUE — renv restore/init skipped")
} else if (requireNamespace("renv", quietly = TRUE)) {
  tryCatch({
    if (!file.exists(file.path(analysis_dir, "renv.lock"))) {
      renv::init(project = analysis_dir, bare = TRUE, restart = FALSE)
      log_msg("info", "renv initialised (bare)")
    } else {
      log_msg("info", "renv.lock exists — restoring")
      renv::restore(project = analysis_dir, prompt = FALSE)
    }
  }, error = function(e) log_msg("warn", paste("renv issue:", conditionMessage(e))))
} else {
  log_msg("warn", "renv not available — manual package management")
}

# --- Install required packages (all stages) ---
required_pkgs <- c(
  # Stage-1
  "tidyverse", "readr", "janitor", "here", "fs",
  # Stage-2
  "vegan", "cluster", "indicspecies", "randomForest", "xgboost", "caret",
  # Stage-3
  "ggplot2", "patchwork", "cowplot", "scales", "RColorBrewer",
  "gt", "flextable"
)

if (skip_install) {
  log_msg("info", "SKIP_INSTALL=TRUE — package installation skipped")
} else {
  for (pkg in required_pkgs) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
      log_msg("info", paste("Installing:", pkg))
      tryCatch(
        install.packages(pkg, quiet = TRUE),
        error = function(e) log_msg("warn", paste("Failed:", pkg, "-",
                                                   conditionMessage(e)))
      )
    }
  }
}

# Snapshot
if (skip_snapshot) {
  log_msg("info", "SKIP_SNAPSHOT=TRUE — renv snapshot skipped")
} else {
  tryCatch({
    if (requireNamespace("renv", quietly = TRUE)) {
      renv::snapshot(project = analysis_dir, prompt = FALSE)
      log_msg("info", "renv snapshot saved")
    }
  }, error = function(e) log_msg("warn", paste("Snapshot issue:", conditionMessage(e))))
}

# --- Archive session info ---
writeLines(capture.output(sessionInfo()),
           file.path(paths$admin, "sessionInfo.txt"))
pkg_df <- as.data.frame(installed.packages()[, c("Package", "Version")])
write.csv(pkg_df, file.path(paths$admin, "packages.csv"), row.names = FALSE)
log_msg("info", "sessionInfo and packages archived")

# --- Audit ---
write_audit(
  stage_num  = 1,
  stage_name = "Setup & Dependency Locking",
  inputs     = "(none — environment setup)",
  outputs    = c("00_admin/sessionInfo.txt", "00_admin/packages.csv",
                 "renv.lock", "01_logs/pipeline.log", "Directory tree"),
  notes      = c(paste("R version:", R.version.string),
                 paste("Packages:", length(required_pkgs)))
)

update_stage("setup")
log_msg("info", "=== Stage 1: Setup Complete ===")
