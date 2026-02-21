# 01. Journal Guideline Compliance Audit

Journal: Journal of Vegetation Science (JVS)  
Guideline URL: https://submission.wiley.com/journal/jvs  
Source used for clauses: `JVS_Author_Guidelines.md`

## Checklist

| Requirement | Status | Manuscript Location | Comment |
|---|---|---|---|
| Double-anonymized submission with separate title page | PASS | `00_title_page/title_page.md`; `01_main_text/MAIN_TEXT.docx` | Separate title page and main text files are provided. |
| Main text includes required scientific sections (Abstract/Introduction/Methods/Results/Discussion/References) | PASS | `01_main_text/MAIN_TEXT_extracted.md` (`# Abstract` to `# References`) | Required structure is present. |
| Research Article abstract uses named sections (Questions/Location/Methods/Results/Conclusions) | PASS | `# Abstract` | Sectioned abstract present in correct structure. |
| Abstract length <= 300 words | PASS | `# Abstract` | Appears within limit. |
| 8-10 keywords | PASS | `# Abstract` (Keywords line) | 10 keywords provided. |
| Main text must be line-numbered for submission | FAIL | `01_main_text/MAIN_TEXT.docx` (`word/settings.xml`: `lnNumType not present`) | Line numbering metadata is absent in the DOCX settings. |
| Data availability statement must include repository link/DOI for underlying data; data sharing mandated | FAIL | `00_title_page/title_page.md` (`Data availability statement`) | Statement contains placeholder: "[TODO — INSERT DOI WHEN AVAILABLE]"; no active DOI/repository link supplied. |
| Data/code availability should support verification and replication | PARTIAL | `01_main_text/MAIN_TEXT_extracted.md` (`## Reproducibility and data stewardship`); `04_supplementary/*.csv` | Supplementary outputs are provided, but no public archive DOI and no executable analysis scripts are supplied in submission package. |
| Software and analysis environment described clearly enough to support reproducibility | PARTIAL | `## Software environment` | R and PC-ORD are mentioned, but R version, package versions, and Excel version are missing. |
| Supporting Information is provided and referenced from main text | PASS | `# Supporting information`; Appendix references in Results | S1-S10 are listed and files exist in `04_supplementary`. |
| Taxon nomenclature source and accession date specified | PASS | `## Vegetation data collection` | World Flora Online with accession date is reported. |
| Figures/tables supplied with legends in manuscript | PASS | `# Figure captions`; `# Table captions` | Legends included in main text extract. |

## Top 10 Submission-Blocking Violations

1. **Critical** - Missing line numbering in main manuscript file.  
   Location: `01_main_text/MAIN_TEXT.docx` (DOCX settings).  
   Why it matters: JVS states manuscripts should be line-numbered; missing numbering can trigger technical return before review.  
   Guideline clause: Preparing the Submission -> Formatting ("the text is line-numbered").

2. **Critical** - Data availability statement lacks a functional repository DOI/link.  
   Location: `00_title_page/title_page.md` (`[TODO — INSERT DOI WHEN AVAILABLE]`).  
   Why it matters: JVS mandates data sharing for data-analysis studies and requires a repository link in the statement.  
   Guideline clause: Data availability statement + data sharing policy.

3. **Major** - Code/scripts used for analyses are not publicly archived in the provided package.  
   Location: `01_main_text/MAIN_TEXT_extracted.md` (`## Reproducibility and data stewardship` claims deposit upon submission).  
   Why it matters: Replication of ordination, PERMANOVA, and ML steps is currently not verifiable.  
   Guideline clause: Data sharing policy (program source code/scripts should be publicly archived whenever possible).

4. **Major** - Data availability references internal project paths not available to reviewers.  
   Location: `00_title_page/title_page.md` (mentions `03_analysis/...`).  
   Why it matters: Internal paths are not resolvable as public evidence for review.  
   Guideline clause: Data availability statement should provide repository link.

5. **Major** - Software environment lacks versioned specification (R version and package versions).  
   Location: `## Software environment`.  
   Why it matters: Non-versioned software limits analytical reproducibility and compliance with transparency expectations.  
   Guideline clause: Data/code sufficient to verify analyses (data-sharing policy intent).

6. **Major** - No explicit public citation entry for the final archived dataset/code DOI in references.  
   Location: References + data availability statement.  
   Why it matters: JVS requests repository linkage in statement and citation in references for traceability.  
   Guideline clause: Data availability statement guidance.

7. **Major** - Exact manuscript line references cannot be provided by reviewers due absent line numbering.  
   Location: whole main text file.  
   Why it matters: Hinders peer-review precision and compliance with JVS submission readability requirements.  
   Guideline clause: Formatting expectation (line-numbered text).

8. **Major** - Supporting-information package does not include a narrative reproducibility appendix describing full computational workflow.  
   Location: `04_supplementary/` (CSV outputs only).  
   Why it matters: Outputs alone do not allow method re-execution or parameter auditing.  
   Guideline clause: Data sharing policy (sufficient materials to verify analyses).

9. **Major** - DOI-based public archive is deferred to post-acceptance wording.  
   Location: `## Reproducibility and data stewardship`; title-page DAS.  
   Why it matters: JVS policy frames secure public archiving as a condition for publication and expects clear statement at submission.  
   Guideline clause: Data availability statement and data-sharing mandate.

10. **Minor** - Journal guidelines emphasize conflict/funding declarations during submission workflow; these are present in title page but not mirrored in main text.  
   Location: `00_title_page/title_page.md`.  
   Why it matters: Not a strict initial-format violation, but clear declarations reduce editorial queries.  
   Guideline clause: Editorial Policies (Conflict of Interest; Funding).

## Exact Guideline Clauses Implicated

- Preparing the Submission -> Formatting: manuscript text should be line-numbered.
- Data availability statement: statement is mandatory.
- Data sharing policy: for data-analysis articles, supporting data must be securely archived in a public repository with DOI (or supplementary information where appropriate), and repository link should be provided in the article.
- Data sharing policy: code/scripts should be publicly archived whenever possible.
- Main text/title page file structure requirements: required sections and separate title page.
