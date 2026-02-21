# AUDIT — Stage 9: ML Regeneration Models
Generated: 2026-02-06 11:15:57.813756

## Inputs
- env_clean.rds
- diversity_metrics.rds

## Outputs
- rf_importance.csv
- xgb_importance.csv
- ml_summary.csv
- rf_model.rds
- xgb_model.bin
- ml_results.rds

## Seeds Used
- 42 (folds, RF, XGBoost)

## Runtime
- Completed: 2026-02-06 11:15:57.813888

## Notes
- RF: ntree=500 | XGB: nrounds=100, depth=4, eta=0.1
- CV: 5-fold | Observations: 192
- Predictors: elevation, latitude, longitude, slope, temperature, precipitation, eto, water_balance, aspect, trees_richness, trees_shannon, shrubs_richness, shrubs_shannon

