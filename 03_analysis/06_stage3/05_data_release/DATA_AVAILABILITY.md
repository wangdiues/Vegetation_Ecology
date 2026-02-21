# Data Availability Statement

Generated: 2026-02-06 12:14:22.280947

## Raw Data

Raw vegetation and environmental CSV files are archived in `01_data/`.
These files are READ-ONLY and must not be modified.

## Processed Data

Processed community matrices (RDS format) are in
`03_analysis/03_outputs/data_processed/`.

## Analysis Outputs

- Summary tables (CSV): `03_analysis/03_outputs/tables/`
- Ordination results (RDS): `03_analysis/04_results/ordinations/`
- Statistical tests (RDS): `03_analysis/04_results/tests/`
- Indicator species (CSV, RDS): `03_analysis/04_results/indicators/`
- ML models (RDS, BIN): `03_analysis/04_results/ml/`

## Publication Materials

- Figures (PNG 300dpi + PDF): `03_analysis/06_stage3/01_figures/`
- Formatted tables (CSV): `03_analysis/06_stage3/02_tables/`
- Manuscript blocks (MD): `03_analysis/06_stage3/03_manuscript_blocks/`
- Supplementary (CSV): `03_analysis/06_stage3/04_supplementary/`

## Reproducibility

- R version and packages: `03_analysis/00_admin/sessionInfo.txt`
- Package versions: `03_analysis/renv.lock`
- Pipeline log: `03_analysis/01_logs/pipeline.log`
- Audit trail: `03_analysis/99_handoff/AUDIT_STAGE_*.md`
- Traceability: `03_analysis/06_stage3/TRACEABILITY.csv`
- Checksums: `03_analysis/06_stage3/05_data_release/checksums.sha256.csv`

## Scripts

All analysis scripts are in `03_analysis/05_scripts/`:

| Script | Purpose |
|---|---|
| 01_setup.R | Environment setup & dependency locking |
| 02_data_inspect_qc_harmonize.R | Data QC & harmonisation |
| 03_build_matrices.R | Community matrix construction |
| 04_nmds_envfit.R | NMDS ordination & environmental fitting |
| 05_permanova_dispersion.R | PERMANOVA & dispersion tests |
| 06_cca_vif_permutation.R | CCA with VIF screening |
| 07_indicator_species.R | Indicator species analysis |
| 08_diversity_regeneration_metrics.R | Diversity & regeneration metrics |
| 09_ml_regeneration_rf_xgb.R | Random Forest & XGBoost models |
| 10_publication_figures_and_tables.R | Publication figures & tables |
| 11_manuscript_blocks.R | Manuscript automation |
| 12_supplementary_materials.R | Supplementary materials |
| 13_data_release_traceability.R | Data release & traceability |

## Licence

See LICENSE in the project root.

## Citation

See CITATION.cff in the project root.

