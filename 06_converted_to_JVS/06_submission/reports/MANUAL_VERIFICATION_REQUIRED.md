# MANUAL VERIFICATION REQUIRED

Items below could not be fully validated automatically and require author review before submission.

---

## 1. Figure Resolution and Quality

- **Item:** JVS requires high-resolution figures for final publication.
- **Status:** Figures are provided as PNG and PDF. Resolution could not be programmatically verified.
- **Action required:** Confirm all figures meet Wiley's post-acceptance resolution requirements. Ensure sans-serif fonts are used in figure panels and visual keys (not word keys) are present.

## 2. Data Availability — Public Repository DOI

- **Item:** The Data Availability Statement refers to a DOI "to be provided upon manuscript acceptance."
- **Status:** Placeholder per author intent.
- **Action required:** Upon acceptance, deposit data in a public repository (e.g., Zenodo, Figshare, Dryad) and update the Data Availability Statement with the actual DOI. During review, consider providing anonymous access via https://anonymous.4open.science.

## 3. Anonymization Completeness

- **Item:** Main text has been anonymized (no author names, affiliations, or self-identifying citations).
- **Status:** No obvious identifying information found.
- **Action required:** Authors should review the main text to confirm no inadvertent self-identification remains (e.g., through "our previous study" phrasing linked to recognizable work, or institutional details in Methods).

## 4. Reference Completeness — Carpenter (2005)

- **Item:** Carpenter (2005) is cited in the Discussion but was not present in the original source reference list.
- **Status:** A BibTeX entry has been created based on the most likely match: Carpenter, C. 2005. "The environmental control of plant species density on a Himalayan elevation gradient." Journal of Biogeography 32: 999–1018.
- **Action required:** Authors must confirm this is the correct reference. If incorrect, replace with the intended citation.

## 5. Reference Completeness — Acharya et al. (2011)

- **Item:** Acharya et al. (2011) is cited in the Discussion/Results but was not in the original source reference list.
- **Status:** A BibTeX entry has been created based on the most likely match: Acharya, B. K., Chettri, B., and Vijayan, L. 2011. "Distribution pattern of trees along an elevational gradient of Eastern Himalaya, India." Acta Oecologica 37: 329–336.
- **Action required:** Authors must confirm this is the correct reference. If incorrect, replace with the intended citation.

## 6. LaTeX Compilation

- **Item:** The LaTeX package has not been test-compiled in this environment (no TeX distribution installed).
- **Status:** The .tex file has been validated syntactically but not compiled to PDF.
- **Action required:** Compile locally using `pdflatex` + `bibtex` (see `06_README_compile.txt`) and verify output. Fix any compilation issues.

## 7. In-Text Citation Format — Narrative vs. Parenthetical Consistency

- **Item:** JVS Chicago author-date allows both narrative ("Smith (2001) found...") and parenthetical ("(Smith 2001)") forms.
- **Status:** Both forms are used in the manuscript as appropriate. Ampersands (&) have been replaced with "and".
- **Action required:** Briefly scan to confirm no residual ampersands in citations and that the parenthetical/narrative usage reads naturally.

## 8. Table Formatting in Word Document

- **Item:** Tables were reconstructed from CSV data using python-docx.
- **Status:** All values match source CSVs.
- **Action required:** Open `02_Main_Text_JVS.docx` in Microsoft Word and verify table formatting, alignment, and readability. Adjust column widths if needed.

## 9. Cover Letter

- **Item:** JVS states cover letters are "not mandatory; however, it may be supplied at the author's discretion."
- **Status:** No cover letter was produced (not in source materials).
- **Action required:** Authors may optionally prepare a cover letter for submission.

## 10. Graphical Table of Contents

- **Item:** JVS requests a graphical ToC entry with the first revision (not first submission).
- **Status:** Not produced.
- **Action required:** Not needed for initial submission. Prepare for revision if requested.

## 11. Word Document Line Numbering

- **Item:** Line numbering was enabled via XML injection in the Word document.
- **Status:** Should render in Microsoft Word. May not render in all Word-compatible editors (e.g., LibreOffice).
- **Action required:** Open in Microsoft Word and confirm line numbers appear. If not visible, enable manually via Layout → Line Numbers → Continuous.

---

*End of manual verification items.*
