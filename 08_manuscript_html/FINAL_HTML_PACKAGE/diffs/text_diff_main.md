# Text Diff: Main Manuscript (LaTeX vs HTML)

**Date:** 2026-02-21  
**Comparison:** `01_manuscript_jvs.tex` vs `FINAL_HTML_PACKAGE/index.html`

---

## Summary

| Metric | Count |
|--------|-------|
| Total sections compared | 25 |
| Exact matches | 25 |
| Minor formatting differences | 0 |
| Content discrepancies | 0 |

---

## Section-by-Section Analysis

### Abstract

**LaTeX:**
```
\textbf{Questions:} Understanding how plant communities vary along elevation...
\textbf{Location:} Sarpang District, south-central Bhutan...
\textbf{Methods:} We analysed vegetation data from four strata...
\textbf{Results:} Community composition differed among forest types...
\textbf{Conclusions:} Forest types impose a statistically detectable...
```

**HTML:**
```html
<p class="abstract-text"><strong>Questions:</strong> Understanding how plant communities vary along elevation...</p>
<p class="abstract-text"><strong>Location:</strong> Sarpang District, south-central Bhutan...</p>
<p class="abstract-text"><strong>Methods:</strong> We analysed vegetation data from four strata...</p>
<p class="abstract-text"><strong>Results:</strong> Community composition differed among forest types...</p>
<p class="abstract-text"><strong>Conclusions:</strong> Forest types impose a statistically detectable...</p>
```

**Status:** ✅ Content match (formatting conversion only)

---

### Introduction (Section 1)

**Comparison:** Full paragraph-by-paragraph comparison

| Paragraph | LaTeX | HTML | Status |
|-----------|-------|------|--------|
| 1 | Elevational gradients constitute... | Elevational gradients constitute... | ✅ Match |
| 2 | The eastern Himalaya represents... | The eastern Himalaya represents... | ✅ Match |
| 3 | Here, we present a multi-stratum... | Here, we present a multi-stratum... | ✅ Match |

**Notes:** All citations preserved with correct anchor mappings.

---

### Methods (Section 2)

| Subsection | Status | Notes |
|------------|--------|-------|
| 2.1 Study Area | ✅ Match | Figure 1 reference preserved |
| 2.2 Sampling Design | ✅ Match | 220 plots confirmed |
| 2.3 Vegetation Data Collection | ✅ Match | DBH protocols preserved |
| 2.4 Environmental Variables | ✅ Match | DOI link preserved |
| 2.5 Data Preparation | ✅ Match | Diversity indices preserved |
| 2.6 Multivariate Community Analyses | ✅ Match | NMDS, CCA, PERMANOVA details |
| 2.7 Regeneration Dynamics | ✅ Match | RF, XGBoost parameters |
| 2.8 Software Environment | ✅ Match | R, PC-ORD mentioned |
| 2.9 Reproducibility | ✅ Match | Data availability statement |

---

### Results (Section 3)

| Subsection | Status | Key Statistics Verified |
|------------|--------|------------------------|
| 3.1 Community Composition | ✅ Match | Stress: 0.0001, 0.070, 0.001, 0.0006 |
| 3.2 Community Differences | ✅ Match | R² = 0.031, 0.050, 0.017, 0.021 |
| 3.3 Species-Environment | ✅ Match | 3.2%, 3.8%, 3.4%, 3.4% |
| 3.4 Diversity Patterns | ✅ Match | 5.30 ± 2.57, 1.391 ± 0.595 |
| 3.5 Indicator Species | ✅ Match | 10, 15, 10, 8 indicators |
| 3.6 Regeneration Modelling | ✅ Match | R² = 0.142 ± 0.040 |

---

### Discussion (Section 4)

| Subsection | Status |
|------------|--------|
| 4.1 Stratified Community Turnover | ✅ Match |
| 4.2 Environmental Drivers | ✅ Match |
| 4.3 Diversity Patterns | ✅ Match |
| 4.4 Indicator Species | ✅ Match |
| 4.5 Regeneration Dynamics | ✅ Match |
| 4.6 Limitations | ✅ Match |

---

### Conclusions (Section 5)

**Status:** ✅ Match

All four paragraphs preserved with exact statistical values:
- R² = 0.017–0.050
- 3–4% CCA variation
- R² ≈ 0.14 for regeneration
- 260–1,964 m elevation range

---

## Statistical Values Verification

| Value | LaTeX | HTML | Status |
|-------|-------|------|--------|
| PERMANOVA R² (trees) | 0.031 | 0.031 | ✅ |
| PERMANOVA R² (shrubs) | 0.050 | 0.050 | ✅ |
| PERMANOVA R² (herbs) | 0.017 | 0.017 | ✅ |
| PERMANOVA R² (regen) | 0.021 | 0.021 | ✅ |
| CCA % explained (trees) | 3.2 | 3.2 | ✅ |
| CCA % explained (shrubs) | 3.8 | 3.8 | ✅ |
| Shannon diversity (trees) | 1.391 ± 0.595 | 1.391 ± 0.595 | ✅ |
| RF CV R² | 0.142 ± 0.040 | 0.142 ± 0.040 | ✅ |
| RF CV RMSE | 1.165 ± 0.182 | 1.165 ± 0.182 | ✅ |
| XGBoost CV R² | -0.009 ± 0.096 | -0.009 ± 0.096 | ✅ |

---

## Formatting Conversions (Expected)

| LaTeX | HTML | Status |
|-------|------|--------|
| `\textbf{}` | `<strong>` | ✅ Expected |
| `\textit{}` | `<i>` | ✅ Expected |
| `$R^2$` | R² | ✅ Expected |
| `$\alpha$` | α | ✅ Expected |
| `$\approx$` | ≈ | ✅ Expected |
| `\citep{}` | (Author, Year) | ✅ Expected |
| `\citet{}` | Author (Year) | ✅ Expected |
| `&` | `&amp;` | ✅ Expected (HTML entity) |
| `≤` | `&le;` or ≤ | ✅ Expected |
| `≥` | `&ge;` or ≥ | ✅ Expected |

---

## Conclusion

**No content discrepancies detected.** All differences are expected formatting conversions from LaTeX to HTML. Scientific content, statistical values, and citations are preserved exactly.
