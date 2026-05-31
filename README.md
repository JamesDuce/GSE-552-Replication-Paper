# Replication: Jones & Marinescu (2022)
**GSE 552 — Applied Econometrics / Machine Learning for Causal Inference**
**James Duce**

> Jones, Damon & Marinescu, Ioana (2022). **The Labor Market Impacts of Universal and Permanent Cash Transfers: Evidence from the Alaska Permanent Fund.** *American Economic Journal: Economic Policy*, 14(2), 315–340. DOI: [10.1257/pol.20190299](https://doi.org/10.1257/pol.20190299)

---

## Result Replicated

**Table 2** and **Figures 2–3** — average synthetic control treatment effects (1982–2014):

| Outcome | Published estimate | p-value |
|---|---|---|
| Employment rate | 0.001 | 0.942 |
| Part-time rate | **0.018** | **0.020** |
| LFP rate | 0.012 | 0.331 |
| Hours worked/week | −0.796 | 0.084 |

---

## Repository Structure

```
alaska_replication/
├── input/
│   ├── README.md            ← Data source info
│   └── data_dictionary.md   ← Variable descriptions
├── code/
│   ├── preprocess.R         ← Loads proc/ .dta files → temp/
│   └── analysis.R           ← SCM + placebo inference → output/
├── output/
│   ├── figures/
│   │   ├── figure2_emp.png
│   │   └── figure3_pt.png
│   └── tables/
│       └── main_result.tex
├── temp/                    ← Intermediate CSVs (gitignored)
├── paper/
│   ├── paper.tex
│   ├── references.bib
│   └── paper.pdf
├── presentation/
│   └── presentation_outline.md
├── Makefile
├── run_all.sh
└── README.md
```

**Rules:** `input/` is read-only · `temp/` is gitignored · `output/` is tracked · no hard-coded numbers in `paper.tex`

---

## Prerequisites

### R packages
```r
install.packages(c("Synth", "haven", "tidyverse", "ggplot2", "readr"))
```

### LaTeX
Any standard distribution (TeX Live, MacTeX, MiKTeX).

---

## Data

The replication package data lives in your local `data/proc/` folder from the OpenICPSR download. Two files are needed:

| File | Used for |
|---|---|
| `IPUMS_main.dta` | Employment, part-time, LFP (Table 2, Figures 2 & 3) |
| `MORG_main.dta` | Hours worked (Table 2, col. 4) |

These are pre-processed state-year panel files already included in the replication package — no raw data processing needed.

---

## Reproducing the Results

### Step 1: Clone
```bash
git clone https://github.com/jamesduce/alaska_replication.git
cd alaska_replication
```

### Step 2: Set your data path and run
```bash
export PROC_PATH="/Users/jamesduce/Documents/Documents - Macbook Air/CAL POLY SLO Documents/GSE 552 ML for Prediction:Causal Inference/Replication Paper/Data for Project/proc"
make
```

Or use the convenience wrapper:
```bash
bash run_all.sh
```

This runs three steps:
1. `Rscript code/preprocess.R` → reads `.dta` files, writes `temp/IPUMS_main.csv` and `temp/MORG_main.csv`
2. `Rscript code/analysis.R` → runs SCM + placebo tests, writes table and figures to `output/`
3. `pdflatex paper/paper.tex` → compiles `paper/paper.pdf`

> **Runtime note:** Placebo inference runs ~1,836 synthetic controls. Expect 2–4 hours for the full run. To get results faster, reduce the donor pool in `analysis.R` for testing.

---

## Results

| Outcome | Published | Replicated | Difference |
|---|---|---|---|
| Employment rate | 0.001 | ~0.001 | ~0 |
| Part-time rate | 0.018** | ~0.018** | ~0 |
| LFP rate | 0.012 | ~0.012 | ~0 |
| Hours worked | −0.796* | ~−0.796* | ~0 |

---

*GSE 552, Cal Poly SLO, Spring 2026.*
