## Tidy data concept

counts_df <- data.frame(
  day = c("Monday","Tuesday","Wednesday"),
  wolf = c(2, 1, 3),
  hare = c(20, 25, 30),
  fox = c(4, 4, 4)
)

## Reshaping multiple columns in category/value pairs

library(tidyr)
counts_gather <- gather(counts_df,key = 'species', value = 'count', wolf:fox)

counts_spread <- spread(counts_gather, key = species, value = count)

## Exercise 1

counts_gather <- counts_gather[-2,]



## Read comma-separated-value (CSV) files

surveys <- read.csv("data/surveys.csv", na.strings="")
## Subsetting and sorting

library(dplyr)
surveys_1990_winter <- filter(surveys,year == 1990,month %in% 1:3)

surveys_1990_winter <- select(surveys_1990_winter, record_id, month, day, plot_id, species_id, sex, hindfoot_length, weight)

surveys_1990_winter <- select(surveys_1990_winter, -year)


sorted <- arrange(surveys_1990_winter, desc(species_id), weight)

## Exercise 2

surveys_RO <- filter(surveys, species_id == 'RO')
surveys_RO <- select(surveys_RO, record_id, sex, weight)

## Grouping and aggregation

surveys_1990_winter_gb <- group_by(surveys_1990_winter, species_id)

counts_1990_winter <- summarize(surveys_1990_winter_gb, count = n())

## Exercise 3

surveys_DM <- filter(surveys, species_id == "DM")
surveys_DM <- group_by(surveys_DM, month)
Surveys_DM_Avg_Weight_Avg_Hindfoot <- summarize(surveys_DM, mean(weight, na.rm = TRUE), mean(hindfoot_length, na.rm = TRUE))

## Transformation of variables
## Create new column containing proportion of each species in the data set

prop_1990_winter <- mutate(counts_1990_winter, prop = count /sum(count) )

## Exercise 4



minWeight_1990_winter <- filter(surveys_1990_winter_gb, weight == min(weight))

rank_Hindfoot <- mutate(surveys_1990_winter_gb, H_rank = row_number(hindfoot_length))



## Chainning with pipes

c(1,3,5) %>% sum(na.rm=TRUE)

prop_1990_winter_piped <- surveys %>%
  filter(year == 1990, month %in% 1:3)  %>%
  select(-year) %>% # select all columns but year
  group_by(species_id) %>% # group by species_id
  summarize(count = n()) %>% # summarize with counts
  mutate(prop = count / sum(count)) # mutate into proportions
