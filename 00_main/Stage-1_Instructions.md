# =====================================================
# STAGE-1 FOUNDATION CONSTITUTION — VEGETATION ECOLOGY
# =====================================================

This document governs **Stage-1** of the vegetation-ecology pipeline described in `Methods.md`.

Stage-1 operationalises the field-ecology design into a **deterministic, auditable, journal-ready computational foundation**.

Scope:

• directory creation  
• dependency locking (renv)  
• ingestion of raw CSVs  
• schema harmonisation  
• PlotID normalisation  
• species standardisation  
• value-column selection  
• QC reporting  
• dropped-record tracking  
• environmental alignment  
• community-matrix construction  

🚫 Stage-1 MUST NOT run:

• ordinations  
• PERMANOVA  
• CCA  
• clustering  
• KDE  
• Random Forest / XGBoost  
• mapping  
• manuscript automation  

---

# =====================================================
# PROJECT ROOT
# =====================================================

Windows:

D:\2025-2026\Vegetation_Ecology


---

# =====================================================
# INPUT FILES (READ-ONLY)
# =====================================================

01_data/

• Trees.csv  
• Shrubs.csv  
• Herbs.csv  
• Regeneration.csv  
• Environmental_data.csv  

02_manuscripts/

• Methods.md  
• manuscript drafts  

🚫 Never overwrite.

---

# =====================================================
# SCIENTIFIC EXPECTATIONS (FROM METHODS)
# =====================================================

• Target vegetation plots: **221**  
• Strata: trees / shrubs / herbs / regeneration  
• Environmental variables expected:

  elevation  
  slope  
  aspect  
  temperature  
  precipitation  
  evapotranspiration  
  water_balance  

• Nested subplots cannot be validated at Stage-1 — document this limitation.

---

# =====================================================
# OUTPUT ROOT (ALL NEW)
# =====================================================

Create exactly:

03_analysis/
00_admin/
01_logs/
02_checkpoints/
03_outputs/
data_processed/
tables/
05_scripts/
99_handoff/


---

# =====================================================
# HARD CONSTRAINTS
# =====================================================

• Raw CSVs immutable  
• Manuscripts immutable  
• PlotID must be character everywhere  
• "#N/A", "", "NA" → invalid PlotID  
• All drops exported  
• Deterministic ordering mandatory  
• Stage-1 runner executes ONLY stages 1–3  
• Environmental mismatches logged  
• Presence-absence fallback explicit  
• Seeds set everywhere  

---

# =====================================================
# REQUIRED STAGE-1 SCRIPTS
# =====================================================

05_scripts/

• 01_setup.R  
• 02_data_inspect_qc_harmonize.R  
• 03_build_matrices.R  

Runner:

• run_all.R  

---

# =====================================================
# DEPENDENCY LOCKING
# =====================================================

In `01_setup.R`:

• `renv::init(bare = TRUE)` → 00_admin/  
• install only:

tidyverse
readr
janitor
here
fs
renv


• `renv::snapshot()`

Save:

• sessionInfo.txt  
• packages.csv  

Failure → log + STOP.

---

# =====================================================
# PLOTID NORMALISATION
# =====================================================

After `clean_names()`:

Normalize:

• trim whitespace  
• coerce to character  
• NA for "", "#N/A", "NA"  

Duplicates in Environmental_data:

→ export `plotid_conflicts.csv`  
→ STOP.

---

# =====================================================
# SPECIES STANDARDISATION
# =====================================================

Dynamically pick:

species
scientific_me
scientific_name
taxon
sp


Create canonical:

species


All grouping uses this.

Rows with missing species:

→ dropped_records_qc.csv  
(reason = missing_species)

---

# =====================================================
# VALUE-COLUMN SELECTION
# =====================================================

Priority:

Cover > Abundance > Count > Density > BA


If none present:

→ presence–absence fallback:

mutate(presence = 1)
value_col = "presence"


Never summarise without creating the column.

Record chosen column in QC table.

---

# =====================================================
# QC SUMMARY TABLE
# =====================================================

Create:

03_outputs/tables/Table01_data_qc_summary.csv


Fields:

• stratum  
• n_rows_raw  
• n_plots_after_species_filter  
• n_species  
• chosen_value_column  
• pct_na_plotid  
• pct_na_species  

QC counts must reflect **post-species filtering**.

---

# =====================================================
# ENVIRONMENTAL ALIGNMENT
# =====================================================

Compute PlotID universes:

• vegetation  
• environmental  

Missing env:

→ `plots_missing_env_data.csv`

Stage-1 does NOT drop vegetation plots.

---

# =====================================================
# METHODS ALIGNMENT CHECKS
# =====================================================

At QC end:

• expected_plots = 221  

If mismatch:

→ log WARNING  
→ export:

plot_inventory.csv


Columns:

PlotID | trees | shrubs | herbs | regen | env

---

# =====================================================
# CHECKPOINTS
# =====================================================

After QC:

env_clean.rds
trees_long_clean.rds
shrubs_long_clean.rds
herbs_long_clean.rds
regen_long_clean.rds


After matrices:

community_matrices.rds
trees_mat.rds
shrubs_mat.rds
herbs_mat.rds
regen_mat.rds


---

# =====================================================
# MATRIX CONSTRUCTION RULES
# =====================================================

Before pivot:

arrange(PlotID, species)


After pivot:

• rows sorted by PlotID  
• species columns alphabetical  
• zeros filled explicitly  

No floating order allowed.

---

# =====================================================
# LOGGING SYSTEM
# =====================================================

Implement:

log_msg(level, message)


Write to:

01_logs/pipeline.log


Each stage:

error_STAGE.log


---

# =====================================================
# RUNNER RULES (CRITICAL)
# =====================================================

Default:

run_stages <- 1:3


Full pipeline only with:

--all


Resume:

• LAST_SUCCESSFUL_STAGE.txt  
• STATUS.md  

Never report completion for skipped stages.

---

# =====================================================
# RANDOMNESS CONTROL
# =====================================================

Top of every script:

set.seed(1)


ML scripts forbidden in Stage-1.

---

# =====================================================
# END CONDITION
# =====================================================

Write in STATUS.md:

Stage-1 foundation complete.
QC + matrices stable.
Ready for Stage-2.


---

# =====================================================
# USER VERIFICATION
# =====================================================

After run, user checks:

• pipeline.log  
• Table01_data_qc_summary.csv  
• plots_missing_env_data.csv  
• community_matrices.rds  

---

# END STAGE-1 CONSTITUTION
