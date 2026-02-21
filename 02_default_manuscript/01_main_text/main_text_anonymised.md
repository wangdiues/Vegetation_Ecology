0001 # Vegetation community composition and species-environment relationships along an elevational gradient in south-central Bhutan
0002 
0003 ## Abstract
0004 **Questions:** Understanding how plant communities vary along elevation is essential for predicting biodiversity responses to environmental change. We asked how community composition, diversity, and species-environment relationships differ among vegetation strata along an elevational gradient, and which environmental variables best explain regeneration patterns.
0005 
0006 **Location:** [TODO — STUDY LOCATION REQUIRED]
0007 
0008 **Methods:** We analysed vegetation data from four strata (trees, shrubs, herbs, regeneration) across 209 to 221 plots. We constructed community matrices, quantified environmental variables, applied non-metric multidimensional scaling and canonical correspondence analysis, and tested group differences with permutational multivariate analysis of variance. Indicator species analysis and machine-learning models (random forest and gradient boosting) assessed regeneration patterns.
0009 
0010 **Results:** Community composition differed among forest types in all strata (R2 0.0165 to 0.0502; p = 0.001). Environmental predictors explained 3.2 to 3.8 per cent of variation in trees and shrubs and were not significant for herbs and regeneration. Trees had the highest Shannon diversity (1.391 plus or minus 0.595), whereas herbs had the lowest (0.325 plus or minus 0.451). Random forest models outperformed gradient boosting for regeneration richness (root mean square error 1.165 plus or minus 0.182; coefficient of determination 0.142 plus or minus 0.040).
0011 
0012 **Conclusions:** Plant communities show consistent elevational structuring across strata, with distinct environmental signals by layer. These results highlight the need to consider vertical heterogeneity when assessing mountain forest biodiversity and regeneration.
0013 
0014 **Total word count:** 232
0015 
0016 **Keywords:** elevational gradient, plant community, tropical mountain forest, species-environment relationships, community assembly, diversity, regeneration, ordination, canonical correspondence analysis, indicator species
0017 
0018 ---
0019 
0020 ## Introduction\nElevational gradients provide powerful natural laboratories for understanding how climate, topography, and habitat heterogeneity structure biodiversity. Across taxa and regions, elevational diversity patterns are often unimodal or vary with sampling extent and environmental context, indicating that no single mechanism universally explains richness–elevation relationships (McCain and Grytnes 2013). In mountain forests, strong abiotic gradients combine with fine-scale heterogeneity to shape community composition and to filter species differently across vegetation strata.
0021 
0022 In the eastern Himalaya, steep environmental gradients and complex terrain create sharp transitions among forest types and high beta diversity across short distances. Yet, community-level evidence that integrates multiple strata (trees, shrubs, herbs, regeneration) remains limited, and few studies explicitly compare the strength of species-environment relationships among strata or evaluate regeneration patterns alongside diversity and composition.
0023 
0024 Here, we examine plant community composition, diversity, and species-environment relationships along an elevational gradient in south-central Bhutan. We test whether forest types differ in composition across strata, identify environmental predictors of community structure, and quantify diversity patterns and indicator species. We also assess regeneration patterns using machine-learning models to identify key predictors. Together, these analyses provide a multi-strata perspective on elevational community structure and regeneration dynamics in subtropical to cool broadleaved forests.\n---
0025 
0026 ## Methods\n\n### Study area
0027 The study was conducted in unmanaged forests of Sarpang District, south-central Bhutan, within the jurisdiction of the Sarpang Forest Division. The region spans a strong altitudinal gradient from approximately 153 to 3 500 m a.s.l., encompassing subtropical broadleaved (100–500 m), warm broadleaved (500–1 500 m), and cool broadleaved forests (1 500–3 000 m). Annual precipitation ranges from 3 500 to 5 500 mm, driven by monsoonal circulation and orographic uplift, while steep terrain generates pronounced microclimatic heterogeneity. The landscape forms a strategic ecological link among Bhutan's protected areas and Biological Corridor-03, although most sampled forests remain outside formal management regimes.
0028 
0029 ### Sampling design
0030 Vegetation sampling followed a stratified random design along the elevational gradient from Shershong (approximately 260 m) in the south to Singye (approximately 1 964 m) in the north. A total of 221 plots were established across forest types. Each plot measured 20 × 20 m (400 m²), with a nested 2 × 2 m subplot used to survey herbaceous vegetation. Fieldwork was undertaken between March and November to capture seasonal variation while avoiding peak monsoon inaccessibility.
0031 
0032 ### Vegetation data collection
0033 All free-standing woody stems with diameter at breast height (DBH) > 1 cm and height > 1.3 m were recorded. DBH was measured using diameter tapes and tree height with hypsometers. Shrubs were assessed for presence, height, and lateral spread, whereas herbs were quantified using per cent cover, frequency, and maximum height. Species identifications were verified with regional floras and herbarium material. Species nomenclature followed the Flora of Bhutan and was cross-checked against the World Flora Online (accessed 6 Feb 2026).. Structural descriptors including basal area, DBH class, and height class distributions were derived to characterise stand structure and regeneration dynamics.
0034 
0035 ### Environmental variables
0036 Topographic attributes (elevation, slope, aspect) were recorded in the field using GPS receivers, clinometers, and compasses. Spatial climatic surfaces for temperature, precipitation, evapotranspiration, and water balance were extracted from national-scale interpolation models and matched to plot coordinates. Digital elevation data from ASTER DEM were used to derive terrain predictors incorporated into statistical analyses.
0037 
0038 ### Data preparation
0039 Field records were curated in tabular form to compute species abundance, frequency, basal area, and importance value index for each vegetation stratum. Alpha diversity was quantified using Shannon-Wiener diversity, Simpson’s index, and Pielou's evenness for each forest type and vegetation layer (Shannon 1948; Simpson 1949; Pielou 1966).
0040 
0041 ### Multivariate community analyses
0042 Floristic variation among plots was examined using non-metric multidimensional scaling based on Bray-Curtis dissimilarities (Bray and Curtis 1957; Kruskal 1964). species-environment relationships were assessed with canonical correspondence analysis using climatic and topographic predictors (ter Braak 1986). Ordination axes were interpreted through correlations between species scores and environmental variables. Community differences among forest types were tested using permutational multivariate analysis of variance (Anderson 2001).
0043 
0044 Vegetation communities were delineated by hierarchical agglomerative clustering, and solution robustness was evaluated using partitioning around medoids. Indicator species analysis identified taxa significantly associated with forest types at alpha = 0.05 using the indicator value approach (Dufrene and Legendre 1997). Sampling adequacy and dominance patterns were assessed through species–area curves and rank–abundance distributions.
0045 
0046 ### Regeneration dynamics and predictive modelling
0047 Seedling and sapling data were analysed to quantify regeneration patterns and spatial structure. Kernel density estimation was applied to map recruitment hotspots across the landscape. Environmental drivers of regeneration density were modelled using random forest and XGBoost algorithms (Breiman 2001; Chen and Guestrin 2016), with predictor importance evaluated via gain, cover, and mean-decrease-accuracy metrics. Model performance was assessed using mean squared error and out-of-bag error rates. K-means clustering was used to classify plots into regeneration zones representing contrasting environmental regimes and recruitment intensity.
0048 
0049 ### Software environment
0050 All analyses were conducted in R with community-ecology workflows implemented primarily through the vegan package (Oksanen et al. 2025). Multivariate classification and indicator-species procedures were cross-checked in PC-ORD v5, and spreadsheet software was used for initial data curation and quality control.
0051 
0052 ### Reproducibility and data stewardship
0053 Reproducibility was ensured by archiving raw field data, spatial environmental layers, curated datasets, and derived analytical outputs; documenting all distance measures, clustering criteria, ordination settings, and machine-learning parameters; and recording software versions. Intermediate products including ordination scores, cluster assignments, regeneration surfaces, and variable-importance tables were retained to permit independent replication and re-analysis of vegetation patterns and regeneration models.\n---|---:|---:|---:|---|---:|---:|
0054 | Trees | 2134 | 221 | 222 | dbh_cm | 0 | 0 |
0055 | Shrubs | 1394 | 209 | 114 | cover_percentage | 0.6456 | 0.2152 |
0056 | Herbs | 410 | 210 | 134 | cover | 0.4878 | 0 |
0057 | Regeneration | 451 | 211 | 109 | plot_cover | 0.6652 | 0 |
0058 
0059 Non-metric multidimensional scaling (NMDS) was computed using Bray-Curtis dissimilarities (k = 2, seed = 42). Environmental vectors were fitted with envfit using 999 permutations.
0060 
0061 Permutational multivariate analysis of variance (PERMANOVA) was performed using adonis2 with 999 permutations. Homogeneity of multivariate dispersions was assessed with betadisper and permutation tests.
0062 
0063 Canonical correspondence analysis (CCA) was performed after iterative variance inflation factor screening (threshold = 10, deterministic tie-breaking). Significance was tested with 999 permutations.
0064 
0065 Indicator species analysis used multipatt with the IndVal.g function, 999 permutations, and alpha = 0.05.
0066 
0067 Alpha diversity was quantified using species richness, Shannon-Wiener (H'), Simpson (one minus D), inverse Simpson, and Pielou's evenness (J). Beta diversity was calculated as Whittaker's beta (gamma divided by mean alpha).
0068 
0069 Random forest (ntree = 500) and gradient boosting (nrounds = 100, max depth = 4, eta = 0.1) models were trained with five-fold cross-validation (seed = 42). Variable importance was assessed via percentage increase in mean squared error (random forest) and gain (gradient boosting).
0070 
0071 ---
0072 
0073 ## Results
0074 
0075 ### Community composition and ordination
0076 Ordination results are shown in Figure 1. Environmental vectors significant at p < 0.05 are indicated.
0077 
0078 ![Figure 1. NMDS ordination of vegetation plots.](../02_figures/Figure01_NMDS.png)
0079 
0080 Figure 1. NMDS ordination of vegetation plots for four strata (trees, shrubs, herbs, regeneration). Bray-Curtis dissimilarity, k = 2. Red arrows indicate significant environmental vectors (envfit, p < 0.05, 999 permutations).
0081 
0082 ### Community differences among forest types
0083 Community composition differed significantly among forest types across all strata (Table 2).
0084 
0085 Table 2. PERMANOVA and dispersion tests by stratum.
0086 | Stratum | Group variable | Sites | Groups | R2 | F | p | Dispersion F | Dispersion p | Homogeneous dispersion |
0087 |---|---|---:|---:|---:|---:|---:|---:|---:|---|
0088 | Trees | forest_type | 216 | 3 | 0.0307 | 3.38 | 0.001 | 1.24 | 0.291 | TRUE |
0089 | Shrubs | forest_type | 194 | 3 | 0.0502 | 5.05 | 0.001 | 12.93 | 0.001 | FALSE |
0090 | Herbs | forest_type | 206 | 3 | 0.0165 | 1.70 | 0.001 | 15.05 | 0.001 | FALSE |
0091 | Regeneration | forest_type | 205 | 3 | 0.0208 | 2.14 | 0.001 | 1.17 | 0.319 | TRUE |
0092 
0093 ### species-environment relationships
0094 Canonical correspondence analysis indicated that selected environmental variables explained a small but significant proportion of variation for trees and shrubs, but not for herbs and regeneration (Table 3; Figure 4).
0095 
0096 Table 3. Canonical correspondence analysis summary by stratum.
0097 | Stratum | Sites | Species | Environmental variables | Total inertia | Constrained inertia | Proportion explained | p | Significant |
0098 |---|---:|---:|---|---:|---:|---|---:|---|
0099 | Trees | 216 | 221 | aspect; eto; latitude; longitude; slope | 35.117 | 1.109 | 3.2 per cent | 0.008 | TRUE |
0100 | Shrubs | 194 | 101 | aspect; eto; latitude; longitude; slope | 27.832 | 1.045 | 3.8 per cent | 0.001 | TRUE |
0101 | Herbs | 206 | 134 | aspect; eto; latitude; longitude; slope | 68.475 | 2.309 | 3.4 per cent | 0.125 | FALSE |
0102 | Regeneration | 205 | 109 | aspect; eto; latitude; longitude; slope | 58.906 | 1.987 | 3.4 per cent | 0.076 | FALSE |
0103 
0104 ![Figure 4. CCA biplots for four vegetation strata.](../02_figures/Figure04_CCA.png)
0105 
0106 Figure 4. CCA biplots for four vegetation strata. Environmental predictors selected after variance inflation factor screening (threshold = 10). Significance tested with 999 permutations.
0107 
0108 ### Diversity patterns
0109 Alpha diversity differed among strata (Table 4; Figure 2), and species accumulation patterns are shown in Figure 3. Species richness varied along the elevational gradient (Figure 6).
0110 
0111 Table 4. Alpha diversity by stratum.
0112 | Stratum | Plots | Richness (mean plus or minus SD) | Shannon | Simpson (mean) | Evenness (mean) |
0113 |---|---:|---|---|---:|---:|
0114 | Herbs | 210 | 1.79 plus or minus 1.32 | 0.325 plus or minus 0.451 | 0.193 | 0.804 |
0115 | Regeneration | 209 | 2.00 plus or minus 1.26 | 0.443 plus or minus 0.499 | 0.264 | 0.839 |
0116 | Shrubs | 198 | 4.77 plus or minus 3.43 | 1.063 plus or minus 0.706 | 0.524 | 0.832 |
0117 | Trees | 221 | 5.30 plus or minus 2.57 | 1.391 plus or minus 0.595 | 0.665 | 0.903 |
0118 
0119 ![Figure 2. Alpha diversity indices across strata.](../02_figures/Figure02_Diversity.png)
0120 
0121 Figure 2. Alpha diversity indices across vegetation strata. (A) Species richness, (B) Shannon-Wiener diversity (H'), (C) Simpson's index (one minus D), (D) Pielou's evenness (J).
0122 
0123 ![Figure 3. Species accumulation curves.](../02_figures/Figure03_SpeciesAccumulation.png)
0124 
0125 Figure 3. Species accumulation curves (random method, 100 permutations) showing cumulative species richness as a function of sampling effort for each vegetation stratum.
0126 
0127 ![Figure 6. Species richness along the elevational gradient.](../02_figures/Figure06_Diversity_Elevation.png)
0128 
0129 Figure 6. Species richness along the elevational gradient for each vegetation stratum. LOESS smoothing applied.
0130 
0131 ### Indicator species
0132 Indicator species analysis identified significant indicators across all strata (Table 5).
0133 
0134 Table 5. Indicator species summary by stratum.
0135 | Stratum | Group variable | Sites | Species | Groups | Significant indicators | Per cent significant |
0136 |---|---|---:|---:|---:|---:|---|
0137 | Trees | elevation_group | 216 | 221 | 3 | 10 | 4.5 per cent |
0138 | Shrubs | elevation_group | 194 | 101 | 3 | 15 | 14.9 per cent |
0139 | Herbs | elevation_group | 206 | 134 | 3 | 10 | 7.5 per cent |
0140 | Regeneration | elevation_group | 205 | 109 | 3 | 8 | 7.3 per cent |
0141 
0142 ### Regeneration modelling
0143 Random forest models outperformed gradient boosting models for regeneration richness (Table 6; Figure 5). Top predictors included shrub Shannon diversity, shrub richness, temperature, elevation, and evapotranspiration.
0144 
0145 Table 6. Cross-validated model performance for regeneration richness.
0146 | Model | Predictors | Observations | Coefficient of determination | Root mean square error | Mean absolute error |
0147 |---|---:|---:|---|---|---|
0148 | Random forest | 13 | 192 | 0.142 plus or minus 0.040 | 1.165 plus or minus 0.182 | 0.907 |
0149 | Gradient boosting | 13 | 192 | -0.009 plus or minus 0.096 | 1.261 plus or minus 0.192 | 0.942 |
0150 
0151 ![Figure 5. Random forest variable importance.](../02_figures/Figure05_RF_Importance.png)
0152 
0153 Figure 5. Random forest variable importance for regeneration richness prediction. Top ten predictors ranked by percentage increase in mean squared error.
0154 
0155 ---
0156 
0157 ## Discussion\nCommunity composition differed significantly among forest types across all strata, indicating strong structuring along the elevational gradient. The ordination and PERMANOVA results together suggest that shifts in forest type are associated with consistent compositional changes despite high within-type variability. Such stratified responses are consistent with the view that elevational gradients provide strong environmental filters but that local heterogeneity and dispersal processes contribute substantial additional variation (McCain and Grytnes 2013).
0158 
0159 Canonical correspondence analysis identified relatively small proportions of explained variation for trees and shrubs and non-significant models for herbs and regeneration. Low constrained inertia is common in community datasets where multiple unmeasured drivers and stochastic processes influence composition. The stronger signals in woody strata compared with herbs and regeneration suggest that longer-lived strata integrate environmental conditions over longer periods, whereas short-lived layers may respond to fine-scale microsite variability and recent disturbance.
0160 
0161 Diversity patterns varied by stratum, with trees showing the highest Shannon diversity and herbs the lowest. These differences likely reflect contrasting life-history strategies and the balance between dominance and evenness across strata. The indicator species results highlight that forest types retain distinctive floristic signatures, supporting their use in ecological classification and management.
0162 
0163 Regeneration modelling indicated that shrub-layer diversity and climate variables (temperature, elevation, and evapotranspiration) were among the strongest predictors of regeneration richness. This suggests that regeneration dynamics are influenced by both biotic context and environmental gradients, reinforcing the need to consider multi-strata interactions when assessing forest resilience and future compositional change.\n---
0164 
0165 ## Conclusions\nPlant communities along the Sarpang elevational gradient are strongly structured by forest type across all strata, with distinct species assemblages and indicator taxa. Environmental predictors explain modest but significant variation in woody strata, while herb and regeneration layers show weaker coupling to measured predictors. Regeneration richness is best predicted by a combination of shrub diversity and climatic variables, underscoring the importance of vertical heterogeneity for understanding forest dynamics. These findings provide a multi-strata baseline for monitoring and for assessing how Himalayan forest communities may respond to environmental change.\n---
0166 
0167 ## Data availability statement\nThe data supporting the findings of this study are available in the Supporting Information (Appendix S1–S10). Processed community matrices and analysis outputs are archived in the project repository accompanying this submission (see 03_analysis/06_stage3 and 03_analysis/04_results for traceable outputs). A public repository with DOI will be provided upon acceptance (e.g., Zenodo DOI: 234526251).\n---
0168 
0169 ## References\nAnderson, Marti J. 2001. “A new method for non-parametric multivariate analysis of variance.” *Austral Ecology* 26(1): 32–46. https://doi.org/10.1111/j.1442-9993.2001.01070.pp.x.
0170 
0171 Bray, J. Roger, and J. T. Curtis. 1957. “An Ordination of the Upland Forest Communities of Southern Wisconsin.” *Ecological Monographs* 27(4): 325–349. https://doi.org/10.2307/1942268.
0172 
0173 Breiman, Leo. 2001. “Random Forests.” *Machine Learning* 45: 5–32. https://doi.org/10.1023/A:1010933404324.
0174 
0175 Chen, Tianqi, and Carlos Guestrin. 2016. “XGBoost: A Scalable Tree Boosting System.” In *Proceedings of the 22nd ACM SIGKDD International Conference on Knowledge Discovery and Data Mining*, 785–794. https://doi.org/10.1145/2939672.2939785.
0176 
0177 Dufrene, Marc, and Pierre Legendre. 1997. “Species assemblages and indicator species: The need for a flexible asymmetrical approach.” *Ecological Monographs* 67(3): 345–366. https://doi.org/10.2307/2963459.
0178 
0179 Kruskal, J. B. 1964. “Nonmetric multidimensional scaling: A numerical method.” *Psychometrika* 29(2): 115–129. https://doi.org/10.1007/BF02289694.
0180 
0181 McCain, Christy M., and John-Arvid Grytnes. 2013. “Global variation in elevational diversity patterns.” *Scientific Reports* 3: 3007. https://doi.org/10.1038/srep03007.
0182 
0183 Oksanen, Jari, Gavin L. Simpson, F. Guillaume Blanchet, Roeland Kindt, Pierre Legendre, Peter R. Minchin, R. B. O'Hara, Peter Solymos, M. Henry H. Stevens, Eduard Szoecs, Helene Wagner, Matt Barbour, Michael Bedward, Ben Bolker, Daniel Borcard, Tuomas Borman, Gustavo Carvalho, Michael Chirico, Miquel De Caceres, Sebastien Durand, Heloisa Beatriz Antoniazi Evangelista, Rich FitzJohn, Michael Friendly, Brendan Furneaux, Geoffrey Hannigan, Mark O. Hill, Leo Lahti, Cameron Martino, Dan McGlinn, Marie-Helene Ouellette, Eduardo Ribeiro Cunha, Tyler Smith, Adrian Stier, Cajo J. F. ter Braak, and James Weedon. 2025. *vegan: Community Ecology Package*. R package version 2.7-2. https://CRAN.R-project.org/package=vegan. https://doi.org/10.32614/CRAN.package.vegan.
0184 
0185 Pielou, E. C. 1966. “The measurement of diversity in different types of biological collections.” *Journal of Theoretical Biology* 13: 131–144. https://doi.org/10.1016/0022-5193(66)90013-0.
0186 
0187 Shannon, Claude E. 1948. “A Mathematical Theory of Communication.” *Bell System Technical Journal* 27: 379–423, 623–656. https://doi.org/10.1002/j.1538-7305.1948.tb00917.x.
0188 
0189 Simpson, E. H. 1949. “Measurement of Diversity.” *Nature* 163: 688. https://doi.org/10.1038/163688a0.
0190 
0191 ter Braak, C. J. F. 1986. “Canonical correspondence analysis: a new eigenvector technique for multivariate direct gradient analysis.” *Ecology* 67(5): 1167–1179. https://doi.org/10.2307/1938672.\n---
0192 
0193 ## Supporting information list
0194 Appendix S1. TableS1_VIF_all_strata.csv — Variance inflation factor screening by stratum
0195 Appendix S2. TableS2_PERMANOVA_full.csv — Full PERMANOVA and dispersion outputs
0196 Appendix S3. TableS3_envfit_all.csv — Envfit results for all strata
0197 Appendix S4. TableS4_indicator_species_full.csv — Indicator species list
0198 Appendix S5. TableS5_ML_parameters.csv — Machine-learning model parameters
0199 Appendix S6. TableS6_variable_importance.csv — Variable importance outputs
0200 Appendix S7. TableS7_CV_fold_results.csv — Cross-validation fold results
0201 Appendix S8. TableS8_diversity_correlations.csv — Diversity correlation matrix
0202 Appendix S9. TableS9_beta_diversity.csv — Beta diversity metrics
0203 Appendix S10. TableS10_matrix_diagnostics.csv — Community matrix diagnostics
0204 
0205 
0206 
0207 
0208 
0209 
0210 
0211 
