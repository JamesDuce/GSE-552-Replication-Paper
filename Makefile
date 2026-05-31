# =============================================================================
# Makefile — Jones & Marinescu (2022) Replication
# James Duce | GSE 552
#
# Usage:
#   make            — full pipeline
#   make data       — preprocessing only
#   make analysis   — analysis only (needs temp/ data)
#   make paper      — compile LaTeX only
#   make clean      — remove all generated files
# =============================================================================

.PHONY: all data analysis paper clean help

all: paper/paper.pdf

# ---------------------------------------------------------------------------
# Step 1: Preprocessing
# Edit PROC_PATH to match your machine (or export PROC_PATH= before make)
# ---------------------------------------------------------------------------
PROC_PATH ?= /Users/jamesduce/Documents/Documents - Macbook Air/CAL POLY SLO Documents/GSE 552 ML for Prediction:Causal Inference/Replication Paper/Data for Project/proc

temp/IPUMS_main.csv temp/MORG_main.csv: code/preprocess.R
	@echo ">>> Preprocessing..."
	PROC_PATH="$(PROC_PATH)" Rscript code/preprocess.R

data: temp/IPUMS_main.csv temp/MORG_main.csv

# ---------------------------------------------------------------------------
# Step 2: Analysis → table + figures
# ---------------------------------------------------------------------------
output/tables/main_result.tex output/figures/figure2_emp.png output/figures/figure3_pt.png: \
		temp/IPUMS_main.csv temp/MORG_main.csv code/analysis.R
	@echo ">>> Running analysis..."
	Rscript code/analysis.R

analysis: output/tables/main_result.tex output/figures/figure2_emp.png output/figures/figure3_pt.png

# ---------------------------------------------------------------------------
# Step 3: Compile paper
# ---------------------------------------------------------------------------
paper/paper.pdf: paper/paper.tex paper/references.bib \
		output/tables/main_result.tex \
		output/figures/figure2_emp.png \
		output/figures/figure3_pt.png
	@echo ">>> Compiling paper..."
	cd paper && pdflatex -interaction=nonstopmode paper.tex
	cd paper && bibtex paper
	cd paper && pdflatex -interaction=nonstopmode paper.tex
	cd paper && pdflatex -interaction=nonstopmode paper.tex
	@echo ">>> Done: paper/paper.pdf"

paper: paper/paper.pdf

# ---------------------------------------------------------------------------
# Clean
# ---------------------------------------------------------------------------
clean:
	rm -f temp/IPUMS_main.csv temp/MORG_main.csv
	rm -f output/tables/*.tex output/figures/*.png output/figures/*.pdf
	rm -f paper/paper.pdf paper/paper.aux paper/paper.log \
	      paper/paper.bbl paper/paper.blg paper/paper.out

help:
	@echo "make          — full pipeline (data → analysis → paper)"
	@echo "make data     — preprocessing only"
	@echo "make analysis — SCM + figures (needs temp/ data)"
	@echo "make paper    — LaTeX only"
	@echo "make clean    — remove generated files"
