# =====================================================
# STAGE-3 SYNTHESIS & PUBLICATION CONSTITUTION
# =====================================================

This document governs **Stage-3** of the vegetation-ecology pipeline.

Stage-3 translates validated Stage-1 and Stage-2 outputs into:

• publication-quality figures  
• statistical tables  
• manuscript-ready text blocks  
• supplementary materials  
• reproducibility packages  
• data-availability archives  

Stage-3 MUST NOT modify analytical results.

---

# =====================================================
# PREREQUISITES
# =====================================================

Stage-2 must be complete.

Required:

02_checkpoints/  
03_outputs/  
04_stage2/  

99_handoff/STATUS.md must state:

“Stage-2 analyses complete.”

---

# =====================================================
# OUTPUT ROOT
# =====================================================

Create:

03_analysis/
06_stage3/
01_figures/
02_tables/
03_manuscript_blocks/
04_supplementary/
05_data_release/


---

# =====================================================
# HARD CONSTRAINTS
# =====================================================

• No recalculation of models  
• No re-reading raw CSVs  
• No editing Stage-1 or Stage-2 outputs  
• All figure scripts read only processed files  
• All tables traceable to CSV/RDS  
• Deterministic plotting  
• DPI ≥300 for raster/vector exports  
• British English  
• No AI-invented results  

---

# =====================================================
# REQUIRED PACKAGES
# =====================================================

Add via renv:

ggplot2  
patchwork  
cowplot  
gt  
flextable  
officer  
rmarkdown  
knitr  
quarto  

---

# =====================================================
# FIGURE STANDARDS
# =====================================================

All figures:

• A4 or journal-compliant sizing  
• 300–600 dpi  
• colour-blind safe palettes  
• north arrows / scale bars on maps  
• legend outside plotting area  
• panel labels (A, B, C…)

File naming:

Figure01_*.png  
Figure02_*.png  

Captions saved separately:

03_manuscript_blocks/Figure_Captions.md

---

# =====================================================
# TABLE STANDARDS
# =====================================================

All tables:

• CSV master  
• formatted DOCX/LaTeX versions  
• descriptive titles  
• units included  
• sample size column

Saved under:

06_stage3/02_tables/

---

# =====================================================
# MANUSCRIPT AUTOMATION
# =====================================================

Scripts:

05_scripts/10_build_manuscript_blocks.R

Tasks:

• auto-populate:
  – Methods subsections  
  – Results text skeletons  
  – figure call-outs  
  – table references  

• generate:

03_manuscript_blocks/
  Results_Stage2.md  
  Methods_Computation.md  
  Supplementary_Methods.md  

No interpretation allowed — numbers only.

---

# =====================================================
# SUPPLEMENTARY MATERIALS
# =====================================================

Create:

06_stage3/04_supplementary/

Including:

• extended tables  
• parameter grids  
• sensitivity analyses  
• VIF outputs  
• permutation test summaries  
• cluster diagnostics  
• ML tuning logs  

---

# =====================================================
# DATA-AVAILABILITY PACKAGE
# =====================================================

Prepare archive:

06_stage3/05_data_release/

Contents:

• raw-data README (no CSV copies)  
• processed CSV/RDS  
• scripts used  
• renv.lock  
• LICENSE  
• CITATION.cff  
• SHA256 checksums  

Generate:

DATA_AVAILABILITY.md

---

# =====================================================
# TRACEABILITY MATRIX
# =====================================================

Produce:

06_stage3/TRACEABILITY.csv

Columns:

Stage | Script | Input | Output | Figure/Table | Manuscript_section

---

# =====================================================
# METHODS ALIGNMENT CHECK
# =====================================================

Verify:

• all figures correspond to Methods analyses  
• all tables derived from Stage-2 outputs  
• any deviations documented

Mismatch → STOP.

---

# =====================================================
# STATUS REPORTING
# =====================================================

Append to:

99_handoff/STATUS.md

Stage-3 synthesis complete.
Manuscript blocks and data release ready.


---

# =====================================================
# USER VERIFICATION
# =====================================================

User inspects:

• Figure01_*.png  
• TRACEABILITY.csv  
• DATA_AVAILABILITY.md  
• manuscript blocks  
• pipeline.log

---

# END STAGE-3 CONSTITUTION
