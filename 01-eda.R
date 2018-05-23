# #######################################
# Analyses of APS 2018 paper 
# exploratory graphs

# #######################################
# packages and setup

set.seed(12345)

library(tidyverse)
library(readxl)
library(tmap)

# #######################################
# geo data
SA4 <- readRDS(file = "./data/SA4_2016_AUST_clean.rds")
states <- readRDS(file = "./data/STE_2016_AUST_clean.rds")

# census data
age_sex_night <- readRDS("./data/age_sex_cenight_fullpop.rds")
SA4_sex <- readRDS("./data/SA4_sex.rds")
SA4_NMR <- readRDS("./data/SA4_NMR.rds")

# #######################################
# proportion of individuals 'elsewhere' across age & sex
ggplot(age_sex_night, aes(x = Age, y = Proportion, linetype = Sex)) + 
  geom_line() +
  xlim(0, 85) + ylim(0, NA) +
  theme_minimal(base_size = 12) + 
  ggtitle("Individuals away from usual place of residence during Census night")

# sex ratio across SA4
tm_shape(SA4_sex) +
  tm_polygons("Ratio", palette = "-RdYlBu", title="NMR", border.col = "white", lwd = 0.5, id = "SA4_NAME16", popup.vars = c("Ratio")) +
  tm_shape(states) +
  tm_borders(lwd = 0.5, alpha = 0.5)

# net migration rate
tm_shape(SA4_NMR) +
  tm_polygons("NMR_cat", palette = "-RdYlBu", title="NMR", border.col = "white", lwd = 0.5, id = "SA4_NAME16", popup.vars = c("NMR", "NMR_cat")) +
  tm_shape(states) +
  tm_borders(lwd = 0.5, alpha = 0.5)