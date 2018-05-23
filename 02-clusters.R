# #######################################
# Analyses of APS 2018 paper 
# clustering

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
SA4_PUR_age <- readRDS("./data/SA4_PUR_age.rds")
SA4_POE_age <- readRDS("./data/SA4_POE_age.rds")

# matrices
Xpur <- data.matrix(SA4_PUR_age[,-1])
Xpoe <- data.matrix(SA4_POE_age[,-1])

# #######################################
## k-means clustering - PUR - 4 clusters

# clustering 
kmeans4_pur <- kmeans(Xpur, 4)
# aggregate(Xpur, by = list(cluster = kmeans4_pur$cluster), mean)
# table(kmeans4_pur$cluster)
SA4_PUR_age$km4_pur <- as.factor(kmeans4_pur$cluster)
# table(SA4_PUR_age$km4_pur)

# age profiles
individual <- gather(SA4_PUR_age, Age, Proportion, `15-19 years`:`85+ years`, factor_key = TRUE) %>% 
  mutate(Age = gsub(" years", "", Age))

grouped <- gather(SA4_PUR_age, Age, Proportion, `15-19 years`:`85+ years`, factor_key = TRUE) %>% 
  group_by(Age, km4_pur) %>% 
  summarise(Proportion = mean(Proportion)) %>% 
  ungroup() %>% 
  mutate(Age = gsub(" years", "", Age))

ggplot(data = individual, aes(Age, Proportion, colour = km4_pur)) + 
  geom_line(aes(group = SA4), alpha = 0.15) + 
  geom_line(data = grouped, aes(group = km4_pur), size = 0.75) +
  theme_minimal(base_size = 12) + theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  scale_colour_brewer(palette = "Set2") +
  labs(colour="Cluster") +
  ggtitle("Individuals away from SA4 regions - clusters' age profiles and spatial distribution")

# map
SA4_PUR <- sp::merge(SA4, subset(SA4_PUR_age, SA4 != "Other Territories", select = c(SA4, km4_pur)),
                 by.x = "SA4_NAME16", by.y = "SA4")

tm_shape(SA4_PUR) +
  tm_polygons("km4_pur", palette = "Set2", title="Cluster", border.col = "white", lwd = 0.5, id = "SA4_NAME16") +
  tm_shape(states) +
  tm_borders(lwd = 0.5, alpha = 0.5)

# #######################################
## k-means clustering - POE - 4 clusters

# clustering 
kmeans4_poe <- kmeans(Xpoe, 4, nstart = 25)
# aggregate(Xpoe, by = list(cluster = kmeans4_poe$cluster), mean)
# table(kmeans4_poe$cluster)
SA4_POE_age$km4_poe <- as.factor(kmeans4_poe$cluster)
# table(SA4_POE_age$km4_poe)

# age profiles
individual <- gather(SA4_POE_age, Age, Proportion, `15-19 years`:`85+ years`, factor_key = TRUE) %>% 
  mutate(Age = gsub(" years", "", Age))

grouped <- gather(SA4_POE_age, Age, Proportion, `15-19 years`:`85+ years`, factor_key = TRUE) %>% 
  group_by(Age, km4_poe) %>% 
  summarise(Proportion = mean(Proportion)) %>% 
  ungroup() %>% 
  mutate(Age = gsub(" years", "", Age))

ggplot(data = individual, aes(Age, Proportion, colour = km4_poe)) + 
  geom_line(aes(group = SA4), alpha = 0.15) + 
  geom_line(data = grouped, aes(group = km4_poe), size = 0.75) +
  theme_minimal(base_size = 12) + theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  scale_colour_brewer(palette = "Set2") +
  labs(colour="Cluster") +
  ggtitle("Individuals inside SA4 regions - clusters' age profiles and spatial distribution")

# map
SA4_POE <- sp::merge(SA4, subset(SA4_POE_age, SA4 != "Other Territories", select = c(SA4, km4_poe)),
                 by.x = "SA4_NAME16", by.y = "SA4")

tm_shape(SA4_POE) +
  tm_polygons("km4_poe", palette = "Set2", title="Cluster", border.col = "white", lwd = 0.5, id = "SA4_NAME16") +
  tm_shape(states) +
  tm_borders(lwd = 0.5, alpha = 0.5)
