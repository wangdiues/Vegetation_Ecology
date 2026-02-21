# Computational Methods

## Software Environment

All analyses were conducted in R version 4.4.0 with packages managed via renv.

## Data Preparation

Community matrices were constructed for four vegetation strata: Trees, Shrubs, Herbs, Regeneration .
Matrix dimensions ranged from 209 to 221 sites and 109 to 222 species.

## Ordination

Non-metric Multidimensional Scaling (NMDS) was computed using Bray-Curtis
dissimilarities (k = 2, seed = 42). Environmental vectors were fitted via
envfit with 999 permutations.

## Community Differences

Permutational MANOVA (PERMANOVA) was performed using adonis2 with 999
permutations. Homogeneity of multivariate dispersions was assessed with
betadisper and permutation tests.

## Constrained Ordination

Canonical Correspondence Analysis (CCA) was performed after iterative VIF
screening (threshold = 10, deterministic tie-breaking). Significance was
tested with 999 permutations.

## Indicator Species

Indicator Species Analysis used multipatt with the IndVal.g function,
999 permutations, and alpha = 0.05.

## Diversity Indices

Alpha diversity was quantified using species richness, Shannon-Wiener (H'),
Simpson (1-D), inverse Simpson, and Pielou's evenness (J). Beta diversity
was calculated as Whittaker's beta (gamma / mean alpha).

## Regeneration Modelling

Random Forest (ntree = 500) and XGBoost (nrounds = 100, max_depth = 4,
eta = 0.1) were trained with 5-fold cross-validation (seed = 42).
Variable importance was assessed via %IncMSE (RF) and Gain (XGBoost).

