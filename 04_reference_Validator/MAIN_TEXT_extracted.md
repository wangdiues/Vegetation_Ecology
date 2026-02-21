Vegetation community composition and species–environment relationships along an elevational gradient in south-central Bhutan

## Abstract

Questions: Understanding how plant communities vary along elevation is essential for predicting biodiversity responses to environmental change. We asked how community composition, diversity, and species–environment relationships differ among vegetation strata along an elevational gradient, and which environmental variables best explain regeneration patterns.

Location: Sarpang District, south-central Bhutan; unmanaged subtropical to cool broadleaved forests spanning approximately 260 to 1 964 m a.s.l.

Methods: We analysed vegetation data from four strata (trees, shrubs, herbs, regeneration) across 209 to 221 plots. We constructed community matrices, quantified environmental variables, applied non-metric multidimensional scaling and canonical correspondence analysis, and tested group differences with permutational multivariate analysis of variance. Indicator species analysis and machine-learning models (random forest and gradient boosting) assessed regeneration patterns.

Results: Community composition differed among forest types in all strata (R² 0.017 to 0.050; p = 0.001). Environmental predictors explained 3.2 to 3.8 percent of variation in trees and shrubs and were not significant for herbs and regeneration. Trees had the highest Shannon diversity (1.391 ± 0.595), whereas herbs had the lowest (0.325 ± 0.451). Random forest models outperformed gradient boosting for regeneration richness (root mean square error 1.165 ± 0.182; coefficient of determination 0.142 ± 0.040).

Conclusions: Plant communities show consistent elevational structuring across strata, with distinct environmental signals by layer. These results highlight the need to consider vertical heterogeneity when assessing mountain forest biodiversity and regeneration.

Keywords: elevational gradient, plant community, tropical mountain forest, species–environment relationships, community assembly, diversity, regeneration, ordination, canonical correspondence analysis, indicator species.

## Introduction

Elevational gradients constitute powerful natural laboratories for understanding how climate, topography, and habitat heterogeneity interact to structure plant communities. Because temperature, moisture availability, and growing-season length vary predictably with altitude, mountain systems have long served as test beds for ecological theory addressing species richness, environmental filtering, and community turnover (Lomolino 2001; Rahbek 2005). Across regions, richness–elevation relationships are frequently unimodal but vary with spatial extent, taxonomic scope, and climatic context, indicating that no single mechanism universally governs elevational diversity patterns (Grytnes 2003; McCain 2009). In forest ecosystems, steep abiotic gradients combined with fine-scale variation in soils, canopy structure, and disturbance regimes generate pronounced compositional turnover and vertically stratified responses among trees, shrubs, and herb layers (Gilliam 2007; Sundqvist et al. 2013). Mountain floras therefore often exhibit high beta diversity over short distances, reflecting both dispersal limitation and niche differentiation along climatic and edaphic gradients (Qian et al. 2005). Recent research has increasingly focused on disentangling the relative roles of environmental filtering, functional traits, and biotic interactions in shaping elevational community organization (Siefert et al. 2013; Kraft et al. 2015). Nevertheless, many studies continue to focus primarily on canopy trees, despite mounting evidence that understorey strata respond more sensitively to microclimatic and edaphic variation and may follow distinct compositional trajectories along the same gradient (Gilliam 2007; Lenoir et al. 2008). Regeneration layers are especially informative in this context because they integrate recent recruitment processes and may foreshadow future changes in forest composition under ongoing climatic warming (Clark et al. 2014).

The eastern Himalaya represents a global centre of biodiversity characterized by extreme elevational relief, complex terrain, and monsoonal climates that generate sharp forest transitions and exceptionally high species turnover (Myers et al. 2000; Grytnes & Vetaas 2002). Within this region, numerous studies have documented steep elevational zonation and marked diversity patterns, while broad-scale syntheses emphasize the region’s sharp biodiversity gradients and habitat heterogeneity (Myers et al. 2000; Grytnes & Vetaas 2002). Despite this growing body of work, community-level investigations integrating multiple vegetation strata across Himalayan elevational gradients remain uncommon. Few studies explicitly compare species–environment relationships among canopy and understorey layers, and regeneration dynamics are seldom analysed in parallel with diversity and compositional patterns, despite their central importance for forest resilience and long-term reorganization (Sundqvist et al. 2013; Clark et al. 2014).

Here, we present a comprehensive assessment of plant community composition, diversity, and species–environment relationships along an elevational gradient in south-central Bhutan. We test whether forest types differ consistently in composition across four strata—trees, shrubs, herbs, and regeneration—identify the principal environmental drivers of community structure, and quantify elevational trends in alpha and beta diversity together with indicator species. In addition, we model regeneration patterns using machine-learning approaches (random forest and gradient boosting) to determine which environmental variables are most strongly associated with recruitment success. By integrating multiple vegetation strata within a unified analytical framework, this study offers a novel, multi-layer perspective on elevational community organization and regeneration dynamics in subtropical to cool broadleaved forests of Bhutan. This approach enables evaluation of how microhabitat versus macroclimatic factors govern different vertical layers, providing empirical evidence directly relevant to both ecological theory and Himalayan Forest conservation.

## Methods

Study area

The study was conducted in unmanaged forests of Sarpang District in south-central Bhutan under the jurisdiction of the Sarpang Forest Division. The region spans a pronounced elevational gradient from approximately 153 to 3 500 m a.s.l., encompassing subtropical broadleaved forests at lower elevations (100–500 m), warm broadleaved forests at mid-elevations (500–1 500 m), and cool broadleaved forests between 1 500 and 3 000 m. Such steep altitudinal transitions typify Himalayan landscapes and generate strong climatic and edaphic gradients over short distances (Grytnes & Vetaas 2002; Körner 2007).

Annual precipitation is high and strongly seasonal, reflecting monsoon circulation intensified by orographic uplift, a defining feature of the eastern Himalayan foothills (Bookhagen & Burbank 2010). Rugged terrain and variable slope exposure create pronounced microclimatic heterogeneity, which is expected to contribute to high beta diversity and fine-scale community turnover along the gradient (Grytnes & Vetaas 2002). The landscape also forms part of a strategic ecological linkage among Bhutan’s protected areas and Biological Corridor-03, although the sampled forests themselves lie largely outside formal management regimes.

Sampling design

Vegetation sampling followed a stratified random design along the elevational gradient extending from Shershong (approximately 260 m a.s.l.) in the south to Singye (approximately 1 964 m a.s.l.) in the north. A total of 221 plots were established across forest types to ensure representation of major vegetation zones and environmental conditions.

Each plot measured 20 × 20 m (400 m²), a size widely used in forest community studies to characterise tree assemblages and stand structure, with a nested 2 × 2 m subplot used to survey herbaceous vegetation. Fieldwork was undertaken between March and November to encompass seasonal variability in understorey communities while avoiding periods of peak monsoon inaccessibility. Plots were distributed approximately evenly among elevational bands and forest types to ensure balanced representation of vegetation zones. Within each band, plot locations were stratified by forest type and positioned using random bearings and distances from access transects, subject to terrain safety and forest accessibility constraints.

Vegetation data collection

All free-standing woody individuals with diameter at breast height (DBH) > 1 cm and height > 1.3 m were recorded as trees. DBH was measured using diameter tapes, and total height was estimated with optical hypsometers. Shrubs were assessed for presence, height, and lateral spread, while herbaceous species were quantified within subplots using percentage cover, frequency, and maximum height.

Regeneration comprised all woody individuals below the canopy layer that had not yet reached the tree stratum. Seedlings were defined as individuals ≤ 1.3 m in height, irrespective of stem diameter, whereas saplings were defined as individuals > 1.3 m in height with DBH ≤ 1 cm. Individuals exceeding 1 cm DBH were assigned to the tree layer. Regeneration richness therefore integrated both seedling and sapling cohorts, representing early demographic stages that are particularly sensitive to microsite conditions and neighbourhood effects.

Species identifications were verified using regional floras and herbarium reference material, and taxonomic nomenclature was cross-checked against the World Flora Online database (accessed 6 February 2026). Structural attributes, including basal area, DBH-class distributions, and height-class distributions, were derived to characterise stand structure and regeneration dynamics across forest types and elevational gradients.

Environmental variables

Topographic attributes, including elevation, slope, and aspect, were recorded in the field using handheld Global Positioning System receivers, clinometers, and compasses. Spatial climatic surfaces describing air temperature, precipitation, evapotranspiration, and water balance were extracted from national-scale interpolation products and matched to plot coordinates.

Digital elevation data from the Advanced Spaceborne Thermal Emission and Reflection Radiometer (ASTER) global digital elevation model were used to derive additional terrain predictors, including slope and transformed aspect variables, which were incorporated into all multivariate and modelling analyses (Abrams et al. (2020)). Terrain–climate coupling in montane systems is widely recognized as a dominant driver of vegetation turnover along elevational gradients (Grytnes & Vetaas, 2002; Körner, 2007).

High-resolution (250 m) historical and projected (CMIP6) temperature and precipitation surfaces for Bhutan were obtained from the national gridded climate dataset produced by Dorji et al. (2025), developed by CSIRO and distributed with a permanent digital object identifier (https://doi.org/10.25919/pec2-hs50). These climate layers were used consistently across all spatial and statistical analyses.

Data preparation

Field records were curated in tabular format to compute species abundance, frequency, basal area and importance value index separately for each vegetation stratum. Alpha diversity was quantified using the Shannon–Wiener index (H′), Simpson’s diversity index (1 – D) and Pielou’s evenness (J) for each forest type and vegetation layer (Shannon 1948; Simpson 1949; Pielou 1966).

Multivariate community analyses

Floristic variation among plots was examined using non-metric multidimensional scaling (NMDS) based on Bray–Curtis dissimilarities (Bray and Curtis 1957; Kruskal 1964). Species–environment relationships were assessed using canonical correspondence analysis (CCA), which constrains ordination axes by linear combinations of climatic and topographic predictors (ter Braak 1986). Ordination axes were interpreted through correlations between site scores and environmental variables.

Community differences among forest types were tested using permutational multivariate analysis of variance (PERMANOVA; Anderson 2001). NMDS was computed with two dimensions (k = 2) and a fixed random seed (42) to ensure reproducibility. Environmental vectors were fitted using permutation tests with 999 randomizations. PERMANOVA was conducted with 999 permutations, and homogeneity of multivariate dispersions was evaluated using permutation tests on distance-to-centroid values to verify that significant results reflected shifts in community centroids rather than unequal spread among groups.

Prior to CCA, collinearity among predictors was assessed using variance inflation factors, and variables exceeding a threshold of 10 were sequentially removed following deterministic selection rules. Statistical significance of constrained axes and individual predictors was evaluated using 999 permutations.

Indicator species analysis was applied to identify taxa significantly associated with forest types using the indicator value method, with significance assessed at α = 0.05 and 999 permutations (Dufrêne and Legendre 1997).

Regeneration dynamics and predictive modelling

Seedling and sapling data were analysed to quantify regeneration patterns and spatial structure across forest types and elevations. Environmental drivers of regeneration richness were modelled using random forest and extreme gradient boosting algorithms, both of which are widely applied for non-linear ecological prediction problems (Breiman 2001; (Chen & Guestrin 2016). Random forest models were fitted with 500 trees, and predictor importance was quantified as the percentage increase in mean squared error following permutation. Gradient boosting models were parameterized with 100 boosting rounds, a maximum tree depth of four and a learning rate of 0.1, and predictor influence was assessed using relative gain values.

Model performance was evaluated using five-fold cross-validation with a fixed random seed (42) to ensure reproducibility. Predictive accuracy was summarized using cross-validated error statistics and explained variance, and response curves were inspected to verify ecologically plausible relationships between regeneration patterns and key climatic or topographic predictors.

Software environment

All analyses were conducted in R. Community-ecology workflows, including ordination, dissimilarity-based testing and indicator-species analysis, were implemented primarily using functions described in the ecological literature underlying widely adopted multivariate methods (ter Braak 1986; Anderson 2001; Dufrêne and Legendre 1997). Results from selected multivariate classifications and indicator-species procedures were independently verified in PC-ORD version 5 to confirm analytical consistency. Spreadsheet software was used solely for preliminary data curation and quality-control screening prior to statistical analysis.

Reproducibility and data stewardship

Reproducibility was ensured through systematic archiving of raw field observations, spatial environmental layers, curated analysis tables and derived outputs. All distance measures, ordination settings, permutation schemes and machine-learning hyperparameters were documented in metadata files accompanying the archived datasets. Intermediate products, including ordination scores, regeneration prediction surfaces, cross-validation partitions and variable-importance tables were retained to permit independent replication of all analytical steps.

Upon submission, data and code supporting the results will be deposited in a public repository with a digital object identifier in accordance with Journal of Vegetation Science data-sharing policy, with anonymized access provided during double-blind peer review.

## Results

Community composition and ordination

Non-metric multidimensional scaling (NMDS) revealed clear compositional gradients across forest types and vegetation strata (Figure 1). Stress values were uniformly low (trees = 0.0001; shrubs = 0.070; herbs = 0.001; regeneration = 0.0006), indicating excellent two-dimensional representation of Bray–Curtis dissimilarities (Appendix S3).

Shrub and herb assemblages displayed the greatest dispersion in ordination space and the strongest alignment with fitted climatic vectors, particularly temperature, evapotranspiration and precipitation (Figure 1B–C). Tree assemblages were comparatively compressed along NMDS axes (Figure 1A), indicating lower turnover across forest types. Regeneration plots exhibited broad scatter, suggesting heterogeneous recruitment patterns along environmental gradients (Figure 1D).

These stratified responses mirror patterns previously documented along elevational gradients in Bhutanese forests, where understorey layers show stronger compositional turnover than canopy trees (Wangda & Ohsawa 2006a).

Community differences among forest types

Community composition differed significantly among forest types across all vegetation strata (Table 2). Tree assemblages exhibited modest but statistically significant separation (PERMANOVA R² = 0.031, F = 3.38, p = 0.001), with homogeneous dispersions (betadisper p = 0.291), indicating that group differences reflected centroid shifts rather than unequal within-group variability (Appendix S2).

Shrub communities showed the strongest differentiation among forest types (R² = 0.050, F = 5.05, p = 0.001), although dispersions were heterogeneous (p = 0.001), suggesting that both location and spread contributed to observed differences. Herb and regeneration assemblages also differed significantly (R² = 0.017 and 0.021, respectively; both p = 0.001), but both strata exhibited heterogeneous dispersions (Table 2).

The greater sensitivity of shrub and herb layers relative to trees is consistent with Himalayan studies showing that microclimate and topography exert stronger filtering effects on understorey communities (Wangda & Ohsawa 2006a; Grierson & Long 1983–2001). Because shrub and herb strata exhibited heterogeneous multivariate dispersions (Table 2; full outputs in Appendix S2), significant PERMANOVA results in these layers likely reflect a combination of centroid shifts and differences in within-group variability. In contrast, homogeneous dispersions for trees and regeneration indicate that compositional differences among forest types in these strata primarily represent shifts in group centroids.

Species–environment relationships

Canonical correspondence analysis revealed that selected environmental variables—aspect, evapotranspiration, latitude, longitude and slope—explained a small but statistically significant fraction of floristic variation in trees (3.2%, p = 0.008) and shrubs (3.8%, p = 0.001; Table 3; Figure 4). For herbs and regeneration, constrained models explained similar proportions of inertia (3.4%) but were not significant at α = 0.05 (p = 0.125 and 0.076, respectively) (Appendix S9).

CCA biplots illustrated contrasting environmental controls among strata (Figure 4). Tree communities aligned primarily with slope and aspect gradients, shrub assemblages were most strongly oriented toward evapotranspiration and latitudinal position, while herbaceous vegetation responded to combined slope–climate axes. Regeneration patterns were structured along gradients of evapotranspiration and aspect, suggesting climatically mediated recruitment filters.

The low proportion of constrained inertia across all strata indicates that substantial compositional variation is driven by fine-scale heterogeneity and unmeasured microhabitat factors, consistent with findings from Bhutanese mountain forests characterized by rugged terrain and localized disturbance mosaics (Wangda & Ohsawa 2006a).

Diversity patterns

Alpha diversity differed markedly among vegetation strata (Table 4; Figure 2). Trees exhibited the highest mean species richness (5.30 ± 2.57 species per plot) and Shannon diversity (1.391 ± 0.595), followed by shrubs (richness = 4.77 ± 3.43; Shannon = 1.063 ± 0.706), regeneration (richness = 2.00 ± 1.26; Shannon = 0.443 ± 0.499) and herbs (richness = 1.79 ± 1.32; Shannon = 0.325 ± 0.451). Pielou’s evenness was highest for trees (0.903) and lowest for herbs (0.804).

Species accumulation curves approached asymptotes most rapidly for shrubs and regeneration, whereas trees and herbs continued to increase steadily with sampling effort, indicating incomplete saturation of the regional species pool in these strata (Figure 3). Such patterns are consistent with Bhutanese broadleaved forests where high canopy and herb-layer richness persist across large elevational ranges (Wangda & Ohsawa 2006a, 2006c). Continued species accumulation in tree and herb strata suggests that additional sampling would likely yield further taxa, particularly rare canopy species and ephemeral understorey herbs, indicating exceptionally high regional diversity along the gradient.

Species richness varied along the elevational gradient for all strata (Figure 6). Shrubs displayed a unimodal mid-elevation peak, whereas trees showed comparatively stable richness across the sampled range, and herbs and regeneration exhibited weaker, irregular trends. These responses align with Himalayan studies—including Bhutan—demonstrating mid-elevation diversity maxima in woody layers and high small-scale heterogeneity in understorey communities (Wangda & Ohsawa 2006; Grytnes & Vetaas 2002).

Beta diversity (Whittaker’s β) was highest for herbs (75.04), followed by regeneration (54.63), trees (41.86) and shrubs (23.89), indicating pronounced species turnover in the herb layer relative to the regional species pool.

Indicator species

Indicator-species analysis detected significant associations with elevational classes across all strata (Table 5). Shrubs contained the largest proportion of indicator taxa (15 of 101 species; 14.9%), followed by herbs (10 of 134; 7.5%), regeneration (8 of 109; 7.3%) and trees (10 of 221; 4.5%) ( Appendix S4).

Among canopy trees, Schima wallichii and Castanopsis indica were characteristic of low- to mid-elevation forests, whereas Alnus nepalensis was associated with higher elevations. These patterns accord with floristic zonation documented in Bhutanese mountain forests, where evergreen broadleaved species dominate lower belts and pioneer or cool-adapted taxa become more frequent upslope (Wangda & Ohsawa 2006; Grierson & Long (1983–2001)).

Regeneration Modelling

Random forest models outperformed gradient boosting models for predicting regeneration richness (Table 6; Figure 5). Random forest achieved a modest but positive cross-validated coefficient of determination (R² = 0.142 ± 0.040) with a root mean square error of 1.165 ± 0.182, whereas gradient boosting showed negative explanatory power (R² = −0.009 ± 0.096) and higher prediction error (RMSE = 1.261 ± 0.192) (Appendix S5)

Variable-importance rankings from the random forest model indicated that shrub-layer attributes, particularly Shannon diversity and species richness, were the strongest predictors of regeneration richness, followed by temperature, elevation and evapotranspiration (Figure 5). Spatial coordinates and terrain aspect contributed comparatively little explanatory power ( Appendix S6).

The dominance of shrub-layer structure and climate-related variables suggests that microsite filtering and competitive or facilitative interactions in the understorey exert stronger controls on recruitment than coarse spatial position alone. Similar links between regeneration and local stand structure have been reported for Bhutanese montane forests across elevational gradients (Wangda & Ohsawa 2006c), although few published studies have applied machine-learning approaches to regeneration dynamics within Bhutan.

The relatively low explanatory power of all models indicates that important drivers—such as canopy openness, disturbance history, soil properties or fine-scale moisture regimes—were not fully captured by the available predictors, a common limitation in forest-regeneration modelling in complex mountain terrain (Elith, Leathwick & Hastie 2008).

## DISCUSSION

Stratified community turnover along elevational gradients.

Our analyses revealed pronounced vertical stratification in community turnover, with understorey assemblages (shrubs and herbs) responding more strongly to forest-type and elevational gradients than canopy trees. This pattern mirrors observations from other Himalayan forests where understorey communities closely track microclimatic and edaphic variability, whereas long-lived canopy trees integrate conditions over broader temporal and spatial scales (Wangda & Ohsawa 2006a; Grytnes & Vetaas 2002). In Bhutan, for instance, Wangda and Ohsawa (2006) found steep elevational turnover in shrub and herb layers across broadleaved forests while canopy composition remained comparatively stable, consistent with the compressed tree NMDS configuration observed here. Significant PERMANOVA results across all strata confirm that forest type imposes a consistent compositional filter along the gradient, even when effect sizes are small. In our data, forest type explained only about 1.7–5.0% of the variation in species composition (R² = 0.017–0.050, p = 0.001). Although modest, such values indicate non-random differences given the extremely high beta diversity in these forests. Similar Himalayan studies likewise report significant yet low R² values, reflecting the overwhelming influence of fine-scale heterogeneity and dispersal in montane communities (Acharya et al. 2011; Carpenter 2005). In our plots, shrubs and herbs showed greater between-plot dispersion than trees, likely due to patchy responses to slope position, moisture pockets, and disturbance legacies that vary sharply across Bhutan’s rugged terrain (Wangda & Ohsawa 2006). By contrast, tree assemblages were more homogenously dispersed, suggesting that forest-type differentiation in the canopy involves shifts in community centroids (dominant species) rather than broad increases in within-type variation. Such a pattern – subtle but consistent compositional shifts in overstorey vs. more erratic, microhabitat-driven changes in the understorey – is consistent with montane forests across the Himalaya, where overstorey composition is constrained by broad climatic envelopes while understorey communities respond flexibly to local topography and disturbance (Ohsawa 1995; Grytnes & Vetaas 2002).

Environmental drivers and scale of control.

Direct gradient analyses (CCA) showed that aspect, slope, evapotranspiration, and spatial position together explained only a small fraction of floristic variation (≈3–4% for trees and shrubs), even where correlations were statistically significant. Such low constrained inertia is common in steep mountain systems, where unmeasured microtopographic factors – canopy gaps, soil depth, fine-scale moisture, and disturbance history – often dominate local community assembly, overwhelming the effects of macroclimatic gradients (Grytnes & Vetaas 2002; Wangda & Ohsawa 2006). Bhutanese forests in particular are characterized by abrupt changes in slope, exposure, and substrate over tens of meters, producing high species turnover within the nominal elevational belts (Grierson & Long (1983–2001)–2001; Wangda & Ohsawa 2006). The contrasting environmental orientations of different strata in our study reinforce this interpretation. Tree communities aligned primarily with slope and aspect, consistent with long-term geomorphic controls on soil stability and moisture availability. In contrast, shrubs and the regeneration layer were more strongly associated with factors like evapotranspiration and latitude (northing), suggesting that early life stages are especially sensitive to thermal and water-balance constraints. Herbaceous assemblages responded to a combination of slope and climate axes, reflecting their rapid turnover and strong coupling to idiosyncratic microsite conditions. Such decoupling between canopy and understorey responses has also been reported in other Himalayan gradients, where herb-layer distributions can be driven by localized canopy openings and moisture pockets rather than elevation per se (Grytnes & Vetaas 2002). Overall, our results underscore that broad macro-environmental gradients exert relatively weak control on community composition in these montane forests compared to the dominant influence of fine-scale habitat heterogeneity.

Diversity patterns and beta-diversity.

Marked differences in alpha diversity among strata further highlight the vertically structured nature of Himalayan broadleaved forests. Tree layers in our study maintained high species richness and evenness across the gradient, reflecting the coexistence of multiple canopy dominants in these unmanaged stands – a feature repeatedly documented in Bhutan’s warm and cool broadleaved forests (Grierson & Long (1983–2001)–2001; Wangda & Ohsawa 2006). Shrub richness peaked at mid-elevations, consistent with many Himalayan studies that find unimodal diversity curves in the woody understorey around intermediate altitudes where moisture, temperature, and structural complexity are jointly optimized (Grytnes & Vetaas 2002). By contrast, herbs and regeneration showed weak or irregular elevational trends in richness, coupled with exceptionally high beta diversity in the herb layer. This implies small-scale environmental mosaics, rather than any smooth elevational forcing, structure ground-layer communities. Indeed, high herb-layer beta diversity is widely reported in Himalayan forests and alpine systems, where aspect, litter depth, and gap dynamics generate sharp species turnover over very short distances (Grytnes & Vetaas 2002). The fact that our species accumulation curves did not fully asymptote for trees and herbs even after 221 plots suggests that a considerable portion of the regional species pool remained unsampled in these strata – reinforcing the extraordinary floristic heterogeneity and fine-grained beta diversity of Bhutan’s montane landscapes.

Indicator species and floristic transitions.

Indicator species analysis revealed relatively few significant canopy indicators but a greater number of shrub and herb specialists, underscoring finer niche partitioning among understorey taxa along the gradient. The associations of Schima wallichii and Castanopsis indica with low- to mid-elevations, and Alnus nepalensis with higher elevations, align closely with Bhutanese floristic syntheses: evergreen broadleaved dominants characterize lower belts, whereas cold-tolerant or disturbance-adapted taxa (including pioneers like Alnus) become increasingly prominent upslope (Grierson & Long (1983–2001)–2001; Wangda & Ohsawa 2006). These patterns support the view that Himalayan forest zonation is not defined by sharp, discrete boundaries, but rather by overlapping species distributions structured by gradual shifts in temperature, moisture, and disturbance regimes (Ohsawa 1995). The paucity of indicator tree species in our analysis suggests that many canopy species have broad ecological amplitudes across the gradient, whereas shrubs and herbs serve as more sensitive markers of environmental transitions within each elevational zone.

Regeneration dynamics and model interpretation.

Our machine-learning models provided additional insight into regeneration controls, with shrub-layer diversity and richness emerging as stronger predictors of tree seedling richness than macroclimatic variables or spatial location. This finding points to the primacy of neighborhood interactions and microsite filtering during early demographic stages. Dense or diverse shrub understories may facilitate tree recruitment by moderating microclimate extremes (reducing heat and evaporative stress) or protecting seedlings from herbivory and physical disturbance; conversely, shrubs can also suppress regeneration via competition for light and soil moisture, depending on local conditions. The importance of understorey structure in shaping tree regeneration echoes the conclusions of Wangda and Ohsawa (2006), who qualitatively noted that sites with well-developed shrub layers in Bhutan tended to support greater tree recruitment. Quantitative modeling of regeneration drivers, however, remains rare in the eastern Himalaya, making our results a novel contribution. Notably, the explanatory power of our models was modest: even the best random forest model achieved a cross-validated R² of only ~0.14 (14%)[5]. Such modest predictive strength suggests that key drivers – for example, canopy gap openness, soil characteristics, disturbance history, or fine-scale moisture availability – were not captured by our set of environmental predictors. In mountainous, gap-dynamic forests, this outcome is expected: regeneration is often governed by stochastic gap formation and microsite variability rather than by smooth climatic gradients[6]. Indeed, many of the factors influencing seedling establishment (e.g. episodic treefall gaps, pathogen outbreaks, animal dispersal events) are inherently patchy or random. Thus, a low R² does not imply that regeneration is unstructured, but rather that it is driven by contingent local events and unmeasured variables. Our use of machine-learning was therefore intended as an exploratory approach to identify potential drivers, not to produce a deterministic predictive model of regeneration. The comparatively better performance of random forest over gradient boosting in our case further suggests complex, non-linear interactions among predictors that are difficult to capture without additional structural and edaphic variables. Future studies incorporating direct measures of canopy gap fraction, soil nutrients, and disturbance metrics could improve prediction of regeneration patterns.

Limitations and novelty of the study.

Several caveats merit consideration when interpreting our findings. First, our climate variables were derived from interpolated surfaces (WorldClim, etc.) that may not fully capture plot-level conditions in steep terrain; fine-scale temperature and moisture regimes likely deviate from these macroclimatic estimates. Second, as noted above, the heterogeneity in shrub, herb, and regeneration communities means that part of the compositional differentiation we detected reflects within-type variability rather than clear shifts in community centroids alone. Third, our regeneration data provide only a snapshot in time and may underestimate longer-term recruitment dynamics, especially for slow-growing montane tree species that establish episodically. Despite these constraints, this study represents one of the most comprehensive multi-stratum assessments of vegetation structure and regeneration along an elevational gradient in Bhutan to date. To our knowledge, no prior study in the eastern Himalaya has simultaneously examined trees, shrubs, herbs, and the regeneration layer across such a climatic gradient, highlighting the novelty of our integrative approach. The results emphasise that Himalayan Forest assembly is governed by strong vertical stratification, pervasive fine-scale heterogeneity, and neighborhood-scale interactions that cannot be inferred from macroclimatic patterns alone. From a conservation perspective, the findings underscore those unmanaged forests in Bhutan harbor exceptionally high understorey turnover and complex, gap-driven regeneration dynamics. Maintaining microhabitat heterogeneity and natural disturbance regimes across elevations – especially in mid-elevation broadleaved forests that emerge as centers of shrub diversity and floristic transition – will be critical for sustaining biodiversity and regeneration processes under environmental change in the eastern Himalaya.

## Conclusions

Plant communities along the Sarpang elevational gradient are consistently structured by forest type across all vegetation strata, yet the strength and drivers of this structuring differ markedly among canopy, understorey and regeneration layers. Shrub and herb assemblages exhibited the strongest compositional turnover and the highest beta diversity, indicating pronounced sensitivity to fine-scale environmental heterogeneity, whereas tree communities were comparatively stable across forest types and elevations. Macro-environmental predictors explained only a small fraction of floristic variation, even where statistically significant for woody strata, emphasising the overriding influence of microsite conditions, neighbourhood interactions and disturbance legacies in Himalayan mountain forests.

Diversity patterns further underscore this vertical differentiation. Trees and shrubs maintained high local richness and evenness, with shrubs showing a mid-elevation peak characteristic of eastern Himalayan systems, while herbaceous and regeneration layers were characterised by irregular elevational trends and exceptionally high turnover. Indicator species reinforced classical Bhutanese zonation patterns, with evergreen broadleaved taxa dominating lower belts and pioneer or cool-adapted species increasing upslope, yet also revealed substantial within-belt heterogeneity, particularly in the understorey.

Regeneration modelling highlighted the central role of shrub-layer structure in shaping recruitment, with shrub diversity and richness emerging as stronger predictors than spatial position alone, alongside temperature, elevation and evapotranspiration. The modest predictive performance of all models indicates that key demographic controls—such as canopy openness, soil properties and fine-scale moisture remain unresolved, pointing to priority directions for future field-based and experimental work.

Taken together, these results provide one of the most comprehensive multi-stratum assessments of vegetation organisation along an elevational gradient in south-central Bhutan. They demonstrate that Himalayan Forest assembly cannot be inferred solely from canopy patterns or broad climatic gradients but instead reflects strong vertical stratification and pervasive fine-scale heterogeneity. This baseline offers a critical reference for long-term monitoring and for evaluating how Bhutan’s unmanaged broadleaved forests may reorganise under shifting climatic and disturbance regimes across the eastern Himalaya. Integrating functional trait data—such as specific leaf area, wood density, seed mass and shade tolerance—would permit direct tests of environmental filtering and neighbourhood interactions along the gradient. Experimental approaches, including gap-creation trials and seedling transplant experiments across elevation bands, would further clarify causal mechanisms controlling regeneration success and vertical stratification. Future research combining functional trait analyses, repeated seasonal sampling and manipulative regeneration experiments will be essential for disentangling climatic, edaphic and neighbourhood drivers of recruitment and for forecasting long-term reorganisation of Himalayan forests under climate change.

Data availability statement

All R scripts used for data preparation, multivariate analyses, machine-learning modelling and figure generation will be deposited alongside the curated datasets in the public repository associated with this study. A permanent DOI will be provided upon acceptance in accordance with Journal of Vegetation Science data-sharing requirements.

## References

Abrams, M., Crippen, R., & Fujisada, H. (2020). ASTER Global Digital Elevation Model (GDEM) and ASTER Global Water Body Dataset (ASTWBD). Remote Sensing, 12, 1156. https://doi.org/10.3390/rs12071156

Anderson, M. J. (2001). A new method for non‐parametric multivariate analysis of variance. Austral Ecology, 26, 32–46. https://doi.org/10.1111/j.1442-9993.2001.01070.pp.x

Bookhagen, B., & Burbank, D. W. (2010). Toward a complete Himalayan hydrological budget: Spatiotemporal distribution of snowmelt and rainfall and their impact on river discharge. Journal of Geophysical Research: Earth Surface, 115, F03019. https://doi.org/10.1029/2009JF001426

Bray, J. R., & Curtis, J. T. (1957). An ordination of the upland forest communities of southern Wisconsin. Ecological Monographs, 27, 325–349. https://doi.org/10.2307/1942268

Breiman, L. (2001). Random forests. Machine Learning, 45, 5–32. https://doi.org/10.1023/A:1010933404324

Chen, T., & Guestrin, C. (2016). XGBoost: A scalable tree boosting system. In Proceedings of the 22nd ACM SIGKDD International Conference on Knowledge Discovery and Data Mining (pp. 785–794). https://doi.org/10.1145/2939672.2939785

Clark, J. S., Bell, D., Chu, C., Courbaud, B., Dietze, M., Hersh, M., … Wyckoff, P. (2014). High‐dimensional coexistence based on individual variation: A synthesis of evidence. Ecological Monographs, 84, 3–42. https://doi.org/10.1890/13-0209.1

Dufrêne, M., & Legendre, P. (1997). Species assemblages and indicator species: The need for a flexible asymmetrical approach. Ecological Monographs, 67, 345–366. https://doi.org/10.2307/2963459

Elith, J., Leathwick, J. R., & Hastie, T. (2008). A working guide to boosted regression trees. Journal of Animal Ecology, 77, 802–813. https://doi.org/10.1111/j.1365-2656.2008.01390.x

Gilliam, F. S. (2007). The ecological significance of the herbaceous layer in temperate forest ecosystems. BioScience, 57, 845–858. https://doi.org/10.1641/B571007

Grierson, A. J. C., & Long, D. G. (1983–2001). Flora of Bhutan (Vols. 1–3). Royal Botanic Garden Edinburgh & Royal Government of Bhutan.

Grytnes, J.-A., & Vetaas, O. R. (2002). Species richness and altitude: A comparison between null models and interpolated plant species richness along the Himalayan altitudinal gradient, Nepal. The American Naturalist, 159, 294–304. https://doi.org/10.1086/338542

Körner, C. (2007). The use of “altitude” in ecological research. Trends in Ecology & Evolution, 22, 569–574. https://doi.org/10.1016/j.tree.2007.09.006

Kraft, N. J. B., Godoy, O., & Levine, J. M. (2015). Plant functional traits and the multidimensional nature of species coexistence. Proceedings of the National Academy of Sciences of the United States of America, 112, 797–802. https://doi.org/10.1073/pnas.1413650112

Kruskal, J. B. (1964). Nonmetric multidimensional scaling: A numerical method. Psychometrika, 29, 115–129. https://doi.org/10.1007/BF02289694

Lenoir, J., Gégout, J.-C., Marquet, P. A., de Ruffray, P., & Brisse, H. (2008). A significant upward shift in plant species optimum elevation during the twentieth century. Science, 320, 1768–1771. https://doi.org/10.1126/science.1156831

Lomolino, M. V. (2001). Elevation gradients of species density: Historical and prospective views. Global Ecology and Biogeography, 10, 3–13. https://doi.org/10.1046/j.1466-822X.2001.00229.x

McCain, C. M. (2009). Global analysis of bird elevational diversity. Global Ecology and Biogeography, 18, 346–360. https://doi.org/10.1111/j.1466-8238.2008.00443.x

Myers, N., Mittermeier, R. A., Mittermeier, C. G., da Fonseca, G. A. B., & Kent, J. (2000). Biodiversity hotspots for conservation priorities. Nature, 403, 853–858. https://doi.org/10.1038/35002501

Ohsawa, M. (1995). Latitudinal pattern of mountain vegetation zonation in eastern Asia and its relation to climate. Vegetatio, 121, 3–10. https://doi.org/10.1007/BF00044667

Pielou, E. C. (1966). The measurement of diversity in different types of biological collections. Journal of Theoretical Biology, 13, 131–144. https://doi.org/10.1016/0022-5193(66)90013-0

Qian, H., Ricklefs, R. E., & White, P. S. (2005). Beta diversity of angiosperms in temperate floras of eastern Asia and eastern North America. Ecology Letters, 8, 15–22. https://doi.org/10.1111/j.1461-0248.2004.00682.x

Rahbek, C. (2005). The role of spatial scale and the perception of large‐scale species‐richness patterns. Ecology Letters, 8, 224–239. https://doi.org/10.1111/j.1461-0248.2004.00701.x

Shannon, C. E. (1948). A mathematical theory of communication. Bell System Technical Journal, 27, 379–423. https://doi.org/10.1002/j.1538-7305.1948.tb01338.x

Simpson, E. H. (1949). Measurement of diversity. Nature, 163, 688. https://doi.org/10.1038/163688a0

Siefert, A., Ravenscroft, C., Weiser, M. D., & Cleland, E. E. (2013). Functional beta‐diversity patterns reveal deterministic community assembly processes in eastern North American trees. Global Ecology and Biogeography, 22, 682–691. https://doi.org/10.1111/geb.12030

Sundqvist, M. K., Sanders, N. J., & Wardle, D. A. (2013). Community and ecosystem responses to elevational gradients. Annual Review of Ecology, Evolution, and Systematics, 44, 261–280. https://doi.org/10.1146/annurev-ecolsys-110512-135750

ter Braak, C. J. F. (1986). Canonical correspondence analysis: A new eigenvector technique for multivariate direct gradient analysis. Ecology, 67, 1167–1179. https://doi.org/10.2307/1938672

Wangda, P., & Ohsawa, M. (2006a). Structure and pattern of the forest vegetation along the altitudinal gradient in the dry valley of the Bhutan Himalaya. Journal of Vegetation Science, 17, 409–418. https://doi.org/10.1111/j.1654-1103.2006.tb02461.x

Wangda, P., & Ohsawa, M. (2006b). Gradational forest change along the climatically dry valley slopes of Bhutan in the midst of humid eastern Himalaya. Plant Ecology, 186, 109–128. https://doi.org/10.1007/s11258-006-9116-0

Wangda, P., & Ohsawa, M. (2006c). Structure and regeneration dynamics of dominant tree species along an altitudinal gradient in dry valley slopes of the Bhutan Himalaya. Forest Ecology and Management, 230, 136–150. https://doi.org/10.1016/j.foreco.2006.04.027

Figure captions

Figure 1.

Non-metric multidimensional scaling (NMDS) ordinations of vegetation plots for four strata: (A) trees, (B) shrubs, (C) herbs and (D) regeneration. Points represent sample plots coloured by forest type; polygons delineate convex hulls for each forest type. Red arrows indicate fitted environmental vectors significant at p < 0.05 based on 999 permutations. Stress values are shown for each ordination.

Figure 2.

Alpha-diversity metrics across vegetation strata. Panels show (A) species richness, (B) Shannon diversity (H′), (C) Simpson diversity (1 – D) and (D) Pielou’s evenness (J). Boxplots depict medians and interquartile ranges; points represent individual plots.

Figure 3.

Sample-based species accumulation curves for herbs, regeneration, shrubs and trees. Solid lines indicate mean richness across random permutations; shaded envelopes show 95% confidence intervals.

Figure 4.

Canonical correspondence analysis (CCA) biplots for (A) trees, (B) shrubs, (C) herbs and (D) regeneration. Points represent plots and arrows denote environmental predictors retained after variance inflation factor screening (threshold = 10). Arrow length indicates the strength of correlations with ordination axes.

Figure 5.

Random-forest variable-importance ranking for predictors of regeneration richness. Bars show percentage increase in mean squared error (%IncMSE) following permutation of each variable during five-fold cross-validation. Higher values indicate stronger influence on predictive accuracy.

Figure 6.

Variation in plot-level species richness along the elevational gradient for herbs, regeneration, shrubs and trees. Curves represent locally weighted regression fits with 95% confidence bands.

Table captions

Table 2.

Results of permutational multivariate analysis of variance (PERMANOVA) and tests of multivariate dispersion for vegetation strata across forest types. p-values are based on 999 permutations.

Table 3.

Summary of canonical correspondence analyses by vegetation stratum. Environmental variables were selected following iterative variance inflation factor screening (threshold = 10). Significance of constrained inertia was assessed using 999 permutations.

Table 4.

Mean alpha-diversity metrics by vegetation stratum. Values are mean ± standard deviation.

Table 5.

Summary of indicator-species analysis by stratum. Groups were defined by elevational class (low, mid and high). Significance was assessed using 999 permutations at α = 0.05.

Table 6.

Cross-validated performance of machine-learning models predicting regeneration richness across five folds. R² denotes coefficient of determination; RMSE, root mean square error; MAE, mean absolute error. Full fold-level output is provided in Appendix S7.

Supporting information

Appendix S1. TableS1_VIF_all_strata.csv — Variance inflation factor screening by stratum.

Appendix S2. TableS2_PERMANOVA_full.csv — Full PERMANOVA and dispersion outputs.

Appendix S3. TableS3_envfit_all.csv — Envfit results for all strata.

Appendix S4. TableS4_indicator_species_full.csv — Indicator species list.

Appendix S5. TableS5_ML_parameters.csv — Machine-learning model parameters.

Appendix S6. TableS6_variable_importance.csv — Variable importance outputs.

Appendix S7. TableS7_CV_fold_results.csv — Cross-validation fold results.

Appendix S8. TableS8_diversity_correlations.csv — Diversity correlation matrix.

Appendix S9. TableS9_beta_diversity.csv — Beta diversity metrics.

Appendix S10. TableS10_matrix_diagnostics.csv — Community matrix diagnostics.
