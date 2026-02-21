import argparse
import csv
import re
import textwrap
from dataclasses import dataclass
from datetime import datetime
from difflib import SequenceMatcher
from pathlib import Path

import requests
from docx import Document


@dataclass
class Citation:
    raw: str
    author: str
    year: str
    location: str


@dataclass
class Reference:
    ref_id: str
    raw: str
    first_author: str
    year: str
    title: str
    doi: str


def normalize_space(text: str) -> str:
    return re.sub(r"\s+", " ", text).strip()


def extract_paragraphs(docx_path: Path) -> list[str]:
    doc = Document(str(docx_path))
    paras = [p.text.strip() for p in doc.paragraphs if p.text.strip()]
    return paras


def split_references(paras: list[str]) -> tuple[list[str], list[str]]:
    ref_idx = None
    for i, p in enumerate(paras):
        if p.strip().lower() == "references":
            ref_idx = i
            break
    if ref_idx is None:
        return paras, []
    return paras[:ref_idx], paras[ref_idx + 1 :]


def extract_intext_citations(text_blocks: list[str]) -> list[Citation]:
    citations: list[Citation] = []
    parenthetical = re.compile(r"\(([^()]*\d{4}[a-z]?[^()]*)\)")
    narrative = re.compile(
        r"\b([A-Z][A-Za-z\-']+)(?:\s+&\s+[A-Z][A-Za-z\-']+)?(?:\s+et al\.)?\s+\((\d{4}[a-z]?)\)"
    )

    for idx, block in enumerate(text_blocks, start=1):
        for match in narrative.finditer(block):
            author = match.group(1)
            year = match.group(2)
            citations.append(
                Citation(raw=match.group(0), author=author, year=year, location=f"p{idx}")
            )
        for match in parenthetical.finditer(block):
            content = match.group(1)
            parts = [p.strip() for p in content.split(";")]
            for part in parts:
                m = re.search(r"(.+?)\s+(\d{4}[a-z]?)", part)
                if not m:
                    continue
                author_chunk = m.group(1)
                year = m.group(2)
                author = re.split(r"\s*&\s*|\s+et al\.", author_chunk)[0].strip()
                citations.append(
                    Citation(raw=part, author=author, year=year, location=f"p{idx}")
                )
    return citations


def parse_reference_entry(raw: str, ref_id: str) -> Reference:
    doi = ""
    doi_match = re.search(r"https?://doi\.org/\S+", raw)
    if doi_match:
        doi = doi_match.group(0).rstrip(".")

    year_match = re.search(r"\b(19|20)\d{2}[a-z]?\b", raw)
    year = year_match.group(0) if year_match else ""

    first_author = ""
    author_match = re.match(r"^([^,]+)", raw)
    if author_match:
        first_author = author_match.group(1).strip()

    title = ""
    if year:
        after_year = raw.split(year, 1)[-1]
        title_match = re.search(r"\)\s*([^\.]+)\.", after_year)
        if title_match:
            title = title_match.group(1).strip()

    return Reference(
        ref_id=ref_id,
        raw=raw,
        first_author=first_author,
        year=year,
        title=title,
        doi=doi,
    )


def build_reference_index(refs: list[Reference]) -> dict[tuple[str, str], list[Reference]]:
    index: dict[tuple[str, str], list[Reference]] = {}
    for r in refs:
        key = (r.first_author.lower(), r.year)
        index.setdefault(key, []).append(r)
    return index


def match_citations_to_refs(
    citations: list[Citation], refs_index: dict[tuple[str, str], list[Reference]]
) -> list[dict]:
    rows = []
    for c in citations:
        key = (c.author.lower(), c.year)
        matches = refs_index.get(key, [])
        matched_id = matches[0].ref_id if matches else ""
        rows.append(
            {
                "citation_raw": c.raw,
                "citation_author": c.author,
                "citation_year": c.year,
                "location": c.location,
                "matched_reference_id": matched_id,
                "status": "matched" if matched_id else "missing",
            }
        )
    return rows


def find_uncited_references(
    citations: list[Citation], refs: list[Reference]
) -> list[Reference]:
    cited_keys = {(c.author.lower(), c.year) for c in citations}
    uncited = [r for r in refs if (r.first_author.lower(), r.year) not in cited_keys]
    return uncited


def write_csv(path: Path, fieldnames: list[str], rows: list[dict]) -> None:
    with path.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)


def sentence_split(text: str) -> list[str]:
    parts = re.split(r"(?<=[.!?])\s+", text)
    return [p.strip() for p in parts if p.strip()]


def build_claims(text_blocks: list[str]) -> list[dict]:
    claims = []
    cite_pattern = re.compile(r"\(([^()]*\d{4}[a-z]?[^()]*)\)")
    for idx, block in enumerate(text_blocks, start=1):
        for sentence in sentence_split(block):
            if cite_pattern.search(sentence):
                claims.append(
                    {
                        "claim_id": f"CLM_{len(claims)+1:04d}",
                        "location": f"p{idx}",
                        "sentence": sentence,
                        "status": "needs_manual_review",
                        "notes": "",
                    }
                )
    return claims


def crossref_lookup(query: str) -> dict:
    url = "https://api.crossref.org/works"
    params = {"query.bibliographic": query, "rows": 1}
    headers = {"User-Agent": "JVS-Reference-Auditor/1.0 (mailto:unknown@example.com)"}
    try:
        resp = requests.get(url, params=params, headers=headers, timeout=20)
        resp.raise_for_status()
        data = resp.json()
        items = data.get("message", {}).get("items", [])
        return items[0] if items else {}
    except Exception:
        return {}


def similarity(a: str, b: str) -> float:
    return SequenceMatcher(None, a.lower(), b.lower()).ratio()


def verify_references(refs: list[Reference]) -> list[dict]:
    results = []
    for r in refs:
        query_parts = [r.first_author, r.year, r.title]
        query = normalize_space(" ".join(p for p in query_parts if p))
        item = crossref_lookup(query)
        status = "unconfirmed"
        matched_doi = ""
        matched_title = ""
        matched_year = ""
        matched_first_author = ""

        if item:
            matched_title = " ".join(item.get("title", [])).strip()
            matched_doi = f"https://doi.org/{item.get('DOI')}" if item.get("DOI") else ""
            issued = item.get("issued", {}).get("date-parts", [[None]])[0][0]
            matched_year = str(issued) if issued else ""
            author_list = item.get("author", [])
            if author_list:
                matched_first_author = author_list[0].get("family", "")

            score = similarity(r.title, matched_title) if r.title and matched_title else 0.0
            if matched_year == r.year and matched_first_author.lower() == r.first_author.lower():
                status = "confirmed" if score >= 0.6 else "tentative"

        results.append(
            {
                "reference_id": r.ref_id,
                "query": query,
                "status": status,
                "matched_title": matched_title,
                "matched_first_author": matched_first_author,
                "matched_year": matched_year,
                "matched_doi": matched_doi,
            }
        )
    return results


def convert_to_markdown(paras: list[str]) -> str:
    lines = []
    for p in paras:
        if p.lower() in {"abstract", "introduction", "methods", "results", "discussion", "conclusions", "references"}:
            lines.append(f"## {p}")
        else:
            lines.append(p)
        lines.append("")
    return "\n".join(lines).strip() + "\n"


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Validate in-text citations and references, and prepare web verification inputs."
    )
    parser.add_argument("docx_path", type=Path, help="Path to MAIN_TEXT.docx")
    parser.add_argument(
        "--output-dir",
        type=Path,
        default=Path("D:/2025-2026/Vegetation_Ecology/06_converted_to_JVS"),
        help="Output directory for extracted files",
    )
    args = parser.parse_args()

    docx_path = args.docx_path
    output_dir = args.output_dir
    output_dir.mkdir(parents=True, exist_ok=True)

    paras = extract_paragraphs(docx_path)
    main_text, ref_paras = split_references(paras)

    citations = extract_intext_citations(main_text)
    refs = [parse_reference_entry(p, f"REF_{i+1:04d}") for i, p in enumerate(ref_paras)]

    refs_index = build_reference_index(refs)
    mapping_rows = match_citations_to_refs(citations, refs_index)

    uncited = find_uncited_references(citations, refs)
    uncited_rows = [
        {
            "reference_id": r.ref_id,
            "first_author": r.first_author,
            "year": r.year,
            "raw": r.raw,
        }
        for r in uncited
    ]

    claims = build_claims(main_text)
    verification = verify_references(refs)

    write_csv(
        output_dir / "citations_extracted.csv",
        ["citation_raw", "citation_author", "citation_year", "location"],
        [
            {
                "citation_raw": c.raw,
                "citation_author": c.author,
                "citation_year": c.year,
                "location": c.location,
            }
            for c in citations
        ],
    )
    write_csv(
        output_dir / "references_extracted.csv",
        ["reference_id", "first_author", "year", "title", "doi", "raw"],
        [
            {
                "reference_id": r.ref_id,
                "first_author": r.first_author,
                "year": r.year,
                "title": r.title,
                "doi": r.doi,
                "raw": r.raw,
            }
            for r in refs
        ],
    )
    write_csv(
        output_dir / "citation_reference_map.csv",
        [
            "citation_raw",
            "citation_author",
            "citation_year",
            "location",
            "matched_reference_id",
            "status",
        ],
        mapping_rows,
    )
    write_csv(
        output_dir / "uncited_references.csv",
        ["reference_id", "first_author", "year", "raw"],
        uncited_rows,
    )
    write_csv(
        output_dir / "claims_to_verify.csv",
        ["claim_id", "location", "sentence", "status", "notes"],
        claims,
    )
    write_csv(
        output_dir / "web_verification.csv",
        [
            "reference_id",
            "query",
            "status",
            "matched_title",
            "matched_first_author",
            "matched_year",
            "matched_doi",
        ],
        verification,
    )

    md_text = convert_to_markdown(paras)
    md_path = output_dir / "MAIN_TEXT_extracted.md"
    md_path.write_text(md_text, encoding="utf-8")

    readme = textwrap.dedent(
        f"""
        Reference validation outputs created: {datetime.now().strftime('%Y-%m-%d %H:%M')}

        Files:
        - citations_extracted.csv
        - references_extracted.csv
        - citation_reference_map.csv
        - uncited_references.csv
        - claims_to_verify.csv
        - web_verification.csv
        - MAIN_TEXT_extracted.md
        """
    ).strip()
    (output_dir / "validation_outputs.README.txt").write_text(readme, encoding="utf-8")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
