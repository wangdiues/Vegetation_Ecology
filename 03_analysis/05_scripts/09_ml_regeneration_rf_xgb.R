#!/usr/bin/env Rscript
# =============================================================================
# 09_ml_regeneration_rf_xgb.R — Stage-2: ML Regeneration Modelling
# Random Forest + XGBoost with 5-fold CV, proper predict() (no recursion bug)
# Constitution: MASTER_CONSTITUTION.md, Stage-2_Instructions.md
# =============================================================================

set.seed(42)
log_msg("info", "=== Stage 9: ML Regeneration Models (RF + XGBoost) ===")

suppressPackageStartupMessages({
  library(tidyverse)
  library(randomForest)
  library(xgboost)
  library(caret)
})

env_clean <- load_checkpoint("env_clean")
div_data  <- load_checkpoint("diversity_metrics")

# =============================================================================
# PREPARE MODELLING DATASET
# =============================================================================

regen_metrics <- div_data$regen_metrics
div_env       <- div_data$div_env

# Merge regeneration metrics with environmental data
model_df <- regen_metrics %>%
  inner_join(env_clean, by = "plot_id")

# Add diversity from trees/shrubs if available
trees_div <- div_data$div_by_plot %>%
  filter(stratum == "Trees") %>%
  select(plot_id, trees_richness = richness, trees_shannon = shannon)
shrubs_div <- div_data$div_by_plot %>%
  filter(stratum == "Shrubs") %>%
  select(plot_id, shrubs_richness = richness, shrubs_shannon = shannon)

model_df <- model_df %>%
  left_join(trees_div, by = "plot_id") %>%
  left_join(shrubs_div, by = "plot_id")

# Response variable
response <- "regen_richness"
if (!response %in% names(model_df)) {
  log_msg("error", "Response variable regen_richness not found")
  stop("Missing response")
}

# Candidate predictors (Methods.md aligned)
predictors <- intersect(
  c("elevation", "latitude", "longitude", "slope", "temperature",
    "precipitation", "eto", "water_balance", "aspect",
    "trees_richness", "trees_shannon", "shrubs_richness", "shrubs_shannon"),
  names(model_df)
)

log_msg("info", paste("Response:", response))
log_msg("info", paste("Predictors:", paste(predictors, collapse = ", ")))

# Clean dataset
ml_data <- model_df %>%
  select(all_of(c(response, predictors))) %>%
  drop_na()

# Convert any factors to numeric
for (col in names(ml_data)) {
  if (is.factor(ml_data[[col]])) {
    ml_data[[col]] <- as.numeric(as.character(ml_data[[col]]))
  }
}

log_msg("info", paste("ML dataset:", nrow(ml_data), "obs x",
                       length(predictors), "predictors"))

if (nrow(ml_data) < 30) {
  log_msg("warn", "Fewer than 30 observations — ML results may be unreliable")
}

# =============================================================================
# 5-FOLD CROSS-VALIDATION
# =============================================================================

set.seed(42)
folds <- createFolds(ml_data[[response]], k = 5, returnTrain = FALSE)

# --- Random Forest CV ---
rf_cv_results <- lapply(seq_along(folds), function(i) {
  set.seed(42)
  test_idx  <- folds[[i]]
  train_df  <- ml_data[-test_idx, ]
  test_df   <- ml_data[test_idx, ]

  rf_model <- randomForest(
    x = train_df[, predictors, drop = FALSE],
    y = train_df[[response]],
    ntree = 500, importance = TRUE
  )
  pred <- predict(rf_model, newdata = test_df[, predictors, drop = FALSE])
  actual <- test_df[[response]]
  ss_res <- sum((actual - pred)^2)
  ss_tot <- sum((actual - mean(actual))^2)

  tibble(
    fold = i,
    rmse = sqrt(mean((actual - pred)^2)),
    mae  = mean(abs(actual - pred)),
    r2   = if (ss_tot > 0) 1 - ss_res / ss_tot else NA_real_
  )
})
rf_cv <- bind_rows(rf_cv_results)
log_msg("info", paste("RF CV — RMSE:", round(mean(rf_cv$rmse), 3),
                       "+/-", round(sd(rf_cv$rmse), 3)))

# --- XGBoost CV ---
xgb_cv_results <- lapply(seq_along(folds), function(i) {
  set.seed(42)
  test_idx  <- folds[[i]]
  train_df  <- ml_data[-test_idx, ]
  test_df   <- ml_data[test_idx, ]

  x_train <- as.matrix(train_df[, predictors, drop = FALSE])
  y_train <- train_df[[response]]
  x_test  <- as.matrix(test_df[, predictors, drop = FALSE])
  actual  <- test_df[[response]]

  dtrain <- xgb.DMatrix(data = x_train, label = y_train)
  dtest  <- xgb.DMatrix(data = x_test)

  params <- list(
    objective        = "reg:squarederror",
    max_depth        = 4,
    eta              = 0.1,
    subsample        = 0.8,
    colsample_bytree = 0.8,
    seed             = 42
  )

  xgb_model <- xgb.train(params = params, data = dtrain,
                          nrounds = 100, verbose = 0)

  # Use standard predict() — NO xgboost::: namespace access (fixes recursion bug)
  pred <- predict(xgb_model, newdata = dtest)

  ss_res <- sum((actual - pred)^2)
  ss_tot <- sum((actual - mean(actual))^2)

  tibble(
    fold = i,
    rmse = sqrt(mean((actual - pred)^2)),
    mae  = mean(abs(actual - pred)),
    r2   = if (ss_tot > 0) 1 - ss_res / ss_tot else NA_real_
  )
})
xgb_cv <- bind_rows(xgb_cv_results)
log_msg("info", paste("XGB CV — RMSE:", round(mean(xgb_cv$rmse), 3),
                       "+/-", round(sd(xgb_cv$rmse), 3)))

# =============================================================================
# FINAL MODELS (full data)
# =============================================================================

set.seed(42)
rf_final <- randomForest(
  x = ml_data[, predictors, drop = FALSE],
  y = ml_data[[response]],
  ntree = 500, importance = TRUE
)

set.seed(42)
x_all  <- as.matrix(ml_data[, predictors, drop = FALSE])
y_all  <- ml_data[[response]]
d_all  <- xgb.DMatrix(data = x_all, label = y_all)

xgb_final <- xgb.train(
  params  = list(objective = "reg:squarederror", max_depth = 4,
                 eta = 0.1, subsample = 0.8, colsample_bytree = 0.8, seed = 42),
  data    = d_all,
  nrounds = 100,
  verbose = 0
)

# =============================================================================
# VARIABLE IMPORTANCE
# =============================================================================

# RF importance
rf_imp <- as.data.frame(importance(rf_final)) %>%
  rownames_to_column("variable") %>%
  arrange(desc(`%IncMSE`))
write_csv(rf_imp, file.path(paths$tables, "rf_importance.csv"))

# XGBoost importance
xgb_imp <- xgb.importance(model = xgb_final)
write_csv(as.data.frame(xgb_imp),
          file.path(paths$tables, "xgb_importance.csv"))

log_msg("info", paste("RF top vars:", paste(head(rf_imp$variable, 5),
                                             collapse = ", ")))
log_msg("info", paste("XGB top vars:", paste(head(xgb_imp$Feature, 5),
                                              collapse = ", ")))

# =============================================================================
# ML SUMMARY
# =============================================================================

ml_summary <- tibble(
  model           = c("Random Forest", "XGBoost"),
  response_variable = response,
  n_predictors    = length(predictors),
  n_observations  = nrow(ml_data),
  cv_rmse         = c(round(mean(rf_cv$rmse), 3),
                      round(mean(xgb_cv$rmse), 3)),
  cv_rmse_sd      = c(round(sd(rf_cv$rmse), 3),
                      round(sd(xgb_cv$rmse), 3)),
  cv_r2           = c(round(mean(rf_cv$r2, na.rm = TRUE), 3),
                      round(mean(xgb_cv$r2, na.rm = TRUE), 3)),
  cv_r2_sd        = c(round(sd(rf_cv$r2, na.rm = TRUE), 3),
                      round(sd(xgb_cv$r2, na.rm = TRUE), 3)),
  cv_mae          = c(round(mean(rf_cv$mae), 3),
                      round(mean(xgb_cv$mae), 3))
)
write_csv(ml_summary, file.path(paths$tables, "ml_summary.csv"))

# =============================================================================
# SAVE MODELS
# =============================================================================

saveRDS(rf_final, file.path(paths$ml, "rf_model.rds"))
xgb.save(xgb_final, file.path(paths$ml, "xgb_model.bin"))
saveRDS(list(rf_cv = rf_cv, xgb_cv = xgb_cv, ml_summary = ml_summary,
             predictors = predictors, response = response),
        file.path(paths$ml, "ml_results.rds"))

save_checkpoint(list(
  rf_model   = rf_final,
  xgb_model  = xgb_final,
  rf_cv      = rf_cv,
  xgb_cv     = xgb_cv,
  rf_imp     = rf_imp,
  xgb_imp    = xgb_imp,
  ml_summary = ml_summary,
  predictors = predictors,
  response   = response,
  ml_data    = ml_data
), "ml_models")

write_audit(
  stage_num  = 9,
  stage_name = "ML Regeneration Models",
  inputs     = c("env_clean.rds", "diversity_metrics.rds"),
  outputs    = c("rf_importance.csv", "xgb_importance.csv", "ml_summary.csv",
                 "rf_model.rds", "xgb_model.bin", "ml_results.rds"),
  seeds_used = "42 (folds, RF, XGBoost)",
  notes      = c(paste("RF: ntree=500 | XGB: nrounds=100, depth=4, eta=0.1"),
                 paste("CV: 5-fold | Observations:", nrow(ml_data)),
                 paste("Predictors:", paste(predictors, collapse = ", ")))
)

update_stage("ml")
log_msg("info", "=== Stage 9: ML Models Complete ===")
log_msg("info", "Stage-2 analyses complete. Ready for Stage-3 synthesis.")
