# Supplementary Methods

## Seed & Reproducibility

All stochastic procedures used set.seed(42). The pipeline is managed
via renv for package version locking.

## VIF Selection

Variance Inflation Factors were calculated iteratively. At each step,
the variable with the highest VIF was removed. Ties were broken
alphabetically (deterministic). The threshold was VIF = 10.

## Cross-Validation

5-fold cross-validation was used for Random Forest (ntree = 500) and
XGBoost (nrounds = 100, max_depth = 4, eta = 0.1, subsample = 0.8,
colsample_bytree = 0.8). Folds were created deterministically via
caret::createFolds with seed = 42.

## Permutation Tests

PERMANOVA, envfit, ISA, and CCA significance tests used 999 permutations.

