Geographical and tabular data derived from Australian Bureau of Statistics.

Region boundaries (2016) simplified with `rmapshaper` package (default settings) and saved to `rds` files. All files exclude 'Other Teritories':

- `GCCSA_2016_AUST_clean.rds`	- boundaries of five cities
- `SA4_2016_AUST_clean.rds`	- SA4 level boundaries
- `STE_2016_AUST_clean.rds`	- state boundaries

Census 2016 data derived from TableBuilder (login required):

- `age_sex_cenight_fullpop.rds` - proporiton of individuals registered outside of their place of usual residence (PUR) on Census night, stratified by age and sex, using full census dataset without any exclusions, aggregating individuals 85 year old and over (to avoid small n problem)
- `SA4_sex.rds` - SA4 geographical level, place of enumeration (POE) men to women ratio (*100), using working population only, all ages aggregated, 'Other teritories' excluded
- `SA4_NMR.rds` - SA4 geographical level, PUR x POE matrix used, using working population only, all ages aggregated, 'Other teritories' excluded
- `SA4_PUR_age` - SA4 geographical level, using working population only, age band  proportions of *PUR*, aggregating individuals 85 year old and over to form one class, data for clustering includes 'Other teritories' but maps exclude them 
- `SA4_POE_age` - SA4 geographical level, using working population only, age band  proportions of *POE*, aggregating individuals 85 year old and over to form one class, data for clustering includes 'Other teritories' but maps exclude them 
