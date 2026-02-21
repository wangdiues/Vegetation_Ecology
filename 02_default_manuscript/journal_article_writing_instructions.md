READ FIRST AND OBEY STRICTLY.

You are operating inside a governed scientific repository.

====================================================
STEP 0 — AUTHOR METADATA INGESTION (MANDATORY)
====================================================

Before generating ANY manuscript files, read:

D:\2025-2026\Vegetation_Ecology\02_manuscripts\00_title_page\author_details.txt

This file is the ONLY permitted source for:

- author names
- affiliations
- ORCID IDs
- corresponding author
- email addresses
- funding acknowledgements (if listed)
- author contributions (if listed)

----------------------------------------------------
AUTHOR RULES
----------------------------------------------------

- Do NOT invent or infer any author information.
- If a required field is missing from author_details.txt, insert:

  [TODO — <FIELD> REQUIRED]

- Title page MUST use this file.
- Anonymised main text MUST NOT include any author-identifying information.
- Compliance report MUST state whether each required author field was present.

----------------------------------------------------
FAIL CONDITION — AUTHOR FILE
----------------------------------------------------

If author_details.txt is missing or unreadable:

STOP → output ONLY:

MISSING_AUTHOR_DETAILS.md

====================================================
STEP 1 — REQUIRED INGESTION ORDER
====================================================

Read ALL files in this exact sequence:

A) Governance and journal rules:
D:\2025-2026\Vegetation_Ecology\02_manuscripts\04_Journal_guidelines\01_MACHINE_POLICY_PACK.yaml  
D:\2025-2026\Vegetation_Ecology\02_manuscripts\04_Journal_guidelines\02_COMPLIANCE_CHECKLIST.md  
D:\2025-2026\Vegetation_Ecology\02_manuscripts\04_Journal_guidelines\03_TEMPLATES.md  
D:\2025-2026\Vegetation_Ecology\02_manuscripts\04_Journal_guidelines\04_VALIDATION_RULE_SUMMARY.md  
D:\2025-2026\Vegetation_Ecology\02_manuscripts\04_Journal_guidelines\05_LLM_CONTROL_PROMPT.md  

B) Analysis code and results:
D:\2025-2026\Vegetation_Ecology\03_analysis\05_scripts  
D:\2025-2026\Vegetation_Ecology\03_analysis\04_results  

C) Stage-3 artefacts:
D:\2025-2026\Vegetation_Ecology\03_analysis\06_stage3\TRACEABILITY.csv  

====================================================
STEP 1b — CHATGPT MODE FALLBACK
====================================================

If filesystem access is unavailable:

STOP and ask the user to paste:

- author metadata
- TRACEABILITY.csv excerpt
- figure captions
- tables

Do NOT proceed without them.

====================================================
STEP 2 — LOCKED FIGURES (DO NOT SUBSTITUTE)
====================================================

Use ONLY figures listed in TRACEABILITY.csv.

No regeneration.
No substitution.

====================================================
STEP 2b — TRACEABILITY VALIDATION GATE
====================================================

Before writing Results or Discussion:

1) Extract every Figure/Table callout.
2) Cross-check against TRACEABILITY.csv → asset_id.
3) Reject any mismatch.
4) Log mismatches in compliance_report.md.
5) Proceed ONLY when 100% validated.

====================================================
TRACEABILITY.csv REQUIRED SCHEMA
====================================================

Mandatory columns:

asset_id  
source_path  
checksum_sha256  
used_in_section  

====================================================
STEP 3 — TABLE SOURCE (DO NOT RECOMPUTE)
====================================================

Tables MUST be drawn exclusively from:

D:\2025-2026\Vegetation_Ecology\03_analysis\06_stage3\02_tables  

Formatting allowed.  
Re-analysis forbidden.

====================================================
STEP 4 — SUPPLEMENTARY + DATA RELEASE
====================================================

Use ONLY:

D:\2025-2026\Vegetation_Ecology\03_analysis\06_stage3\04_supplementary  
D:\2025-2026\Vegetation_Ecology\03_analysis\06_stage3\05_data_release  

====================================================
GOAL
====================================================

Generate a FULL Journal of Vegetation Science–compliant submission package:

1) Title Page  
2) Anonymised Main Text  
3) Supporting Information  
4) Compliance Report  
5) OPTIONAL Cover Letter (only if mandated)

====================================================
MANDATORY CONSTRAINTS
====================================================

- British English only.
- No fabrication.
- No recomputation.
- Figure/table callouts MUST match TRACEABILITY.csv.
- Insert TODO placeholders:

[TODO — AUTHOR DETAILS REQUIRED]  
[TODO — ORCID REQUIRED]  
[TODO — AFFILIATIONS REQUIRED]  
[TODO — FUNDING SOURCE REQUIRED]  
[TODO — DATA AVAILABILITY STATEMENT REQUIRED]  
[TODO — ETHICS / PERMITS STATEMENT REQUIRED]

- Main text MUST remain fully anonymised.

====================================================
STEP 5 — MANUSCRIPT OUTPUT LOCATIONS (MANDATORY)
====================================================

Write ONLY into:

Title Page:  
D:\2025-2026\Vegetation_Ecology\02_manuscripts\00_title_page\title_page.md  

Main Text:  
D:\2025-2026\Vegetation_Ecology\02_manuscripts\01_main_text\main_text_anonymised.md  

Supporting Info:  
D:\2025-2026\Vegetation_Ecology\02_manuscripts\01_main_text\supporting_information.md  

Compliance:  
D:\2025-2026\Vegetation_Ecology\02_manuscripts\01_main_text\compliance_report.md  

Cover Letter:  
D:\2025-2026\Vegetation_Ecology\02_manuscripts\00_title_page\cover_letter.md  

Figures:  
D:\2025-2026\Vegetation_Ecology\02_manuscripts\02_figures\  

Tables:  
D:\2025-2026\Vegetation_Ecology\02_manuscripts\03_tables\  

====================================================
TIERED FAILURE RESPONSE
====================================================

| Missing Asset | Action |
|--------------|--------|
author_details.txt | STOP → MISSING_AUTHOR_DETAILS.md |
TRACEABILITY.csv | STOP → MISSING_TRACEABILITY.md |
Single figure/table | CONTINUE → log in compliance |
Output directory | STOP → MISSING_OUTPUT_DIRECTORIES.md |
Checksum failure | STOP → CHECKSUM_FAILURE.md |

====================================================
TOKEN-EXHAUSTION / CONTINUATION HANDOFF
====================================================

If interrupted:

STOP → emit:

CODEX_CONTINUATION_HANDOFF.md  
handoff_state.json  

====================================================
WRITE WHITELIST
====================================================

Agent may write ONLY to:

D:\2025-2026\Vegetation_Ecology\02_manuscripts\00_title_page\  
D:\2025-2026\Vegetation_Ecology\02_manuscripts\01_main_text\  
D:\2025-2026\Vegetation_Ecology\02_manuscripts\02_figures\  
D:\2025-2026\Vegetation_Ecology\02_manuscripts\03_tables\  

and failure / handoff artefacts.

====================================================
FINAL QUALITY GATE
====================================================

Verify:

- all outputs exist
- only allowed folders touched
- checksums match
- TRACEABILITY validated
- checklist satisfied

Failure → FINAL_AUDIT_FAILURE.md

====================================================
END OF MASTER PROMPT
====================================================
