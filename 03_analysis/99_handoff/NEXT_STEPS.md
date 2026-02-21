# Pipeline Stopped - Action Required

Timestamp: 2026-02-06 11:38:29.970823
Failed at stage: 5 - permanova

## Error
ℹ In argument: `!is.na(plot_id)`.
Caused by error:
! object 'plot_id' not found

## Recovery
1. Check: D:/2025-2026/Vegetation_Ecology/03_analysis/01_logs/error_stage_05.log
2. Check 01_logs/pipeline.log
3. Fix the issue
4. Re-run: Rscript 03_analysis/run_all.R

To force re-run from a specific stage:
  Rscript run_all.R stage=5 --force
