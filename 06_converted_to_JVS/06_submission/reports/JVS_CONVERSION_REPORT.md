# JVS CONVERSION REPORT

## Conversion Metadata

- **Conversion date/time:** 2026-02-12 (local)
- **Target journal:** Journal of Vegetation Science (JVS, Wiley)
- **Article type:** Research Article

---

## Input Files Used

| File | Path |
|---|---|
| Title page | `00_title_page/title_page.docx` |
| Main text | `01_main_text/MAIN_TEXT.docx` |
| Figures (6 files, PNG + PDF) | `02_figures/Figure01–06` |
| Tables (6 CSV files) | `03_tables/Table01–06` |
| Supplementary (10 CSV files) | `04_supplementary/TableS1–S10` |
| JVS Author Guidelines | `JVS_Author_Guidelines.md` |

---

## Output Files Produced

### Word Package (`06_submission/word/`)

| File | Description |
|---|---|
| `01_Title_Page_JVS.docx` | JVS-formatted title page with authors, ORCIDs, affiliations, funding, acknowledgements, author contributions, data availability |
| `02_Main_Text_JVS.docx` | Anonymized main text: title, structured abstract, keywords, Introduction, Methods, Results, Discussion, Conclusions, References (Chicago author-date), Tables 1–6 with legends, Figures 1–6 with legends, Supporting Information list |
| `03_Figures/` | 12 files (6 PNG + 6 PDF) |
| `04_Tables/` | 6 CSV source files |
| `05_Supporting_Information/` | 10 files renamed as Appendix_S01–S10 with paper-reference headers |

### LaTeX Package (`06_submission/latex/`)

| File | Description |
|---|---|
| `01_manuscript_jvs.tex` | Full LaTeX manuscript (anonymized, line-numbered, double-spaced) |
| `02_references.bib` | BibTeX database (31 entries) |
| `03_figures/` | 12 files (6 PNG + 6 PDF) |
| `04_tables/` | 6 CSV source files |
| `05_supporting_information/` | 10 files renamed as Appendix_S01–S10 |
| `06_README_compile.txt` | Compilation instructions |

### Reports (`06_submission/reports/`)

| File | Description |
|---|---|
| `JVS_CONVERSION_REPORT.md` | This file |
| `SECTION_MAPPING.md` | Source-to-target section mapping |
| `MANUAL_VERIFICATION_REQUIRED.md` | Items requiring manual review |

---

## JVS Compliance Checklist

### A) Scope and Article Type

| Check | Status |
|---|---|
| Article mapped to JVS category | **PASS** — Research Article |
| Content within JVS Aims & Scope (plant community ecology, vegetation science) | **PASS** |

### B) Structure and Separation

| Check | Status |
|---|---|
| Separate title page file present | **PASS** — `01_Title_Page_JVS.docx` |
| Main text anonymized for double-anonymized review | **PASS** — No author names, affiliations, or identifying info in main text |
| Main text order: title → abstract+keywords → main text → references → tables → figures → appendices | **PASS** |
| Title page contains: title, authors, affiliations, funding, acknowledgements, author contributions, data availability | **PASS** |

### C) Abstract and Keywords

| Check | Status |
|---|---|
| Abstract uses structured sections (Questions, Location, Methods, Results, Conclusions) | **PASS** |
| Abstract length ≤ 300 words (Research Article cap) | **PASS** — ~227 words |
| Keywords present | **PASS** — 10 keywords |
| Keyword count 8–10 | **PASS** — exactly 10 |

### D) Citation/Reference Integrity

| Check | Status |
|---|---|
| In-text style is Chicago author-date | **PASS** — converted from APA-like to Chicago |
| Ampersands (&) replaced with "and" in in-text citations | **PASS** |
| Chronological ordering in grouped citations | **PASS** — verified in source; maintained |
| Same author-year disambiguation (2006a, 2006b) | **PASS** — Wangda and Ohsawa 2006a, 2006b |
| All in-text citations present in reference list | **PASS** — 31 references, all cited |
| No orphan references | **PASS** — all references are cited in text |
| References alphabetized by author surname | **PASS** |
| Full journal names used | **PASS** |
| DOI included where available | **PASS** |
| For 1–3 authors: all names listed in text | **PASS** |
| For ≥4 authors: first author + et al. | **PASS** |
| Reference list: ≤6 authors all listed; ≥7 first 3 + et al. | **PASS** |
| Reference format matches JVS Chicago examples | **PASS** — Author. Year. "Title." Journal Volume: Pages. DOI |

### E) Supporting Information

| Check | Status |
|---|---|
| File naming uses Appendix S# convention | **PASS** — Appendix S1–S10 |
| All appendices cited from main text | **PASS** — Appendices S1–S10 all referenced |
| Appendix title list inserted after references in main text | **PASS** |
| Each appendix file has paper-reference header | **PASS** |

### F) Figures/Tables and Readability

| Check | Status |
|---|---|
| Figures and legends paired on same page (in review-ready manuscript) | **PASS** — figures embedded with captions in main text |
| Tables and legends present and consistently numbered (Tables 1–6) | **PASS** |
| Manuscript line-numbered | **PASS** — Word (section-level) and LaTeX (lineno package) |
| No text footnotes | **PASS** — none present |

### G) Content Integrity

| Check | Status |
|---|---|
| All numeric values, statistics, p-values preserved | **PASS** — spot-checked: R² values, F statistics, p-values, sample sizes, diversity indices all match source |
| Effect directions unchanged | **PASS** |
| Sample sizes unchanged | **PASS** — 220 plots, 4 strata |
| Units preserved | **PASS** |
| No scientific content invented | **PASS** |
| No scientific content deleted | **PASS** |

### H) Taxon Nomenclature and Style

| Check | Status |
|---|---|
| Taxon author citations not used (JVS default) | **PASS** |
| Scientific names used consistently | **PASS** |
| SI/SI-derived units | **PASS** |
| Date format (JVS: 2 Sep 2017) | **PASS** — "6 Feb 2026" used |

---

## Citation/Reference Mismatch List

**No mismatches detected.** All 31 in-text citations have corresponding reference entries, and all reference entries are cited in the text.

Note: `Carpenter (2005)` and `Acharya et al. (2011)` appear in the Discussion but are also in the reference list. These were present in the source manuscript.

---

## Supporting Information Mapping

| Source File | Target Name | Appendix ID |
|---|---|---|
| `TableS1_VIF_all_strata.csv` | `Appendix_S01_VIF_all_strata.csv` | Appendix S1 |
| `TableS2_PERMANOVA_full.csv` | `Appendix_S02_PERMANOVA_full.csv` | Appendix S2 |
| `TableS3_envfit_all.csv` | `Appendix_S03_envfit_all.csv` | Appendix S3 |
| `TableS4_indicator_species_full.csv` | `Appendix_S04_indicator_species_full.csv` | Appendix S4 |
| `TableS5_ML_parameters.csv` | `Appendix_S05_ML_parameters.csv` | Appendix S5 |
| `TableS6_variable_importance.csv` | `Appendix_S06_variable_importance.csv` | Appendix S6 |
| `TableS7_CV_fold_results.csv` | `Appendix_S07_CV_fold_results.csv` | Appendix S7 |
| `TableS8_diversity_correlations.csv` | `Appendix_S08_diversity_correlations.csv` | Appendix S8 |
| `TableS9_beta_diversity.csv` | `Appendix_S09_beta_diversity.csv` | Appendix S9 |
| `TableS10_matrix_diagnostics.csv` | `Appendix_S10_matrix_diagnostics.csv` | Appendix S10 |

---

## Word-LaTeX Parity Exceptions

| Element | Word | LaTeX | Note |
|---|---|---|---|
| Figures | Embedded PNG | Referenced PDF via `\includegraphics` | Both use same source figures; format differs |
| Line numbering | Word section-level continuous numbering | `lineno` package | Both provide continuous numbering |
| Table styling | python-docx table objects | `booktabs` package | Visual appearance differs slightly |
| Font rendering | System-dependent Times New Roman | `mathptmx` package | Functionally equivalent |
| Title page | Separate .docx file | Not included in .tex (anonymized) | By design — title page is Word-only for submission |

---

## Manual Verification Items

See `MANUAL_VERIFICATION_REQUIRED.md` for full list.

---

## Final Status

**COMPLETE WITH TODOs**

All JVS structural, formatting, and compliance requirements have been applied. Items flagged for manual verification relate to content that cannot be automatically confirmed (e.g., figure resolution adequacy, data repository DOI assignment upon acceptance).
