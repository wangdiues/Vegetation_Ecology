# 04. Reproducibility and Transparency Audit

## Data Availability Status

- **Status: PARTIAL / policy-critical gap**
- Evidence:
- Title-page statement includes placeholder DOI text (`[TODO — INSERT DOI WHEN AVAILABLE]`) in `00_title_page/title_page.md`.
- Supplementary files (`04_supplementary/TableS1-TableS10`) provide derived outputs.
- Public repository DOI/link for complete analysis assets is not provided.

## Code Availability Status

- **Status: FAIL (for full replication)**
- No executable scripts/notebooks/pipeline code are present in provided folders.
- Manuscript states data and code "will be deposited" upon submission, but archive evidence is absent from package.

## Software and Versions

- **Status: PARTIAL**
- Reported: "All analyses were conducted in R"; PC-ORD version 5 referenced; Microsoft Excel mentioned.
- Missing: R version, package names/versions, OS/session info, exact ML library versions.

## Randomness Control

- **Status: PARTIAL (good but incomplete)**
- Reported fixed seed 42 for NMDS and CV.
- I cannot confirm from the manuscript that all stochastic operations (e.g., all model fits, resampling steps) were controlled and documented consistently.

## Pipeline Traceability

- **Status: PARTIAL**
- Positive: Manuscript claims retained intermediate products; supplementary contains many outputs.
- Gap: No executable workflow manifest (inputs -> processing -> model -> outputs) linking each final table/figure to code steps.
- Gap: Internal path references in DAS (`03_analysis/...`) are not accessible as public provenance artifacts.

## Missing Elements Blocking Replication

1. **Critical** - Public DOI-linked repository containing data and code needed to reproduce all analyses.  
Location: `00_title_page/title_page.md`; `## Reproducibility and data stewardship`.  
Why it blocks replication: Independent researchers cannot retrieve complete materials.

2. **Critical** - Analysis code/scripts for NMDS, PERMANOVA, CCA, indicator species, diversity metrics, and ML models.  
Location: submission package (no code files present).  
Why it blocks replication: Output CSVs alone do not permit method re-execution.

3. **Major** - Version-locked computational environment (R + package versions + OS metadata).  
Location: `## Software environment`.  
Why it blocks replication: Results may vary by package/version implementations.

4. **Major** - End-to-end data provenance (raw field files -> cleaned matrices -> reported statistics) with checksums or clear IDs.  
Location: `## Data preparation` and supplementary.  
Why it blocks replication: Filtering/transform decisions cannot be audited fully.

5. **Major** - Transparent fold assignment/tuning protocol for ML reproducibility.  
Location: `## Regeneration dynamics and predictive modelling`; `TableS7_CV_fold_results.csv`.  
Why it blocks replication: Model performance and importance estimates are not independently reproducible without fold definitions and training scripts.

6. **Minor** - Reproducibility statement references anonymized sharing intent but no reviewer-access mechanism is provided in files.  
Location: `## Reproducibility and data stewardship`.  
Why it matters: Reviewers cannot validate claims during peer review.
