param(
  [string]$Main = "01_manuscript_jvs"
)

$ErrorActionPreference = "Stop"

Write-Host "Building $Main.tex ..."

pdflatex -interaction=nonstopmode "$Main.tex"
bibtex "$Main"
pdflatex -interaction=nonstopmode "$Main.tex"
pdflatex -interaction=nonstopmode "$Main.tex"

Write-Host "Build complete: $Main.pdf"