READ FIRST AND OBEY STRICTLY.

You are operating inside a governed scientific repository.

Task: Convert the manuscript in this repository into full compliance with Journal of Vegetation Science (JVS, Wiley) author guidelines. Work offline only. Use only files in this repository.

====================================================
0) NON-NEGOTIABLE RULES
====================================================

- Do NOT invent or add scientific content: data, analyses, numbers, statistics, interpretations, citations, references, authors, affiliations, ORCIDs, funding, ethics permits, acknowledgements, or declarations.
- Do NOT delete scientific content. Do NOT alter meaning.
- Preserve all numeric values, statistics, p-values, effect directions, sample sizes, and units.
- Permitted changes ONLY:
  - section order and headings to comply with JVS
  - style/formatting for JVS submission readiness
  - file splitting/packaging per JVS requirements
  - citation and reference formatting normalization (author-date)
  - reference de-duplication (only true duplicates)
  - Word and LaTeX packaging for submission

If required info is missing, insert exactly:
  [TODO - <FIELD> REQUIRED]

If any required input is missing/unreadable: STOP and output ONLY `MISSING_INPUTS.md` listing each missing file and consequence.

====================================================
1) REQUIRED INPUT FILES (LOCAL REPO PATHS)
====================================================

SOURCE FILES (this repository):
- Title page file:
  D:\2025-2026\Vegetation_Ecology\06_converted_to_JVS\00_title_page\title_page.docx
- Main text file:
  D:\2025-2026\Vegetation_Ecology\06_converted_to_JVS\01_main_text\MAIN_TEXT.docx
- Figures folder:
  D:\2025-2026\Vegetation_Ecology\06_converted_to_JVS\02_figures\
- Tables folder:
  D:\2025-2026\Vegetation_Ecology\06_converted_to_JVS\03_tables\
- Supplementary folder:
  D:\2025-2026\Vegetation_Ecology\06_converted_to_JVS\04_supplementary\

GUIDELINES SOURCE OF TRUTH:
- JVS author guidelines file:
  D:\2025-2026\Vegetation_Ecology\06_converted_to_JVS\JVS_Author_Guidelines.md

Do NOT assume requirements that are not explicitly in `JVS_Author_Guidelines.md`.

====================================================
2) OUTPUT LOCATION (DO NOT OVERWRITE SOURCES)
====================================================

Use:
  D:\2025-2026\Vegetation_Ecology\06_converted_to_JVS\06_submission\

Create and fill:
- `06_submission\word\`
- `06_submission\latex\`
- `06_submission\reports\`

====================================================
3) OUTPUTS TO PRODUCE (BOTH FORMATS REQUIRED)
====================================================

A) WORD PACKAGE (`06_submission\\word\\`)
- `01_Title_Page_JVS.docx`
- `02_Main_Text_JVS.docx`
- `03_Figures\` (submission-ready figure files)
- `04_Tables\` (submission-ready tables)
- `05_Supporting_Information\` (JVS Appendix S naming; see rules below)

B) LATEX PACKAGE (`06_submission\\latex\\`)
- `01_manuscript_jvs.tex`
- `02_references.bib` (or keep `.tex` references if no BibTeX conversion is feasible without invention)
- `03_figures\`
- `04_tables\`
- `05_supporting_information\`
- `06_README_compile.txt` (exact compile steps and assumptions)

C) REPORTS (`06_submission\\reports\\`)
- `JVS_CONVERSION_REPORT.md` (mandatory)
- `SECTION_MAPPING.md` (mandatory)
- `MANUAL_VERIFICATION_REQUIRED.md` (mandatory if any check cannot be automated)

====================================================
4) JVS REQUIREMENTS TO ENFORCE (FROM GUIDELINES)
====================================================

Apply these JVS-aligned requirements:

A) Journal + submission model
- Target journal is Journal of Vegetation Science (Wiley).
- Double-anonymized review policy: main text must be anonymized; title page separate.
- Submission through Research Exchange (file structure must support separate uploads).

B) Manuscript parts and order
- Title page file includes: title, authors, affiliations, funding, acknowledgements, author contributions (optional), data availability statement.
- Main text file order: title, abstract+keywords, main text, references, tables with legends, figures with legends, appendices (only specified kinds).

C) Abstract and keywords
- Research Article/Synthesis/Methodological Article abstract: <=300 words.
- Forum/Report abstract: <=200 words.
- Commentary abstract: <=60 words.
- Research Article abstract structure should use named sections (Questions/Aims, Location, Methods, Results, Conclusions) where applicable.
- Keywords: 8-10 (comma separated). Repetition of key title words is allowed for SEO.

D) Citations and references
- In-text style: Chicago author-date.
- Multiple citations in one parenthesis should be chronological.
- Same author-year disambiguation: 2019a, 2019b.
- Reference list alphabetized by author surname.
- Journal names written in full.
- DOI included where available.
- For 1-3 authors in-text: list names; for >=4 use `et al.`

E) Taxon nomenclature and style
- Do not use taxon author citation unless needed for disambiguation.
- Scientific taxon names used consistently; common names only under JVS exceptions.
- SI/SI-derived units; numbers and symbol style follow JVS conventions.

F) Supporting Information
- Electronic appendices must be named `Appendix S1`, `Appendix S2`, etc.
- Each appendix must be cited from main text.
- Include brief appendix-title list in main manuscript after references.

G) Formatting for submission readiness
- For new submission, JVS allows free format, but manuscript must be readable and line-numbered.
- Figure legends should appear on the same page as figure in review-ready manuscript.
- No text footnotes.

====================================================
5) CONVERSION WORKFLOW (MANDATORY)
====================================================

1. Parse `JVS_Author_Guidelines.md` and extract enforceable rules.
2. Load source files from `00_title_page`, `01_main_text`, `02_figures`, `03_tables`, `04_supplementary`.
3. Build `SECTION_MAPPING.md`:
   | Source section/file | Target file/location | Action | Notes/TODO |
4. Produce Word package (`06_submission\\word\\`) with separate title page and anonymized main text.
5. Produce LaTeX package (`06_submission\\latex\\`) mirroring Word content and structure.
6. Normalize citations/references to JVS author-date rules (no content invention).
7. Repackage supplementary files as Appendix S convention and ensure manuscript references them.
8. Run all checks in Section 6 and log results in `JVS_CONVERSION_REPORT.md`.
9. If any rule cannot be fully validated, record in `MANUAL_VERIFICATION_REQUIRED.md`.

====================================================
6) VALIDATION CHECKLIST (RECORD IN REPORT)
====================================================

A) Scope and article type
- Article category mapped to JVS categories (Research Article / Synthesis / Methodological Article / Forum / Report / Commentary).

B) Structure and separation
- Separate title page file present.
- Main text anonymized for double-anonymized review.
- Main text order compliant with JVS expectations.

C) Abstract and keywords
- Abstract length check against category-specific cap.
- Keyword count = 8-10.

D) Citation/reference integrity
- In-text style is Chicago author-date.
- Chronological ordering in grouped citations.
- All in-text citations present in reference list.
- No orphan references.
- Alphabetized references with full journal names and DOI where available.

E) Supporting Information
- File naming uses `Appendix S#`.
- Mentioned from main text.
- Appendix title list inserted after references.

F) Figures/tables and readability
- Figures and legends are paired in review-ready manuscript.
- Tables and legends present and consistently numbered.
- Manuscript line-numbered.

G) Content integrity
- Spot-check confirms values/statistics/p-values unchanged.

====================================================
7) REPORT TEMPLATE (MANDATORY CONTENT)
====================================================

`JVS_CONVERSION_REPORT.md` must include:
- Conversion date/time (local)
- Input files used (exact paths)
- Output files produced (exact paths)
- Rule-by-rule JVS checklist with pass/fail/todo
- Citation/reference mismatch list (if any)
- Supporting Information mapping to Appendix S#
- Manual verification items
- Final status: COMPLETE / COMPLETE WITH TODOs / INCOMPLETE

====================================================
8) WORD + LATEX PARITY RULE
====================================================

Both output packages must represent the same scientific content and section order.
If a formatting element cannot be mirrored exactly between Word and LaTeX, document the discrepancy in `JVS_CONVERSION_REPORT.md` under:
`## Word-LaTeX Parity Exceptions`

====================================================
9) EXECUTION INSTRUCTION
====================================================

Proceed with JVS conversion only.
Do not use Biodiversity and Conservation, Springer templates, SERC, Conservation Evidence, ESM/Online Resource naming, or `sn-jnl` class references.

If blocked by missing inputs, output `MISSING_INPUTS.md` and stop.