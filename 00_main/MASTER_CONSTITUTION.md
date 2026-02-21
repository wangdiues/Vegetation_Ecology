# =====================================================
# MASTER CONSTITUTION — VEGETATION ECOLOGY PIPELINE
# =====================================================

This document is the **supreme governance authority** for this repository.

It unifies:

• Methods.md  
• Stage-1_Instructions.md  
• Stage-2_Instructions.md  
• Stage-3_Instructions.md  
• CLAUDE.md  

If conflicts arise:

→ Methods.md governs science  
→ Stage documents govern computation  
→ This MASTER governs behaviour and enforcement

---

# =====================================================
# PROJECT PURPOSE
# =====================================================

This repository implements a reproducible vegetation-ecology study in Bhutan.

Goals:

• journal-grade reproducibility  
• deterministic computation  
• auditability  
• AI-safe execution  
• strict separation of scientific stages  
• transparent data provenance

---

# =====================================================
# STAGE ARCHITECTURE
# =====================================================

## Stage-1 — Foundation
File: Stage-1_Instructions.md  
Scope:

• dependency locking  
• QC + harmonisation  
• plot/species validation  
• environmental alignment  
• community matrices  

🚫 No modelling or ordination.

---

## Stage-2 — Ecological Analyses
File: Stage-2_Instructions.md  
Scope:

• NMDS  
• CCA  
• clustering  
• indicator species  
• regeneration KDE  
• RF/XGB

🚫 No manuscript writing.

---

## Stage-3 — Synthesis & Publication
File: Stage-3_Instructions.md  
Scope:

• figures  
• tables  
• manuscript automation  
• supplementary material  
• data-availability packaging

🚫 No raw-data edits.

---

# =====================================================
# METHODS SUPREMACY
# =====================================================

Methods.md is the scientific authority.

If any code, AI agent, or stage instruction deviates:

→ STOP  
→ log discrepancy  
→ request human resolution

---

# =====================================================
# IMMUTABILITY RULES
# =====================================================

READ-ONLY:

01_data/  
02_manuscripts/  

Violation → pipeline halt.

---

# =====================================================
# AI GOVERNANCE
# =====================================================

All AI agents must:

• read MASTER_CONSTITUTION.md first  
• obey Stage instructions  
• respect Methods.md  
• update STATUS.md truthfully  
• never fabricate data  
• never invent plots/species  
• halt on schema mismatch

---

# =====================================================
# REPRODUCIBILITY
# =====================================================

Mandatory:

• renv per stage  
• locked package versions  
• sessionInfo archived  
• seeds fixed  
• OS + hardware logged  
• deterministic sorting  
• explicit joins  
• logged randomness

---

# =====================================================
# LOGGING & AUDIT
# =====================================================

Canonical log:

03_analysis/01_logs/pipeline.log

Each stage must write:

99_handoff/AUDIT_STAGE_X.md

Including:

• inputs  
• outputs  
• plot counts  
• species counts  
• env mismatches  
• seeds  
• runtime

---

# =====================================================
# STATUS AUTHORITY
# =====================================================

99_handoff/STATUS.md is authoritative.

Stages may only mark themselves complete if:

• all required outputs exist  
• audit file written  
• no ERROR logs present

---

# =====================================================
# ENVIRONMENTAL INTERSECTION POLICY
# =====================================================

Vegetation ≠ Environment mismatch:

• Stage-1 logs only  
• Stage-2 intersects explicitly  
• Stage-3 reports exclusions

Never silent.

---

# =====================================================
# NON-DETERMINISM PROHIBITED
# =====================================================

Sources of forbidden variability:

• unsorted joins  
• pivot_wider without ordering  
• implicit numeric-column choice  
• unseeded ML  
• floating factor levels

If detected:

→ STOP  
→ patch  
→ rerun stage

---

# =====================================================
# DATA AVAILABILITY PREPARATION
# =====================================================

All derived products:

• CSV tables  
• PNG ≥300 dpi  
• GeoTIFF rasters  
• README per output folder  
• metadata tables

---

# =====================================================
# VIOLATION HANDLING
# =====================================================

On breach:

• halt  
• write error log  
• write NEXT_STEPS.md  
• preserve partial outputs

---

# =====================================================
# HUMAN OVERRIDE
# =====================================================

Principal investigator decisions override automation.

All overrides must be logged.

---

# =====================================================
# FINAL AUTHORITY
# =====================================================

This MASTER_CONSTITUTION.md is binding for:

• humans  
• AI agents  
• CI pipelines  
• Codex / Claude / ChatGPT usage

---

# END MASTER CONSTITUTION
