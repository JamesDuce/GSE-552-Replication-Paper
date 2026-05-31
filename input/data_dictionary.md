# Data Dictionary

All variables used in the replication of Jones & Marinescu (2022).  
Source: Current Population Survey (CPS), monthly files, July 1977 – June 2015.  
Unit of observation (analysis file): state × year cell.

| Variable | Description | Units | Source |
|---|---|---|---|
| `state` | State FIPS code | Integer (1–56) | CPS |
| `year` | Survey year | Integer (1977–2015) | CPS |
| `emp_rate` | Employment-to-population ratio | Proportion (0–1) | CPS |
| `pt_rate` | Part-time employment rate (part-time workers / population) | Proportion (0–1) | CPS |
| `lfp_rate` | Labor force participation rate | Proportion (0–1) | CPS |
| `hrs_worked` | Average hours worked last week (conditional on employment) | Hours per week | CPS MORG |
| `alaska` | Indicator = 1 if state is Alaska | Binary | Constructed |
| `post1982` | Indicator = 1 if year ≥ 1982 (post-dividend) | Binary | Constructed |
| `share_female` | Share of state population that is female | Proportion | CPS |
| `share_age1829` | Share of population aged 18–29 | Proportion | CPS |
| `share_age3049` | Share of population aged 30–49 | Proportion | CPS |
| `share_age50plus` | Share of population aged 50+ | Proportion | CPS |
| `share_hs` | Share with high school diploma (highest education) | Proportion | CPS |
| `share_somecol` | Share with some college | Proportion | CPS |
| `share_col` | Share with 4-year college degree or more | Proportion | CPS |
| `share_manuf` | Share employed in manufacturing | Proportion | CPS |
| `share_mining` | Share employed in mining/extraction | Proportion | CPS |
| `share_govt` | Share employed in government | Proportion | CPS |
| `share_married` | Share of adults who are married | Proportion | CPS |

## Key Identifiers

- **Treatment unit**: Alaska (FIPS = 2)
- **Treatment onset**: 1982 (first year of Alaska Permanent Fund Dividend payments)
- **Pre-treatment period**: 1977–1981
- **Post-treatment period**: 1982–2014
- **Donor pool**: All other 50 states + D.C. (49 donor units)
