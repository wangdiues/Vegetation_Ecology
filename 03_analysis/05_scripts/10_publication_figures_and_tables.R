#!/usr/bin/env Rscript
# =============================================================================
# 10_publication_figures_and_tables.R — Stage-3: Figures & Formatted Tables
# Colour-blind safe, >=300 dpi, panelled, journal-ready
# Constitution: MASTER_CONSTITUTION.md, Stage-3_Instructions.md
# =============================================================================

set.seed(42)
log_msg("info", "=== Stage 10: Publication Figures & Tables ===")

suppressPackageStartupMessages({
  library(tidyverse)
  library(vegan)
  library(ggplot2)
  library(patchwork)
  library(scales)
  library(RColorBrewer)
})

# --- Publication theme ---
theme_pub <- function(base_size = 10) {
  theme_bw(base_size = base_size) +
    theme(
      panel.grid.minor = element_blank(),
      panel.grid.major = element_line(colour = "grey90", linewidth = 0.3),
      strip.background = element_rect(fill = "grey95", colour = "grey70"),
      strip.text       = element_text(face = "bold"),
      axis.title       = element_text(face = "bold"),
      legend.position  = "bottom",
      plot.title       = element_text(face = "bold", hjust = 0.5),
      plot.subtitle    = element_text(hjust = 0.5, colour = "grey40")
    )
}

# Colour-blind safe palette (Stage-3 constitution requirement)
cb_palette <- brewer.pal(4, "Set2")
names(cb_palette) <- c("Trees", "Shrubs", "Herbs", "Regeneration")

fig_dir <- paths$stage3_figs
tab_dir <- paths$stage3_tabs

# --- Load all checkpoints ---
nmds_data  <- tryCatch(load_checkpoint("nmds_envfit"), error = function(e) NULL)
perm_data  <- tryCatch(load_checkpoint("permanova_dispersion"), error = function(e) NULL)
cca_data   <- tryCatch(load_checkpoint("cca_results"), error = function(e) NULL)
div_data   <- tryCatch(load_checkpoint("diversity_metrics"), error = function(e) NULL)
isa_data   <- tryCatch(load_checkpoint("indicator_species"), error = function(e) NULL)
ml_data    <- tryCatch(load_checkpoint("ml_models"), error = function(e) NULL)
matrices   <- tryCatch(load_checkpoint("community_matrices"), error = function(e) NULL)
env_clean  <- tryCatch(load_checkpoint("env_clean"), error = function(e) NULL)

# =============================================================================
# FIGURE 1: NMDS Ordination (2x2 panel)
# =============================================================================

if (!is.null(nmds_data)) {
  create_nmds_panel <- function(res, title, colour) {
    if (is.null(res) || is.null(res$nmds)) return(ggplot() + theme_void())
    sites <- as.data.frame(scores(res$nmds, display = "sites"))
    p <- ggplot(sites, aes(NMDS1, NMDS2)) +
      geom_point(size = 2, alpha = 0.6, colour = colour) +
      labs(title = title,
           subtitle = paste("Stress:", round(res$nmds$stress, 4))) +
      theme_pub()

    # Add significant envfit vectors
    if (!is.null(res$envfit_df)) {
      sig_vec <- res$envfit_df %>% filter(significant)
      if (nrow(sig_vec) > 0) {
        scale_factor <- min(max(abs(sites))) * 0.8 /
                        max(abs(c(sig_vec$NMDS1, sig_vec$NMDS2)))
        p <- p + geom_segment(
          data = sig_vec,
          aes(x = 0, y = 0, xend = NMDS1 * scale_factor,
              yend = NMDS2 * scale_factor),
          arrow = arrow(length = unit(0.2, "cm")),
          colour = "darkred", linewidth = 0.5
        ) + geom_text(
          data = sig_vec,
          aes(x = NMDS1 * scale_factor * 1.1,
              y = NMDS2 * scale_factor * 1.1, label = variable),
          size = 2.5, colour = "darkred"
        )
      }
    }
    p
  }

  p1 <- create_nmds_panel(nmds_data$trees,  "A) Trees",         cb_palette["Trees"])
  p2 <- create_nmds_panel(nmds_data$shrubs, "B) Shrubs",        cb_palette["Shrubs"])
  p3 <- create_nmds_panel(nmds_data$herbs,  "C) Herbs",         cb_palette["Herbs"])
  p4 <- create_nmds_panel(nmds_data$regen,  "D) Regeneration",  cb_palette["Regeneration"])

  fig1 <- (p1 | p2) / (p3 | p4)
  ggsave(file.path(fig_dir, "Figure01_NMDS.png"), fig1,
         width = 10, height = 10, dpi = 300)
  ggsave(file.path(fig_dir, "Figure01_NMDS.pdf"), fig1,
         width = 10, height = 10)
  log_msg("info", "Figure01_NMDS saved")
}

# =============================================================================
# FIGURE 2: Diversity Boxplots (2x2 panel)
# =============================================================================

if (!is.null(div_data)) {
  dbp <- div_data$div_by_plot
  make_div_box <- function(var, label, panel_label) {
    ggplot(dbp, aes(x = stratum, y = .data[[var]], fill = stratum)) +
      geom_boxplot(outlier.size = 0.8, alpha = 0.7) +
      geom_jitter(width = 0.15, size = 0.5, alpha = 0.3) +
      scale_fill_manual(values = cb_palette) +
      labs(title = panel_label, y = label) +
      theme_pub() + theme(legend.position = "none",
                           axis.title.x = element_blank())
  }

  fig2 <- (make_div_box("richness", "Species Richness", "A) Richness") |
            make_div_box("shannon",  "Shannon H'",       "B) Shannon")) /
           (make_div_box("simpson",  "Simpson (1-D)",    "C) Simpson") |
            make_div_box("evenness", "Pielou's J",       "D) Evenness"))
  ggsave(file.path(fig_dir, "Figure02_Diversity.png"), fig2,
         width = 10, height = 10, dpi = 300)
  ggsave(file.path(fig_dir, "Figure02_Diversity.pdf"), fig2,
         width = 10, height = 10)
  log_msg("info", "Figure02_Diversity saved")
}

# =============================================================================
# FIGURE 3: Species Accumulation Curves
# =============================================================================

if (!is.null(div_data) && nrow(div_data$accumulation) > 0) {
  fig3 <- ggplot(div_data$accumulation,
                 aes(x = sites, y = richness, colour = stratum, fill = stratum)) +
    geom_ribbon(aes(ymin = richness - sd, ymax = richness + sd),
                alpha = 0.2, colour = NA) +
    geom_line(linewidth = 0.8) +
    scale_colour_manual(values = cb_palette) +
    scale_fill_manual(values = cb_palette) +
    facet_wrap(~stratum, scales = "free_y") +
    labs(x = "Number of Sites", y = "Cumulative Species Richness",
         title = "Species Accumulation Curves") +
    theme_pub() + theme(legend.position = "none")
  ggsave(file.path(fig_dir, "Figure03_SpeciesAccumulation.png"), fig3,
         width = 8, height = 6, dpi = 300)
  ggsave(file.path(fig_dir, "Figure03_SpeciesAccumulation.pdf"), fig3,
         width = 8, height = 6)
  log_msg("info", "Figure03_SpeciesAccumulation saved")
}

# =============================================================================
# FIGURE 4: CCA Biplots (2x2 panel)
# =============================================================================

if (!is.null(cca_data)) {
  create_cca_panel <- function(res, title, colour) {
    if (is.null(res) || is.null(res$sites)) return(ggplot() + theme_void())
    sites <- res$sites
    bp    <- res$biplot

    p <- ggplot(sites, aes(CCA1, CCA2)) +
      geom_point(size = 2, alpha = 0.5, colour = colour) +
      labs(title = title) +
      theme_pub()

    if (!is.null(bp) && nrow(bp) > 0) {
      scale_factor <- min(max(abs(sites))) * 0.8 /
                      max(abs(as.matrix(bp)), na.rm = TRUE)
      bp_df <- as.data.frame(bp) %>% rownames_to_column("variable")
      p <- p + geom_segment(
        data = bp_df, aes(x = 0, y = 0, xend = CCA1 * scale_factor,
                          yend = CCA2 * scale_factor),
        arrow = arrow(length = unit(0.2, "cm")),
        colour = "darkred", linewidth = 0.5
      ) + geom_text(
        data = bp_df, aes(x = CCA1 * scale_factor * 1.1,
                          y = CCA2 * scale_factor * 1.1, label = variable),
        size = 2.5, colour = "darkred"
      )
    }
    p
  }

  fig4 <- (create_cca_panel(cca_data$trees,  "A) Trees",        cb_palette["Trees"]) |
            create_cca_panel(cca_data$shrubs, "B) Shrubs",       cb_palette["Shrubs"])) /
           (create_cca_panel(cca_data$herbs,  "C) Herbs",        cb_palette["Herbs"]) |
            create_cca_panel(cca_data$regen,  "D) Regeneration", cb_palette["Regeneration"]))
  ggsave(file.path(fig_dir, "Figure04_CCA.png"), fig4,
         width = 10, height = 10, dpi = 300)
  ggsave(file.path(fig_dir, "Figure04_CCA.pdf"), fig4,
         width = 10, height = 10)
  log_msg("info", "Figure04_CCA saved")
}

# =============================================================================
# FIGURE 5: RF Variable Importance (top 10)
# =============================================================================

if (!is.null(ml_data)) {
  rf_imp <- ml_data$rf_imp %>% slice_max(`%IncMSE`, n = 10)
  fig5 <- ggplot(rf_imp, aes(x = reorder(variable, `%IncMSE`), y = `%IncMSE`)) +
    geom_col(fill = cb_palette["Trees"], alpha = 0.8) +
    coord_flip() +
    labs(x = NULL, y = "% Increase in MSE",
         title = "Random Forest — Variable Importance (Top 10)") +
    theme_pub()
  ggsave(file.path(fig_dir, "Figure05_RF_Importance.png"), fig5,
         width = 8, height = 6, dpi = 300)
  ggsave(file.path(fig_dir, "Figure05_RF_Importance.pdf"), fig5,
         width = 8, height = 6)
  log_msg("info", "Figure05_RF_Importance saved")
}

# =============================================================================
# FIGURE 6: Diversity–Elevation Relationship
# =============================================================================

if (!is.null(div_data) && !is.null(env_clean)) {
  div_elev <- div_data$div_by_plot %>%
    inner_join(env_clean %>% select(plot_id, elevation), by = "plot_id")

  fig6 <- ggplot(div_elev, aes(x = elevation, y = richness, colour = stratum)) +
    geom_point(size = 1.5, alpha = 0.5) +
    geom_smooth(method = "loess", se = TRUE, alpha = 0.2, linewidth = 0.8) +
    scale_colour_manual(values = cb_palette) +
    facet_wrap(~stratum, scales = "free_y") +
    labs(x = "Elevation (m a.s.l.)", y = "Species Richness",
         title = "Diversity Along Elevational Gradient") +
    theme_pub() + theme(legend.position = "none")
  ggsave(file.path(fig_dir, "Figure06_Diversity_Elevation.png"), fig6,
         width = 10, height = 8, dpi = 300)
  ggsave(file.path(fig_dir, "Figure06_Diversity_Elevation.pdf"), fig6,
         width = 10, height = 8)
  log_msg("info", "Figure06_Diversity_Elevation saved")
}

# =============================================================================
# FORMATTED TABLES (CSV master + publication copies)
# =============================================================================

# Table 2: PERMANOVA
perm_file <- file.path(paths$tables, "permanova_summary.csv")
if (file.exists(perm_file)) {
  t2 <- tryCatch(read_csv(perm_file, show_col_types = FALSE),
                 error = function(e) tibble())
  if (nrow(t2) == 0 || !("permanova_p" %in% names(t2))) {
    log_msg("warn", "PERMANOVA summary empty or missing permanova_p — skipping Table02")
  } else {
    t2 <- t2 %>%
      mutate(permanova_p = ifelse(permanova_p < 0.001, "<0.001",
                                  as.character(round(permanova_p, 3))))
    write_csv(t2, file.path(tab_dir, "Table02_PERMANOVA.csv"))
    log_msg("info", "Table02_PERMANOVA saved")
  }
}

# Table 3: CCA
cca_file <- file.path(paths$tables, "cca_summary.csv")
if (file.exists(cca_file)) {
  t3 <- read_csv(cca_file, show_col_types = FALSE) %>%
    mutate(prop_explained = paste0(prop_explained, "%"))
  write_csv(t3, file.path(tab_dir, "Table03_CCA.csv"))
  log_msg("info", "Table03_CCA saved")
}

# Table 4: Diversity
div_file <- file.path(paths$tables, "diversity_summary.csv")
if (file.exists(div_file)) {
  t4 <- read_csv(div_file, show_col_types = FALSE) %>%
    mutate(richness = paste0(richness_mean, " +/- ", richness_sd),
           shannon  = paste0(shannon_mean, " +/- ", shannon_sd)) %>%
    select(stratum, n_plots, richness, shannon, simpson_mean, evenness_mean)
  write_csv(t4, file.path(tab_dir, "Table04_Diversity.csv"))
  log_msg("info", "Table04_Diversity saved")
}

# Table 5: Indicators
isa_file <- file.path(paths$tables, "indicator_species_summary.csv")
if (file.exists(isa_file)) {
  t5 <- read_csv(isa_file, show_col_types = FALSE) %>%
    mutate(pct_significant = paste0(pct_significant, "%"))
  write_csv(t5, file.path(tab_dir, "Table05_Indicators.csv"))
  log_msg("info", "Table05_Indicators saved")
}

# Table 6: ML Performance
ml_file <- file.path(paths$tables, "ml_summary.csv")
if (file.exists(ml_file)) {
  t6 <- read_csv(ml_file, show_col_types = FALSE) %>%
    mutate(cv_r2   = paste0(cv_r2, " +/- ", cv_r2_sd),
           cv_rmse = paste0(cv_rmse, " +/- ", cv_rmse_sd)) %>%
    select(model, n_predictors, n_observations, cv_r2, cv_rmse, cv_mae)
  write_csv(t6, file.path(tab_dir, "Table06_ML_Performance.csv"))
  log_msg("info", "Table06_ML_Performance saved")
}

# Copy QC table to Stage-3
qc_file <- file.path(paths$tables, "Table01_data_qc_summary.csv")
if (file.exists(qc_file)) {
  file.copy(qc_file, file.path(tab_dir, "Table01_QC_Summary.csv"),
            overwrite = TRUE)
}

# =============================================================================
# SAVE
# =============================================================================

figures_created <- list.files(fig_dir, pattern = "\\.(png|pdf)$")
tables_created  <- list.files(tab_dir, pattern = "\\.csv$")

log_msg("info", paste("Figures created:", length(figures_created)))
log_msg("info", paste("Tables created:", length(tables_created)))

save_checkpoint(list(
  figures = figures_created,
  tables  = tables_created,
  timestamp = Sys.time()
), "publication_outputs")

write_audit(
  stage_num  = 10,
  stage_name = "Publication Figures & Tables",
  inputs     = c("All Stage-2 checkpoints"),
  outputs    = c(paste("Figures:", paste(figures_created, collapse = ", ")),
                 paste("Tables:", paste(tables_created, collapse = ", "))),
  notes      = c("DPI: 300 (PNG) | Palette: colour-blind safe (Set2)",
                 "Panel labels: A, B, C, D")
)

update_stage("publication")
log_msg("info", "=== Stage 10: Publication Figures & Tables Complete ===")
