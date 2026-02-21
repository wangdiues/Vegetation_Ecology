# 06. Master Peer Review

## 1. Study Summary

The manuscript investigates vegetation community composition and species-environment relationships along an elevational gradient in south-central Bhutan across four strata (trees, shrubs, herbs, regeneration). Analyses include NMDS, PERMANOVA with dispersion testing, CCA, indicator-species analysis, diversity summaries, and machine-learning models for regeneration richness.

## 2. Novelty and Contribution

The multi-stratum design and integrated analytical framework are relevant to JVS scope and potentially useful for Himalayan vegetation ecology. The manuscript also presents substantial field and analytical effort.

Issue:
- Severity: Major
- Location: `01_main_text/MAIN_TEXT_extracted.md:594` and `01_main_text/MAIN_TEXT_extracted.md:626`
- Why it matters: Novelty claims are strong, but comparative evidence is limited in the cited framing; overstatement can weaken contribution positioning.
- Journal-rule reference: JVS Manuscript Acceptance Criteria (quality/originality/significance for international readership).

## 3. Methodological Assessment

Issue 1:
- Severity: Major
- Location: `01_main_text/MAIN_TEXT_extracted.md:113` and `01_main_text/MAIN_TEXT_extracted.md:135`
- Why it matters: The study-area description (regional elevation span) and sampled transect span are different; inference boundaries need explicit distinction to prevent overgeneralization.
- Journal-rule reference: Methods transparency expected for evaluation and review.

Issue 2:
- Severity: Major
- Location: `01_main_text/MAIN_TEXT_extracted.md:135`
- Why it matters: Plot allocation is described as \"approximately evenly\" distributed, but per-band/per-forest-type sampling counts and exclusion flow are not fully reported in main text, limiting bias assessment.
- Journal-rule reference: Manuscript clarity/readability standards under Preparing the Submission.

Issue 3:
- Severity: Major
- Location: `01_main_text/MAIN_TEXT_extracted.md:182`
- Why it matters: Environmental predictor specification does not report extraction resolution/time-period detail in methods text, reducing reproducibility.
- Journal-rule reference: Data-sharing transparency intent (materials sufficient to verify analyses).

## 4. Statistical Analysis Audit

Issue 1:
- Severity: Major
- Location: `01_main_text/MAIN_TEXT_extracted.md:307`, `01_main_text/MAIN_TEXT_extracted.md:317`, `01_main_text/MAIN_TEXT_extracted.md:318`
- Why it matters: Shrub and herb PERMANOVA results coincide with heterogeneous dispersion; interpretation requires caution because effects may combine centroid shift and spread differences.
- Journal-rule reference: Acceptance criteria emphasize robust/thorough analysis.

Issue 2:
- Severity: Major
- Location: `01_main_text/MAIN_TEXT_extracted.md:288` and NMDS stress report in the same subsection
- Why it matters: Near-zero stress values in multiple strata warrant explicit stability/diagnostic reporting to support ordination validity.
- Journal-rule reference: Analytical rigor under acceptance criteria.

Issue 3:
- Severity: Major
- Location: `01_main_text/MAIN_TEXT_extracted.md:334` and `01_main_text/MAIN_TEXT_extracted.md:626`
- Why it matters: CCA constrained variance is low (about 3-4%) while interpretation remains assertive in later synthesis; conclusions should stay proportional to explained signal.
- Journal-rule reference: Acceptance criteria (quality and significance supported by evidence).

Issue 4:
- Severity: Major
- Location: `01_main_text/MAIN_TEXT_extracted.md:407` and Table 6 in `01_main_text/MAIN_TEXT_extracted.md`
- Why it matters: Regeneration ML performance is modest (RF CV R2 ~0.14; XGBoost mean R2 below zero), so variable-importance claims should be framed as exploratory.
- Journal-rule reference: Statistical robustness expectations.

## 5. Reproducibility and Data / Code Availability

Issue 1:
- Severity: Critical
- Location: `00_title_page/title_page_extracted.md:62` and `00_title_page/title_page_extracted.md:68`
- Why it matters: Data availability statement defers repository DOI to post-acceptance; JVS policy requires a concrete data-availability statement and mandates data sharing for data-analysis studies.
- Journal-rule reference: Data Availability Statement section + JVS mandatory data sharing policy.

Issue 2:
- Severity: Critical
- Location: `01_main_text/MAIN_TEXT_extracted.md:270`
- Why it matters: Manuscript states data/code \"will be deposited\"; in the provided package, executable analysis scripts are not included, preventing full independent replication.
- Journal-rule reference: Data-sharing policy expectation that materials support verification.

Issue 3:
- Severity: Major
- Location: `01_main_text/MAIN_TEXT_extracted.md:258`
- Why it matters: Software versions are incomplete (R version/package versions not reported), limiting reproducibility across environments.
- Journal-rule reference: Transparency needed for verifiable analyses.

## 6. Interpretation and Limitations

Issue:
- Severity: Major
- Location: `01_main_text/MAIN_TEXT_extracted.md:594` and `01_main_text/MAIN_TEXT_extracted.md:626`
- Why it matters: Limitations are acknowledged, but several broad synthesis statements remain stronger than empirical explanatory power reported in CCA/ML sections.
- Journal-rule reference: Acceptance criteria requiring rigorous, defensible interpretation.

## 7. Ethics, Permits and Conflicts of Interest

Issue 1:
- Severity: Minor
- Location: `00_title_page/title_page_extracted.md:71` and `00_title_page/title_page_extracted.md:81`
- Why it matters: Ethics/permits and conflict statements are clearly present in title page, which supports compliance.
- Journal-rule reference: Editorial Policies (Conflict of Interest; ethical reporting).

Issue 2:
- Severity: Minor
- Location: `01_main_text/MAIN_TEXT_extracted.md` (Methods sections) vs `00_title_page/title_page_extracted.md:71`
- Why it matters: Permit information is not clearly mirrored in main text; including it in Methods can reduce editorial clarification cycles.
- Journal-rule reference: Transparency and compliance clarity in submission materials.

## 8. Figures and Tables

Issue 1:
- Severity: Minor
- Location: `01_main_text/MAIN_TEXT_extracted.md:812` and `01_main_text/MAIN_TEXT_extracted.md:870`
- Why it matters: Figure and table captions are provided and generally interpretable.
- Journal-rule reference: Preparing the Submission (figures/tables with legends).

Issue 2:
- Severity: Critical
- Location: `01_main_text/MAIN_TEXT.docx` (settings.xml audit: line numbering metadata absent)
- Why it matters: JVS specifies line-numbered text; missing line numbering can block or delay technical processing.
- Journal-rule reference: Preparing the Submission -> Formatting (text is line-numbered).

## 9. Citation and Literature Coverage

Issue 1:
- Severity: Major
- Location: `01_main_text/MAIN_TEXT_extracted.md:189` and `01_main_text/MAIN_TEXT_extracted.md:681`
- Why it matters: Dorji et al. (2025) is cited in Methods but no corresponding full reference entry is evident in the listed references.
- Journal-rule reference: References completeness/consistency.

Issue 2:
- Severity: Major
- Location: `01_main_text/MAIN_TEXT_extracted.md:56` and `01_main_text/MAIN_TEXT_extracted.md:681`
- Why it matters: Grytnes (2003) appears in Introduction citations, but a matching reference entry is not evident in the reference list.
- Journal-rule reference: References completeness/consistency.

Issue 3:
- Severity: Minor
- Location: `01_main_text/MAIN_TEXT_extracted.md:598`
- Why it matters: The named \"WorldClim\" limitation statement is not clearly linked to a corresponding citation in references.
- Journal-rule reference: Citation traceability.

Issue 4:
- Severity: Minor
- Location: `01_main_text/MAIN_TEXT_extracted.md:217` and `01_main_text/MAIN_TEXT_extracted.md:237`
- Why it matters: Minor style inconsistencies are present (e.g., punctuation in citations and a bracket typo in Chen & Guestrin citation), which may affect editorial polish.
- Journal-rule reference: Consistent manuscript style for submission quality.

## 10. Major Revisions Required

1. Provide an active public repository DOI/link for data and code and update the Data Availability Statement accordingly.
2. Provide executable analysis scripts/workflow sufficient to regenerate key tables/figures.
3. Add explicit ordination and model-diagnostic reporting to support inferential claims.
4. Reframe ecological interpretation in proportion to PERMANOVA/CCA/ML effect sizes and diagnostics.
5. Resolve citation completeness gaps (at least Dorji 2025 and Grytnes 2003 matching entries).
6. Add line numbering to the main manuscript DOCX.

## 11. Minor Revisions

1. Clarify sampled vs regional elevation range and inference domain.
2. Expand environmental-layer technical metadata in Methods.
3. Harmonize minor citation/style inconsistencies.
4. Mirror permit details briefly in Methods text.

## 12. Optional Suggestions

1. Add sensitivity analyses separating seedling and sapling responses.
2. Report repeated CV or bootstrap stability for ML variable importance.
3. Include a concise reproducibility appendix mapping inputs -> analyses -> outputs.

## 13. Overall Recommendation

**Major Revision**

Rationale: The manuscript has strong ecological relevance and useful data, but critical submission/compliance and reproducibility issues (active DOI archive, executable code, line numbering) plus major statistical-interpretation clarifications are required before it is publication-ready.

## 14. Confidence Level of This Review

**High for compliance and reproducibility findings; moderate-to-high for methods/statistics findings; moderate for citation-completeness findings.**

I cannot confirm this from the manuscript: whether any missing reference entries are present in an unprovided full bibliography version outside the supplied files.
