#!/usr/bin/env Rscript
# =============================================================================
# run_all.R — Master Pipeline Runner
# Vegetation Ecology Analysis — Sarpang District, Bhutan
# 13 stages: Foundation (1-3) + Analysis (4-9) + Synthesis (10-13)
# Constitution: MASTER_CONSTITUTION.md
# =============================================================================

cat("==============================================================\n")
cat("  Vegetation Ecology Analysis Pipeline\n")
cat("  13 Stages: Foundation + Analysis + Synthesis\n")
cat("  Seed: 42 | Deterministic | Auditable\n")
cat("==============================================================\n\n")

# --- Parse command-line arguments ---
args <- commandArgs(trailingOnly = TRUE)
force_rerun <- "--force" %in% args
stage_arg   <- grep("^stage=", args, value = TRUE)

run_stages <- 1:13  # Default: all stages

if (length(stage_arg) > 0) {
  stage_spec <- sub("^stage=", "", stage_arg[1])
  if (grepl("-", stage_spec)) {
    parts <- as.integer(strsplit(stage_spec, "-")[[1]])
    run_stages <- parts[1]:parts[2]
  } else {
    run_stages <- as.integer(stage_spec)
  }
  cat("Running stages:", paste(run_stages, collapse = ", "), "\n\n")
}

if (force_rerun) cat("FORCE mode: will rerun specified stages\n\n")

# =============================================================================
# STAGE DEFINITIONS
# =============================================================================

stages <- list(
  list(num = 1,  name = "setup",            script = "01_setup.R"),
  list(num = 2,  name = "qc",               script = "02_data_inspect_qc_harmonize.R"),
  list(num = 3,  name = "matrices",          script = "03_build_matrices.R"),
  list(num = 4,  name = "nmds",             script = "04_nmds_envfit.R"),
  list(num = 5,  name = "permanova",        script = "05_permanova_dispersion.R"),
  list(num = 6,  name = "cca",              script = "06_cca_vif_permutation.R"),
  list(num = 7,  name = "indicators",       script = "07_indicator_species.R"),
  list(num = 8,  name = "diversity",        script = "08_diversity_regeneration_metrics.R"),
  list(num = 9,  name = "ml",               script = "09_ml_regeneration_rf_xgb.R"),
  list(num = 10, name = "publication",      script = "10_publication_figures_and_tables.R"),
  list(num = 11, name = "manuscript_blocks", script = "11_manuscript_blocks.R"),
  list(num = 12, name = "supplementary",    script = "12_supplementary_materials.R"),
  list(num = 13, name = "data_release",     script = "13_data_release_traceability.R")
)

stage_names <- setNames(
  sapply(stages, `[[`, "name"),
  sapply(stages, `[[`, "num")
)

# =============================================================================
# PATH DETECTION (same logic as 01_setup.R)
# =============================================================================

detect_root <- function() {
  args <- commandArgs(trailingOnly = FALSE)
  file_arg <- grep("^--file=", args, value = TRUE)
  if (length(file_arg) > 0) {
    script_dir <- normalizePath(dirname(sub("^--file=", "", file_arg[1])),
                                winslash = "/")
    # run_all.R is in 03_analysis/
    candidate <- normalizePath(file.path(script_dir, ".."), winslash = "/")
    if (dir.exists(file.path(candidate, "01_data"))) return(candidate)
    if (dir.exists(file.path(script_dir, "01_data"))) return(script_dir)
  }
  for (i in seq_len(sys.nframe())) {
    env <- sys.frame(i)
    if (!is.null(env$ofile)) {
      script_dir <- normalizePath(dirname(env$ofile), winslash = "/")
      candidate <- normalizePath(file.path(script_dir, ".."), winslash = "/")
      if (dir.exists(file.path(candidate, "01_data"))) return(candidate)
    }
  }
  wd <- normalizePath(getwd(), winslash = "/")
  for (d in c(wd, dirname(wd))) {
    if (dir.exists(file.path(d, "01_data"))) {
      return(normalizePath(d, winslash = "/"))
    }
  }
  stop("Cannot detect project root.")
}

root_dir     <- detect_root()
analysis_dir <- file.path(root_dir, "03_analysis")
scripts_dir  <- file.path(analysis_dir, "05_scripts")
handoff_dir  <- file.path(analysis_dir, "99_handoff")
logs_dir     <- file.path(analysis_dir, "01_logs")

dir.create(logs_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(handoff_dir, recursive = TRUE, showWarnings = FALSE)

cat("Project root:", root_dir, "\n")
cat("Scripts dir :", scripts_dir, "\n\n")

# --- Runner logging (before 01_setup.R defines log_msg) ---
log_file <- file.path(logs_dir, "pipeline.log")
log_runner <- function(level, message) {
  timestamp <- format(Sys.time(), "%Y-%m-%d %H:%M:%S")
  entry <- sprintf("[%s] [%-5s] %s", timestamp, toupper(level), message)
  cat(entry, "\n")
  cat(entry, "\n", file = log_file, append = TRUE)
}

# =============================================================================
# RESUME LOGIC
# =============================================================================

stage_file <- file.path(handoff_dir, "LAST_SUCCESSFUL_STAGE.txt")

get_last_stage_num <- function() {
  if (!file.exists(stage_file)) return(0)
  last_name <- trimws(readLines(stage_file, n = 1, warn = FALSE))
  idx <- which(sapply(stages, `[[`, "name") == last_name)
  if (length(idx) == 0) return(0)
  stages[[idx]]$num
}

should_run <- function(stage_num) {
  if (force_rerun) return(stage_num %in% run_stages)
  if (!(stage_num %in% run_stages)) return(FALSE)
  stage_num > get_last_stage_num()
}

# =============================================================================
# EXECUTION ENGINE
# =============================================================================

runner_env <- new.env(parent = globalenv())

run_stage <- function(stage) {
  script_path <- file.path(scripts_dir, stage$script)

  log_runner("info", paste(rep("-", 50), collapse = ""))
  log_runner("info", paste("Starting Stage", stage$num, ":", stage$name))
  log_runner("info", paste("Script:", stage$script))

  if (!file.exists(script_path)) {
    log_runner("error", paste("Script not found:", script_path))
    return(FALSE)
  }

  start_time <- Sys.time()

  result <- tryCatch({
    source(script_path, local = runner_env)
    elapsed <- difftime(Sys.time(), start_time, units = "secs")
    log_runner("info", paste("Stage", stage$num, "completed in",
                              round(elapsed, 1), "seconds"))
    TRUE
  }, error = function(e) {
    error_msg <- conditionMessage(e)
    log_runner("error", paste("Stage", stage$num, "FAILED:", error_msg))

    # Error log
    error_log <- file.path(logs_dir,
                            paste0("error_stage_", sprintf("%02d", stage$num), ".log"))
    writeLines(c(
      paste("Timestamp:", Sys.time()),
      paste("Stage:", stage$num, "-", stage$name),
      paste("Script:", script_path),
      paste("Error:", error_msg), "",
      "Traceback:",
      capture.output(traceback())
    ), error_log)

    # NEXT_STEPS
    writeLines(c(
      "# Pipeline Stopped - Action Required", "",
      paste("Timestamp:", Sys.time()),
      paste("Failed at stage:", stage$num, "-", stage$name), "",
      "## Error", error_msg, "",
      "## Recovery",
      paste("1. Check:", error_log),
      "2. Check 01_logs/pipeline.log",
      "3. Fix the issue",
      "4. Re-run: Rscript 03_analysis/run_all.R", "",
      "To force re-run from a specific stage:",
      paste("  Rscript run_all.R stage=", stage$num, " --force", sep = "")
    ), file.path(handoff_dir, "NEXT_STEPS.md"))

    FALSE
  })

  result
}

# =============================================================================
# MAIN EXECUTION
# =============================================================================

log_runner("info", "=== Pipeline Execution Starting ===")
log_runner("info", paste("Last successful stage:", get_last_stage_num()))

pipeline_success <- TRUE

# Bootstrap shared functions/paths if Stage 1 is not scheduled
if (!1 %in% run_stages) {
  setup_script <- file.path(scripts_dir, "01_setup.R")
  if (file.exists(setup_script)) {
    log_runner("info", "Bootstrapping setup (skip renv/install/snapshot)")
    Sys.setenv(SKIP_RENV = "TRUE", SKIP_INSTALL = "TRUE", SKIP_SNAPSHOT = "TRUE")
    source(setup_script, local = runner_env)
    Sys.unsetenv(c("SKIP_RENV", "SKIP_INSTALL", "SKIP_SNAPSHOT"))
  } else {
    log_runner("error", "Cannot bootstrap setup: 01_setup.R missing")
  }
}

for (stage in stages) {
  if (should_run(stage$num)) {
    if (!run_stage(stage)) {
      log_runner("error", paste("Pipeline halted at stage", stage$num))
      pipeline_success <- FALSE
      break
    }
  } else {
    if (stage$num %in% run_stages) {
      log_runner("info", paste("Skipping stage", stage$num,
                                "(already completed)"))
    }
  }
}

# =============================================================================
# FINAL REPORT
# =============================================================================

if (pipeline_success) {
  cat("\n")
  cat("==============================================================\n")
  cat("  FULL PIPELINE COMPLETE (13 STAGES)\n")
  cat("==============================================================\n\n")
  cat("Stage-1 Foundation:\n")
  cat("  - QC + Matrices stable\n\n")
  cat("Stage-2 Analyses:\n")
  cat("  - 04_results/ordinations/  (NMDS, CCA)\n")
  cat("  - 04_results/tests/        (PERMANOVA, dispersion, diversity)\n")
  cat("  - 04_results/indicators/   (Indicator species)\n")
  cat("  - 04_results/ml/           (Random Forest, XGBoost)\n\n")
  cat("Stage-3 Synthesis:\n")
  cat("  - 06_stage3/01_figures/    (Publication figures)\n")
  cat("  - 06_stage3/02_tables/     (Formatted tables)\n")
  cat("  - 06_stage3/03_manuscript_blocks/  (Auto-generated text)\n")
  cat("  - 06_stage3/04_supplementary/      (Extended tables)\n")
  cat("  - 06_stage3/05_data_release/       (Archive + checksums)\n\n")
  cat("Key files to verify:\n")
  cat("  1. 01_logs/pipeline.log\n")
  cat("  2. 99_handoff/STATUS.md\n")
  cat("  3. 99_handoff/AUDIT_STAGE_*.md\n")
  cat("  4. 06_stage3/TRACEABILITY.csv\n")
  cat("  5. 06_stage3/05_data_release/DATA_AVAILABILITY.md\n")
} else {
  cat("\nPipeline stopped. Check 99_handoff/NEXT_STEPS.md\n")
}
