# 03. Statistics and Modeling Audit

## Model Inventory

- Ordination: NMDS (k = 2, Bray-Curtis, seed 42) by vegetation stratum.
- Group differences: PERMANOVA + dispersion tests (999 permutations).
- Constrained ordination: CCA with VIF screening.
- Indicator species analysis: IndVal with 999 permutations.
- Regeneration prediction: Random Forest (500 trees) and XGBoost (nrounds 100, depth 4, eta 0.1), 5-fold CV.

## Assumptions and Diagnostics Status

- PERMANOVA dispersion check reported (Table 2 / `TableS2_PERMANOVA_full.csv`).
- Heterogeneous dispersion occurs for shrubs and herbs (dispersion p = 0.001).
- VIF values are low across retained variables (`TableS1_VIF_all_strata.csv`).
- Matrix density is low (1.3%-4.0%) (`TableS10_matrix_diagnostics.csv`), which may affect ordination behavior.
- I cannot confirm from the manuscript that permutation design accounted for spatial or nested structure.

## Cross-Validation Strategy

- 5-fold CV with fixed seed 42 (`TableS5_ML_parameters.csv`, `TableS7_CV_fold_results.csv`).
- Fold-level performance is reported.
- I cannot confirm from the manuscript whether hyperparameter tuning was nested within CV.

## Uncertainty Reporting

- Means +/- SD reported for CV metrics and diversity summaries.
- p-values are reported, but exact p-values are truncated/floored (e.g., 0.001, 0) in summary tables.

## Severity-Ranked Problems

1. **Critical** - PERMANOVA interpretation remains at risk where dispersion heterogeneity is significant.  
Location: Results `## Community differences among forest types`; Table 2; `TableS2_PERMANOVA_full.csv`.  
Why it matters: For shrubs/herbs, group separation may partly reflect within-group spread, not centroid shifts alone.  
Required correction: Add robust sensitivity analyses (e.g., alternative distance metrics, pairwise tests with caution, explicit effect-size framing, constrained permutation schema).

2. **Major** - Extremely low NMDS stress values for several strata are atypical and require explicit diagnostic justification.  
Location: Results `## Community composition and ordination` (e.g., trees = 0.0001, herbs = 0.001, regeneration = 0.0006).  
Why it matters: Could indicate degeneracy/data-structure artifacts or overfitting in 2D representation.  
Required correction: Provide stress-vs-dim plots, repeated random starts, and Shepard diagnostics per stratum.

3. **Major** - Environmental explained variance in CCA is very low (~3-4%), but narrative claims imply strong drivers.  
Location: Results `## Species–environment relationships`; Discussion sections on environmental control.  
Why it matters: Risks overstating ecological importance of predictor set.  
Required correction: Rephrase as weak explanatory power; include uncertainty and potentially compare unconstrained alternatives.

4. **Major** - ML predictive performance is weak (RF CV R2 ~0.14; XGBoost negative mean R2), yet variable-importance interpretation is strong.  
Location: Table 6; `TableS7_CV_fold_results.csv`; `TableS6_variable_importance.csv`; Discussion regeneration section.  
Why it matters: Weak generalization undermines confidence in inferred predictor ranking.  
Required correction: Emphasize exploratory status, add baseline/null-model comparison, and perform repeated CV or bootstrap stability checks.

5. **Major** - No explicit multiple-testing control for indicator-species significance.  
Location: indicator analysis sections; `TableS4_indicator_species_full.csv`.  
Why it matters: False positive risk increases with many species-level tests.  
Required correction: Apply and report FDR (or similar) adjustment, and indicate adjusted significance.

6. **Major** - Potential data leakage risk in ML preprocessing is not addressed.  
Location: `## Regeneration dynamics and predictive modelling`.  
Why it matters: Preprocessing outside fold loops can inflate perceived performance/importance.  
Required correction: Document fold-wise preprocessing and verify train/test separation for all engineered predictors.

7. **Minor** - Reported p-values rounded to zero in table output reduce interpretability.  
Location: Table 3 (`p = 0` for shrubs).  
Why it matters: Exact significance magnitude is obscured.  
Required correction: Report as `p < 0.001` or exact permutation-derived values with precision.

8. **Minor** - Correlation analyses in `TableS8_diversity_correlations.csv` show mostly small effects, but integration into interpretation is limited.  
Location: Discussion diversity/environment interpretation.  
Why it matters: Quantitative weak-effect evidence should temper conclusions.  
Required correction: Integrate effect-size interpretation consistently.

## Required Corrections (Priority)

1. Rework statistical interpretation where dispersion is heterogeneous (shrubs/herbs).
2. Add ordination diagnostics proving NMDS solution stability and dimensional adequacy.
3. Reframe CCA/ML findings as low-to-moderate explanatory evidence.
4. Apply multiple-testing correction in indicator species results.
5. Document CV/tuning/preprocessing pipeline explicitly to exclude leakage.
