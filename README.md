# Vegetation Ecology Analysis Pipeline

Analysis pipeline for vegetation community data (trees, shrubs, herbs, regeneration) with environmental correlates.

## Requirements

- R >= 4.3.0
- renv for dependency management

## Quick Start

```bash
cd 03_analysis
Rscript run_all.R
```

Or using Make:

```bash
cd 03_analysis
make all
```

## Project Structure

```
01_data/          # READ-ONLY input data
02_manuscripts/   # Manuscript drafts (not overwritten by pipeline)
03_analysis/      # All generated artifacts
```

## Pipeline Stages

| Script | Description |
|--------|-------------|
| 01_setup.R | Environment setup, package loading, path configuration |
| 02_data_inspect_qc_harmonize.R | Data inspection, QC, harmonization |
| 03_build_matrices.R | Build community matrices |
| 04_nmds_envfit.R | NMDS ordination with environmental fitting |
| 05_permanova_dispersion.R | PERMANOVA and dispersion tests |
| 06_cca_vif_permutation.R | CCA with VIF and permutation tests |
| 07_indicator_species.R | Indicator species analysis |
| 08_diversity_regeneration_metrics.R | Diversity and regeneration metrics |
| 09_ml_regeneration_rf_xgb.R | ML models (Random Forest, XGBoost) |
| 10_publication_figures_and_tables.R | Publication-ready outputs |

## Expected Outputs

- `03_outputs/`: Processed data, tables, figures
- `04_results/`: Ordinations, statistical tests, indicator species, ML results
- `06_reports/`: HTML and PDF reports

## Reproducibility

- `renv.lock` captures exact package versions
- `sessionInfo.txt` records R session details
- `RUN_METADATA.json` logs each pipeline run

## Data Availability

The data supporting the findings of this study are available in the Supporting Information (Appendices S1–S10). Processed community matrices, environmental predictors, and statistical outputs are archived in the project repository accompanying this submission. A public repository with a DOI will be provided upon manuscript acceptance to ensure reproducibility and transparency: https://github.com/wangdiues/Vegetation_Ecology
