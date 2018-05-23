Geographical and tabular data derived from Australian Bureau of Statistics.

Region boundaries simplified with `rmapshaper` package (default settings) and saved to `rds` files. All files exclude 'Other Teritories':

- `GCCSA_2016_AUST_clean.rds`	- boundaries of five cities
- `SA4_2016_AUST_clean.rds`	- SA4 level boundaries
- `STE_2016_AUST_clean.rds`	- state boundaries

Tabular data derived from Census TableBuilder (login required):

- `age_sex_cenight_fullpop.rds` - proporiton of individuals registered outside of their place of usual residence (PUR) on Census night, stratified by age and sex, using full census dataset without any exclusions, aggregating individuals 85 year old and over (to avoid small n problem)
- `SA4_sex.rds` - SA4 geographical level, place of enumeration (POE) men to women ratio (*100), using working population only, all ages aggregated, 'Other teritories' excluded

