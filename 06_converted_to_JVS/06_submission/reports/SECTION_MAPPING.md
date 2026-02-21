# SECTION MAPPING — JVS Conversion

## Source → Target Mapping

| Source Section/File | Target File/Location | Action | Notes/TODO |
|---|---|---|---|
| `00_title_page/title_page.docx` → Title | `word/01_Title_Page_JVS.docx` → Title | Reformat heading style | — |
| `00_title_page/title_page.docx` → Authors + ORCIDs | `word/01_Title_Page_JVS.docx` → Authors | Reformat to JVS superscript affiliation style | — |
| `00_title_page/title_page.docx` → Affiliations | `word/01_Title_Page_JVS.docx` → Affiliations | Reformat numbered superscript style | All three authors share single affiliation block |
| `00_title_page/title_page.docx` → Corresponding Author | `word/01_Title_Page_JVS.docx` → Correspondence | Reformat to JVS correspondence block | — |
| `00_title_page/title_page.docx` → Funding | `word/01_Title_Page_JVS.docx` → Funding | Keep as separate section | — |
| `00_title_page/title_page.docx` → Acknowledgements | `word/01_Title_Page_JVS.docx` → Acknowledgements | Keep; remove any funding overlap | — |
| `00_title_page/title_page.docx` → Author Contributions | `word/01_Title_Page_JVS.docx` → Author Contributions | Retain CRediT format | Optional per JVS |
| `00_title_page/title_page.docx` → Data Availability | `word/01_Title_Page_JVS.docx` → Data Availability Statement | Keep verbatim | — |
| `00_title_page/title_page.docx` → Ethics and Permits | `word/01_Title_Page_JVS.docx` → (end of file) | Retain for transparency | Not required by JVS in title page but not harmful |
| `00_title_page/title_page.docx` → Conflict of Interest | `word/01_Title_Page_JVS.docx` → (end of file) | Retain | — |
| `01_main_text/MAIN_TEXT.docx` → Title | `word/02_Main_Text_JVS.docx` → Title | Copy (anonymized) | No author names in main text |
| `01_main_text/MAIN_TEXT.docx` → Abstract | `word/02_Main_Text_JVS.docx` → Abstract | Keep structured sections (Questions, Location, Methods, Results, Conclusions) | Verify ≤300 words |
| `01_main_text/MAIN_TEXT.docx` → Keywords | `word/02_Main_Text_JVS.docx` → Keywords | Verify 8–10 keywords | Currently 10 keywords — compliant |
| `01_main_text/MAIN_TEXT.docx` → Introduction | `word/02_Main_Text_JVS.docx` → Introduction | Copy; fix in-text citation format (& → and) | — |
| `01_main_text/MAIN_TEXT.docx` → Methods | `word/02_Main_Text_JVS.docx` → Methods | Copy; fix in-text citation format | — |
| `01_main_text/MAIN_TEXT.docx` → Results | `word/02_Main_Text_JVS.docx` → Results | Copy; fix in-text citation format | — |
| `01_main_text/MAIN_TEXT.docx` → Discussion | `word/02_Main_Text_JVS.docx` → Discussion | Copy; fix in-text citation format | — |
| `01_main_text/MAIN_TEXT.docx` → Conclusions | `word/02_Main_Text_JVS.docx` → Conclusions | Copy | — |
| `01_main_text/MAIN_TEXT.docx` → References | `word/02_Main_Text_JVS.docx` → References | Reformat to Chicago author-date (JVS style) | Full journal names, DOI, alphabetical |
| `01_main_text/MAIN_TEXT.docx` → Figure captions | `word/02_Main_Text_JVS.docx` → Figures with legends | Pair each caption with its figure | Figures embedded after references+tables |
| `01_main_text/MAIN_TEXT.docx` → Table captions | `word/02_Main_Text_JVS.docx` → Tables with legends | Pair each caption with its table data | Tables embedded after references |
| `01_main_text/MAIN_TEXT.docx` → Supporting information list | `word/02_Main_Text_JVS.docx` → Supporting Information (after References) | Insert Appendix S title list | Already uses Appendix S naming |
| `02_figures/Figure01–06 (.png, .pdf)` | `word/03_Figures/` and `latex/03_figures/` | Copy files | PDF for LaTeX, PNG+PDF for Word package |
| `03_tables/Table01–06 (.csv)` | `word/04_Tables/` and `latex/04_tables/` | Copy CSV files | Embedded versions in main text docs |
| `04_supplementary/TableS1–S10 (.csv)` | `word/05_Supporting_Information/` as `Appendix_S1–S10` | Rename and copy; add header referencing original paper | — |
| — | `latex/01_manuscript_jvs.tex` | Generate LaTeX mirroring Word main text | — |
| — | `latex/02_references.bib` | Convert reference list to BibTeX | — |
| — | `latex/06_README_compile.txt` | Write compilation instructions | — |
