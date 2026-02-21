# Journal of Vegetation Science — Submission Templates

## Template A: Structured Abstract (Research Article / Synthesis / Methodological)

```markdown
**Questions (or Aims):** [Briefly explain context and motivation, then state 1-3 research questions or aims. Use singular 'Question' or 'Aim' if appropriate.]

**Location:** [Geographic location and study system. Omit this section if not location-specific.]

**Methods:** [Summary of approach, data collection, and analytical methods. May be omitted in Synthesis papers if not applicable.]

**Results:** [Key findings in 2-4 sentences.]

**Conclusions:** [Main take-home messages and broader implications.]

**Total word count:** [Must be ≤300 words]
```

### Example (Research Article):
```markdown
**Questions:** Understanding patterns of species coexistence in temperate forest understories is essential for predicting community responses to environmental change. We asked: (1) Do phylogenetically related species show more similar responses to light availability? (2) Does phylogenetic signal in light response traits promote or constrain species coexistence?

**Location:** Deciduous temperate forests across northeastern United States (Vermont, New Hampshire, Massachusetts).

**Methods:** We measured light response curves for 45 understory herbaceous species representing 25 families. We quantified phylogenetic signal in maximum photosynthetic rate, light compensation point, and light saturation point using Blomberg's K. We tested whether phylogenetically related species co-occur less often than expected using null models of community assembly.

**Results:** Light response traits showed significant phylogenetic signal (K = 0.65-0.89). Phylogenetically related species exhibited more similar light niches and co-occurred less frequently than expected by chance in high-light microsites but not in low-light microsites. This pattern was strongest for traits related to high-light tolerance.

**Conclusions:** Phylogenetic conservatism in light response traits structures temperate forest understory communities by promoting niche differentiation among closely related species. These findings suggest that evolutionary history constrains local-scale coexistence patterns and may influence community responses to canopy disturbance regimes.

**Total word count:** 185
```

---

## Template B: Title Page

```markdown
# [Full Title Without Abbreviations or Taxon Authorities]

Peter B. Bush¹ https://orcid.org/0000-0000-0000-0000, George Smith² https://orcid.org/0000-0000-0000-0000, E. Fred Wang²* https://orcid.org/0000-0000-0000-0000

¹ Department of Ecology, University of the South, Southend-on-Sea, UK
² Botany Department, Little Marsh University, Little Marsh, CA, USA

**Correspondence**
E. Fred Wang, Botany Department, Little Marsh University, Little Marsh, CA, USA.
Email: wang@little-marsh.edu

---

## Funding information

[List funding sources with grant codes in brackets and author initials if applicable. Example:]

This research was supported by the National Science Foundation (NSF-123456; E.F.W.), the Royal Society (RS-789012; P.B.B.), and Little Marsh University internal funds.

---

## Acknowledgements

[Acknowledge non-author contributions (with permission), technical support, or material support. Do NOT include funding details here—those go in Funding section. Do NOT thank anonymous reviewers.]

We thank Maria Lopez for assistance with field sampling, James Chen for statistical advice, and the staff at [Research Station Name] for logistical support. We are grateful to [Organization] for providing access to study sites.

---

## Author contributions

[Optional but encouraged. Example:]

E.F.W. conceived the research idea; P.B.B. and G.S. collected field data; E.F.W. and G.S. performed laboratory analyses; P.B.B. conducted statistical analyses; E.F.W., with contributions from P.B.B. and G.S., wrote the paper; all authors discussed results and commented on the manuscript.

---

## Data availability statement

[Choose appropriate statement from Template C below or customize]

The data supporting the findings of this study are openly available in Zenodo at https://doi.org/10.5281/zenodo.XXXXXXX.

---

## Conflict of interest statement

The authors declare no conflicts of interest.
```

---

## Template C: Data Availability Statements

### Template C1: Public Repository (Recommended)
```markdown
The data supporting the findings of this study are openly available in [Zenodo/Figshare/Dryad] at https://doi.org/[DOI], reference number [reference].
```

**Example:**
```markdown
The data supporting the findings of this study are openly available in Zenodo at https://doi.org/10.5281/zenodo.7654321, reference number 7654321.
```

---

### Template C2: Supporting Information Only
```markdown
The data supporting the findings of this study are available in the Supporting Information of this article.
```

---

### Template C3: Combined Repository + Supporting Information
```markdown
Raw data are openly available in [repository name] at https://doi.org/[DOI]. Processed datasets and analysis scripts are provided in the Supporting Information of this article.
```

**Example:**
```markdown
Raw vegetation survey data are openly available in Zenodo at https://doi.org/10.5281/zenodo.7654321. Processed community matrices and R scripts for all analyses are provided in Appendix S1 and S2.
```

---

### Template C4: Multi-Contributor Database (TRY, sPlot, EVA, ForestPlots)
```markdown
The data used in this study are part of the [database name] and are available upon request through project code [project code] using database version [version]. The data selection released for this study is archived in the [database] repository and available for re-analyses upon request.
```

**Example:**
```markdown
The data used in this study are part of the sPlot Open database (Bruelheide et al. 2019) and are available upon request through project code EU-BOT-2023-001 using database version 3.0. The data selection released for this study is archived in the sPlot repository and available for re-analyses upon request.
```

---

### Template C5: Embargo or Third-Party Restrictions
```markdown
Data cannot be made publicly available due to [embargo until DATE / third-party proprietary rights / sensitive species locations / indigenous data sovereignty]. Data are available from the corresponding author upon reasonable request and [with permission of THIRD PARTY / after DATE / subject to approval by DATA CUSTODIAN].
```

**Examples:**

**Embargo:**
```markdown
Data cannot be made publicly available due to an embargo until 1 January 2026 as stipulated by the funding agency. Data will be made available in Zenodo after this date and are available from the corresponding author upon reasonable request for researchers who agree to the embargo terms.
```

**Sensitive Species:**
```markdown
Data on precise locations of rare and endangered species cannot be made publicly available to protect populations from collection pressure. Aggregated data at 10 km resolution are available in the Supporting Information. Full datasets are available from the corresponding author upon reasonable request and with approval from [Conservation Authority].
```

**Indigenous Data:**
```markdown
The vegetation data were collected on indigenous lands and are governed by traditional knowledge protocols. Data cannot be shared publicly without consent from the [Indigenous Nation/Community] Data Governance Committee. Requests for data access should be directed to [contact] with justification for research use.
```

---

### Template C6: Code/Script Sharing
```markdown
The [R/Python/MATLAB] scripts and analytical code supporting this study are openly available at [GitHub/GitLab] (https://github.com/[user]/[repo]) and archived in [Zenodo/Figshare] at https://doi.org/[DOI].
```

**Example:**
```markdown
The R scripts for species distribution modeling and all analytical code are openly available at GitHub (https://github.com/username/forest-sdm) and archived in Zenodo at https://doi.org/10.5281/zenodo.7654322.
```

---

### Template C7: Combination Statement (Data + Code)
```markdown
The data supporting the findings of this study are openly available in [repository] at https://doi.org/[DOI1]. The R scripts and analytical code are openly available at GitHub (https://github.com/[user]/[repo]) and archived in [repository] at https://doi.org/[DOI2].
```

---

## Template D: Cover Letter (Optional)

**Use when:**
- Manuscript exceeds 8,000 words and needs justification
- Data cannot be made public (embargo, third-party rights)
- Special circumstances need explanation

```markdown
[Date]

Chief Editor
Journal of Vegetation Science

Dear Editor,

I am submitting our manuscript entitled "[Full Title]" for consideration as a [Research Article / Synthesis / Forum / Methodological Article] in the Journal of Vegetation Science.

[PARAGRAPH 1: Brief overview of study and main contribution]
This manuscript presents [brief description of research]. Our work addresses a key gap in vegetation science by [explain novelty]. We believe this study will be of interest to the Journal's international readership because [explain broad relevance].

[OPTIONAL PARAGRAPH 2: Length justification - include only if manuscript >8000 words]
**Justification for length:** Our manuscript exceeds the typical 8,000-word guideline (total: [X] words including references). This length is necessary because [explain: e.g., "we present comprehensive analyses across five contrasting biomes requiring detailed methodological explanation," or "the manuscript integrates three conceptual frameworks that each require substantial development," or "we include extensive validation of a new method requiring detailed comparison with existing approaches"].

[OPTIONAL PARAGRAPH 3: Data availability explanation - include only if data cannot be public]
**Data availability explanation:** We are unable to make the full dataset publicly available at this time because [explain: e.g., "the data are under embargo until 1 January 2026 as stipulated by our funding agreement with [Agency]," or "the data include precise locations of endangered species and are restricted by [Conservation Authority] to protect populations," or "the data belong to a third-party collaborative project and are governed by [Database] data sharing policies"]. We have provided [summary data in Supporting Information / aggregated data at coarser resolution / detailed metadata to facilitate data requests].

[OPTIONAL PARAGRAPH 4: Scope and significance]
**Scope and significance:** Our work focuses on [community/ecosystem level patterns] and has international relevance because [explain broader implications beyond study system]. The findings [test general theory / develop new methods / identify general patterns applicable to / provide new conceptual framework for] [broader vegetation science topic].

[OPTIONAL PARAGRAPH 5: Suggested reviewers]
**Suggested reviewers:**
We suggest the following potential reviewers based on their expertise in [relevant topic areas]:

1. Dr. [Name], [Institution], [Email] — expertise in [specific area]
2. Dr. [Name], [Institution], [Email] — expertise in [specific area]
3. Dr. [Name], [Institution], [Email] — expertise in [specific area]

[Alternatively, if you prefer to exclude certain reviewers:]
We respectfully request that [Dr. Name, Institution] not review this manuscript due to [recent collaboration / competing research program / prior conflict].

[PARAGRAPH: Conflict of interest and originality]
**Conflict of interest statement:** The authors declare no conflicts of interest.

We confirm that this manuscript represents original work that has not been published elsewhere and is not under consideration by another journal. [Optional: A preprint version was posted on [preprint server] on [date], DOI: [DOI].] All authors have read and approved the final manuscript and agree with its submission to the Journal of Vegetation Science.

Thank you for considering our work. We look forward to your response.

Sincerely,

[Corresponding Author Name]
[Title/Position]
[Institution]
[Email]
[ORCID: https://orcid.org/0000-0000-0000-0000]
```

---

### Cover Letter Example (Short, no special circumstances):

```markdown
15 March 2024

Chief Editor
Journal of Vegetation Science

Dear Editor,

I am submitting our manuscript entitled "Phylogenetic constraints on light niche differentiation in temperate forest understories" for consideration as a Research Article in the Journal of Vegetation Science.

This manuscript examines how evolutionary relationships among plant species influence local-scale coexistence patterns in forest understories. By integrating phylogenetic comparative methods with community assembly theory, we demonstrate that phylogenetic conservatism in light response traits promotes niche differentiation among closely related species. This work advances our understanding of how evolutionary history shapes contemporary plant community structure and will be of interest to community ecologists, biogeographers, and forest ecologists.

The authors declare no conflicts of interest. We confirm that this manuscript represents original work that has not been published elsewhere and is not under consideration by another journal. All authors have read and approved the final manuscript.

Thank you for considering our work.

Sincerely,

Dr. E. Fred Wang
Associate Professor of Botany
Little Marsh University
wang@little-marsh.edu
ORCID: https://orcid.org/0000-0002-1234-5678
```

---

### Cover Letter Example (With justifications):

```markdown
15 March 2024

Chief Editor
Journal of Vegetation Science

Dear Editor,

I am submitting our manuscript entitled "Global patterns of forest biodiversity responses to climate change: A synthesis of long-term monitoring data across six continents" for consideration as a Synthesis in the Journal of Vegetation Science.

This manuscript synthesizes three decades of forest biodiversity monitoring data from 847 permanent plots across all forested continents. We identify consistent global patterns in community responses to climate warming and develop a new predictive framework for biodiversity change. This work integrates multiple conceptual approaches and will be of broad interest to community ecologists, conservation biologists, and forest managers worldwide.

**Justification for length:** Our manuscript is 11,420 words including references. This length is necessary because we: (1) synthesize complex datasets from six continents requiring detailed methodological explanation for data harmonization across diverse monitoring schemes; (2) present comprehensive sensitivity analyses for each continental region to establish generality of patterns; and (3) develop and validate a new predictive framework requiring extensive comparison with existing models. We have moved all supplementary analyses, extended tables, and regional case studies to Supporting Information to keep the main text as concise as possible while maintaining completeness.

**Data availability explanation:** The synthesized data represent contributions from 127 research groups across 45 countries, many of which are governed by third-party data sharing agreements. We have worked with all contributors to prepare a comprehensive data package that includes: (1) fully anonymized and aggregated community matrices (publicly available in Zenodo); (2) detailed metadata for each plot including coordinates aggregated to 10 km resolution (Appendix S1); and (3) complete plot-level data available through the ForestPlots.net portal (access code FP-SYNTH-2024) following contributor approval. This approach balances open science principles with respect for contributor data sovereignty.

**Conflict of interest statement:** The authors declare no conflicts of interest.

We confirm that this manuscript represents original work not published elsewhere. All 127 contributing research groups and all listed authors have approved this submission.

Thank you for considering our work.

Sincerely,

Dr. E. Fred Wang
Associate Professor of Botany
Little Marsh University
wang@little-marsh.edu
ORCID: https://orcid.org/0000-0002-1234-5678
```

---

## Template E: Supporting Information File Header

Each Supporting Information file should begin with:

```markdown
Supporting Information to the article:

[Full list of authors]. [Year]. [Full title]. Journal of Vegetation Science.

---

# Appendix S[number]. [Descriptive title]

[Detailed caption explaining the contents of this appendix. This should be comprehensive enough that the appendix is understandable on its own.]

---

[Content of appendix begins here]
```

### Example:

```markdown
Supporting Information to the article:

Bush, P. B., G. Smith, and E. F. Wang. 2024. Phylogenetic constraints on light niche differentiation in temperate forest understories. Journal of Vegetation Science.

---

# Appendix S1. Extended Methods and Supplementary Analyses

This appendix provides detailed descriptions of field sampling protocols, extended methodological justifications for phylogenetic comparative methods, and supplementary analyses testing the sensitivity of our results to alternative tree construction methods and taxonomic resolution.

**Contents:**
- Table S1. Complete list of study species with family assignments and phylogenetic placement
- Figure S1. Sensitivity analysis of phylogenetic signal estimates to tree topology
- Figure S2. Regional variation in phylogenetic clustering patterns
- Supplementary Methods: Detailed protocols for light measurements

---

[Content begins here]
```

---

## Template F: Quick Reference Card

### Submission Requirements at a Glance

| Element | Requirement |
|---------|-------------|
| **Files** | 3 separate: Title page, Main text (anonymized), SI |
| **Abstract** | 300 words (Research/Synthesis), 200 (Forum), 60 (Commentary) |
| **Keywords** | 8-10, comma-separated |
| **Word count** | ~8000 words (text + refs) for Research Article |
| **Line numbers** | Required in main text |
| **Anonymization** | Complete (no self-identifying info in main text) |
| **Data** | Public repository with DOI OR in SI |
| **References** | Chicago author-date, alphabetical, full journal names |
| **Figures/Tables** | Legends on same page (figures) or above (tables) |
| **SI naming** | Appendix S1, S2, S3, etc. |
| **ORCID** | Required for submitting author |

### Pre-Submission Checklist

1. ✅ Scope: Plant communities (not single species)
2. ✅ Three files prepared
3. ✅ Main text anonymized + line numbered
4. ✅ Abstract: correct structure + within word limit
5. ✅ Keywords: 8-10 present
6. ✅ Data statement included
7. ✅ Data archived
8. ✅ References formatted correctly
9. ✅ Figures/tables: legends positioned correctly
10. ✅ SI cited and properly named
