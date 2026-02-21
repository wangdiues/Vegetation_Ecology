# Validation Rule Summary

## Complete Rule Index for Automated Compliance Checking

| Rule ID | Strength | Applies To | What To Check | Auto-Checkable? | Check Method |
|---------|----------|-----------|---------------|-----------------|--------------|
| **SCOPE** |
| SCOPE-001 | MUST | All articles | Plant community focus (not single species except key dominants) | Partial | Keyword/title scan for community-level terms; flag single-species focus |
| SCOPE-002 | SHOULD | All articles | Novelty: new concepts/methods/theory/patterns | Manual | Requires editorial judgment |
| SCOPE-003 | MUST | All articles | International interest beyond local scope | Manual | Assess broader implications in aims/discussion |
| **ARTICLE TYPES** |
| ATYPE-001 | SHOULD | Research Article | ~8000 words (text+refs) | Yes | Word count: main text + references |
| ATYPE-002 | MUST | Synthesis | Novel synthesis (not just literature summary) | Manual | Assess originality of conclusions |
| ATYPE-003 | MUST | Methodological | Describes new/tested/applied methods | Partial | Check for methods section; assess novelty |
| ATYPE-004 | SHOULD | Forum | ~4000 words; no new data | Yes | Word count + scan for data/results sections |
| ATYPE-005 | MUST | Report | Describes tool/database/software/initiative | Partial | Check for tool/resource description |
| ATYPE-006 | MUST | Commentary | Solicited by editors | Manual | Verify solicitation status with editorial office |
| **FILES** |
| FILE-001 | MUST | All articles | Three separate files: title page, main text, SI | Yes | Count submitted files; check file purposes |
| FILE-002 | MUST | All articles | Main text anonymized (no author names/affiliations) | Yes | Text scan for names, affiliations, self-citations |
| FILE-003 | MUST | All articles | Line numbers in main text | Yes | Check for line numbering in document properties |
| FILE-004 | SHOULD | All articles | Free format acceptable initially | Yes | Allow any readable format for initial submission |
| FILE-005 | MUST | All articles | Files must be readable | Manual | Visual inspection of clarity |
| FILE-006 | MUST | All articles | Format: .doc, .docx, or .tex | Yes | File extension check |
| FILE-007 | MUST | LaTeX submissions | PDF + all supporting files provided | Yes | Check for companion PDF and .tex dependencies |
| FILE-008 | MUST_NOT | All articles | Not published/submitted elsewhere (except preprints/abstracts) | Manual | Author declaration verification |
| **FORMATTING - LANGUAGE** |
| FMT-001 | MUST | All articles | English (British or American, consistent) | Partial | Language detection; flag inconsistencies |
| **FORMATTING - STRUCTURE** |
| FMT-002 | MUST | All articles | Required sections: title, abstract, intro, methods, results, discussion, refs | Yes | Section header detection |
| FMT-003 | SHOULD | All articles | Manuscript is concise | Partial | Flag excessive wordiness/repetition (NLP) |
| FMT-004 | MUST | All articles | Figure legends on same page as figures | Partial | Proximity check (page analysis) |
| FMT-005 | MUST_NOT | All articles | No footnotes in main text | Yes | Footnote marker detection |
| **FORMATTING - ABBREVIATIONS** |
| FMT-006 | SHOULD_NOT | All articles | Avoid excessive abbreviations | Partial | Count abbreviations; flag if >X per page |
| FMT-007 | MUST | When abbreviations used | Define on first use (word + parenthetical) | Partial | Check first occurrence has definition |
| FMT-008 | MUST | All articles | Two-letter country codes (UK not GB) | Yes | Regex: flag "GB" country code |
| **FORMATTING - UNITS** |
| FMT-009 | MUST | All articles | SI or SI-derived units | Partial | Pattern matching for common non-SI units |
| FMT-010 | MAY | All articles | Time units: s/min/hr/week/mo/yr for contemporary | Partial | Verify standard time abbreviations |
| FMT-011 | MUST | Palaeo studies | Use ka/Ma; clarify 14C vs calendar years BP | Partial | Check for palaeo terms + clarification |
| FMT-012 | MUST | All articles | Date format: "2 Sep 2017" | Yes | Regex pattern matching for dates |
| **FORMATTING - NUMBERS** |
| FMT-013 | MUST | All articles | Numbers ≤10 spelled; >10 digits (with exceptions) | Partial | Context-dependent parsing required |
| FMT-014 | MUST | All articles | Decimal point is "." | Yes | Flag commas used as decimal separators |
| FMT-015 | MUST | All articles | Thousands: space for ≥10,000 (e.g., 10 000) | Yes | Number format pattern matching |
| **FORMATTING - SYMBOLS** |
| FMT-016 | MUST | All articles | Variables/parameters in italics (e.g., *p*) | Partial | Check italicization of single letters in equations |
| **STYLE - TITLE** |
| STYLE-001 | MUST | All articles | Title: short, informative, contains keywords | Partial | Length check; keyword analysis |
| STYLE-002 | MUST_NOT | All articles | No abbreviations or taxon authorities in title | Yes | Pattern matching for abbr. and authorities |
| STYLE-003 | SHOULD | All articles | Use words not symbols in title/abstract/keywords | Yes | Symbol detection (β, α, ≥, etc.) |
| **STYLE - ABSTRACT** |
| STYLE-004 | MUST | Research/Synthesis/Method | Sections: Questions/Aims, Location, Methods, Results, Conclusions | Yes | Section header detection in abstract |
| STYLE-005 | MUST | Research/Synthesis/Method | Abstract ≤300 words | Yes | Word count |
| STYLE-006 | MUST | Forum/Report | Abstract ≤200 words, no sections | Yes | Word count + section header check |
| STYLE-007 | MUST | Commentary | Abstract ≤60 words | Yes | Word count |
| STYLE-008 | SHOULD_NOT | All articles | Avoid abbreviations in abstract | Partial | Abbreviation detection |
| STYLE-009 | MUST_NOT | All except Commentary | No references in abstract | Yes | Citation pattern matching |
| STYLE-010 | MUST_NOT | All articles | No taxon authorities in abstract | Yes | Pattern matching for author citations |
| **STYLE - KEYWORDS** |
| STYLE-011 | MUST | All articles | 8-10 keywords, comma-separated | Yes | Count comma-separated items |
| STYLE-012 | MAY | All articles | Keywords may be phrases | Yes | Allow multi-word keywords |
| STYLE-013 | SHOULD | All articles | Repeat title words in keywords for SEO | Partial | Compare title vs keywords overlap |
| **STYLE - MAIN TEXT** |
| STYLE-014 | SHOULD | All articles | Standard structure: Intro, Methods, Results, Discussion, Conclusions | Yes | Section header detection |
| STYLE-015 | MUST | All articles | Introduction: context, knowledge, importance, questions/aims | Manual | Content analysis required |
| **TAXONOMY** |
| TAX-001 | MUST | All articles | Nomenclatural source cited in Methods (with accession date) | Partial | Check Methods for flora/database citation |
| TAX-002 | SHOULD_NOT | All articles | Avoid taxon authorities in text (unless disambiguation) | Yes | Pattern matching: Genus species Author |
| TAX-003 | MUST | All articles | Scientific names throughout; common names defined | Partial | Check for common names + definition |
| **DATA & CODE** |
| DATA-001 | MUST | All articles | Data availability statement present | Yes | Search for statement section or keyword |
| DATA-002 | MUST | Articles with data | Data in public repository with DOI or in SI | Partial | Check for DOI pattern or SI reference |
| DATA-003 | MUST | All articles | Data sufficient to verify analyses | Manual | Requires assessment of data completeness |
| DATA-004 | SHOULD | All articles | Code/scripts archived | Partial | Check for code repository mention |
| DATA-005 | MUST | All articles | Repository link in statement AND cited in references | Yes | Cross-reference statement vs reference list |
| DATA-006 | MAY | When data restricted | Cover letter explains embargo/restrictions | Manual | Check cover letter for explanation |
| DATA-007 | MUST | Multi-contributor DBs | Project code and database version specified | Yes | Search for database name + code/version |
| DATA-008 | SHOULD | All articles | Data/code anonymized for review | Manual | Suggest anonymization tools |
| **REFERENCES - STYLE** |
| REF-001 | MUST | All articles | Chicago author-date format | Partial | Citation pattern matching |
| REF-002 | MUST | All articles | One author: (Smith 1990) or Smith (1990) | Yes | Single-author citation pattern check |
| REF-003 | MUST | All articles | 2-3 authors: all names (Bond and Keely 2005) | Yes | 2-3 author citation pattern check |
| REF-004 | MUST | All articles | 4+ authors: first et al. (Kapfer et al. 2017) | Yes | Multi-author et al. pattern check |
| REF-005 | MUST | All articles | Multiple citations: chronological, semicolon-separated | Yes | Check ordering and separators |
| REF-006 | MUST | All articles | Same author-year: letters (Jones 2019a; 2019b) | Yes | Pattern matching for letter suffixes |
| REF-007 | MAY | All articles | Unpublished: 'unpubl.' or 'pers. comm.' with details | Yes | Pattern matching for unpublished markers |
| REF-008 | MAY | All articles | Submitted papers: remove if not published by proofs | Manual | Flag at proof stage for verification |
| **REFERENCES - LIST** |
| REF-009 | MUST | All articles | Alphabetically ordered | Yes | Alphabetical sorting check |
| REF-010 | MUST | All articles | ≤6 authors: all listed; ≥7: first three + et al. | Yes | Count authors per reference |
| REF-011 | MUST | All articles | Full journal names (no abbreviations) | Partial | Dictionary lookup for common abbreviations |
| REF-012 | MUST | All articles | DOIs provided where available | Partial | Check journal articles for DOI field |
| REF-013 | MUST | Non-English refs | Titles translated; language noted; journals original | Partial | Check for language notation [In ...] |
| **TABLES** |
| TBL-001 | MUST | All articles | Self-contained, complement (not duplicate) text/figures | Manual | Assess content overlap |
| TBL-002 | MUST | All articles | Editable format, not images | Partial | Check if table is embedded object vs image |
| TBL-003 | SHOULD_NOT | All articles | Avoid vertical lines | Manual | Visual inspection of table formatting |
| TBL-004 | MAY | All articles | Shading for highlighting (not frames/boldface) | Manual | Visual inspection |
| TBL-005 | SHOULD | Large tables | Empty cells filled with dots | Manual | Visual inspection |
| TBL-006 | MUST | All articles | Legend above table on same page | Partial | Position check (above vs below) |
| TBL-007 | MUST | All articles | Legend comprehensive; table understandable alone | Manual | Assess legend completeness |
| TBL-008 | MUST | All articles | First legend sentence is short title | Partial | Check legend structure |
| TBL-009 | MUST | All articles | Units in column headings, not table body | Manual | Visual inspection of table structure |
| **FIGURES** |
| FIG-001 | MUST | All articles | At publication size, details readable | Manual | Visual inspection at target size |
| FIG-002 | SHOULD_NOT | All articles | Avoid unnecessary frames/borders | Manual | Visual inspection |
| FIG-003 | MUST | All articles | Symbol/line definitions as visual key on figure | Manual | Visual inspection |
| FIG-004 | MUST | All articles | Sub-graphs: lowercase letter + brief heading | Manual | Visual inspection of panel labels |
| FIG-005 | SHOULD | All articles | Full labels; abbreviations explained in caption | Manual | Check labels and caption |
| FIG-006 | SHOULD | All articles | Sans-serif fonts | Manual | Visual inspection of fonts |
| FIG-007 | MUST | Maps/microphotographs | Scale bars present | Manual | Visual inspection |
| FIG-008 | SHOULD | All articles | Use colour where suitable (no fees) | Manual | Suggest colour optimization |
| FIG-009 | MUST | All articles | Legend on same page as figure | Partial | Proximity/page check |
| FIG-010 | MUST | All articles | Legend comprehensive; understandable alone | Manual | Assess legend completeness |
| FIG-011 | MUST | All articles | First legend sentence is short title | Partial | Check legend structure |
| FIG-012 | MUST | Final publication | High resolution for electronic version | Manual | Check resolution at acceptance |
| **SUPPORTING INFORMATION** |
| SI-001 | MUST | All articles | SI is supplementary (not essential) | Manual | Assess content importance |
| SI-002 | MUST | All articles | Named Appendix S1, S2, etc. | Yes | File naming pattern check |
| SI-003 | MUST | All articles | All SI cited in main text | Yes | Cross-reference SI names vs citations |
| SI-004 | MUST | All articles | Each appendix: paper reference + detailed caption | Yes | Check appendix headers |
| SI-005 | SHOULD | All articles | PDFs styled similar to journal | Manual | Visual inspection |
| SI-006 | MUST | All articles | Text/tables→PDF; large data→TXT/CSV; code→plain text | Yes | File format check |
| SI-007 | MUST | All articles | Figures in PDFs with captions | Yes | Check PDF contents |
| SI-008 | SHOULD | All articles | Related items grouped in single appendix | Manual | Suggest grouping |
| SI-009 | MUST | All articles | SI submitted with first version as separate file | Yes | Check submission package |
| SI-010 | MUST | All articles | SI list after References in main text | Yes | Check for list section |
| SI-011 | MAY | All articles | Main appendices only for formulas/syntaxa | Manual | Assess appropriateness |
| **BOXES** |
| BOX-001 | SHOULD | When used | Important info not fit for main text | Manual | Assess content appropriateness |
| BOX-002 | MUST | When used | Boxes cited in text | Yes | Cross-reference box numbers vs citations |
| BOX-003 | MUST | When used | Embedded at end of Word file | Yes | Check box location in file |
| BOX-004 | MUST | When used | Boxes have short titles | Yes | Check for title presence |
| BOX-005 | MUST | When used | Box text ≤500 words | Yes | Word count |
| BOX-006 | MAY | When used | Paragraphs or bullet points | Yes | Allow flexible formatting |
| **ETHICS & PEER REVIEW** |
| PEER-001 | MUST | All articles | Double-anonymized peer review | Yes | Enforce anonymization workflow |
| PEER-002 | MUST | All articles | Authors responsible for anonymization | Yes | Verify anonymization complete |
| PEER-003 | SHOULD_NOT | All articles | Preprint sharing may compromise anonymity | Manual | Warn about risk |
| ETH-001 | MUST | All articles | Conflict of interest statement present | Yes | Check for COI statement |
| ETH-002 | MUST | All articles | Submitting author liaised with co-authors on COI | Manual | Author attestation |
| ETH-003 | MUST | All articles | Disclose relevant interests/relationships | Manual | Assess disclosure completeness |
| ETH-004 | MUST | All articles | Funding section present and complete | Yes | Check for funding section |
| ETH-005 | MUST | All articles | Accurate funder designations | Partial | Verify against Open Funder Registry |
| ETH-006 | MUST | All articles | All authors meet 5 authorship criteria | Manual | Author attestation |
| ETH-007 | MUST | All articles | Non-qualifying contributions in Acknowledgements | Manual | Check acknowledgements |
| ETH-008 | MUST | All articles | Author order agreed by all | Manual | Author attestation |
| ETH-009 | MUST | All articles | Submitting author ORCID provided | Yes | ORCID format check (0000-000X-XXXX-XXXX) |
| ETH-010 | SHOULD | All articles | Co-author ORCIDs encouraged | Partial | Suggest ORCIDs if missing |
| ETH-011 | MUST | All articles | iThenticate plagiarism check | Yes | Automated by journal system |
| **LICENSING** |
| LIC-001 | MUST | All articles | License choice: standard copyright or CC-BY OA | Manual | Verify at acceptance |
| LIC-002 | MUST | Open Access articles | Authors charged APC | Manual | Inform of APC requirement |
| LIC-003 | MAY | Standard copyright | Self-archiving allowed | Manual | Inform of rights |
| **ACCEPTANCE CRITERIA** |
| ACC-001 | MUST | All articles | Quality, originality, significance | Manual | Editorial assessment |
| ACC-002 | MUST | All articles | Meets ≥1 interest criterion (concepts/testing/methods/etc.) | Manual | Editorial assessment |
| **POST-ACCEPTANCE** |
| POST-001 | MUST | Accepted articles | Wiley Author Services registration | Yes | Automated workflow |
| POST-002 | MUST | Accepted articles | Publication license signed | Yes | Track signature |
| POST-003 | MUST | Accepted articles | Accepted Articles published online with DOI | Yes | Automated by system |
| POST-004 | MUST | Accepted articles | Proofs returned within 48 hours | Yes | Track turnaround time |
| POST-005 | SHOULD | Accepted articles | Blog post for VegSci Blog | Manual | Offer opportunity |
| **GRAPHICAL TOC** |
| TOC-001 | MUST | First revision | TOC entry: title, authors, ≤80 words, figure | Yes | Check components + word count |
| TOC-002 | MUST | First revision | TOC image 50×60mm, legible | Manual | Check dimensions + readability |

---

## Summary Statistics

### Total Rules: 129

**By Auto-Checkability:**
- **Yes (fully automated)**: 69 rules (53%)
- **Partial (semi-automated)**: 35 rules (27%)
- **Manual (requires human judgment)**: 25 rules (20%)

**By Strength:**
- **MUST**: 94 rules (73%)
- **MUST_NOT**: 7 rules (5%)
- **SHOULD**: 15 rules (12%)
- **SHOULD_NOT**: 7 rules (5%)
- **MAY**: 6 rules (5%)

**By Domain:**
- Formatting & Style: 29 rules
- References: 13 rules
- Data & Code: 8 rules
- Tables: 9 rules
- Figures: 12 rules
- Supporting Information: 11 rules
- Ethics & Review: 11 rules
- Files & Submission: 8 rules
- Scope: 3 rules
- Article Types: 6 rules
- Taxonomy: 3 rules
- Boxes: 6 rules
- Licensing: 3 rules
- Acceptance: 2 rules
- Post-acceptance: 5 rules

---

## Priority Rules (Critical for Submission)

**Must be checked before any submission is accepted for review:**

1. **SCOPE-001**: Plant community focus (not single species)
2. **FILE-001**: Three separate files
3. **FILE-002**: Complete anonymization of main text
4. **FILE-003**: Line numbers present
5. **STYLE-005/006/007**: Abstract word limit
6. **STYLE-011**: 8-10 keywords
7. **DATA-001**: Data availability statement
8. **ETH-009**: Submitting author ORCID

**These 8 rules represent hard gates that should prevent submission if violated.**
