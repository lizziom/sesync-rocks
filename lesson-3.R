## Libraries and data

library(dplyr)
library(ggplot2)
surveys <- read.csv("data/surveys.csv", na.strings = "") %>%
  filter(!is.na(species_id), !is.na(sex), !is.na(weight))
## !is.na will remove all entries that don't have data input
## Constructing layered graphics in ggplot

ggplot(data = surveys,
       aes(x = species_id, y = weight)) +
  geom_point()

ggplot(data = surveys,
       aes(x = species_id, y = weight)) +
  geom_boxplot() +
  geom_point(stat = "summary",
             fun.y = "mean",
             color = "red")
# With stat = "summary", we can plot a summary statistic (defined by fun.y ) instead of the raw data.  Setting Color = red applies one color to the whole later.

qplot(data = surveys, x=species_id, y=weight, geom="boxplot")

## Exercise 1

dm <- filter(surveys, species_id == "DM")

ggplot(data = dm, aes(x = year, y = weight, color = sex)) +
  geom_point(stat = "summary",
             fun.y = "mean")


...

## Adding and customizing scales

surveys_dm <- filter(surveys, species_id == "DM")
ggplot(surveys_dm,
       aes(x = year, y = weight)) +
  geom_point(aes(shape = sex),
             size = 3,
             stat = "summary",
             fun.y = "mean") +
  geom_smooth(method="lm")

year_wgt <- ggplot(surveys_dm,
                   aes(x = year, y = weight)) +
  geom_point(aes(color = sex),
             size = 3,
             stat = "summary",
             fun.y = "mean") +
  geom_smooth(method="lm")

year_wgt

year_wgt <- year_wgt +
  scale_color_manual(values = c("darkblue", "orange"),
                     labels = c("Female", "Male"))

year_wgt

## Exercise 2

ggplot(surveys_dm, aes(fill = sex, x = weight)) +
  geom_histogram(binwidth = 1)
             

## Axes, labels and themes

histo <- ggplot(data = surveys_dm,
                aes(x = weight, fill = sex)) +
  geom_histogram(binwidth = 1)

histo

histo <- histo +
  labs(title = "Dipodomys merriami weight distribution",
       x = "Weight (g)",
       y = "Count") +
  scale_x_continuous(limits = c(20, 60),
                     breaks = c(20, 30, 40, 50, 60))


histo <- histo +
  labs(title = expression(paste(italic("Dipodomys merriami"),
       x = "Weight (g)",
       y = "Count") +
  scale_x_continuous(limits = c(20, 60),
                     breaks = c(20, 30, 40, 50, 60))

histo

histo <- histo +
  theme_bw() +
  theme(legend.position = c(0.2, 0.5),
        plot.title = element_text(face = 'bold', vjust =2),
        axis.title.y = element_text(size = 12, vjust =1),
        axis.title.x = element_text(size = 13, vjust = 0))
histo

## Facets

surveys_dm$month <- as.factor(surveys_dm$month)
levels(surveys_dm$month) <- c("January", "February", "March", "April", "May", "June",
                              "July", "August", "September", "October", "November", "December")

ggplot(data = surveys_dm,
       aes(x = weight)) +
  geom_histogram() +
  facet_wrap( ~ month)
  labs(title = "DM weight distribution by month",
       x = "Count",
       y = "Weight (g)")

ggplot(data = surveys_dm,
       aes(x = weight)) +
  geom_histogram(aes(y = ..density..),
                 alpha = 0.8) +
  facet_wrap( ~ month) +
  geom_histogram(data = select(surveys_dm, -month)) +
  labs(title = "DM weight distribution by month",
       x = "Count",
       y = "Weight (g)") +
  guides(fill = FALSE)

## Exercise 3

...

