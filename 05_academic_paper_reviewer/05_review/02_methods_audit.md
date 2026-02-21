# 02. Methods and Study-Design Audit

## Study-Design Overview

The manuscript presents a stratified field survey along an elevational gradient in Sarpang District (Bhutan), with 220 plots and four vegetation strata (trees, shrubs, herbs, regeneration). Analyses include NMDS, PERMANOVA, CCA, indicator-species analysis, diversity summaries, and ML modeling of regeneration richness.

## Ranked Issues

1. **Critical** - Reproducible methodological chain cannot be executed from provided submission files.  
Location: `## Reproducibility and data stewardship`; `04_supplementary/*.csv`.  
Scientific risk: Core claims (ordination, indicator species, ML ranking) cannot be independently re-run or audited end-to-end.  
Required fix: Provide full analysis scripts/workflow, raw/processed input matrices, and executable run order with versioned dependencies.

2. **Major** - Sampling-frame description is internally inconsistent in elevational extent.  
Location: `## Study area` (153-3 500 m a.s.l. regional span) vs `## Sampling design` (260-1 964 m sampling span).  
Scientific risk: Readers may misinterpret inference domain; conclusions could be overgeneralized beyond sampled altitude.  
Required fix: Explicitly distinguish "regional context" from "actual sampled range" in Methods and Discussion.

3. **Major** - Plot allocation and per-group sample balance are insufficiently specified.  
Location: `## Sampling design`; Tables 2-6.  
Scientific risk: Uneven effort across forest types/elevation bands can bias community turnover and diversity contrasts.  
Required fix: Add per-forest-type and per-elevation-band sample sizes (before/after filtering), plus exclusion rationale.

4. **Major** - Access-constrained randomization introduces potential site-selection bias without quantification.  
Location: `## Sampling design` ("subject to terrain safety and forest accessibility constraints").  
Scientific risk: Accessibility bias can confound elevational and vegetation effects.  
Required fix: Report excluded/inaccessible sectors, and assess whether sampled plots differ from accessible landscape background.

5. **Major** - Environmental covariate specification lacks sufficient technical detail (spatial resolution, extraction method, temporal period).  
Location: `## Environmental variables`.  
Scientific risk: Mis-specified environmental layers can weaken ecological inference and comparability.  
Required fix: Provide raster resolution, baseline years, extraction protocol per plot, and coordinate reference framework.

6. **Major** - Regeneration endpoint definition mixes seedlings and saplings into one richness target without sensitivity analysis.  
Location: `## Vegetation data collection`; `## Regeneration dynamics and predictive modelling`.  
Scientific risk: Potentially distinct demographic processes are collapsed, reducing mechanistic interpretability.  
Required fix: Run separate analyses for seedling and sapling richness (or justify aggregation quantitatively).

7. **Major** - Strong ecological interpretation is made despite very low constrained variance in CCA (~3-4%).  
Location: `## Species–environment relationships`; Table 3.  
Scientific risk: Over-interpretation of weak explanatory signal can misstate driver strength.  
Required fix: Reframe as weak effects; quantify uncertainty and compare with alternative models/axes.

8. **Minor** - Temporal sampling window is broad (March-November), but phenological/seasonality handling is not described.  
Location: `## Sampling design`.  
Scientific risk: Understorey detectability may vary seasonally.  
Required fix: Include sampling month covariate or sensitivity check by season.

9. **Minor** - Data cleaning and filtering pipeline is only broadly described.  
Location: `## Data preparation`; Table01/Table02 differences in n_sites.  
Scientific risk: Ambiguity in row/plot filtering complicates reproducibility and bias assessment.  
Required fix: Add explicit filtering criteria with record counts at each step.

10. **Suggestion** - Limited treatment of spatial dependence in community analyses.  
Location: multivariate sections (lat/long included as predictors only).  
Scientific risk: Residual spatial autocorrelation may inflate nominal significance.  
Required fix: Assess residual spatial structure or use permutation constraints/spatial terms where appropriate.

## Ecology/Spatial Checks

- Elevation-driven design is appropriate for mountain-community questions, but inference should be restricted to sampled range (260-1 964 m).  
- Inclusion of multiple strata is a strength and aligns with vertical heterogeneity questions.  
- Spatial predictors (lat/long) are included, but I cannot confirm from the manuscript that spatial autocorrelation diagnostics were performed.

## Conclusion-Threatening Flaws

- **Critical**: No fully executable reproducibility package in the submission files.  
- **Major**: Interpretation strength exceeds the explanatory power of environmental models in key sections.
