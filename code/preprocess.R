# =============================================================================
# preprocess.R
# GSE 552 Replication: Jones & Marinescu (2022)
# James Duce
#
# PURPOSE: Load pre-processed proc/ data files, verify structure,
#          and write analysis-ready CSVs to temp/.
#
# INPUTS:  [proc_path]/IPUMS_main.dta   — state-year panel, main outcomes
#          [proc_path]/MORG_main.dta    — state-year panel, hours worked
#
# OUTPUTS: temp/IPUMS_main.csv
#          temp/MORG_main.csv
#
# USAGE:   Rscript code/preprocess.R
#          (set PROC_PATH env var or edit the path below)
# =============================================================================

suppressPackageStartupMessages({
  library(haven)
  library(dplyr)
  library(readr)
})

cat("=== preprocess.R ===\n")

# ---------------------------------------------------------------------------
# Set data path — edit this to match your machine, or set env var PROC_PATH
# ---------------------------------------------------------------------------
proc_path <- Sys.getenv("PROC_PATH", unset = paste0(
  "/Users/jamesduce/Documents/Documents - Macbook Air/",
  "CAL POLY SLO Documents/GSE 552 ML for Prediction:Causal Inference/",
  "Replication Paper/Data for Project/proc"
))
cat(sprintf("Reading from: %s\n", proc_path))

# ---------------------------------------------------------------------------
# 1. Load and verify IPUMS_main.dta
# ---------------------------------------------------------------------------
ipums_path <- file.path(proc_path, "IPUMS_main.dta")
cat(sprintf("\nLoading %s ...\n", basename(ipums_path)))

ipums <- read_dta(ipums_path) %>%
  mutate(across(everything(), zap_labels)) %>%   # drop Stata value labels
  filter(!is.na(year), !is.na(statefip))

cat(sprintf("  Rows:    %s\n",   format(nrow(ipums), big.mark = ",")))
cat(sprintf("  Years:   %d – %d\n", min(ipums$year), max(ipums$year)))
cat(sprintf("  States:  %d unique FIPS\n", n_distinct(ipums$statefip)))
cat(sprintf("  Columns: %s\n", paste(names(ipums), collapse = ", ")))

# Verify key outcome variables are present
required_ipums <- c("year", "statefip", "employed", "parttime", "activelf",
                    "female", "age1", "age2", "age3", "age4",
                    "educ1", "educ2", "educ3")
missing <- setdiff(required_ipums, names(ipums))
if (length(missing) > 0) stop(paste("Missing columns:", paste(missing, collapse = ", ")))
cat("  All required columns present.\n")

# ---------------------------------------------------------------------------
# 2. Load and verify MORG_main.dta
# ---------------------------------------------------------------------------
morg_path <- file.path(proc_path, "MORG_main.dta")
cat(sprintf("\nLoading %s ...\n", basename(morg_path)))

morg <- read_dta(morg_path) %>%
  mutate(across(everything(), zap_labels)) %>%
  filter(!is.na(year), !is.na(statefip))

cat(sprintf("  Rows:    %s\n",   format(nrow(morg), big.mark = ",")))
cat(sprintf("  Years:   %d – %d\n", min(morg$year), max(morg$year)))
cat(sprintf("  States:  %d unique FIPS\n", n_distinct(morg$statefip)))
cat(sprintf("  Columns: %s\n", paste(names(morg), collapse = ", ")))

required_morg <- c("year", "statefip", "hourslw")
missing_morg <- setdiff(required_morg, names(morg))
if (length(missing_morg) > 0) stop(paste("Missing MORG columns:", paste(missing_morg, collapse = ", ")))
cat("  All required columns present.\n")

# ---------------------------------------------------------------------------
# 3. Write to temp/
# ---------------------------------------------------------------------------
dir.create("temp", showWarnings = FALSE)
write_csv(ipums, "temp/IPUMS_main.csv")
write_csv(morg,  "temp/MORG_main.csv")
cat("\n=== Summary ===\n")

alaska_pre <- ipums %>% filter(statefip == 2, year < 1982)
cat(sprintf("Alaska pre-1982 mean employment rate: %.4f\n", mean(alaska_pre$employed,  na.rm = TRUE)))
cat(sprintf("Alaska pre-1982 mean part-time rate:  %.4f\n", mean(alaska_pre$parttime,  na.rm = TRUE)))
cat(sprintf("Alaska pre-1982 mean LFP rate:        %.4f\n", mean(alaska_pre$activelf,  na.rm = TRUE)))

alaska_pre_morg <- morg %>% filter(statefip == 2, year < 1982)
cat(sprintf("Alaska pre-period mean hours worked:  %.4f\n", mean(alaska_pre_morg$hourslw, na.rm = TRUE)))

cat("\nOutputs written to temp/IPUMS_main.csv and temp/MORG_main.csv\n")
cat("=== preprocess.R complete ===\n")
