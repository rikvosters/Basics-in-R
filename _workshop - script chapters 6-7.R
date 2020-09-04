###### CHAPTERS 6 AND 7 ######

# 6. DATA EXPLORATION AND VISUALIZATION
# 6.1 Preparation
# 6.2 Numerically summarizing - base package
# 6.3 Visualization - base package
# 6.4 Numerically summarizing - tidyverse/dplyr
# 6.5 Visualization - tidyverse/ggplot
# 7. BASIC STATISTICS
# 7.1 Distributions
# 7.2 Frequencies
# 7.3 Means
# 7.4 Correlations


### 6. DATA EXPLORATION AND VISUALIZATION -----


### 6.1 Preparation -----

# load packages
library(tidyverse)
library(readxl)
library(writexl)

# empty workspace
rm(list=ls(all=TRUE))

# For this section, we'll work with a slightly modified version of the well-known Titanic dataset (source: 'Titanic: Machine Learning from Disaster' - https://www.kaggle.com/c/titanic/), which is often used in machine learning. 

tt <- read.csv(file = "https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/Titanic_training.csv", na.strings = "")
tt <- as_tibble(tt)

# It contains data on survived (Survived = 1) and deceased (Survived = 0) passengers, and their characteristics (i.e. ID, name, passenger class, sex, age, number of siblings and spouses on board, number of parents and children on board, the price of their fare, and the port where they embarked)
tt

# Let's rename the untransparent letters of the port where they embarked
tt$Embarked <- fct_recode(tt$Embarked, "Cherbourg (FR)" = "C", "Queenstown (IR)" = "Q", "Southampton (EN)" = "S")
tt

# Have a first look at the dataset
tt
str(tt)
summary(tt)

# Oops, we forgot to make Survived and Class into factors
class(tt$Survived)
class(tt$Class)
tt$Survived <- as.factor(tt$Survived)
tt$Class <- as.factor(tt$Class)

# Check order of factor levels
levels(tt$Embarked)
levels(tt$Class)
levels(tt$Survived) # all okay for now

# Better!
tt
str(tt)
summary(tt)

# A first visual view
plot(tt)

### 6.2 Numerically summarizing - base package -----

# overview per variable
summary(tt$SiblingsSpouses)

# NUMERIC VARIABLES

# same basic functions
min(tt$Fare, na.rm = TRUE)
max(tt$Fare, na.rm = T)
mean(tt$Fare, na.rm = T)
median(tt$Fare, na.rm = T)

# add an independent variable (categorical) 
median(tt$Fare[tt$Class == "1"], na.rm = T)
median(tt$Fare[tt$Class == "2"], na.rm = T)
median(tt$Fare[tt$Class == "3"], na.rm = T)

# easier with tapply
tapply(tt$Fare, tt$Embarked, mean)
tapply(tt$Fare, tt$Class, median, na.rm = T) # apply function 'median' to 'Fare', split up by 'Class'

# CATEGORICAL VARIABLES

# same basic functions

# frequency table
table(tt$Survived)

# totals?
addmargins(table(tt$Survived), FUN=sum) # try also other functions, e.g. mean

# relative frequency
prop.table(table(tt$Survived)) # table with relative frequency counts (weighed over 1)

# percentage?
prop.table(table(tt$Survived))*100 # over 100 

# round
round(prop.table(table(tt$Survived))*100, 2) # two decimals

# different way, same result:
surv_table <- table(tt$Survived)
surv_prop <- prop.table(surv_table)*100
round(surv_prop, 2)

# save
write.table(surv_prop, "surv_prop.txt", sep="\t", quote=FALSE, row.names=F)
write_xlsx(x = as.data.frame(surv_prop), path = "surv_prop.xlsx")

# nicely styled and html tables: check out knitr::kable and the kableExtra package

# add an independent variable

# table with absolute freqs
table(tt$Survived, tt$Sex) # 2 dimensions

# row and column totals
addmargins(table(tt$Survived, tt$Sex))

# table with relative freqs 
prop.table(table(tt$Survived, tt$Sex), 2) # each column totals 100 (= read: relative distribution of DV for each level of IV)

# round?
round(prop.table(table(tt$Survived, tt$Sex), 2), 2)

# percentages?
round(prop.table(table(dv, iv), 2), 3)*100

# tip: make your own function

mytable <- function(dv, iv) {
  round(prop.table(table(dv, iv), 2), 3)*100
}

mytable(tt$Survived, tt$Sex)

# add more independent variables?
ftable(tt$Class, tt$Sex, tt$Survived) 
round(prop.table(ftable(tt$Class, tt$Sex, tt$Survived) , 1), 2)

# ASIDE: FROM NUMERIC TO CATEGORICAL - BINNING

# problem:
round(prop.table(table(tt$Survived, tt$Age), 2), 3)*100
summary(tt$Age)

# let r do the split
cut(tt$Age, breaks = 4)
cut(tt$Age, breaks = 4, labels = c("adolescent", "young", "middle-aged", "elderly"))

# do it yourself
cut(tt$Age, breaks = c(0, 18, 30, 50, 100))
cut(tt$Age, breaks = c(0, 18, 30, 50, 100), 
    labels = c("adolescent", "young", "middle-aged", "elderly"))

# save/assign
tt$Age_fct <- cut(tt$Age, breaks = c(0, 18, 30, 50, 100), labels = c("adolescent", "young", "middle-aged", "elderly"))
tt

# explore
round(prop.table(table(tt$Survived, tt$Age_fct), 2), 3)*100


### 6.3 Visualization - base package -----

# HISTOGRAMS AND QQPLOTS

# visualizing one numeric variable

hist(tt$Fare)

  # cf. also: 
  library(rcompanion)
  plotNormalHistogram(tt$Fare)

qqnorm(tt$Fare)
qqline(tt$Fare, col = "red")
  
# SCATTER PLOTS

# basic
plot(tt$Age)
plot(tt$Age, tt$Fare)

  # option: axis limits
  plot(tt$Age, tt$Fare, xlim = c(0,100), ylim = c(0,600))
  
  # option: point character
  plot(tt$Age, tt$Fare, xlim = c(0,100), ylim = c(0,600), pch = "x")

# adapts to input
plot(tt$Age, tt$Fare)
plot(tt$Age_fct, tt$Fare)

  # compare:
  plot(tt$Age_fct, tt$Fare, ylim = c(0,300))
  
  # option: rotate axis labels
  plot(tt$Age_fct, tt$Fare, ylim = c(0,300), las = 2)
  
  # adjust margins
  par(mar=c(7,4.1,4.1,2.1))
  plot(tt$Age_fct, tt$Fare, ylim = c(0,300), las = 2, xlab = "")
  par(mar=c(5.1,4.1,4.1,2.1))
  
# 'squiggle' notation
plot(tt$Survived ~ tt$Embarked)

  # option: labels
  plot(tt$Survived ~ tt$Embarked, xlab = "Port of Embarkment",
       ylab = "Survived")
  
  # option: colors
  plot(tt$Survived ~ tt$Embarked, xlab = "Port of Embarkment",
       ylab = "Survived", col=c("green", "darkgreen"))

  # option: titles
  plot(tt$Survived ~ tt$Embarked, xlab = "Port of Embarkment",
       ylab = "Survived", col=c("green", "darkgreen"),
       main = "My plot title 2")
  
# BARPLOTS

table(tt$Survived) # numerically
barplot(table(tt$Survived)) # visually: basic barplot
  
# make temporary object of barplot to remember its x-axis coordinates (used to e.g. add text)
aze <- barplot(table(tt$Survived))
aze #  x-axis coordinates

# add text
text(aze, table(tt$Survived)/2, table(tt$Survived)) 
  # arguments: 
  # 1. x-coord. (= aze) 
  # 2. y-coord. (= table/2 = halfway to the top of each bar)
  # 3. what to plot (= the absolute freqs from table(Negation))

# y-axis too short
barplot(table(tt$Survived))
aze <- barplot(table(tt$Survived), ylim=c(0, 600)) # set y-axis limit: "ylim=c(minimum, maximum)"

# add more text
text(aze, table(tt$Survived), round(prop.table(table(tt$Survived))*100, 2), pos=3, cex=0.75)  # explain?
  # pos = position of text relative to the coordinates given
  # cf. ?text()
  # "Values of 1, 2, 3 and 4, respectively indicate positions below, to the left of, above and to the right"

# with independent variable

barplot(prop.table(table(tt$Survived, tt$Class), 2)*100)
barplot(prop.table(table(tt$Survived, tt$Class), 2)*100, beside=TRUE)

  # cf. to: 
  plot(tt$Survived ~ tt$Class)

# add legend
barplot(prop.table(table(tt$Survived, tt$Class), 2)*100, col = c("darkgreen", "darkolivegreen3"))
legend("top", legend=c("Deceased", "Survived"), ncol=2, fill=c("darkgreen", "darkolivegreen3"), cex=0.75)
    # where: either x and y coordinates, 
    #        or: "bottomright", "bottom", "bottomleft", "left", "topleft", "top", "topright", "right", "center"
    # what to write as a legend (legend=)
    # ncol: in one or in more columns 
    # fill: colors used to label legend
    # slightly smaller text (cex=0.75)
    # inset = just a bit above 'bottom'

  
# BOXPLOTS

# basics
boxplot(tt$Fare ~ tt$Embarked)
boxplot(tt$Fare ~ tt$Embarked, ylim = c(0,200))

# notches
boxplot(tt$Fare ~ tt$Embarked, ylim = c(0,200), notch = T)

# with some more options
par(mar=c(7,4.1,4.1,2.1))
boxplot(tt$Fare ~ tt$Embarked, ylim = c(0,200), las=2, xlab = "", col = "gold")
par(mar=c(5.1,4.1,4.1,2.1))

# MOSAIC PLOTS

mosaicplot(table(tt$Survived, tt$Sex))

library(vcd)
assoc(table(tt$Survived, tt$Sex), shade=TRUE, legend = T) # blue = more observations than expected under null hypothesis; red = less observations
assoc(table(tt$Class, tt$Embarked), shade=TRUE, legend = T) 


# LINE PLOTS

sample <- data.frame(year = c(1700, 1750, 1800, 1850, 1900), observations = c(123, 136, 195, 277, 288))
plot(sample, type = "l")
plot(sample, type = "b", pch = 5)

# SAVING GRAPHS

# 1. Export > Save Plot as PDF (or: Copy plot to clipboard)

# 2. pdf()

pdf(file="output_plot.pdf", width=12, height=8) # open port for pdf file before plotting, and specify format
barplot(prop.table(table(tt$Survived, tt$Class), 2)*100)
dev.off() # and close port to save

# see also: ?pdf()

### 6.4 Numerically summarizing - tidyverse/dplyr -----

# two new tidyverse/dplyr operators: group_by() and summarise()

# make new tibble with summarize
tt %>% 
  summarise(mean_fare = mean(Fare))

# use group_by to introduce grouping independent variables
tt %>% 
  group_by(Embarked) %>% 
  summarise(mean_fare = mean(Fare))

# you can add various summary functions
tt %>% 
  group_by(Embarked) %>% 
  summarise(mean_fare = mean(Fare),
            stddev_fare = sd(Fare),
            median_fare = median(Fare),
            IQR_fare = IQR(Fare)) -> summ_embarked
summ_embarked

# combine with other dplyr functions, such as filter to filter out NA's
tt %>% 
  filter(is.na(Embarked) == FALSE) %>%
  group_by(Embarked) %>% 
  summarise(mean_fare = mean(Fare))

# or filter to select only certain ages
tt %>% 
  filter(Age >= 18) %>% 
  group_by(Embarked) %>% 
  summarise(mean_fare = mean(Fare))

# you can also introduce several grouping independent variables
tt %>% 
  group_by(Embarked, Sex) %>% 
  summarise(mean_fare = mean(Fare))

# useful function to use with summarise: n() = number of rows
tt %>% 
  group_by(Embarked) %>% 
  summarise(mean_fare = mean(Fare),
            number_passengers = n())

# useful function to use with summarise: n_distinct() = number of unique entries
tt %>% 
  group_by(Embarked) %>% 
  summarise(mean_fare = mean(Fare),
            number_passengers = n(),
            n_cabins = n_distinct(Cabin))

# combine with mutate
tt %>% 
  group_by(Embarked) %>% 
  summarise(mean_fare = mean(Fare),
            number_passengers = n()) %>% 
  mutate(perc_passengers = number_passengers/sum(number_passengers)*100)  

# useful function to use with summarise: rank()
tt %>% 
  filter(is.na(Age_fct) == FALSE) %>%
  group_by(Age_fct) %>% 
  summarise(mean_fare = mean(Fare)) %>% 
  mutate(rank_fare = rank(mean_fare))

### 6.5 Visualization - tidyverse/ggplot -----

# SYNTAX

data %>% 
  ggplot(aes(x = variable_x_axis, y = variable_y_axis)) +
  geom_type()

# example:

tt %>% 
  ggplot(aes(x = Age, y = Fare)) +
  geom_point()

# you can also first do dplyr operations, for instance:

tt %>% 
  filter(Class == "1") %>% 
  ggplot(aes(x = Age, y = Fare)) +
  geom_point()

# and you can add multiple layers in ggplot:

tt %>% 
  filter(Class == "1") %>% 
  ggplot(aes(x = Age, y = Fare)) +
  geom_point() +
  geom_rug()

tt %>% 
  filter(Class == "1") %>% 
  ggplot(aes(x = Age, y = Fare)) +
  geom_point() +
  geom_smooth(method = "lm") # see: ?geom_smooth: lm, loess, gam, ...

tt %>% 
  filter(Class == "1") %>% 
  ggplot(aes(x = Age, y = Fare)) +
  geom_point() +
  geom_label(aes(label = Name, hjust = 0, vjust = 0))

tt %>% 
  filter(Class == "1") %>% 
  ggplot(aes(x = Age, y = Fare)) +
  geom_point() +
  geom_hline(yintercept = mean(tt$Fare), col = "red") +
  geom_hline(yintercept = median(tt$Fare), col = "blue")


# easy saving to hard disk (working directory)
tt %>% 
  filter(Class == "1") %>% 
  ggplot(aes(x = Age, y = Fare)) +
  geom_point() +
  geom_smooth(method = "lm") 
ggsave("graph.pdf", device = "pdf", width = 9, height = 6)

# themes

tt %>% 
  filter(Class == "1") %>% 
  ggplot(aes(x = Age, y = Fare)) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_bw() # google ggplot themes

# HISTOGRAMS, QQPLOTS AND DENSITY PLOTS

tt %>% 
  ggplot(aes(x = Fare)) +
  geom_histogram()


tt %>% 
  ggplot(aes(x = Fare)) +
  geom_histogram(bins = 10)

tt %>% 
  ggplot(aes(x = Fare)) +
  geom_histogram(bins = 50) 

tt %>% 
  ggplot() +
  geom_qq(aes(sample = Fare))

# SCATTER PLOTS

tt %>% 
  ggplot(aes(x = Age, y = Fare)) +
  geom_point() +
  labs(title = "Titanic", subtitle = "Age and fare", 
       x = "Age (years)", y = "Fare (USD)", 
       caption = "(source: Titanic dataset)") 

# add extra layer of 'aesthetic'

tt %>% 
  ggplot(aes(x = Age, y = Fare, col = Class)) +
  geom_point()
  
tt %>% 
  ggplot(aes(x = Age, y = Fare, size = SiblingsSpouses)) +
  geom_point()

tt %>% 
  ggplot(aes(x = Age, y = Fare, size = SiblingsSpouses, col = Class)) +
  geom_point()

# facets

tt %>% 
  ggplot(aes(x = Age, y = Fare)) +
  geom_point() +
  facet_wrap(~ Class)

# jitter

tt %>%        # useless
  ggplot(aes(x = Class, y = Fare)) +
  geom_point() 

tt %>%         # better
  ggplot(aes(x = Class, y = Fare)) +
  geom_point(position = "jitter") +
  geom_boxplot(col="white", fill=NA)

# other possibility:

tt %>%
  ggplot(aes(x = Class, y = Fare)) +
  geom_count() 

# BARPLOTS

# start with summarise

tt %>% 
  filter(is.na(Embarked) == FALSE) %>%
  group_by(Embarked) %>% 
  summarise(mean_fare = mean(Fare)) %>% 
  ggplot(aes(x = Embarked, y = mean_fare)) +
  geom_bar(stat="identity")

tt %>% 
  filter(is.na(Embarked) == FALSE) %>%
  group_by(Embarked) %>% 
  summarise(mean_fare = mean(Fare)) %>% 
  ggplot(aes(x = Embarked, y = mean_fare)) +
  geom_bar(stat="identity", fill = "darkolivegreen4") + # color
  geom_text(aes(label = round(mean_fare,1)), vjust = -0.5) # add text
  

# add extra aesthetic 

tt %>% 
  filter(is.na(Embarked) == FALSE) %>%
  group_by(Embarked, Survived) %>% 
  summarise(mean_fare = mean(Fare)) %>% 
  ggplot(aes(x = Embarked, y = mean_fare, fill = Survived)) +
  geom_bar(stat="identity")  # color

# percentage plot

tt %>% 
  filter(is.na(Embarked) == FALSE) %>%
  group_by(Embarked, Survived) %>% 
  summarise(mean_fare = mean(Fare)) %>% 
  ggplot(aes(x = Embarked, y = mean_fare, fill = Survived)) +
  geom_bar(stat="identity", position="fill") # position = "fill"

# dodge

tt %>% 
  filter(is.na(Embarked) == FALSE) %>%
  group_by(Embarked, Survived) %>% 
  summarise(mean_fare = mean(Fare)) %>% 
  ggplot(aes(x = Embarked, y = mean_fare, fill = Survived)) +
  geom_bar(stat="identity", position = "dodge") 

# horizontal 

tt %>% 
  filter(is.na(Embarked) == FALSE) %>%
  group_by(Embarked) %>% 
  summarise(mean_fare = mean(Fare)) %>% 
  ggplot(aes(x = Embarked, y = mean_fare)) +
  geom_bar(stat="identity", fill = "darkolivegreen4") + # color
  coord_flip()

# legend

tt %>% 
  filter(is.na(Embarked) == FALSE) %>%
  group_by(Embarked, Survived) %>% 
  summarise(mean_fare = mean(Fare)) %>% 
  ggplot(aes(x = Embarked, y = mean_fare, fill = Survived)) +
  geom_bar(stat="identity") +
  scale_fill_discrete(name="Survived?",labels = c("No", "Yes"))


# BOXPLOTS

tt %>% 
  ggplot(aes(x = Class, y = Fare)) +
  geom_boxplot()

# change axis limits and labels
tt %>% 
  ggplot(aes(x = Class, y = Fare)) +
  geom_boxplot(fill="gold") +
  scale_y_continuous(limits = c(0,200)) +
  scale_x_discrete(labels = c("1st", "2nd", "3rd"))

# notches
tt %>% 
  ggplot(aes(x = Sex, y = Fare)) +
  geom_boxplot(notch = T) +
  scale_y_continuous(limits = c(0,150))

# VIOLIN PLOTS  ,

tt %>% 
  ggplot(aes(x = Survived, y = Age)) +
  geom_violin(fill="gold")

# MOSAIC PLOTS

library(geom_mosaic) # only R version 3.x

tt %>% 
  ggplot(aes(x = Class, y = Survived)) +
  geom_mosaic()

# LINE PLOTS

sample <- data.frame(year = c(1700, 1750, 1800, 1850, 1900), observations = c(123, 136, 195, 277, 288))

sample %>% 
  ggplot(aes(x = year, y = observations)) +
  geom_line() +
  geom_point() 


####--- | exercise: influenza ---####

# Load a collection on US age-adjusted death rates for selected major causes of death per 100,000 U.S. inhabitants (1900-2013) (source: https://data.world/health/death-rates-for-major-causes), located online ("https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/DeathRatesforMajorCauses_wide.csv"). Transform it from its current (very) wide format to a long data format. Then, filter out the death rates per year for 'Influenza and Pneumonia', and make an appropriate plot of this using ggplot. 

####--- | exercise: flights ---####

# Install and load the 'flights' package, and then assign the element 'hflights' to a new dataframe of your choice. Also convert it into a tibble, and then select the variables Year, DayOfWeek, DepTime, UniqueCarrier, AirTime, ArrDelay, Dest, Distance, Cancelled, and CancellationCode, removing the others. Now, try to explore yoru data to answer the following questions:
# Which percentage of flights was cancelled in 2011? Visualize in a barplot.
# Calculate the percentage of flights cancelled versus the percentage of flights not cancelled, and visualize this in a simple barplot.
# Recode CancellationCode ("carrier" = "A", "weather" = "B", "FFA" = "C", "security" = "D") and use it to find out what the major cause of flight cancellations is.
# Plot the distance versus the arrival delay for all short-haul flights (i.e. with a total distance under 500 miles).
# Try to find out what the total airtime is per weekday, for the AA (American Airlines) and EV (ExpressJet) carriers. Plot this in a barplot with a different facet for each of the two carriers.
# Make a boxplot and a violin plot of the arrival delay for airline companies AA (American Airlines), DL (Delta) and US (US Airways), so you can check out which of these three companies holds the record in terms of arrival delay.


### 7. BASIC STATISTICS -----

# Based on Gries' 2013 - Statistics for Linguistics with R


### 7.1 Distributions -----

# Shapiro Wilk Test: check for normal distribution

# Fare
shapiro.test(tt$Fare) # if p < 0.05, then significantly different from normal distribution (so: NOT normally distributed)
hist(tt$Fare)

# Age 
shapiro.test(tt$Age)
library(rcompanion)
plotNormalHistogram(tt$Age)

# Kolmogorov-Smirnov test
# alternative: for large datasets and for dependent variable + independent variable
ks.test(tt$Fare, "pnorm", mean=mean(tt$Fare), sd=sd(tt$Fare))
ks.test(tt$Age[tt$Sex == "male"], tt$Age[tt$Sex == "female"]) # p > 0.05, thus not sign. different 
                                                              # in terms of distribution 
                                                              # (D = 0.1038, p-value = 0.056)

### 7.2 Frequencies -----

# Categorical variables

# Chi-squared test 

# 1 variable: are the two outcomes of Survived equally frequent?

table(tt$Survived)

# statistical test  (! always assign a test to a separate element, e.g. "test")
test <- chisq.test(table(tt$Survived)) 
test # sign.

# assumptions
# - all observations are independent of each other
# - 80% of expected frequencies >= 5, and all >1
str(test)
test$expected

# Conclusion: the two outcomes (survived, deceased) are not equally frequent (chi-square=48.091, df=1, p<0.001)

# note: never run chi-square test (or other significance test) on relative frequencies! (sensitive to sample size, which != 100)

# 2 variables: is there a correlation between two variables?

# numerically
table(tt$Survived, tt$Embarked)

# visually
library(vcd)
assoc(table(tt$Survived, tt$Embarked), shade=TRUE, legend = T) # blue = more observations than expected under null hypothesis; red = less observations

# statistically
test <- chisq.test(table(tt$Survived, tt$Embarked))
test
test$residuals # notice large deviation from 0 for Cherbourg ~ Surviving

# assumptions
test$expected

  # if not: Fisher's exact test, often used for small samples
  fisher.test(table(tt$Survived, tt$Embarked))

# also: Cramer's V to show strength of association (= effect size) 
library(DescTools)
CramerV(table(tt$Survived, tt$Embarked)) # report Cramer's V: from 0 to 1 (= perfect association)
# compare:
CramerV(table(tt$Survived, tt$Class)) 


### 7.3 Means -----

# numeric dependent variable, categorical independent variable
# 2 variables: do differences in ticket fare differ significantly by gender (i.e. between men and women)?

# Welch Two Sample t-test
t.test(tt$Fare ~ tt$Sex) 

# assumption of independent samples - otherwise (e.g. repeated-measures design), use paired versions

# assumption of normality
tapply(tt$Fare, tt$Sex, shapiro.test) # violates assumption of normality!

# Wilcoxon rank sum test (U-test)
wilcox.test(tt$Fare ~ tt$Sex) # for ordinal data
tapply(tt$Fare, tt$Sex, median) # so median difference is significant


### 7.4 Correlations -----

# 2 numeric variables: can we predict Fare if we know Age?

# visually
plot(tt$Fare ~ tt$Age)
abline(lm(Fare ~ Age, data=tt), col="red", lwd=2)

# correlation score:
cor(tt$Fare, tt$Age, use = "complete.obs") # ignore NA's: use = "complete.obs"s
                                           # very slight positive correlation

# assumption of normality
shapiro.test(tt$Age); shapiro.test(tt$Fare) # if p < 0.05, then NOT normally distributed

# cor.test(tt$Fare, tt$Age) # if normality had not been violated

# Spearman’s rank correlation
# alternative (reduce to ordinal): Spearman's rho 
cor.test(tt$Fare, tt$Age, method="spearman") # sign. but weak correlation

# notice:
# correlations (and even t-tests) are in fact just easy cases of regression

# Pearson's R linear correlation 
# (= basic linear regression - only here monofactorial instead of multifactorial)

model <- lm(Fare ~ Age, data=tt)
model # cf. to plot

summary(model)


####--- | exercise: metal fan base ---#####

# Use 'read_excel' to load the 'metal_data.xlsx' dataframe from the working directory on your computer, and do the same to also load the 'metal_meta.xlsx' metadata file (source: https://www.kaggle.com/mrpantherson/metal-by-nation). Merge both using the merge() function, using the ID column as a unique identifier. Then explore the new dataset, and answer two questions:
# 1. Is there a correlation between the year a band was formed and its number of fans? Explore visually and test statistically.
# 2. Lump all of the countries of origin together into the two most frequent countries + one 'other' category. Then look if you can detect any differences in mean or median fan base between two most common countries. Explore numerically and graphically, and also do appropriate statistical testing.

####--- | exercise: female chess players ---#####

# Load a dataframe (source: https://www.kaggle.com/vikasojha98/top-women-chess-players) with recent scores by female chess players. Read it as csv and convert it to a tibble, but remove the variables 'Inactive_flag' and 'Gender'. Then, split the variable 'Age' up into 3 predefined groups (young = under 30, middle = 30-60, older = 60+), and split variable 'Standard_Rating' into 3 groups ("low", "medium", "high" -- allowing R to determine the exact cut-off points itself). Next, check out a possible effect of the (now) ordinal variable 'Age' on the ordinal variable 'Rating' -- explore numerically, graphically, and statistically. Finally, convert the dataset from a wide to a long format, and plot year of birth and rating (but only for the 'Blitz_rating' type), for both Russian (RUS) and Polish (POL) players in different colors, and add a LOESS smoother (method = "loess") for each group.
