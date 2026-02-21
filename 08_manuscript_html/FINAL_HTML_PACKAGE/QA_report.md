# QA Report: HTML Manuscript Reconciliation

**Date:** 2026-02-21  
**Project:** Vegetation Community Composition and Species–Environment Relationships Along an Elevational Gradient in South-Central Bhutan  
**Journal:** Journal of Vegetation Science (Wiley)  
**Build Type:** Definitive HTML Package

---

## Executive Summary

This report documents the reconciliation of the HTML manuscript package against authoritative sources (LaTeX/PDF and Title Page). All content discrepancies have been identified and resolved. The final HTML package is internally consistent and matches the authoritative manuscript content.

**Status:** ✅ PASSED

---

## 1. Section-by-Section Comparison (LaTeX vs HTML)

| Section | LaTeX Source | HTML Output | Status | Notes |
|---------|--------------|-------------|--------|-------|
| Title | ✓ | ✓ | ✅ Match | Exact match |
| Authors | ✓ | ✓ | ✅ Match | All 3 authors with affiliations |
| ORCID | ✓ | ✓ | ✅ Match | All 3 ORCIDs verified |
| Correspondence | ✓ | ✓ | ✅ Match | Email verified |
| Abstract | ✓ | ✓ | ✅ Match | All 5 subsections (Questions, Location, Methods, Results, Conclusions) |
| Keywords | ✓ | ✓ | ✅ Match | 10 keywords |
| 1. Introduction | ✓ | ✓ | ✅ Match | 4 paragraphs |
| 2.1 Study Area | ✓ | ✓ | ✅ Match | Figure 1 reference |
| 2.2 Sampling Design | ✓ | ✓ | ✅ Match | 220 plots |
| 2.3 Data Collection | ✓ | ✓ | ✅ Match | DBH, height protocols |
| 2.4 Environmental Vars | ✓ | ✓ | ✅ Match | DOI link included |
| 2.5 Data Preparation | ✓ | ✓ | ✅ Match | Diversity indices |
| 2.6 Multivariate Analysis | ✓ | ✓ | ✅ Match | NMDS, CCA, PERMANOVA |
| 2.7 Regeneration Modelling | ✓ | ✓ | ✅ Match | RF, XGBoost |
| 2.8 Software | ✓ | ✓ | ✅ Match | R, PC-ORD |
| 2.9 Reproducibility | ✓ | ✓ | ✅ Match | Data availability |
| 3.1 Composition | ✓ | ✓ | ✅ Match | Figure 2 reference |
| 3.2 Forest Types | ✓ | ✓ | ✅ Match | Table 1 reference |
| 3.3 Species-Environment | ✓ | ✓ | ✅ Match | Table 2, Figure 3 |
| 3.4 Diversity | ✓ | ✓ | ✅ Match | Table 3, Figures 4-6 |
| 3.5 Indicator Species | ✓ | ✓ | ✅ Match | Table 4 |
| 3.6 Regeneration | ✓ | ✓ | ✅ Match | Table 5, Figure 7 |
| 4.1-4.6 Discussion | ✓ | ✓ | ✅ Match | 6 subsections |
| 5. Conclusions | ✓ | ✓ | ✅ Match | 4 paragraphs |
| References | ✓ | ✓ | ✅ Match | 33 references |
| Tables (1-5) | ✓ | ✓ | ✅ Match | All 5 tables |
| Figures (1-7) | ✓ | ✓ | ✅ Match | All 7 figures |
| Supporting Info | ✓ | ✓ | ✅ Match | S1-S10 |
| Funding | ✓ | ✓ | ✅ Match | From Title Page |
| Acknowledgements | ✓ | ✓ | ✅ Match | From Title Page |
| Author Contributions | ✓ | ✓ | ✅ Match | From Title Page |
| Data Availability | ✓ | ✓ | ✅ Match | From Title Page |
| Conflict of Interest | ✓ | ✓ | ✅ Match | From Title Page |

---

## 2. Figure Audit Table

| Figure # | Expected Filename | Location | Status | Caption Match |
|----------|-------------------|----------|--------|---------------|
| Figure 1 | Figure01_Study_Area_Map.png | assets/ | ✅ Present | ✅ Exact match |
| Figure 2 | Figure02_NMDS.png | assets/ | ✅ Present | ✅ Exact match |
| Figure 3 | Figure05_CCA.png | assets/ | ✅ Present | ✅ Exact match |
| Figure 4 | Figure03_Diversity.png | assets/ | ✅ Present | ✅ Exact match |
| Figure 5 | Figure04_SpeciesAccumulation.png | assets/ | ✅ Present | ✅ Exact match |
| Figure 6 | Figure07_Diversity_Elevation.png | assets/ | ✅ Present | ✅ Exact match |
| Figure 7 | Figure06_RF_Importance.png | assets/ | ✅ Present | ✅ Exact match |

**Notes:**
- All 7 figures present and correctly numbered
- Figure numbering in text matches figure IDs (#fig1 through #fig7)
- Captions match LaTeX source exactly

---

## 3. Table Audit Table

| Table # | Caption Summary | Status | Anchor ID |
|---------|-----------------|--------|-----------|
| Table 1 | PERMANOVA results | ✅ Present | #table1 |
| Table 2 | CCA summary | ✅ Present | #table2 |
| Table 3 | Alpha diversity metrics | ✅ Present | #table3 |
| Table 4 | Indicator species summary | ✅ Present | #table4 |
| Table 5 | ML performance | ✅ Present | #table5 |

**Notes:**
- All 5 tables present with correct numbering
- Table data matches LaTeX source exactly
- All statistical values verified (R², F, p-values)

---

## 4. Supporting Information Audit

| Appendix | Expected File | Status | HTML Summary |
|----------|---------------|--------|--------------|
| Appendix S1 | Appendix_S01_VIF_all_strata.csv | ✅ Present | ✅ HTML summary created |
| Appendix S2 | Appendix_S02_PERMANOVA_full.csv | ✅ Present | ✅ HTML summary created |
| Appendix S3 | Appendix_S03_envfit_all.csv | ✅ Present | ✅ HTML summary created |
| Appendix S4 | Appendix_S04_indicator_species_full.csv | ✅ Present | ✅ HTML summary created |
| Appendix S5 | Appendix_S05_ML_parameters.csv | ✅ Present | ✅ HTML summary created |
| Appendix S6 | Appendix_S06_variable_importance.csv | ✅ Present | ✅ HTML summary created |
| Appendix S7 | Appendix_S07_CV_fold_results.csv | ✅ Present | ✅ HTML summary created |
| Appendix S8 | Appendix_S08_diversity_correlations.csv | ✅ Present | ✅ HTML summary created |
| Appendix S9 | Appendix_S09_beta_diversity.csv | ✅ Present | ✅ HTML summary created |
| Appendix S10 | Appendix_S10_matrix_diagnostics.csv | ✅ Present | ✅ HTML summary created |

**Notes:**
- All 10 supporting information files present
- HTML summaries created for each appendix
- Links in main manuscript resolve correctly

---

## 5. Reference List Comparison

| Metric | LaTeX (.bbl) | HTML | Status |
|--------|--------------|------|--------|
| Total References | 33 | 33 | ✅ Match |
| Citation Keys | Verified | Mapped | ✅ All resolved |
| Author-Date Format | Chicago | Chicago | ✅ Match |

**Reference Verification:**
- All 33 references from .bbl file present in HTML
- Citation anchor IDs match (#Acharya2011, #Anderson2001, etc.)
- In-text citations resolve to bibliography entries

---

## 6. Detected Differences and Resolutions

### 6.1 Original HTML Issues (manuscript_final_complete.html)

| Issue | Original | Resolution |
|-------|----------|------------|
| TOC section numbering | Missing 2.5, 2.7-2.9 | ✅ Fixed in index.html |
| Discussion subsections | Not in TOC | ✅ Added to TOC |
| Figure paths | 03_figures/ | ✅ Changed to assets/ |
| Table placement | Inline only | ✅ Separate Tables section added |
| Figure placement | Inline only | ✅ Separate Figures section added |
| SI links | Not functional | ✅ All 10 SI files linked |

### 6.2 Content Discrepancies Resolved

| Discrepancy | Source | Resolution |
|-------------|--------|------------|
| Author affiliations | Title Page | ✅ Used Title Page as authoritative |
| ORCID URLs | Title Page | ✅ Verified and included |
| Funding statement | Title Page | ✅ Used Title Page text |
| Correspondence email | Title Page | ✅ Verified |
| Statistical values | LaTeX | ✅ All values match LaTeX source |
| Figure captions | LaTeX | ✅ All captions match exactly |
| Table captions | LaTeX | ✅ All captions match exactly |

---

## 7. Link Validation

### 7.1 Internal Anchors

| Anchor Type | Count | Status |
|-------------|-------|--------|
| Section anchors (#intro, #methods, etc.) | 25 | ✅ All resolve |
| Figure anchors (#fig1-#fig7) | 7 | ✅ All resolve |
| Table anchors (#table1-#table5) | 5 | ✅ All resolve |
| Reference anchors (#AuthorYear) | 33 | ✅ All resolve |
| TOC links | 35 | ✅ All resolve |

### 7.2 External Links

| URL | Purpose | Status |
|-----|---------|--------|
| https://orcid.org/0009-0007-7726-1742 | Wangdi Wangdi ORCID | ✅ Valid |
| https://orcid.org/0000-0003-0417-0296 | Rupesh Subedi ORCID | ✅ Valid |
| https://orcid.org/0009-0004-1245-5931 | Kezang Choden ORCID | ✅ Valid |
| https://doi.org/10.25919/pec2-hs50 | Dorji et al. climate data | ✅ Valid |

---

## 8. Asset Verification

### 8.1 Figures

```
✅ assets/Figure01_Study_Area_Map.png
✅ assets/Figure02_NMDS.png
✅ assets/Figure03_Diversity.png
✅ assets/Figure04_SpeciesAccumulation.png
✅ assets/Figure05_CCA.png
✅ assets/Figure06_RF_Importance.png
✅ assets/Figure07_Diversity_Elevation.png
```

### 8.2 Supporting Information

```
✅ supporting/Appendix_S01_VIF_all_strata.csv
✅ supporting/Appendix_S02_PERMANOVA_full.csv
✅ supporting/Appendix_S03_envfit_all.csv
✅ supporting/Appendix_S04_indicator_species_full.csv
✅ supporting/Appendix_S05_ML_parameters.csv
✅ supporting/Appendix_S06_variable_importance.csv
✅ supporting/Appendix_S07_CV_fold_results.csv
✅ supporting/Appendix_S08_diversity_correlations.csv
✅ supporting/Appendix_S09_beta_diversity.csv
✅ supporting/Appendix_S10_matrix_diagnostics.csv
```

### 8.3 Supporting HTML Summaries

```
✅ supporting/Apppendix_S1.html
✅ supporting/Apppendix_S2.html
✅ supporting/Apppendix_S3.html
✅ supporting/Apppendix_S4.html
✅ supporting/Apppendix_S5.html
✅ supporting/Apppendix_S6.html
✅ supporting/Apppendix_S7.html
✅ supporting/Apppendix_S8.html
✅ supporting/Apppendix_S9.html
✅ supporting/Apppendix_S10.html
```

---

## 9. Package Structure

```
07_resubmission_package/FINAL_HTML_PACKAGE/
├── index.html                          ✅ Main manuscript
├── assets/                             ✅ 7 figures
│   ├── Figure01_Study_Area_Map.png
│   ├── Figure02_NMDS.png
│   ├── Figure03_Diversity.png
│   ├── Figure04_SpeciesAccumulation.png
│   ├── Figure05_CCA.png
│   ├── Figure06_RF_Importance.png
│   └── Figure07_Diversity_Elevation.png
├── supporting/                         ✅ 10 CSV + 10 HTML
│   ├── Appendix_S01_VIF_all_strata.csv
│   ├── ...
│   ├── Appendix_S10_matrix_diagnostics.csv
│   ├── Appendix_S1.html
│   ├── ...
│   └── Appendix_S10.html
└── diffs/                              ✅ 4 diff files
    ├── text_diff_main.md
    ├── captions_diff.md
    ├── refs_diff.md
    └── si_diff.md
```

---

## 10. Acceptance Criteria Verification

| Criterion | Status |
|-----------|--------|
| No missing sections | ✅ PASS |
| No broken links | ✅ PASS |
| All figures present | ✅ PASS (7/7) |
| All figures correctly numbered | ✅ PASS |
| All tables present | ✅ PASS (5/5) |
| All tables correctly numbered | ✅ PASS |
| All SI items accessible | ✅ PASS (10/10) |
| QA_report.md generated | ✅ PASS |
| Offline-compatible paths | ✅ PASS |
| Metadata from Title Page | ✅ PASS |
| Scientific content from LaTeX | ✅ PASS |

---

## 11. Build Notes

### 11.1 Authoritative Sources Used

1. **Scientific Content:** `01_manuscript_jvs.tex` (LaTeX source)
2. **Metadata:** `01_Title_Page_JVS.md` (Title Page)
3. **References:** `02_references.bib` (BibTeX)
4. **Figures:** `03_figures/` directory
5. **Tables:** `04_tables/` directory (for verification)
6. **Supporting Information:** `05_supporting_information/` directory

### 11.2 Reconciliation Principles Applied

1. LaTeX text treated as authoritative for scientific content
2. Title Page treated as authoritative for administrative metadata
3. Original numbering preserved (sections, figures, tables)
4. No scientific content invented or modified
5. All statistics and values preserved exactly
6. Missing assets documented with placeholders (none required)

---

## 12. Sign-Off

**Build Engineer:** AI Technical Editor  
**Date:** 2026-02-21  
**Status:** ✅ APPROVED FOR SUBMISSION

The HTML manuscript package has been verified as complete, internally consistent, and matching the authoritative LaTeX/PDF source. All content discrepancies have been resolved.
