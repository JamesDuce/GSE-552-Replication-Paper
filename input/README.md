# Input Data

## Source

Jones, Damon & Marinescu, Ioana (2022).  
*The Labor Market Impacts of Universal and Permanent Cash Transfers: Evidence from the Alaska Permanent Fund.*  
American Economic Journal: Economic Policy.

Replication package: https://www.openicpsr.org/openicpsr/project/140121/version/V2/view

## Download Instructions

1. Navigate to https://www.openicpsr.org/openicpsr/project/140121/version/V2/view
2. Click **Download This Project** (requires free ICPSR account)
3. Unzip the archive into this `input/` directory
4. The key files needed for this replication are:
   - `data/cps_all.dta` — CPS state-year panel (main dataset)
   - `data/cps_morg.dta` — CPS Merged Outgoing Rotation Groups sub-sample

## Notes

- Data cannot be committed to Git due to file size (~500 MB unzipped)
- The raw input files must NEVER be modified by any script
- All cleaning/transformation happens in `code/preprocess.R`
