# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
###                                                                     ###
###    Workshop: Basics in R for people who are afraid of computers     ###
###                  DSh - VUB - December 2022                          ###
###             Rik Vosters - Vrije Universiteit Brussel                ###
###             Rik.Vosters@vub.be | www.rikvosters.be                  ###
###                                                                     ###
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# 1. GETTING STARTED
# 2. BASIC VECTORS
# 2.1 Numeric vectors
# 2.2 Character vectors
# 3. DATAFRAMES, SUBSETTING AND DATA IMPORT
# 3.1 Data frames
# 3.2 Subsetting
# 3.3 Importing data
# 3.4 An alternative approach: tidyverse/dplyr
# 3.5 Other types of data structures
# 4. DATA CLEANING AND MANIPULATION
# 4.1 Data classes
# 4.2 Basic manipulations
# 4.3 Long and wide data
# 4.4  Merging datasets and working with metadata
# 4.5  Loading multiple files (loops and lapply)
# 5. ANALYZING TEXTUAL DATA
# 5.1 Loading text files
# 5.2 Basic text manipulation
# 5.3 Powersearching and regular expressions
# 5.4 Lemmatizing and POS tagging
# 5.5 Frequency lists
# 5.6 Keyness and word clouds
# 5.7 Concordances and collocations
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


### 1. GETTING STARTED -----

# How does R work?

# Type things in script and send to console

"hello world"
print("hello world")

# Basic functions in R: addition, subtraction, etc.

2 + 7
2 * 7
2 + 7

# Notice how anything behind the hash is a comment and is not processed

2 + 7 # comment
2 + 7 # +100
2 + 7 + 100

# Assigning values

a <- 2 + 7 # assign  (pro tip Mac: OPTION + '-')
# cf. 'Environment' window
a

# Alternative:

a = 2 + 7

# Operations on save values

a - 3
a <- a - 3 # overwrite
a

10 * a + (1 / 3 * a)

A # careful: R is case sensitive

# Define a sequence of elements (= vector)
b <- c(2, 4, 6) # notice: function c()
b

a + b
c <- c(a, b) # again, combine
c

# Some other basic functions

mean(c)
median(c)
min(b)
max(b)
plot(c) # plot -- cf. 'Plots' window
barplot(c)

# Embedded functions

plot(c(c, b)) # function combine inside function plot
barplot(c(mean(b), mean(c)))

# Syntax: three ways of writing it out

# most economical:
barplot(c(mean(b), mean(c)))

# most clear:
first_mean <- mean(b)
second_mean <- mean(c)
means_to_plot <- c(first_mean, second_mean)
barplot(means_to_plot)

# middle ground
means_to_plot <- c(mean(b), mean(c))
barplot(means_to_plot)

# Pro tip: use 'TAB'

# Typical structure of a function:
# function(x, y, option=FALSE)

# Need help?
?plot # cf. 'Help' window
?max()
?barplot()

# Starting routine

# clear working space
rm(list = ls(all = TRUE))

# set working directory
setwd("")
setwd("~/Dropbox/@ Documenten/Colleges - courses/_Gastcolleges/2022.12 DSh workshop - Basics in R/Basics-in-R")
getwd()
# Windows: setwd(choose.dir())
# Linux: tk_choose.files() does same thing - library(tcltk)
# also possible: CTRL + SHIFT + H
# also possible: RStudio Project

# Working with packages

# first, once:
install.packages("stylo")

# then, every session before using it or at the beginning of the script:
library(stylo)

# want to know more about the package?
help(package = stylo) # or write in 'Help' window

install.packages("tidyverse") # once
library(tidyverse)

# alternatively:
# Packages > Install Packages | Tools > Install Packages
# Select a CRAN Mirror (Austria)
# Select a package or type the name of a package
# Use library(package) to load it
# see also: 'Packages' window


#### --- | exercise: create new file  ---####

# - Create a new script file in RStudio (File > New file > R Script)
# - Enter the following in this new script file
# x <- c(1530, 1540, 1550, 1560, 1570, 1580, 1590, 1600)
# x
# y <- c(4, 9, 17, 48, 78, 92, 96, 98)
# y
# plot(x, y)
# - Save this file (File > Save as > …)
# - Now run your code: either line by line, or by selecting all
#   of the lines and hitting 'CMD + enter' once
#   (or clicking the 'Run' button in the toolbar at the top of your script file)
# - Go to the plot window, and save the plot you created
#   (Export > Save plot as PDF > …; change the working directory if necessary)
# - Inspect the output you generated


#### --- | exercise: hours of sleep  ---####

# - Assign values to create two vectors: one called 'sleep_week' where you input 5 numeric values for the (actual or fictitious) number of hours of sleep you got per weekday last week, and one called 'sleep_weekend' where you input 2 numeric values for the number of hours of sleep you got per day of the weekend last week. Make an estimation up to one decimal point (e.g. 8.5).
# - Create a new vector called 'weekend_zzz', for which you (automatically) calculate on average how many more hours of sleep you get in the weekend compared to during the week.


### 2. BASIC VECTORS -----

# empty workspace
rm(list = ls(all = TRUE))

# Most important data structures:
# Vectors: numeric, character, logical
# Dataframes (and tibble)
# Lists

### 2.1 Numeric vectors -----

# create a vector
vecky <- c(90, 95, 100, 105, 110)
vecky

# subsetting - access one specific element of that vector
vecky[1]
vecky[1:3]
vecky[c(2, 5)]

# generating vectors
1:35
1:1000
seq(from = 7, to = 9.5, by = 0.25)
rep(1:4, 3)
rep("abc", 3) # also for non-numerical vectors, cf. below

# some more data
wordcounts <- rnorm(100, mean = 180, sd = 40) # Generate normally distributed
# data with a standard deviation
# of 40 around a mean score of 100
wordcounts

# round
round(wordcounts, 0)
wordcounts <- round(wordcounts, 0)
wordcounts

# sort
sort(wordcounts)
sort(wordcounts, decreasing = T)

# visually
plot(wordcounts)
plot(sort(wordcounts))
hist(wordcounts)

# some other useful functions
length(wordcounts)
sum(wordcounts)
sum(wordcounts, vecky)
max(wordcounts)
min(wordcounts)
rev(wordcounts)

# more subsetting: logical expressions

wordcounts
sort(wordcounts, decreasing = T)
wordcounts[wordcounts >= 200] # gives you the actual elements from the
# dataframe matching the logical expression

# compare:
wordcounts >= 200 # logical vector
wordcounts[wordcounts >= 200]

#     <   Smaller than
#     <=  Smaller than or equal to
#     >   Larger than
#     >=  Larger than or equal to
#     ==  Equal to
#     !=  Unequal to
#  is.na  Has missing values (NA)
# !is.ba  Does not have missing values (not NA)

wordcounts[wordcounts != 210]
wordcounts[wordcounts >= 210]
wordcounts[is.na(wordcounts)] # to check if there are missing values

# how many elements in vector?
length(wordcounts[wordcounts >= 210])

wordcounts[wordcounts > 210 | wordcounts < 150] # | = OR
wordcounts[wordcounts < 175 & wordcounts > 150] # & = AND

benchmark <- 210:500 # define a vector with a benchmark range
benchmark
wordcounts[wordcounts %in% benchmark] # select all wordcount values
# that occur in that range
wordcounts[!wordcounts %in% benchmark] # select all wordcount values
# that do NOT occur in that range


#### --- | exercise: hours of sleep (bis) ---####

# 1. Empty the work space.
# 2. Create one vector with the (estimated) average hours of sleep you had for each night last week. Make an estimation up to one decimal point (e.g. 8.5), starting with Monday and ending with Sunday (i.e. 7 numbers in total)
# 3. Calculate your mean number of hours of sleep based on this vector. Round to two decimal points.
# 4. Calculate with a function how many nights you had less than 7 hours of sleep.
# 5. Calculate in how many percent of all nights last week you had 8 hours or more of sleep. (Tip: percent = (x/y)*100)
# 6. Calculate the difference between your average hours of sleep during the week (i.e. Monday night till Friday night) versus in the weekend (i.e. Saturday and Sunday night). Use a subset of the first 5 and the last 2 elements in your vector.


#### 2.2 Character vectors -----

# create a vector

vecky2 <- c("Colorless", "green", "ideas", "sleep", "furiously")
vecky2

vecky3 <- c("Time flies like an arrow", "Fruit flies like a banana")
vecky3

# no spaces in vector names - use underscore or dot
# vekkie test <- c("Aa", "Bb", "Cc")
vekkie_test <- c("Aa", "Bb", "Cc")

# subsetting - access one specific element of that vector

vecky2[1:3]
vecky2[c(2, 4)]

# stoplists

stoplist <- c("green", "linguistics", "sleep", "Chomsky") # define stoplist to test vector against for subsetting
vecky2 %in% stoplist # Does each element of vector vecky2 occur in
# the stoplist? (returns logical vector)
vecky2[vecky2 %in% stoplist] # Which elements of vecky2 occur in the stoplist?
vecky2[!vecky2 %in% stoplist] # Opposite: which elements of vecky2
# do not occur in stoplist?
# Useful for subsetting your corpus data or
# throwing out unwanted items (cf. later)

# other useful functions:
nchar(vecky2)
toupper(vecky2)
tolower(vecky2)
substr(vecky2, 1, 3)


# types and tokens
konami_code <- c("up", "up", "down", "down", "left", "right", "left", "right", "B", "A", "start")
konami_code
unique(konami_code) # types of the vector
table(konami_code) # type frequencies
sort(table(konami_code), decreasing = T) # sorted - basic frequency list!


# missing values = NA
konami_missing <- c("up", NA, "down", "down", "left", "right", "left", "right", "B", "A", "start")
table(konami_missing)

# numeric values missing
numbers <- c(1, 2, NA, 8, 12, NA, 36)
mean(numbers)
mean(numbers, na.rm = T)


#### --- | exercise: Belgian Dutch words ---####

# Below is a selection of words that are considered to be non-standard Belgian Dutch, according to one particular prescriptivist language advice guidebook. The actual list is longer, but we just show the words starting with the letters A and B for practical reasons.
# > "Afgevaardigd Beheerder", "Ajuin", "Alcoholieker", "Alleszins", "Ardeens", "Autostrade", "Autotaks", "Allergisch Aan", "Aftrekker", "Afkuisen", "Baxter", "Bedanking", "Bedelen", "Beenhouwer", "Begankenis", "Bekwaam Om", "Benadeligen", "Bereide Schotel", "Beschaamd", "Beteugelen", "Betoelagen", "Betonneren", "Betrachten", "Betrachting", "Betrouwen", "Bic", "Bijhuis", "Binnendoen", "Binnenkoer", "Baxter", "Botermelk", "Boerenbuiten", "Brol", "Brossen", "Buitensmijten", "Bureel"
# 1. Load the list of words into your workspace. Don't type all of them, but use copy and paste!
# 2. Convert the text to lower case.
# 3. Make a frequency table of the words in the list to check of there are no words accidentally listed twice.
# 4. If necessary, remove double words from the list.
# 5. Try to use subsetting to find our if the words 'beschaamd', 'bisser' and 'boterkoek' appear in the list of the non-standard Belgian Dutch words.

### 3. DATAFRAMES, SUBSETTING AND DATA IMPORT -----

# empty workspace
rm(list = ls(all = TRUE))

### 3.1 Data frames -----

# A dataframe consists of different vectors of the same length
col1 <- c("Aldrych", "Theobald", "Cadwell", "Ogden", "Roderick", "Rypley", "Marston", "Jimmy")
col2 <- c("/r/", "/R/", "/R/", NA, "/r/", "/r/", "/R/", "/R/")
col3 <- c(21, 98, 46, 17, 91, 100, 76, 0)
col4 <- c(TRUE, FALSE, TRUE, FALSE, TRUE, TRUE, TRUE, FALSE)

# Combining these three vectors with the function data.frame gives us one dataframe called 'OE'
OE <- data.frame(col1, col2, col3, col4)

# You can add column names (= Variable names) to the dataframe
names(OE) <- c("Scribe", "Pronunciation", "Reaction_time", "Verified")
OE # access entire dataframe

### 3.2 Subsetting -----

# Subsetting: same logic, but two dimensions: [rows, columns]

OE
OE[1, ] # first row of dataframe OE
OE[, 1] # first column of dataframe OE; same as:

# same, but easier (columns)
OE$Scribe
OE$Reaction_time

OE[, 1:3] # what will we get here?
OE[3:6, 1] # and here?

OE[3:6,]$Scribe
OE$Scribe[3:6]

# Functions: Functions operating on vectors also work on columns/factors in a data frame

# … both numerical:
mean(OE$Reaction_time)
plot(sort(OE$Reaction_time))

# … and character-based:
toupper(OE$Scribe)
table(OE$Pronunciation)

# More subsetting: we can also subset the whole dataframe based on selection criteria applied to specific factors

OE[OE$Reaction_time > 25, ] # Subset the dataframe OE with all the entries
# (rows) which have a reaction time of more than 25
# Mind the comma!
OE[OE$Scribe != "Roderick", ]
OE[OE$Reaction_time > 25 & OE$Pronunciation == "/r/", ]

# head() # cf. tail()

# see only first 6 rows
head(OE) # identical as OE[1:6,]
head(OE, 3) # specify number of rows

### 3.3 Importing data -----

# Several methods, depending on format of source

# TYPE 1: CSV - comma-separated (text) files

# be sure to set the working directory (or give a full path)
setwd("/Users/rikvosters/Dropbox/@ Documenten/Colleges - courses/_Gastcolleges/2022.12 DSh workshop - Basics in R/Basics-in-R")

# load
shark <- read.csv("SharkAttacks_sample.csv") # based on: https://data.world/shruti-prabhu/shark-attacks
head(shark)

# options:
read.csv("SharkAttacks_sample.csv", header = T, sep = ",", na.strings = "", encoding = "UTF-8", strip.white = T, dec = ".")

# separator value = often '\t' (tab-delimited)
# also: read.delim() instead of read.csv

# alternative:
# - Import tool in RStudio:
#   `File` > `Import dataset` > `From Text (base)`

# TYPE 2: Internet files with a specific URL

shark <- read.csv("https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/SharkAttacks_sample.csv") # no need to set working directory
head(shark)

# TYPE 3: Excel spreadsheets

library(readxl) # first (just once): install.packages(readxl)
read_excel("SharkAttacks.xlsx")
# loads it as special type of dataframe: tibble (cf. infra)

# TYPE 4: R package

# some data is just available in a ready-made R package
# e.g. baby names
library(babynames) # first (just once): install.packages("babynames")
bb <- babynames
bb # also tibble


#### --- | exercise: LEGO ---####

# Load a dataset called 'LEGOsets.csv', which contains an overview of all official LEGO sets (source: https://www.kaggle.com/rtatman/lego-database). You can either load it from the workshop folder, or from an online url (https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/LEGOsets.csv). Explore the first six rows of the dataframe. Then make a histogram of the variable 'year', to see how many sets were released each year. Next, check with a function when the first official set was released. Finally, extract the names of all LEGO sets released in 1955.


#### --- | exercise: negation ---####

# Load a dataset called 'negation.csv' (https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/negation.csv). It contains an entry for each linguistic expression of negation in a corpus of early 19th century Flemish soldiers' letters. Negation either occur with a 'Single' negator, or as 'Bipartite' negation (i.e. with two negators). First use table() to check out what the distribution of Single versus Bipartite negation tokens is. Then work with a subset to find out if either form of negation occurs more often in main clauses with a SVO word order (Subject-Verb-Object), compared to subclauses with a SOV order (Subject-Object-Verb).

# alternative (if package is not available for your version of R)
helvetica <- read.csv("https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/swiss.csv")

#### --- | exercise: catholic fertility ---#### 

# Install and load the package called 'datasets'. This package contains a dataset called 'swiss', which contains Swiss fertility and socioeconomic indicators from the year 1888. Save this dataset in your working environment as a new dataframe called 'helvetica', and explore it by looking at the first 10 rows. Now extract the rows only for those districts where more than 50% of the population is catholic, and calculate the mean fertility rate for these predominantly catholic districts. Now compare it to the mean fertility rate of districts with 50% of catholics or less.


### 3.4 An alternative approach: tidyverse/dplyr -----

# new kid on the block: tidyverse (tidyverse.org)
# popular set of packages (dplyr, ggplot, tidyr, ... )
# easier to get started, but harder for some things
# 'tidy' data:
#    1. each column is a variable
#    2. each row is an observation

library(tidyverse) # only once: install.packages("tidyverse")

# Some innovations:

# 1. Tibbles instead of dataframes
bb <- babynames
bb

# faster and easier to work with; always prints 10 cases and as many columns as fit on screen
# to see more:
print(bb, n = 50)

# possible to make a dataframe into a tibble:
OE_tibble <- tibble(OE)
OE_tibble

# and back
OE <- data.frame(OE_tibble)
OE

# 2. Pipe character %>%

# generate some data data
wordcounts <- rnorm(100, mean = 180, sd = 40)

# for sequential code rather than embedded functions (CMD + shift + M)

wordcounts %>%
  sort() %>%
  plot()
# is the same as:
plot(sort(wordcounts))

round(mean(babynames$n))
# is the same as:
babynames$n %>% # CTRL/CMD + SHIFT + M
  mean() %>%
  round()

# 3. 'Plying' your data (dplyr)

# filter(): similar to subsetting, selecting cases (rows) based on their values

babynames %>%
  filter(name == "Dwight")

babynames %>%
  filter(name == "Dwight") %>%
  filter(sex == "M")

# often serves as input for a plot (ggplot: see later)
babynames %>%
  filter(name == "Dwight") %>%
  filter(sex == "M") %>%
  ggplot(aes(x = year, y = prop)) +
  geom_line()

# possibility to match more flexibly (e.g. regular expressions)

babynames %>%
  filter(str_detect(name, "Adol")) %>%
  filter(sex == "F")

# mutate(): add new variables (columns)

babynames %>%
  mutate(prop_overall = n / sum(n))

babynames %>%
  mutate(name_gendered = paste0(name, "_", sex))

# to save new/modified tibble:

babynames %>%
  mutate(prop_overall = n / sum(n)) -> babynames

# same as:
babynames <- babynames %>%
  mutate(prop_overall = n / sum(n))

# select(): select variables (columns)

babynames %>%
  select(year, sex, name)

# arrange(): change order of cases (rows)

babynames %>%
  filter(year == 1950) %>%
  arrange(name, sex)

babynames %>%
  filter(year == 1950) %>%
  arrange(desc(name), sex)

# combine multiple dplyr functions

# most popular boy's names in 1945
babynames %>%
  filter(year == 1945) %>%
  filter(sex == "M") %>%
  arrange(desc(prop))

# popularity of name 'Adolf'
babynames %>%
  filter(name == "Adolf") %>%
  filter(sex == "M") %>%
  ggplot(aes(x = year, y = prop)) +
  geom_line() +
  geom_vline(xintercept = 1940, color = "red")

# tally(): check how many cases/rows left after filter (similar to length)

babynames %>%
  filter(str_detect(name, "Adol")) %>%
  filter(sex == "F") %>%
  select(name) %>%
  unique()

babynames %>%
  filter(str_detect(name, "Adol")) %>%
  filter(sex == "F") %>%
  select(name) %>%
  unique() %>%
  tally()


#### --- | exercise: shark attacks ---####

# Load and explore the data on shark attacks from the internet (https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/SharkAttacks.csv). It is a tab separated file, so be sure to use the argument sep="\t". Also, it uses quotation marks in the text, so add the argument quote="". Browse through this dataset of almost 6000 documented shark attackes in history and try to answer the following questions, using either the base R package or tidyverse/dplyr:
# - How many people died of a shark attack in 2017?
# - Check if more shark attacks occurred in the 10 years before the movie Jaws came out in 1975, compared to 10 years after Jaws.
# - How old was the oldest Australian every to die from a shark attack?
# - Extract the names of all New Zealand victims of shark attacks in the 20th century, under the age of 16.
read.csv("https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/SharkAttacks.csv", sep = "\t", quote = "")


### 3.5 Other types of data structures -----

# matrix
matrix(1:20, nrow = 5, ncol = 4)

# list
names <- c("Samwise", "Meriadoc", "Peregrin", "Gimli", "Legolas")
hobbit <- c(TRUE, TRUE, TRUE, FALSE, FALSE)
age <- c(38, 36, 28, 139, 572)

# compare
data.frame(names, hobbit, age)
list(names, hobbit, age)

# the power of lists: different lengths
sample_list <- list(een = c(1, 2, 3), twee = c(1999, 2000, 2001, 2002, 2003), drie = c("A", "B", "C", "D", "E", "F"))
sample_list

# subsetting
sample_list[[2]]
sample_list[[2]][1]


### 4. DATA CLEANING AND MANIPULATION -----

# empty workspace
rm(list = ls(all = TRUE))

# New dataset: Dogs of Zuerich (https://www.kaggle.com/kmader/dogs-of-zurich)
# Data about Dog Owners in Zuerich, Switzerland
dog <- read.csv("https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/DogsOfZuerich.csv", sep = ";", na.strings = "")
head(dog)

### 4.1 Data classes -----

names <- c("Samwise", "Meriadoc", "Peregrin", "Gimli", "Legolas")
age <- c(38, 36, 28, 139, 572)
hobbit <- c(TRUE, TRUE, TRUE, FALSE, FALSE)

# basic data classes:
class(names)
class(age)
class(hobbit)
class(dog)

# also on columns in dataframes
class(dog$BIRTHYEAR)
class(dog$COLOR)

# character versus factor
dog$OWNER_SEX <- as.factor(dog$OWNER_SEX)
dog$OWNER_SEX

# cf. as.numeric(), as.character(), etc.

# fyi: convert all character vectors in dataframe to factors:
# df %>% mutate_if(is.character, as.factor) -> df

# levels
levels(dog$OWNER_SEX)
table(dog$OWNER_SEX)
barplot(table(dog$OWNER_SEX))

### 4.2 Basic manipulations -----

# reorder factor levels: fct_relevel()

levels(dog$OWNER_SEX)
dog$OWNER_SEX <- factor(dog$OWNER_SEX, levels = c("w", "m"))
levels(dog$OWNER_SEX)
barplot(table(dog$OWNER_SEX))

# alternative (even easier):
fct_relevel(dog$OWNER_SEX, "w", "m")
fct_relevel(dog$OWNER_SEX, "w")

# rename factor levels: fct_recode()

dog$OWNER_SEX <- fct_recode(dog$OWNER_SEX, "female" = "w", "male" = "m") # new = old
dog$OWNER_SEX

dog$OWNER_AGE <- as.factor(dog$OWNER_AGE)
levels(dog$OWNER_AGE) # problem: Excell made '11-20' into '44136' (thinking it was a date)
dog$OWNER_AGE <- fct_recode(dog$OWNER_AGE, "11-20" = "44136")
levels(dog$OWNER_AGE) # solved (but reorder needed!)
dog$OWNER_AGE <- fct_relevel(dog$OWNER_AGE, "11-20") # no need to list the rest
levels(dog$OWNER_AGE)

# make infrequent values into 'other': fct_lump()

# several possibilities:
# fct_lump_n() # lump all except n most frequent items
# fct_lump_min() # lump all items that appear less than min times

sort(table(dog$BREED), decreasing = T) # sorted frequency table

# fct_lump_n
dog$BREED_rcd <- fct_lump_n(dog$BREED, n = 15)
sort(table(dog$BREED_rcd), decreasing = T)

# fct_lump_min
dog$BREED_rcd <- fct_lump_min(dog$BREED, min = 50)
sort(table(dog$BREED_rcd), decreasing = T)

# replace text: gsub()

class(dog$BREED)
table(dog$BREED)
dog$BREED <- gsub("Zwerg", "Miniature ", dog$BREED)
table(dog$BREED)

# transform data: mutate()

table(dog$BIRTHYEAR)
dog %>%
  mutate(AGE = 2016 - dog$BIRTHYEAR) -> dog
table(dog$AGE)

table(dog$BIRTHYEAR)
dog$AGE <- 2016 - dog$BIRTHYEAR
table(dog$AGE) # dogs 36 and 54 years old ≠ possible!

# remove outliers: filter()

dog %>%
  filter(AGE < 30) -> dog
table(dog$AGE)
hist(dog$AGE)

# reorder rows: arrange()

head(dog) # order by dog age instead of ID
dog %>%
  arrange(AGE) -> dog
head(dog)

# change column names: rename()

dog %>%
  rename(OWNER_GENDER = OWNER_SEX) -> dog
head(dog)

# change column order: relocate()

dog %>%
  relocate(AGE) -> dog # AGE to the left
head(dog)

dog %>%
  relocate(ID) -> dog # ID back to the left
head(dog)

dog %>%
  relocate(AGE, .after = BIRTHYEAR) -> dog # age to the right of birthyear
head(dog)

# random subset: sample_n()

dog_sample <- sample_n(dog, 1000)


#### --- | exercise: dogs of Zuerich ---####

# Reload the Dogs of Zuerich csv file (https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/DogsOfZuerich.csv).Recode the 'TYPE_BREED' variable into a new 'SIZE' variable. 'K' stands for 'Kleinwüchsig' and represents small dogs, while 'I' and 'II' stand for 'Rassentypenliste I' and 'II', representing larger dogs. Check the proportion of small versus large dogs in Zurich, and check if women are more likely to have small dogs than men. Finally, if you have to buy a dog for your 85 year old grandmother, what specific breed would have the highest probability of her liking it, given her age and gender?


### 4.3 Long and wide data -----

# 1. Wide to long

# let's load a new data set, with population data of some countries from 1960 to 2015
pop <- read.csv("https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/world_population_wide.csv",
  sep = ",",
  check.names = F
)
pop <- tibble(pop)

# we need another package from the Tidyverse, which is not part of the main 'tidyverse' library
library(tidyr) # once: install.packages("tidyr")

# currently in wide format
pop

# what we want and need for some applications (e.g. plots in ggplot) is a long data format:
# three columns: Country, Year and Population
# so that we can e.g. filter(Year == ...) (which is now not possible, as these are columns and not rows)

pop %>%
  pivot_longer(cols = `1960`:`2015`, names_to = "Year", values_to = "Population") -> popl

popl$Year <- as.numeric(popl$Year)
popl

# now easy filtering....
popl %>%
  filter(Year == 2000)

# ... and easy plotting (cf. later)

popl %>%
  filter(Country %in% c("China", "India", "United States", "Serbia", "United Kingdom")) %>%
  ggplot(aes(x = Year, y = Population, col = Country)) +
  geom_line()

# 2. Long to wide

# sometimes useful for easier/more visual summary

library(babynames)
bb <- babynames
bb %>%
  filter(name %in% c("Izzy", "Ricky", "Archie", "Eli", "Leo", "Freddy", "Tony", "Randy", "Frankie", "Rudy")) %>%
  filter(year >= 2010) %>%
  filter(sex == "M") %>%
  select(year, name, n) -> bb_nn
bb_nn # long

bb_nn %>%
  pivot_wider(names_from = name, values_from = n) # wide

### 4.4  Merging datasets and working with metadata -----

# Let's go back to our negation data. This dataset contains an entry for each linguistic expression of negation in a corpus of early 19th century Flemish soldiers' letters. Negation either occur with a 'Single' negator, or as 'Bipartite' negation (i.e. with two negators). However, there is metadata available in a separate file, linked to each of the soldiers' letters in the dataset. We want to add this to the existing data.

neg <- read.csv("https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/negation.csv")
head(neg)

# load metadata from separate file
meta <- read.csv("https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/negation_metadata.csv")
head(meta)

# compare:
head(neg)
head(meta) # look for shared identifier (here: Letter)

# merge
neg <- merge(neg, meta, by = "Letter") # first the two elements which to merge, then by="" (= the column used for merging)

# check
head(neg) # success!

### 4.5  Loading multiple files (loops and lapply)-----

# loops: easy way to automate repetitive tasks

# loops have the following structure
for (i in 1:total_iterations) { # we define a counter 'i', and
  # define that it will run from 1 to
  # the total number of iterations
  functions # functions in the loop
  # will be performed i times
}

# one example
for (i in 1:50) { # define counter 'i' and iterate from 1 till 20
  # function cat() (= print on screen) will run for 20 times
  # with the element i in it
  cat("This is iteration number", i, "\n", sep = " ") # 'cat()' is similar to 'print'
}


#### --- | exercise: multiplication tables ---#####

# Use a for-loop that will generate the result of the multiplication tables of 7 (i.e. 7x1=7, 7x2=14, 7x3=21, …, 7x50=350). First set a counter which is the number (going from 1 to 50) you use to multiply with 7, and then calculate a variable x with the result of the multiplication. Show each result for 'x' on your screen using the 'print()' function.


# loop to load various files

# as a preparation: define names of data files in a vector called data.files
data.files <- list.files(pattern="text_loop")
# any file in the working directory with " " in its name
# often you can use: pattern="txt"
data.files

# also, already created an empty character vector into which the whole data file will be loaded
data <- data.frame()

# start the loop
for (i in 1:length(data.files)) {   # iterate over file names 
  # read in corpus file as lower case and save it in current.file
  current.file <- read.csv(data.files[i])
  # append the current.file to the rest
  data <- rbind(data, current.file)
}

data

# alternative: 
files <- list.files(pattern = "text_loop")
df_list <- lapply(files, read.csv)
df <- bind_rows(df_list)
df


#### --- | exercise: presidential frequency tables ---####

# Write a loop to load all (two) data files that start with the word 'freqtabel', which contains the inaugural addresses of the last two US presidents. Bind them together with 'rbind()' into one dataframe. Then use the filter() function to check how often the word 'america' occurs in each one.

#### --- | exercise: influenza ---####

# Load a collection on US age-adjusted death rates for selected major causes of death per 100,000 U.S. inhabitants (1900-2013) (source: https://data.world/health/death-rates-for-major-causes), located online ("https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/DeathRatesforMajorCauses_wide.csv"). Use the option `check.names = F` when loading the data with `read.csv` to tell R to load the year numbers as they appear (and not convert them by putting an `X` in front of them). Transform it from its current (very) wide format to a long data format. Then, filter out the death rates per year for 'Influenza and Pneumonia', and make an appropriate plot of this. Finally, make a similar plot comparing the death rates per year for all of the major causes of death in the dataset. Save the last plot as a pdf.

# Tip for plotting:
# ggplot(aes(x = Year, y = AgeAdjustedDeathRate)) + geom_line()


#### --- | exercise: metal ---####

# Load an Excel dataset ('metal_data.xlsx') on metal bands by nation and the corresponding set of metadata ('metal_meta.xlsx') from your working directory (source: https://www.kaggle.com/mrpantherson/metal-by-nation). Use `read_excel()` from the `readxl` package. Merge the two and try to find out the following:
# - What is the name of the oldest Iranian metal band that is still together? For this last element (still together), use 'filter(is.na(split))': this will filter out the rows where the 'split' value is 'NA'.
# - Are there any Mexicans metal bands who play some sort of death metal, and if so, how large is their (total) fan base?


### 5. ANALYZING TEXTUAL DATA -----

# empty workspace
rm(list = ls(all = TRUE))

### 5.1 Loading text files -----

# texts != data files
# need to be loaded in different manner (no tabular structure)

# use scan:
# define what you want to scan (= the file),
# as what you want to load it (= character data),
# and how/where you want R to separate what you are loading
# (= e.g. each line as one element)

# per word (no specification of 'sep' needed)
corpus.file.lower.words <- scan(file = "https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/Dickens-ChristmasCarol.txt", what = character(0), quote = "")

# per line (sep = "\n")
corpus.file <- scan(file = "https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/Dickens-ChristmasCarol.txt", what = character(0), sep = "\n")
corpus.file

# alternatively:
# corpus.file <- scan(file=choose.files(), what=character(0), sep="\n")
# Windows
# corpus.file <- scan(file=file.choose(), what=character(0), sep="\n")
# Mac / Linux - library(tcltk); tk_choose.files()

# all in lower case
corpus.file.lower <- tolower(scan(file = "https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/Dickens-ChristmasCarol.txt", what = character(0), sep = "\n")) # opposite: toupper()

# encoding problems:
# corpus.file <- scan(file = "https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/Dickens-ChristmasCarol.txt", what = character(0), sep = "\n", fileEncoding = "UNICODE-1-1") # argument: fileEncoding=""
corpus.file
iconvlist() # all encoding options for platform

### 5.2 Basic text manipulation -----

# Pasting

# make vector
words <- c("I", "am", "anespeptic,", "phrasmotic,", "even", "compunctious", "to", "have", "caused", "you", "such", "pericombobulation.")

# paste and collapse loose elements together
text <- paste(words, collapse = " ") # collapse pastes all vectors AND all elements within that vector together with the indicated separator
text

# Splitting

# take a character vector
text

# split its elements at the given separator
split <- strsplit(text, " ")
split
unlist(split)

# compare:
strsplit(text, "") # what happened?
sort(table(unlist(strsplit(text, "")))) # useful to get a table of what
# characters occur in your corpus
# helping you decide what to use
# as the strspl separator

# with more elements
text2 <- c("I am anespeptic, phrasmotic, even compunctious to have caused you such pericombobulation.", "Anything I can do to facilitate your velocitous extramurilisation")

# split at spaces
split <- strsplit(text2, " ")
split # returns a list (two levels)

# unlist (= collapse into one level)
unlist(split)

### 5.3 Powersearching and regular expressions -----

# Find: grep()

grep("searchpattern", text)
# argument 1: what to search for
# argument 2: where to search for it
# optional argument value=T to get the element itself (instead of its position)
# optional argument ignore.case=TRUE to ignore case (default=FALSE)

witch <- c("If she weighs the same as a duck, she's made of wood, and therefore a witch!", "The suspect has his head placed upon a block, and an axe aimed at his neck.", "If the man is guilty, the axe will bounce off his neck, so we burn him.", "If the man is not guilty, the axe will simply slice his head off.")
witch

grep("duck", witch) # position
grep("duck", witch, value = TRUE, ignore.case = FALSE) # matched element itself

grep("Guilty", witch, value = TRUE, ignore.case = TRUE)
grep("Guilty", witch, value = TRUE, ignore.case = F)

# also very useful:
grepl() # same, but returns a logical vector (see later for subsetting of corpus!)

# BASIC REGULAR EXPRESSIONS: SLIDES! ("Regex.pdf")


#### --- | exercise: grep ---####

# Write a regex to capture the names of the last four months of the year

# Write a regex to search for all historical spelling variants of the Dutch PersPron 'ik', where the <i> can also take the form of <j> or <ij>, and the <k> could also occur as <ck> (but not as <c>). Test it on the words: "ik", "ick", "jk", "jck", "ijck", "Ik", "Ick", "Jk", "Jck", "Ijck", "ic".

# Write a regex to capture all words (singular and plural) ending in the suffix -ism. Test it on the words: "fascism", "Bushisms", "antidisestablishmentarianism", "prism".
vecky <- c("fascism", "Bushisms", "antidisestablishmentarianism", "prism", "cow")
grep("REGEX", vecky, value=T)

# Write a regex to capture any word starting in a cluster of three or more consonants and exactly one vowel grapheme. Test it on the words: "spring", "schmuck", "strudel", "scared", "straight".

# Gsub 

gsub("searchpattern", "replacement", text)   # (global substitution)
# argument 1: what to search for
# argument 2: what to replace it by
# argument 3: where to search for it
# optional argument value=T to get the element itself (instead of position)
# optional argument ignore.case=TRUE to ignore case (default=FALSE)
# optional argument always set to perl=T (perl-compatible regex)

witch
gsub("she", "he", witch, perl=T)
# remember to assign it to a new element if you want to save it
male_witch <- gsub("she", "he", witch, perl=T) 

gsub("axe", "\taxe\t", witch, perl=T) # add tabs around
#  \t  tab stop
#  \n  new line


#### --- | exercise: gsub GerManC---####

# Load the following fragment from the GerManC corpus, and remove all of the tags from the fragment (source: muenchen1702_1.xml).
# GerManC <- c("<p><s>Verwichenen Dienstag seynd <num type=\"cardinal\" value=\"3\">3.</num> Hussaren vor <rs type=\"place\" key=\"DON\">Donauwerth</rs> gekommen/ vnd haben den Hirten mit <num type=\"cardinal\" value=\"40\">40.</num> Pferdten weggetriben;</s> <s>Die Bayrischen haben ihnen zwar gleich mit <num type=\"cardinal\" value=\"20\">20.</num> Pferdten bis; <rs type=\"place\" key=\"HHar\">Harburg</rs> nachgesetzt/ sie aber dannoch nicht angetroffen.</s>")


#### --- | exercise: gsub anonymize---####

# Load the fragment from the Dutch United Kingdom of the Netherlands Corpus below (Vosters 2009). To protect the identity of the people mentioned in this police report, change their names into their initials. You can assume that a name always consists of one capitalized first name and one capitalized last name.
# policereport <- c("De heer Philip Devaleriola, die den nacht van den zes en twintigsten den zeven en twintigsten april in de fabrijk niet doorgebragt had, op zijnen beurt ondervraagd zijnde, verklaarde dat hij bij zijne vrouw was gaan slapen, in het huis van juffrouw Johanna Roberti alhier te Brussel. Maar de juffrouw Johanna Roberti en Catharina Vanginderachter hare winkel dochter, gaven aan de kommissaris van policie ten antwoord, dat hij dezen nacht bij zijne vrouw geenszins doorgebragt had.")



# Some more regex: anchors & boundaries

# Anchors

# start of line/element
words <- c("John S. is coming, but John. D. isn’t.")
gsub("^John", "Johnnie", words, perl = T)

# start and end of line/element
words <- c("over", "overload", "overdosis", "Over")
grep("^over$", words, value = T, ignore.case = T)

# Word boundaries

words <- c("This is John. John Johnson.")
words

# with \\W
gsub("John\\W", "Bill", words, perl = T) # consumed the \\W

# with \\b
gsub("John\\b", "Bill", words, perl = T) # better!


#### --- | exercise: anchors & boundaries ---####

# Write a regex that can transform different sorts of American date notations into European date notations.
# (e.g. "07.24.2014", "02.23.82", "6/1/2014", "03-10-19", "7.24.14")


### 5.4 Lemmatizing and POS tagging -----

library(udpipe)
udmodel <- udpipe_download_model(language = "english")
witch_POS <- udpipe(witch, object = udmodel)
witch_POS

witch_POS %>%
  select(token_id, token, lemma, upos)

# also for other languages:
udmodel <- ?udpipe_download_model(language = "dutch")
NL <- udpipe("De regering besliste in juni om alle inwoners gratis treinritten aan te bieden", "dutch")
NL
udmodel <- udpipe_download_model(language = "dutch")
NL %>%
  select(token_id, token, lemma, upos)

### 5.5 Frequency lists -----

# example: inaugual addresses last two US presidents

# load both corpora, convert to lower case
obama <- scan(file = "https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/speech-obama.txt", 
              what = character(0), quote = "")
obama <- tolower(obama)
trump <- scan(file = "https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/speech-trump.txt", 
              what = character(0), quote = "")
trump <- tolower(trump)

# explore
head(obama) # first six items
head(trump)
head(obama, 20)
head(trump, 20)
tail(obama, 20)

# simple freq table
freq.obama <- table(obama)
freq.obama # alphabetical
# idem:
freq.trump <- table(trump)
freq.trump

# sort on frequency (high to low)
freq.obama <- sort(table(obama), decreasing = T)
freq.trump <- sort(table(trump), decreasing = T)

freq.obama # entire
freq.obama[1:75] # idem: head(freq.obama, 75)


freq.obama[1:75]
# punctuation (-> A.)
# function words (-> B.)

# A. Punctuation

# new corpus without punctuation
# gsub
obama
obama <- gsub("[,.'…\"”)(“‘’;:!?]", "", obama, perl = TRUE)
obama

# alternative:
# library(stringr)
# obama <- str_remove_all(obama, "[:punct:]")

# new freq list based on new corpus
freq.obama <- sort(table(obama), decreasing = T)
# 10 most frequent tokens
freq.obama[1:75]

# idem trump
trump <- gsub("[,.'…\"”)(“‘’;:!?]", "", trump, perl = TRUE)
freq.trump <- sort(table(trump), decreasing = T)

### ASIDE: functions

## List all characters in a corpus (Gries 2009)

# cf. above
table(unlist(strsplit(obama, "")))

# Menu: 'Code' > 'Extract function'…

charlist <- function(text) {
  table(unlist(strsplit(text, "")))
}

charlist(obama)

## Remove punctuation

punctuation.remover <- function(text) {
  #  remove punctuation - cf. 'gsub' later
  temp <- gsub("[,.'…\";“”‘’:–!?-_]", "", text, perl = TRUE)
  #  remove double spaces
  gsub(" {2,}", " ", temp, perl = TRUE)
}

punctuation.remover(obama)

# compare
freq.obama[1:10]
freq.trump[1:10]

# not very useful: almost all function words

# B. Lists of stop words

# manually define stoplist
stoplist <- c("the", "and", "of", "our", "we", "to")

# or, load existing stoplist
library(stopwords) # once: install.packages("stopwords")
stoplist <- stopwords(language = "en", source = "stopwords-iso")
stoplist

# even add elements manually
stoplist <- c(stoplist, "–", "-")

# also for other languages:
stopwords(language = "nl", source = "stopwords-iso")

# new corpus using stoplist
obama <- obama[!obama %in% stoplist]

# new freq list based on new corpus
freq.obama <- sort(table(obama), decreasing = T)

# 10 most frequent tokens
head(freq.obama, 10)

# idem trump
trump <- trump[!trump %in% stoplist]
freq.trump <- sort(table(trump), decreasing = T)
head(freq.trump, 10)

# compare:
freq.obama[1:10]
freq.trump[1:10]

# graph
barplot(freq.obama[1:15], main = "Most frequent words - Obama", ylab = "Absolute frequency", ylim = c(0, 20), las = 2, cex.names = 0.7)
barplot(freq.trump[1:15], main = "Most frequent words - Trump", ylab = "Absolute frequency", ylim = c(0, 20), las = 2, cex.names = 0.7)

# export as Excel-file

library(writexl) # once: install.packages("writexl")

freq.obama <- as.data.frame(freq.obama)
write_xlsx(freq.obama, path = "freqlist_obama.xlsx")

freq.trump <- as.data.frame(freq.trump)
write_xlsx(freq.trump, path = "freqlist_trump.xlsx")


#### --- | exercise: corpus English dialogues  ---#####

# Load the "https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/CED_example.txt" file from the Corpus of English Dialogues 1560-1760 (CED), and try to make a frequency list (without punctuation) of this corpus, filtering out the words 'sample', 'file' and 'ced'. Limit yourself to the 25 most frequent words, save the frequency list, and visualize the 25 most frequent words in a graph. For the visualization, use the barplot() function.


#### --- | exercise: Dickens  ---####

# Load Charles Dickens' novel A Tale of Two Cities ("https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/Dickens-TwoCities.txt") as separate words into R. Then remove punctuation and make the entire text uppercase. Also filter out stopwords using the stopwords() function, and make a sorted frequency table, which you save as an Excel spreadsheet.


### 5.6 Keyness and word clouds -----

# A. Keyness

# Code from Gries (2009)

# LOAD

rm(list = ls(all = T))

# presidential addresses
# trump v. other recent presidents (Ronald Reagan, George Bush, Bill Clinton, George W. Bush, Barack Obama)

# load (word for word)
corpus <- scan(file = "https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/speech-trump.txt", what = character(0), quote = "")
ref.corpus <- scan(file = "https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/speech-reference.txt", what = character(0), quote = "")

# remove punctuation
punctuation.remover <- function(text) {
  temp <- gsub("[,.)('…\"”“‘’–;:!?]", "", text, perl = TRUE) #  interpunctie weghalen
  gsub(" {2,}", " ", temp, perl = TRUE) #  dubbele spaties weghalen
}

# remove capitals and punctuation
corpus <- tolower(punctuation.remover(corpus))
ref.corpus <- tolower(punctuation.remover(ref.corpus))

# remove stop words
library(stopwords)
stoplist <- stopwords(language = "en", source = "stopwords-iso")
corpus <- corpus[!corpus %in% stoplist]
ref.corpus <- ref.corpus[!ref.corpus %in% stoplist]

# remove empty elements
corpus <- corpus[corpus != ""]
ref.corpus <- ref.corpus[ref.corpus != ""]

# DOUBLE FREQ TABLE

# make a vector with all words from both corpora
words <- c(corpus, ref.corpus)

# make a vector with the names of each corpus, as often as each corpus contains words
corpora <- c(rep("Corpus", length(corpus)), rep("Referencecorpus", length(ref.corpus)))

# 'double' frequency table with freq of each word per corpus
freq.table <- table(words, corpora)

# save as dataframe
result <- as.data.frame.matrix(freq.table)

# explore
tail(result, 20)

# CHI SQUARE TESTS

# package 'corpora' (Evert 2015)
# install.packages("corpora")
library(corpora)

# function chisq (Evert 2004: 82):
# "The standard test for independence of the rows and columns in a contingency table, at least in the field of mathematical statistics, is Pearson’s chi-squared test […]. Its test statistic is often denoted by the symbol X2 (cf. Pedersen 1996), and is a two-sided association measure."
# chisq(k1, n1, k2, n2, correct = TRUE, one.sided=FALSE)
# k1 = frequency of a type in the first corpus
# n1 = sample size of the first corpus
# k2 = frequency of a type in the reference corpus
# n2 = sample size of the reference corpus

# add chisq as extra column to dataframe with frequencies
result$X2 <- chisq(result$Corpus, length(result$Corpus), result$Referencecorpus, length(result$Referencecorpus))

# obtain p-values (identical to chisq(), but with chisq.pval()) and add as extra column to dataframe with frequencies
result$p <- chisq.pval(result$Corpus, length(result$Corpus), result$Referencecorpus, length(result$Referencecorpus))

# explore
tail(result, 20)

# round
result$X2 <- round(result$X2, 2)
result$p <- round(result$p, 5)

# sort dataframe based on X2-value (order())
result <- result[order(result$X2, decreasing = T), ]

# RESULT

# explore
head(result, 10)

# optional: only keep results where words appear more in corpus than in reference corpus
# (actually best to first weigh for number of words in corpora - not balanced here!)
result <- result[result$Corpus > result$Referencecorpus, ]

# if you want: only keep significant keywords (p <= 0.05)
# result_sign <- result[result$p<=0.05,]

# explore
head(result, 10)

# GRAPH (cf. later)

# limit to first ten
result <- result[1:10, ]

# extract frequency values for corpus and reference corpus (in new vector: 'to_plot')
to_plot <- rbind(result$Corpus, result$Referencecorpus)
to_plot

# barplot
barplot(to_plot, main = "Keywords (not significant)", ylab = "Absolute frequency", beside = T, names.arg = rownames(result), las = 2, cex.names = 0.75, legend.text = c("Corpus", "Reference corpus"))


#### --- | exercise: Netherlandic Dutch  ---#####

# For this exercise, we will try to find out which words are typical for Dutch as spoken in the Netherlands, versus Dutch as spoken in Flanders. We will load component A ('spoken conversations') of the Corpus of Spoken Dutch (CGN), with the Netherlandic Dutch subcomponent (https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/CGN-A-nl.txt) and the Flemish Dutch subcomponent (https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/CGN-A-vl.txt) in separate corpus files. Load "CGN-A-vl.txt" as your corpus, and use "CGN-A-nl.txt" as a reference corpus. Then make a copy of the 'keyness' code above, and try to adjust it so that it will work for this assignment. Make a graph showing your results, based on the code sample above, but only retain the words with 25 highest X2-values in your graph.


# B. Word clouds

# The Complete Poetical Works of Samuel Taylor Coleridge (http://www.gutenberg.org/ebooks/29091)

# install.packages("wordcloud")
library("wordcloud")

# load
words <- scan(file = "https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/coleridge.txt", what = character(0), fileEncoding = "UTF-8")
words <- tolower(words)
head(words, 50)

# remove punctuation
words <- gsub("[,.'…\"”)(_“‘’;:!?]", "", words, perl = TRUE)

# stoplist
stoplist <- stopwords(language = "en", source = "stopwords-iso")
words <- words[!words %in% stoplist]

# remove numbers (many years and page/ms. numbers)
nums <- 0:10000
nums <- as.character(nums)
words <- words[!words %in% nums]

# remove empty elements
words <- words[words != ""]

# check
head(words, 50)

# freq table
table_STC <- sort(table(words), decreasing = T)
head(table_STC, 50)

# subset of 100 most frequent
table_STC <- table_STC[1:100]

# word cloud
wordcloud(words = names(table_STC), freq = table_STC, min.freq = 1, max.words = 1000, random.order = FALSE, random.color = TRUE, rot.per = 0.3, use.r.layout = T, colors = brewer.pal(8, "Dark2"), scale = c(3.9, 0.6))

### 5.7 Concordances -----

rm(list = ls(all = TRUE))

# One very useful function: Stefan Gries' EXACT MATCHES - exact.matches()
# = basic concordancing

# load custom function
source("http://www.linguistics.ucsb.edu/faculty/stgries/exact_matches.r")
# alternative: download and place in working directory, and then:
# source("exact_matches.r")
# exact matches

# exact.matches()

corpus <- c("I don't know half of you half as well as I should like.", "And I like less than half of you half as well as you deserve.")

exact.matches("half", corpus)
# Basic syntax: search expression (regex), where/what to search
# Output: list
# 1  $`Exact matches` (cf. grep)
# 2  $`Locations of matches (lines)` (which element of the vector)
# 3  $`Proportion of non-empty corpus parts with matches`
# 4  $`Lines with delimited matches (if requested)`
# 5  $`Search parameters`
# 6  $`Version (date)`

# Use [[4]] to subset only the 'Lines with delimited matches':
matches <- exact.matches("half", corpus)[[4]]
matches

# export
write.table(matches, file = "matches_BilboBaggins.txt", sep = "\t", quote = FALSE)

# Extra options in syntax:
exact.matches("half", corpus)
# Basic syntax: search expression (regex), where/what to search
# case.sens=TRUE
# characters.around=0
# change to get characters before / after match
# (default = whole element)
# lines.around=0
# change to get lines before / after match (default=0)
# clean.up.spaces=TRUE
exact.matches("half", corpus, characters.around = 10)[[4]]


#### --- | exercise: exact matches Old Bailey ---####

# Load each line of the "https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/OldBaileyFragmentOBC-17320114.txt" as an item in the corpus vector. Next, search for any instances of the forms 'I', 'he', 'us' and 'him' in the corpus, and create a txt-file where the hits are shown in context, but separated by tabs. Save this file and open it in a spreadsheet processor to inspect the hits.


#### --- | exercise: terrorism in newspapers  ---#####

# We want to know if newspapers nowadays write more often about terrorism than in the past. We will load part of the Dutch-language VU-DNC newspaper corpus, which contains the archives of the NRC newspaper from 1950 and 2002. We'll search that for the words 'terrorisme', 'terreur', 'terrorist' and 'terroristen', and we'll assume that the use of these words is a proxy for dealing with the topic of terrorism.
# 1. Use a loop to load all corpus files from the "nrc1950" and "nrc2002" folders. Load them as separate subcorpora (`corpus.1950` and `corpus.2002`, i.e. two separate loops), and load in each line separately (line by line).
# 2. Compare the number of files for each subcorpus, and use the wordcount() function of the (to be installed) 'ngram'-package to count the number of words in each subcorpus.
# 3. Use 'exact matches' to search for the mentioned words in both subcorpora.
# 4. Compare the number of results per subcorpus, and weigh them over the total number of words in each subcorpus. Can we find an answer to our research question?


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
tt$Sex <- as.factor(tt$Sex)
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
round(prop.table(table(tt$Survived, tt$Sex), 2), 3)*100

# tip: make your own function

mytable <- function(dv, iv) {
  round(prop.table(table(dv, iv), 2), 3)*100
}

mytable(tt$Survived, tt$Sex)

# add more independent variables?
table(tt$Class, tt$Sex, tt$Survived) 
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
cut(tt$Age, breaks = c(0, 18, 30, 50, 100), labels = c("adolescent", "young", "middle-aged", "elderly"))

# save/assign
tt$Age_fct <- cut(tt$Age, breaks = c(0, 18, 30, 50, 100), labels = c("adolescent", "young", "middle-aged", "elderly"))
tt

# explore
round(prop.table(table(tt$Survived, tt$Age_fct), 2), 3)*100


### 6.3 Visualization - base package -----

# HISTOGRAMS AND QQPLOTS

# visualizing one numeric variable

hist(tt$Fare) # breaks option

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

# adjust marginss
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
     ylab = "Survived", col=c("grey40", "grey80"))

# option: titles
plot(tt$Survived ~ tt$Embarked, xlab = "Port of Embarkment",
     ylab = "Survived", col=c("green", "darkgreen"),
     main = "My plot title")

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
plot(sample, type = "b", pch = 15)

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
            IQR_fare = IQR(Fare))

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
  geom_hline(yintercept = mean(tt$Fare), col = "red")

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
  ggplot(aes(sample = Fare)) +
  geom_qq()

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
  facet_grid(. ~ Class) # facet_grid(Embarked ~ Class)

# jitter

tt %>%        # useless
  ggplot(aes(x = Class, y = Fare)) +
  geom_point() 

tt %>%         # better
  ggplot(aes(x = Class, y = Fare)) +
  geom_point(position = "jitter")

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

# VIOLIN PLOTS

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

# Load a collection on US age-adjusted death rates for selected major causes of death per 100,000 U.S. inhabitants (1900-2013) (source: https://data.world/health/death-rates-for-major-causes), located online ("https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/DeathRatesforMajorCauses_wide.csv"). Transform it from its current (very) wide format to a long data format. Then, filter out the death rates per year for 'Influenza and Pneumonia', and make an appropriate plot of this using ggplot. Next, calculate the mean death rate per cause of death, and plot this in a barplot, for which you chose a custom theme and an appropriate title plus axis labels. Finally, make a plot comparing the death rates per year for different causes, and save it as a PDF file with the name "death.pdf".

####--- | exercise: flights ---####

# Install and load the 'hflights' package, and then assign the element 'hflight' to a new dataframe of your choice. Also convert it into a tibble, and then select the variables Year, DayOfWeek, DepTime, UniqueCarrier, AirTime, ArrDelay, Dest, Distance, Cancelled, and CancellationCode, removing the others. Now, try to explore yoru data to answer the following questions:
# Which percentage of flights was cancelled in 2011? Visualize in a barplot.
# Calculate the percentage of flights cancelled versus the percentage of flights not cancelled, and visualize this in a simple barplot.
# Recode CancellationCode ("carrier" = "A", "weather" = "B", "FFA" = "C", "security" = "D") and use it to find out what the major cause of flight cancellations is.
# Plot the distance versus the arrival delay for all short-haul flights (i.e. with a total distance under 500 miles).
# Try to find out what the total airtime is per weekday, for the AA (American Airlines) and EV (ExpressJet) carriers. Plot this in a barplot with a different facet for each of the two carriers.
# Make a boxplot and a violin plot of the arrival delay for airline companies AA (American Airlines), DL (Delta) and US (US Airways), so you can check out which of these three companies holds the record in terms of arrival delay.

####--- | exercise: student numbers ---####

# Load a dataset with student enrollments for several bachelor programs across the five Flemish universities ("https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/students.csv"; source: Dataloep Vlaanderen). Convert it to a tibble and familiarize yourself with the data. Then carry out the following analyses:
# 1. Make a boxplot of student numbers per program. Give the boxes a nice color, and turn the boxplot around so the labels of the programs can be read horizontally.
# 2. Produce a histograms with student numbers, but with a different facet window for each university
# 3. Calculate the total number of students per university per year. Plot a smoother for these data, with one smoother line per university.
# 4. Make a table with the mean student numbers per program for all universities except for Hasselt, split up for gender: we want to be able to compare the bars for male versus female students side by side in the same plot.
# 5. Divide student groups into small (under 30 students), medium (30-100 students) and large (100 or more students). Then visualize the proportion of small, medium and large student group programs per university in a filled barplot.


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

# ggplot:
tt %>% 
  ggplot(aes(x = Age, y = Fare)) +
  geom_point() +
  geom_smooth(method = "lm")

# assumption of normality
shapiro.test(tt$Age); shapiro.test(tt$Fare) # if p < 0.05, then NOT normally distributed

# if normality had not been violated
# cor(tt$Fare, tt$Age, use = "complete.obs")
# cor.test(tt$Fare, tt$Age) 

# alternative (reduce to ordinal): Spearman's rho 
# Spearman’s rank correlation - correlation score:
cor(tt$Fare, tt$Age, use = "complete.obs", method = "spearman") # ignore NA's: use = "complete.obs"s
# very slight positive correlation
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

# Load a dataframe (source: https://www.kaggle.com/vikasojha98/top-women-chess-players) with recent scores by female chess players. Read it as csv and convert it to a tibble, but remove the variables 'Inactive_flag' and 'Gender'. Then, split the variable 'Age' up into 3 predefined groups (young = under 30, middle = 30-60, older = 60+), and split variable 'Standard_Rating' into 3 groups ("low", "medium", "high" -- allowing R to determine the exact cut-off points itself). Next, check out a possible effect of the (now) ordinal variable 'Age' on the ordinal variable 'Rating' -- explore numerically, graphically, and statistically. Finally, convert the dataset from a wide to a long format, and plot year of birth and rating (but only for the 'Blitz_rating' type), for Russian (RUS), Polish (POL) and Chinese (CHN) players in different colors, and add a LOESS smoother (method = "loess") for each group.
