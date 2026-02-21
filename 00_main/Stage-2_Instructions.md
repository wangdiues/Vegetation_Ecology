# =====================================================
# STAGE-2 ANALYSIS CONSTITUTION — COMMUNITY ECOLOGY
# =====================================================

This document governs **Stage-2** of the vegetation ecology pipeline following successful Stage-1 foundation execution.

Stage-2 implements the scientific analyses described in Methods.md:

• NMDS ordination
• Canonical Correspondence Analysis (CCA)
• hierarchical clustering + PAM
• Indicator Species Analysis (ISA)
• regeneration KDE
• Random Forest + XGBoost modelling

Stage-2 MUST consume only Stage-1 checkpoints.

---

# =====================================================
# PREREQUISITES
# =====================================================

Stage-1 must be complete.

Required files:

02_checkpoints/
• env_clean.rds
• trees_long_clean.rds
• shrubs_long_clean.rds
• herbs_long_clean.rds
• regen_long_clean.rds
• community_matrices.rds

03_outputs/data_processed/
• trees_mat.rds
• shrubs_mat.rds
• herbs_mat.rds
• regen_mat.rds

99_handoff/STATUS.md must state:

“Stage-1 foundation complete.”

---

# =====================================================
# OUTPUT ROOT
# =====================================================

Create new folders:

03_analysis/
  04_stage2/
    01_ordination/
    02_clustering/
    03_indicators/
    04_regeneration_kde/
    05_ml/
    06_figures/
    07_tables/

---

# =====================================================
# HARD CONSTRAINTS
# =====================================================

• Never re-read raw CSVs
• Never overwrite Stage-1 outputs
• All models seeded
• All plots × species intersections logged
• Environmental joins explicit
• All dropped plots exported
• Deterministic ordering required
• Zero silent filtering
• ML hyperparameters recorded

---

# =====================================================
# REQUIRED PACKAGES
# =====================================================

Add via renv:

vegan  
cluster  
indicspecies  
randomForest  
xgboost  
spatstat.geom  
spatstat.explore  
terra  
sf  
caret  

---

# =====================================================
# DATA INTERSECTION RULE
# =====================================================

For any env-driven analysis:

Plots_used =
intersection(
  vegetation plots,
  env_clean plots
)

Export:

03_outputs/tables/plots_used_stage2.csv  
03_outputs/tables/plots_dropped_stage2.csv

---

# =====================================================
# ORDINATION — NMDS
# =====================================================

Scripts:

05_scripts/04_nmds.R

Rules:

• Bray-Curtis distance
• Wisconsin double standardization optional but explicit
• k = 2–3, stress minimised
• seed set
• stress + Shepard plots saved
• envfit vectors exported

Outputs:

04_stage2/01_ordination/
• nmds_scores.csv
• stress_plot.png
• ordination_map.png

---

# =====================================================
# CCA
# =====================================================

Scripts:

05_scripts/05_cca.R

Rules:

• predictors: elevation, slope, aspect, temperature, precipitation,
  evapotranspiration, water_balance
• VIF screening mandatory
• permutation tests (999)
• axis correlations exported

Outputs:

04_stage2/01_ordination/
• cca_axes.csv
• cca_envfit.csv
• cca_plot.png

---

# =====================================================
# CLUSTERING
# =====================================================

Scripts:

05_scripts/06_clustering.R

Methods:

• hierarchical clustering (Ward.D2)
• PAM cross-check
• silhouette width
• dendrogram saved

Outputs:

04_stage2/02_clustering/
• cluster_assignments.csv
• dendrogram.png
• silhouette.png

---

# =====================================================
# INDICATOR SPECIES
# =====================================================

Scripts:

05_scripts/07_indicator_species.R

Rules:

• indicspecies::multipatt
• alpha = 0.05
• permutation = 999

Outputs:

04_stage2/03_indicators/
• indicator_species.csv

---

# =====================================================
# REGENERATION KDE
# =====================================================

Scripts:

05_scripts/08_regen_kde.R

Rules:

• KDE over spatial coords if available
• bandwidth documented
• raster outputs GeoTIFF

Outputs:

04_stage2/04_regeneration_kde/
• regen_kde.tif
• regen_hotspots.png

---

# =====================================================
# ML MODELLING — RF + XGBOOST
# =====================================================

Scripts:

05_scripts/09_ml_regeneration_rf_xgb.R

Rules:

• explicit feature set
• train/test split reproducible
• seeds set
• RF ntree fixed
• XGB seed parameter mandatory
• SHAP/importance exported
• performance metrics saved

Outputs:

04_stage2/05_ml/
• rf_metrics.csv
• xgb_metrics.csv
• variable_importance.csv

---

# =====================================================
# METHODS ALIGNMENT CHECKS
# =====================================================

Confirm:

• regeneration modelling matches Methods
• KDE extent logged
• predictors identical to CCA set

Mismatch → STOP.

---

# =====================================================
# STATUS REPORTING
# =====================================================

Update:

99_handoff/STATUS.md

Add:

“Stage-2 analyses complete. Ready for Stage-3 synthesis.”

---

# =====================================================
# USER VERIFICATION
# =====================================================

User inspects:

• plots_used_stage2.csv
• nmds_scores.csv
• cca_axes.csv
• variable_importance.csv
• pipeline.log

---

# END STAGE-2

# =====================================================
# AI GOVERNANCE & REPRODUCIBLE SCIENCE CONSTITUTION
# =====================================================

This file governs how any AI agent or developer may operate inside this repository.

Failure to comply invalidates the run.

---

# =====================================================
# PROJECT PURPOSE
# =====================================================

This repository implements a reproducible vegetation-ecology study in Bhutan, aligned with:

• peer-reviewed journal standards
• Methods.md
• Stage-1 and Stage-2 Instructions
• deterministic pipelines
• audit-ready outputs

---

# =====================================================
# GENERAL RULES
# =====================================================

• Never edit raw data
• Never overwrite manuscripts
• Never fabricate results
• Never skip QC
• Every transformation logged
• Deterministic execution mandatory
• Seeds set everywhere
• All joins explicit
• All drops exported
• Status files authoritative

---

# =====================================================
# STAGE BOUNDARIES
# =====================================================

Stage-1:
QC + matrices only

Stage-2:
Ecological analyses + modelling

Stage-3:
Figures + manuscript synthesis

Cross-stage execution forbidden unless explicitly requested.

---

# =====================================================
# FILE IMMUTABILITY
# =====================================================

READ-ONLY:

01_data/
02_manuscripts/

Violations → STOP.

---

# =====================================================
# LOGGING
# =====================================================

All scripts must call:

log_msg(level, message)

Pipeline.log is canonical.

---

# =====================================================
# REPRODUCIBILITY
# =====================================================

• renv mandatory
• package snapshot per stage
• sessionInfo archived
• seeds fixed
• hardware/OS logged

---

# =====================================================
# AI BEHAVIOUR RULES
# =====================================================

AI agents:

• may create scripts only in 05_scripts/
• must respect Instructions.md
• must update STATUS.md truthfully
• must never guess data fields
• must stop on schema mismatch
• must not invent plot counts

---

# =====================================================
# METHODS ENFORCEMENT
# =====================================================

If Methods.md and code disagree:

→ STOP  
→ log discrepancy  
→ request human decision

---

# =====================================================
# DATA AVAILABILITY PREP
# =====================================================

All derived outputs:

• CSV
• PNG (≥300 dpi)
• GeoTIFF for rasters

Metadata tables mandatory.

---

# =====================================================
# AUDIT TRAIL
# =====================================================

For each stage:

• inputs used
• outputs produced
• plots dropped
• seeds
• runtime

Saved in:

99_handoff/AUDIT_STAGE_X.md

---

# =====================================================
# VIOLATION HANDLING
# =====================================================

On breach:

• halt pipeline
• write ERROR log
• write NEXT_STEPS.md

---

# =====================================================
# FINAL AUTHORITY
# =====================================================

Human investigator overrides automation.

---

# END CLAUDE.md
