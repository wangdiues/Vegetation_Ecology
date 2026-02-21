======================================================================
 README — LaTeX Compilation Instructions
 JVS Manuscript Package
======================================================================

1. PREREQUISITES
   - A LaTeX distribution (e.g. TeX Live 2023+, MiKTeX)
   - Required packages: inputenc, fontenc, mathptmx, geometry, setspace,
     lineno, graphicx, booktabs, natbib, hyperref, amsmath, textcomp, gensymb
   - The chicago.bst bibliography style file

2. FILE STRUCTURE
   01_manuscript_jvs.tex        Main manuscript source
   02_references.bib            BibTeX reference database
   03_figures/                  Figure files (PDF + PNG)
   04_tables/                   CSV source tables (Table01–06)
   05_supporting_information/   Appendix S01–S10 CSV files
   06_README_compile.txt        This file
   build_latex.ps1              Helper build script

3. COMPILATION STEPS
   From this directory, run either:

     pdflatex -interaction=nonstopmode 01_manuscript_jvs.tex
     bibtex 01_manuscript_jvs
     pdflatex -interaction=nonstopmode 01_manuscript_jvs.tex
     pdflatex -interaction=nonstopmode 01_manuscript_jvs.tex

   Or:

     ./build_latex.ps1

4. NOTES
   - Main text is anonymized for double-anonymized review.
   - Citation style is Chicago author-date via natbib + chicago.bst.
   - Figures are included from PDF files in 03_figures.
   - Supporting Information follows Appendix S naming.
   - If pdflatex reports it cannot write `01_manuscript_jvs.pdf`, close any
     open PDF viewer using that file and rerun.

======================================================================