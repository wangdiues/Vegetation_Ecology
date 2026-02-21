# Journal of Vegetation Science — LLM-Ready Governance Package

**Version 1.0** | **Generated**: 2024  
**Journal**: Journal of Vegetation Science (JVS)  
**Publisher**: Wiley  
**Source**: JVS Author Guidelines (extracted and structured)

---

## 📦 Package Contents

This governance package contains **5 comprehensive files** designed for automated manuscript preparation and compliance enforcement:

### 1. **01_MACHINE_POLICY_PACK.yaml**
- Machine-readable YAML configuration
- 129 atomic rules with strengths (MUST/MUST_NOT/SHOULD/MAY)
- Organized by domain (scope, formatting, data, references, etc.)
- Each rule includes: ID, strength, condition, instruction, and automated check method
- **Use for**: CI/CD pipelines, automated validation systems, LLM configuration

### 2. **02_COMPLIANCE_CHECKLIST.md**
- Human-readable PASS/WARN/FAIL checklist
- Organized by submission phase
- Covers: scope fit, article type, files, abstract, keywords, formatting, taxonomy, data, references, tables, figures, SI, ethics, licensing
- Includes pre-submission checklist and common mistakes to avoid
- **Use for**: Author self-checks, editorial pre-screening, quality assurance

### 3. **03_TEMPLATES.md**
- Ready-to-use submission templates
- Includes:
  - Structured abstract template (with examples)
  - Title page template
  - 7 data availability statement variants
  - Cover letter templates (short and comprehensive)
  - Supporting Information file header template
  - Quick reference card
- **Use for**: Author guidance, automated document generation, standardization

### 4. **04_VALIDATION_RULE_SUMMARY.md**
- Complete index of all 129 rules in tabular format
- Categorizes by: Rule ID, Strength, Applies To, What To Check, Auto-Checkable?, Check Method
- Includes summary statistics:
  - 69 rules (53%) fully automatable
  - 35 rules (27%) semi-automatable
  - 25 rules (20%) require human judgment
- Identifies 8 critical "hard gate" rules
- **Use for**: System design, prioritization, test planning

### 5. **05_LLM_CONTROL_PROMPT.md**
- Complete system prompt for LLM-based manuscript preparation
- Includes:
  - Core capabilities and workflow
  - Mandatory rules with examples
  - Interaction rules and response templates
  - Special case handling
  - Quality assurance checklist
  - Example interactions
- **Use for**: Configuring Claude, GPT-4, or other LLMs for manuscript preparation

---

## 🎯 Use Cases

### For Developers
- **Automated Submission Systems**: Parse YAML rules into validation logic
- **CI/CD Pipelines**: Enforce compliance checks before submission
- **Document Generation**: Use templates to auto-generate compliant manuscripts
- **Quality Gates**: Implement 8 critical rules as hard gates in submission workflows

### For Researchers / Authors
- **Self-Service Tools**: Check manuscript compliance before submission
- **Template Library**: Access standardized templates for all submission components
- **Common Mistakes**: Avoid frequent errors using the checklist
- **Data Statements**: Select appropriate data availability statement template

### For Editorial Offices
- **Pre-Screening**: Systematically check submissions for critical violations
- **Author Guidance**: Provide clear, actionable feedback using rule IDs
- **Training**: Onboard new editorial staff with structured rules
- **Consistency**: Ensure uniform application of guidelines

### For LLM Applications
- **Manuscript Preparation Agents**: Configure AI systems to prepare compliant manuscripts
- **Compliance Checking Bots**: Build automated reviewers that flag violations
- **Author Assistance Tools**: Create interactive tools that guide authors through preparation
- **Quality Assurance**: Implement AI-powered checks before human editorial review

---

## 🚀 Quick Start

### For Authors (Manual Use)
1. Read `02_COMPLIANCE_CHECKLIST.md` to understand requirements
2. Use templates in `03_TEMPLATES.md` for your submission
3. Self-check using the checklist before submission

### For Developers (Integration)
1. Parse `01_MACHINE_POLICY_PACK.yaml` into your validation system
2. Refer to `04_VALIDATION_RULE_SUMMARY.md` for implementation priorities
3. Focus on the 69 fully automatable rules first
4. Implement the 8 critical "hard gate" rules as submission blockers

### For LLM Applications
1. Load `05_LLM_CONTROL_PROMPT.md` as system prompt
2. Provide manuscript content as user input
3. LLM will generate compliant output files + compliance report
4. Review and validate outputs using `02_COMPLIANCE_CHECKLIST.md`

---

## 📊 Key Statistics

### Rule Distribution
- **Total Rules**: 129
- **MUST / MUST_NOT**: 101 rules (78%) — non-negotiable
- **SHOULD / SHOULD_NOT**: 22 rules (17%) — strong recommendations
- **MAY**: 6 rules (5%) — optional/flexible

### Automation Potential
- **Fully Automatable**: 69 rules (53%)
  - Examples: word counts, file format checks, citation patterns
- **Semi-Automatable**: 35 rules (27%)
  - Examples: scope keywords, abbreviation detection, DOI presence
- **Manual Review Required**: 25 rules (20%)
  - Examples: novelty assessment, figure quality, content appropriateness

### Critical "Hard Gate" Rules
These 8 rules should block submission if violated:
1. **SCOPE-001**: Plant community focus (not single species)
2. **FILE-001**: Three separate files
3. **FILE-002**: Complete anonymization
4. **FILE-003**: Line numbers present
5. **STYLE-005/006/007**: Abstract word limit
6. **STYLE-011**: 8-10 keywords
7. **DATA-001**: Data availability statement
8. **ETH-009**: Submitting author ORCID

---

## 🔍 Rule Lookup

### By Domain
- **Scope**: SCOPE-001 to SCOPE-003 (3 rules)
- **Article Types**: ATYPE-001 to ATYPE-006 (6 rules)
- **Files**: FILE-001 to FILE-008 (8 rules)
- **Formatting**: FMT-001 to FMT-016 (16 rules)
- **Style**: STYLE-001 to STYLE-015 (15 rules)
- **Taxonomy**: TAX-001 to TAX-003 (3 rules)
- **Data & Code**: DATA-001 to DATA-008 (8 rules)
- **References**: REF-001 to REF-013 (13 rules)
- **Tables**: TBL-001 to TBL-009 (9 rules)
- **Figures**: FIG-001 to FIG-012 (12 rules)
- **Supporting Info**: SI-001 to SI-011 (11 rules)
- **Boxes**: BOX-001 to BOX-006 (6 rules)
- **Ethics & Review**: PEER-001 to ETH-011 (11 rules)
- **Licensing**: LIC-001 to LIC-003 (3 rules)
- **Acceptance**: ACC-001 to ACC-002 (2 rules)
- **Post-Acceptance**: POST-001 to POST-005 (5 rules)
- **Graphical TOC**: TOC-001 to TOC-002 (2 rules)

### By Strength
- **MUST**: 94 rules — Mandatory requirements
- **MUST_NOT**: 7 rules — Absolute prohibitions
- **SHOULD**: 15 rules — Strong recommendations
- **SHOULD_NOT**: 7 rules — Discouraged practices
- **MAY**: 6 rules — Optional/permitted

---

## 💡 Implementation Examples

### Example 1: Python Validation Script
```python
import yaml

# Load policy pack
with open('01_MACHINE_POLICY_PACK.yaml', 'r') as f:
    policy = yaml.safe_load(f)

# Check abstract word count (STYLE-005)
def check_abstract_length(abstract_text, article_type):
    word_count = len(abstract_text.split())
    limits = {
        'Research Article': 300,
        'Synthesis': 300,
        'Methodological Article': 300,
        'Forum': 200,
        'Report': 200,
        'Commentary': 60
    }
    
    limit = limits.get(article_type, 300)
    
    if word_count <= limit:
        return {'status': 'PASS', 'rule': 'STYLE-005', 'count': word_count}
    else:
        return {'status': 'FAIL', 'rule': 'STYLE-005', 'count': word_count, 'limit': limit}

# Check keyword count (STYLE-011)
def check_keywords(keywords_list):
    count = len(keywords_list)
    if 8 <= count <= 10:
        return {'status': 'PASS', 'rule': 'STYLE-011', 'count': count}
    else:
        return {'status': 'FAIL', 'rule': 'STYLE-011', 'count': count, 'expected': '8-10'}
```

### Example 2: LLM API Call
```python
import anthropic

# Load LLM control prompt
with open('05_LLM_CONTROL_PROMPT.md', 'r') as f:
    system_prompt = f.read()

# Initialize client
client = anthropic.Anthropic(api_key="your-api-key")

# Prepare manuscript
response = client.messages.create(
    model="claude-sonnet-4-20250514",
    max_tokens=4096,
    system=system_prompt,
    messages=[{
        "role": "user",
        "content": f"""
        Please prepare my manuscript for JVS submission:
        
        Title: {manuscript_title}
        Authors: {author_list}
        Abstract: {abstract_text}
        Main Text: {main_text}
        References: {references}
        """
    }]
)

# Response includes: title page, anonymized main text, compliance report
```

### Example 3: Regex Checks
```python
import re

# Check for "GB" instead of "UK" (FMT-008)
def check_country_codes(text):
    gb_pattern = r'\bGB\b'
    if re.search(gb_pattern, text):
        return {'status': 'FAIL', 'rule': 'FMT-008', 'message': 'Use UK not GB'}
    return {'status': 'PASS', 'rule': 'FMT-008'}

# Check for taxon authorities in title (STYLE-002)
def check_taxon_authorities_in_title(title):
    authority_pattern = r'[A-Z][a-z]+ [a-z]+ [A-Z]\.'
    if re.search(authority_pattern, title):
        return {'status': 'FAIL', 'rule': 'STYLE-002', 'message': 'Remove taxon authorities from title'}
    return {'status': 'PASS', 'rule': 'STYLE-002'}

# Check date format (FMT-012)
def check_date_format(text):
    correct_pattern = r'\d{1,2} (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{4}'
    incorrect_pattern = r'\d{1,2}/\d{1,2}/\d{2,4}|\d{4}-\d{2}-\d{2}'
    
    if re.search(incorrect_pattern, text):
        return {'status': 'WARN', 'rule': 'FMT-012', 'message': 'Use format: "2 Sep 2017"'}
    return {'status': 'PASS', 'rule': 'FMT-012'}
```

---

## 🔧 Technical Specifications

### File Formats
- **YAML**: UTF-8 encoded, YAML 1.2 compliant
- **Markdown**: CommonMark standard, UTF-8 encoded
- **Compatibility**: All files are plain text, version-control friendly

### Dependencies
- None (standalone package)
- Optional: YAML parser for programmatic access to policy pack
- Optional: LLM API (Anthropic Claude, OpenAI GPT) for automated preparation

### Integration Points
- **Submission Systems**: Parse YAML rules into validation logic
- **Document Processors**: Use templates for generation
- **LLM Applications**: Load control prompt as system configuration
- **CI/CD Pipelines**: Implement checks as pre-submission gates

---

## 📚 Related Resources

### Official JVS Resources
- **Submission Portal**: https://submission.wiley.com/journal/jvs
- **Author Guidelines**: Available on JVS website
- **Editorial Contact**: JVSAVS@wiley.com

### Associated Journal
- **Applied Vegetation Science**: For management/conservation/survey methods

### Companion Tools
- **Open Funder Registry**: https://www.crossref.org/services/funder-registry/
- **ORCID**: https://orcid.org
- **Data Repositories**: Zenodo, Figshare, Dryad
- **Anonymization Tool**: https://anonymous.4open.science

---

## ⚠️ Important Notes

### Accuracy
This governance package is based on JVS author guidelines as extracted from the provided document. While comprehensive, authors should:
- Verify current guidelines on the JVS website
- Check for any updates since package generation
- Consult editorial office for ambiguous cases

### Scope
This package covers:
- ✅ Manuscript preparation and formatting
- ✅ Submission file requirements
- ✅ Compliance checking and validation
- ❌ Editorial decision-making (acceptance/rejection)
- ❌ Peer review process details
- ❌ Post-acceptance production workflows

### Limitations
- **Manual rules**: 25 rules (20%) require human judgment and cannot be fully automated
- **Context-dependent**: Some rules depend on article type, study context, or editorial discretion
- **Living guidelines**: Journal policies may change; verify current requirements

---

## 🤝 Contributing

### Reporting Issues
If you find errors, ambiguities, or outdated information:
1. Document the specific rule ID
2. Cite the current JVS guideline section
3. Propose corrected/updated language
4. Submit via your internal issue tracking system

### Updating the Package
When JVS guidelines change:
1. Update `01_MACHINE_POLICY_PACK.yaml` with new/modified rules
2. Update corresponding sections in other files
3. Increment version number
4. Document changes in a CHANGELOG

---

## 📄 License & Attribution

**Source**: Journal of Vegetation Science Author Guidelines  
**Publisher**: Wiley  
**Package Created**: 2024  
**Version**: 1.0

This governance package is derived from publicly available author guidelines. It is intended for use by authors, developers, and editorial staff to facilitate compliant manuscript preparation.

---

## 📞 Support

### For Authors
- Email: JVSAVS@wiley.com
- Submission help: submissionhelp@wiley.com

### For Technical Issues
- Consult `04_VALIDATION_RULE_SUMMARY.md` for rule details
- Review `02_COMPLIANCE_CHECKLIST.md` for common issues
- Reference `03_TEMPLATES.md` for formatting examples

---

## 🎓 Citation

If using this governance package in research or development:

```
Journal of Vegetation Science LLM-Ready Governance Package (Version 1.0). 
Structured from JVS Author Guidelines. Wiley, 2024.
```

---

## ✨ Version History

**Version 1.0** (2024)
- Initial release
- 129 rules extracted and structured
- 5 comprehensive files
- Full template library
- LLM control prompt
- Complete validation index

---

## 🚦 Getting Started Checklist

- [ ] Review `README.md` (this file) for overview
- [ ] Examine `02_COMPLIANCE_CHECKLIST.md` for submission requirements
- [ ] Browse `03_TEMPLATES.md` for document templates
- [ ] Study `04_VALIDATION_RULE_SUMMARY.md` for rule reference
- [ ] Review `01_MACHINE_POLICY_PACK.yaml` for programmatic access
- [ ] Configure `05_LLM_CONTROL_PROMPT.md` for automated preparation

**Ready to submit to JVS!** 🌿📄✨
