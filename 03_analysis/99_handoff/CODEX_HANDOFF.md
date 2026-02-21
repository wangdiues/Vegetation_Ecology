# CODEX_HANDOFF

Date: 2026-02-06
Project: Vegetation Ecology Analysis — Sarpang District, Bhutan

## What this repo is
End-to-end vegetation ecology analysis and synthesis pipeline. Stages 1–3 produce QCed matrices, analyses (ordination, PERMANOVA, CCA, indicators, diversity, ML), and Stage-3 synthesis outputs (figures, tables, manuscript blocks, supplementary materials, data release). The master runner is `03_analysis/run_all.R`.

## How to run
From repo root:

```bash
Rscript 03_analysis/run_all.R
```

Run a stage range:

```bash
Rscript 03_analysis/run_all.R stage=4-8
```

Force re-run of a stage:

```bash
Rscript 03_analysis/run_all.R stage=6 --force
```

## Resume and handoff logic
- Resume is driven by `03_analysis/99_handoff/LAST_SUCCESSFUL_STAGE.txt`.
- On errors, the runner writes `03_analysis/99_handoff/NEXT_STEPS.md` and `03_analysis/01_logs/error_stage_XX.log`.
- Pipeline logging is in `03_analysis/01_logs/pipeline.log`.

## Stage map (01–13)
- 01 setup: `01_setup.R`
- 02 qc: `02_data_inspect_qc_harmonize.R`
- 03 matrices: `03_build_matrices.R`
- 04 nmds: `04_nmds_envfit.R`
- 05 permanova: `05_permanova_dispersion.R`
- 06 cca: `06_cca_vif_permutation.R`
- 07 indicators: `07_indicator_species.R`
- 08 diversity: `08_diversity_regeneration_metrics.R`
- 09 ml: `09_ml_regeneration_rf_xgb.R`
- 10 publication: `10_publication_figures_and_tables.R`
- 11 manuscript blocks: `11_manuscript_blocks.R`
- 12 supplementary: `12_supplementary_materials.R`
- 13 data release: `13_data_release_traceability.R`

## Key outputs
Stage-2 analyses:
- `03_analysis/04_results/ordinations/`
- `03_analysis/04_results/tests/`
- `03_analysis/04_results/indicators/`
- `03_analysis/04_results/ml/`

Stage-3 synthesis:
- `03_analysis/06_stage3/01_figures/`
- `03_analysis/06_stage3/02_tables/`
- `03_analysis/06_stage3/03_manuscript_blocks/`
- `03_analysis/06_stage3/04_supplementary/`
- `03_analysis/06_stage3/05_data_release/`
- `03_analysis/06_stage3/TRACEABILITY.csv`

## Verification checklist
- `03_analysis/99_handoff/STATUS.md` contains “Stage-2 analyses complete.” and “Stage-3 synthesis complete. Manuscript blocks and data release ready.”
- `03_analysis/99_handoff/AUDIT_STAGE_*.md` exists for all stages.
- `03_analysis/06_stage3/TRACEABILITY.csv` links all figures/tables back to inputs.
- `03_analysis/06_stage3/05_data_release/DATA_AVAILABILITY.md` present with checksums.

## Notes
- The runner detects the repo root by locating `01_data/`.
- Stage-3 scripts do not recompute analytical models; they only format or summarise existing outputs.
