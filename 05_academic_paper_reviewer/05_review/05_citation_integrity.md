# 05. Citation Integrity Audit

## Unsupported or Weakly Supported Claims

1. **Major** - Discussion claim of novelty ("one of the most comprehensive" / "no prior study ...") is not directly substantiated with systematic evidence.  
Location: Discussion `## Limitations and novelty of the study.`  
Why it matters: Novelty claims require explicit comparative support.

2. **Major** - WorldClim is mentioned in limitations without a corresponding in-text citation or reference entry linked to that statement.  
Location: Discussion `## Limitations and novelty of the study.`  
Why it matters: Methodological caveats should be properly sourced when data products are named.

3. **Major** - Dorji et al. (2025) climate dataset is cited in Methods, but corresponding full reference is not visible in the extracted reference list.  
Location: `## Environmental variables`; `# References`.  
Why it matters: Missing bibliographic entry impairs traceability of key predictor dataset.

## Missing Foundational or Recent Literature

1. **Minor** - If ML interpretation is emphasized, references on permutation-importance instability and model-agnostic uncertainty in ecological prediction could strengthen methodological framing.  
Location: `## Regeneration dynamics and predictive modelling`; Discussion regeneration section.  
Why it matters: Helps prevent over-interpretation of weak predictive models.

## Inconsistencies

1. **Major** - Citation style is internally mixed relative to stated Chicago author-date expectation (e.g., punctuation/ampersands/parenthetical style varies).  
Location: `# References` and in-text citations.  
Why it matters: Stylistic inconsistency can create copyediting burden and occasional ambiguity.

2. **Minor** - Capitalization/format inconsistencies in taxa names in supplementary indicator table suggest possible nomenclature inconsistencies.  
Location: `04_supplementary/TableS4_indicator_species_full.csv` (examples: apparent spelling anomalies).  
Why it matters: Citation-integrity includes accurate scientific naming and source traceability.

## Duplicates or Suspicious Entries

1. **Minor** - Two Wangda & Ohsawa 2006 entries (2006a/2006b) are plausible, but one citation block in references is formatted atypically compared with other entries.  
Location: `# References` (Wangda entries).  
Why it matters: Requires copyediting check to avoid bibliographic parsing errors.

2. **Minor** - Anderson reference includes unusual DOI suffix formatting (`pp.x`), which should be validated.  
Location: `# References` (Anderson 2001).  
Why it matters: Potential DOI parsing/cross-linking issue.

## Severity-Tagged Fix List

1. **Major** - Add complete bibliographic entry for Dorji et al. (2025) dataset and ensure DOI resolves.
2. **Major** - Add explicit citation for WorldClim mention or remove named product if not used.
3. **Major** - Substantiate novelty claims with direct comparative citations or temper wording.
4. **Major** - Harmonize all references and in-text citations to one consistent author-date style.
5. **Minor** - Verify and correct suspicious taxa spellings in supplementary indicator table.
6. **Minor** - Validate DOI strings/formatting for all references before submission.

I cannot confirm this from the manuscript: whether all in-text citations have matching reference entries in the untruncated source file, because only an extracted manuscript representation was audited.
