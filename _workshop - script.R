# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
###                                                                     ###
###    Workshop: Basics in R for people who are afraid of computers     ###
###                  DSh - VUB - September 2020                         ### 
###             Rik Vosters - Vrije Universiteit Brussel                ###
###             Rik.Vosters@vub.ac.be | www.rikvosters.be               ###
###                                                                     ###
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

### 1. GETTING STARTED -----

# How does R work?

# Type things in script and send to console

"hello world"
print("hello world")

# Basic functions in R: addition, subtraction, etc.

2+7
2*7
2 + 7 

# Notice how anything behind the hash is a comment and is not processed

2+7 # comment
2+7 # +100
2+7   +100

# Assigning values

a <- 2+7  # assign  (pro tip Mac: OPTION + '-')
# cf. 'Environment' window
a

# Alternative: 

a = 2+7

# Operations on save values

a - 3
a <- a - 3 # overwrite
a

10*a+(1/3*a)

A # careful: R is case sensitive

# Define a sequence of elements (= vector)
b <- c(2, 4, 6) # notice: function c() 
b

a+b
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
?plot  # cf. 'Help' window
?max()
?barplot()

# Starting routine

# clear working space
rm(list=ls(all=TRUE))

# set working directory
setwd("")
setwd("/Users/rikvosters/Dropbox/@ Documenten/Colleges - courses/_Gastcolleges/2020.05 DSh workshop - Basics in R/Basics-in-R")
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
help(package=stylo) # or write in 'Help' window

install.packages("tidyverse") # once
library(tidyverse)

# alternatively:
# Packages > Install Packages | Tools > Install Packages
# Select a CRAN Mirror (Austria)
# Select a package or type the name of a package
# Use library(package) to load it
# see also: 'Packages' window

####--- | exercise: create new file  ---####

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

####--- | solution: create new file  ---####

x <- c(1530, 1540, 1550, 1560, 1570, 1580, 1590, 1600)
x
y <- c(4, 9, 17, 48, 78, 92, 96, 98)
y
plot(x, y)

####--- | exercise: hours of sleep  ---####

# - Assign values to create two vectors: one called 'sleep_week' where you input 5 numeric values for the (actual or ficticious) number of hours of sleep you got per weekday last week, and one called 'sleep_weekend'where you input 2 numeric values for the number of hours of sleep you got per day of the weekend last week. Make an estimation up to one decimal point (e.g. 8.5).
# - Create a new vector called 'weekend_zzz', for which you (automatically) calculate on average how many more hours of sleep you get in the weekend compared to during the week. 

####--- | solution: hours of sleep  ---####

sleep_week <- c(7, 6, 5.5, 8, 6)
sleep_weekend <- c(5,11)
weekend_zzz <- mean(sleep_weekend) - mean(sleep_week)
weekend_zzz

### 2. BASIC VECTORS -----

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
vecky[c(2,3)]

# generating vectors
1:35
1:1000
seq(from = 7, to = 9.5, by = 0.25)
rep(1:4, 3)
rep("abc", 3) # also for non-numerical vectors, cf. below

# some more data
wordcounts <- rnorm(100, mean=180, sd=40) # Generate normally distributed
                                          # data with a standard deviation 
                                          # of 40 around a mean score of 100
wordcounts

# round
round(wordcounts, 0)
wordcounts <- round(wordcounts, 0)
wordcounts

# sort
sort(wordcounts)
sort(wordcounts, decreasing=T)

# visually
plot(wordcounts)
plot(sort(wordcounts))
hist(wordcounts)

# some other useful functions
length(wordcounts)
sum(wordcounts)
sum(wordcounts, vecky)
max(wordcounts); min(wordcounts)
rev(wordcounts)

# more subsetting: logical expressions

wordcounts
sort(wordcounts, decreasing=T)
wordcounts[wordcounts>=200] # gives you the actual elements from the 
                            # dataframe matching the logical expression

  # compare:
  wordcounts>=200 # logical vector
  wordcounts[wordcounts>=200]

  #     <   Smaller than
  #     <=  Smaller than or equal to
  #     >   Larger than
  #     >=  Larger than or equal to
  #     ==  Equal to
  #     !=  Unequal to

wordcounts[wordcounts != 210]
wordcounts[wordcounts >= 210]

# how many elements in vector?
length(wordcounts[wordcounts >= 210])

wordcounts[wordcounts > 210 | wordcounts < 150] # | = OR
wordcounts[wordcounts < 175 & wordcounts > 150] # & = AND

benchmark <- 210:500 # define a vector with a benchmark range 
benchmark
wordcounts[wordcounts %in% benchmark]   # select all wordcount values 
                                        # that occur in that range
wordcounts[!wordcounts %in% benchmark]  # select all wordcount values
                                        # that do NOT occur in that range

####--- | exercise: hours of sleep (bis) ---####

# 1. Empty the work space.
# 2. Create one vector with the (estimated) average hours of sleep you had for each night last week. Make an estimation up to one decimal point (e.g. 8.5), starting with Monday and ending with Sunday (i.e. 7 numbers in total)
# 3. Calculate your mean number of hours of sleep based on this vector. Round to two decimal points.
# 4. Calculate with a function how many nights you had less than 7 hours of sleep.
# 5. Calculate in how many percent of all nights last week you had 8 hours or more of sleep. (Tip: percent = (x/y)*100)
# 6. Calculate the difference between your average hours of sleep during the week (i.e. Monday night till Friday night) versus in the weekend (i.e. Saturday and Sunday night). Use a subset of the first 5 and the last 2 elements in your vector.

####--- | solution: hours of sleep (bis) ---####

rm(list=ls(all=TRUE))

sleep <- c(7.0, 6.5, 6.0, 8.5, 6.5, 6.0, 5.5)
mean(sleep)
round(mean(sleep),2)

av <- mean(sleep)
round(av,2)

length(slaap[sleep < 7])

(length(slaap[sleep >= 8])/7)*100

week <- round(mean(sleep[1:5]),2)
week
weekend <- round(mean(sleep[6:7]),2)
weekend
diff <- week - weekend; diff


#### 2.2 Character vectors ####

# create a vector

vecky2 <- c("Colorless", "green", "ideas", "sleep", "furiously")
vecky2

vecky3 <- c("Time flies like an arrow", "Fruit flies like a banana")
vecky3

# no spaces in vector names - use underscore or dot
vekkie test <- c("Aa", "Bb", "Cc")
vekkie_test <- c("Aa", "Bb", "Cc")

# subsetting - access one specific element of that vector

vecky2[1:3]
vecky2[c(2,4)]

# stoplists 

stoplist <- c("green", "linguistics", "sleep", "Chomsky") # define stoplist to test vector against for subsetting
vecky2 %in% stoplist  # Does each element of vector vecky2 occur in 
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
sort(table(konami_code), decreasing=T) # sorted - basic frequency list!


# missing values = NA
konami_missing <- c("up", NA, "down", "down", "left", "right", "left", "right", "B", "A", "start")
table(konami_missing)

# numeric values missing
numbers <- c(1, 2, NA, 8, 12, NA, 36)
mean(numbers)
mean(numbers, na.rm = T)

####--- | exercise: Belgian Dutch words ---####

# Below is a selection of words that are considered to be non-standard Belgian Dutch, according to one particular prescriptivist language advice guidebook. The actual list is longer, but we just show the words starting with the letters A and B for practical reasons.
# > "Afgevaardigd Beheerder", "Ajuin", "Alcoholieker", "Alleszins", "Ardeens", "Autostrade", "Autotaks", "Allergisch Aan", "Aftrekker", "Afkuisen", "Baxter", "Bedanking", "Bedelen", "Beenhouwer", "Begankenis", "Bekwaam Om", "Benadeligen", "Bereide Schotel", "Beschaamd", "Beteugelen", "Betoelagen", "Betonneren", "Betrachten", "Betrachting", "Betrouwen", "Bic", "Bijhuis", "Binnendoen", "Binnenkoer", "Baxter", "Botermelk", "Boerenbuiten", "Brol", "Brossen", "Buitensmijten", "Bureel"
# 1. Load the list of words into your workspace. Don't type all of them, but use copy and paste!
# 2. Convert the text to lower case.
# 3. Make a frequency table of the words in the list to check of there are no words accidentally listed twice.
# 4. If necessary, remove double words from the list.
# 5. Try to use subsetting to find our if the words 'beschaamd', 'bisser' and 'boterkoek' appear in the list of the non-standard Belgian Dutch words.

####--- | solution: Belgian Dutch words ---####

# load 
belgicisms <- c("Afgevaardigd Beheerder", "Ajuin", "Alcoholieker", "Alleszins", "Ardeens", "Autostrade", "Autotaks", "Allergisch Aan", "Aftrekker", "Afkuisen", "Baxter", "Bedanking", "Bedelen", "Beenhouwer", "Begankenis", "Bekwaam Om", "Benadeligen", "Bereide Schotel", "Beschaamd", "Beteugelen", "Betoelagen", "Betonneren", "Betrachten", "Betrachting", "Betrouwen", "Bic", "Bijhuis", "Binnendoen", "Binnenkoer", "Baxter", "Botermelk", "Boerenbuiten", "Brol", "Brossen", "Buitensmijten", "Bureel")

# convert to lower
belgicisms <- tolower(belgicisms)

# table for double entries
sort(table(belgicisms)) # baxter = 2x

# remove double entries
belgicisms <- unique(belgicisms)

# check if five words appear in list
words_to_check <- c("beschaamd", "bisser", "boterkoek")
words_to_check[words_to_check %in% belgicisms] # cf.: words_to_check %in% belgicisms


### 3. DATAFRAMES, SUBSETTING AND DATA IMPORT -----

### 3.1 Data frames -----

# A dataframe consists of different vectors of the same length
col1 <- c("Aldrych", "Theobald", "Cadwell", "Ogden", "Roderick", "Rypley", "Marston", "Jimmy")
col2 <- c("/r/", "/R/", "/R/", NA, "/r/", "/r/", "/R/", "/R/")
col3 <- c(21, 98, 46, 17, 91, 100, 76, 0)
col4 <- c(TRUE,FALSE,TRUE,FALSE,TRUE,TRUE,TRUE,FALSE)

# Combining these three vectors with the function data.frame gives us one dataframe called 'OE'
OE <- data.frame(col1, col2, col3, col4) 

# You can add column names (= Variable names) to the dataframe
names(OE) <- c("Scribe","Pronunciation","Reaction_time", "Verified") 
OE # access entire dataframe

### 3.2 Subsetting -----

# Subsetting: same logic, but two dimensions: [rows, columns]

OE
OE[1,] # first row of dataframe OE
OE[,1] # first column of dataframe OE; same as:

# same, but easier (columns)
OE$Scribe
OE$Reaction_time

OE[,1:3] # what will we get here?
OE[3:6,1:2] # and here?

## Functions: Functions operating on vectors also work on columns/factors in a data frame

# … both numerical:
mean(OE$Reaction_time)
plot(sort(OE$Reaction_time))

# … and character-based:
toupper(OE$Scribe)
table(OE$Pronunciation)

## More subsetting: we can also subset the whole dataframe based on selection criteria applied to specific factors

OE[OE$Reaction_time > 25,]  # Subset the dataframe OE with all the entries 
                            # (rows) which have a reaction time of more than 25
                            # Mind the comma!
OE[OE$Scribe != "Roderick",] 
OE[OE$Reaction_time > 25 & OE$Pronunciation == "/r/",] 


# head()

# see only first 6 rows
head(OE) # identical as OE[1:6,]
head(OE,3) # specify number of rows

### 3.3 Importing data -----

# Several methods, depending on format of source

# TYPE 1: CSV - comma-separated (text) files

# be sure to set the working directory (or give a full path)
setwd("/Users/rikvosters/Dropbox/@ Documenten/Colleges - courses/_Gastcolleges/2020.05 DSh workshop - Basics in R/Basics-in-R")

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

library(readxl)  # first (just once): install.packages(readxl)
read_excel("SharkAttacks.xlsx")
# loads it as special type of dataframe: tibble (cf. infra)

# TYPE 4: R package

# some data is just available in a ready-made R package
# e.g. baby names
library(babynames) # first (just once): install.packages(babynames)
bb <- babynames
bb # also tibble

####--- | exercise: LEGO ---####

# Load a dataset called 'LEGOsets.csv', which contains an overview of all official LEGO sets (source: https://www.kaggle.com/rtatman/lego-database). You can either load it from the workshop folder, or from an online url (https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/LEGOsets.csv). Explore the first six rows of the dataframe. Then make a histogram of the variable 'year', to see how many sets were released each year. Next, check with a function when the first official set was released. Finally, extract the names of all LEGO sets released in 1955.

####--- | solution: LEGO ---####

# load data (offline)
lego <- read.csv("LEGOsets.csv")

# load data (online)
lego <- read.csv("https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/LEGOsets.csv")

# first six rows
head(lego)

# histogram
hist(lego$year)

# first
min(lego$year)

# names in 1955
lego$name[lego$year == 1955]

####--- | exercise: negation ---####

# Load a dataset called 'negation.csv' (https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/negation.csv). It contains an entry for each linguistic expression of negation in a corpus of early 19th century Flemish soldiers' letters. Negation either occur with a 'Single' negator, or as 'Bipartite' negation (i.e. with two negators). First use table() to check out what the distribution of Single versus Bipartite negation tokens is. Then work with a subset to find out if either form of negation occurs more often in main clauses with a SVO word order (Subject-Verb-Object), compared to subclauses with a SOV order (Subject-Object-Verb).

####--- | solution: negation ---####

# load
neg <- read.csv("https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/negation.csv")
head(neg)

# base package
table(neg$Negation)

# subset SOV v SVO
table(neg$Negation[neg$WordOrder == "SOV"])
table(neg$Negation[neg$WordOrder == "SVO"])

# tip (cf. later)
table(neg$Negation, neg$WordOrder)

####--- | exercise: catholic fertility ---####

# Install and load the package called 'datasets'. This package contains a dataset called 'swiss', which contains Swiss fertility and socioeconomic indicators from the year 1888. Save this dataset in your working environment as a new dataframe called 'helvetica', and explore it by looking at the first 10 rows. Now extract the rows only for those districts where more than 50% of the population is catholic, and calculate the mean fertility rate for these predominantly catholic districts. Now compare it to the mean fertility rate of districts with 50% of catholics or less.

####--- | solution: catholic fertility ---####

# install and load
library(datasets) # once: install.packages("datasets")

# save as new df
helvetica <- swiss

# first ten rows
head(helvetica, 10)

# rows for districts where Catholic > 50
helvetica[helvetica$Catholic > 50,]

# mean fertility rate in these catholic districts compared to districts with Catholic <= 50
mean(helvetica[helvetica$Catholic > 50,]$Fertility)
mean(helvetica[helvetica$Catholic <= 50,]$Fertility)

# alternative - new dataframe based on subset:
helvetica_catolica <- helvetica[helvetica$Catholic > 50,]
helvetica_heretica <- helvetica[helvetica$Catholic <= 50,]
mean(helvetica_catolica$Fertility)
mean(helvetica_heretica$Fertility)

### 3.4 An alternative approach: tidyverse/dplyr -----

# new kid on the block: tidyverse (tidyverse.org)
# popular set of packages (dplyr, ggplot, tidyr, ... )
# easier to get started, but harder for some things
# 'tidy' data:
#    1. each column is a variable
#    2. each row is an observation

library(tidyverse)

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

# for sequential code rather than embedded functions (CMD + shift + M)

wordcounts %>% sort() %>% plot()
# is the same as:
plot(sort(wordcounts))

round(mean(babynames$n))
# is the same as:
babynames$n %>% 
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
  mutate(prop_overall = n/sum(n))

babynames %>% 
  mutate(name_gendered = paste0(name, "_", sex))

# to save new/modified tibble:

babynames %>% 
  mutate(prop_overall = n/sum(n)) -> babynames

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
  geom_vline(xintercept = 1940, color="red")

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

# LATER •
# summarise(): make summary of data
# group_by(): 
# ggplot()

####--- | exercise: shark attacks ---####

# Load and explore the data on shark attacks from the internet (https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/SharkAttacks.csv). It is a tab separated file, so be sure to use the argument sep="\t". Also, it uses quotation marks in the text, so add the argument quote="". Browse through this dataset of almost 6000 documented shark attackes in history and try to answer the following questions, using either the base R package or tidyverse/dplyr:
# - How many people died of a shark attack in 2017?
# - Check if more shark attacks occurred in the 10 years before the movie Jaws came out in 1975, compared to 10 years after Jaws.
# - How old was the oldest Australian every to die from a shark attack?
# - Extract the names of all New Zealand victims of shark attacks in the 20th century, under the age of 16.

####--- | solution: shark attacks ---####

# load and explore
shark <- read.csv("https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/SharkAttacks.csv", sep="\t", quote="") 
shark

# died of shark attack in 2017
shark %>% 
  filter(Year == 2017) %>% 
  filter(Fatal == "Y") %>% 
  tally()

  # base package alternative:
  length(shark$Name[shark$Year == 2017 & shark$Fatal == "Y"])

# check before and after Jaws (1975)
shark %>% 
  filter(Year < 1975 & Year > 1965) %>% 
  tally()

shark %>% 
  filter(Year > 1975 & Year < 1985) %>% 
  tally()

  # base package alternative:
  length(shark$Name[shark$Year < 1975 & shark$Year > 1965])
  length(shark$Name[shark$Year > 1975 & shark$Year < 1985])

# oldest Australian to die

shark %>% 
  filter(Fatal == "Y") %>% 
  filter(Country == "AUSTRALIA") %>% 
  arrange(desc(Age)) %>% 
  select(Age) %>% 
  head(1)

  # base package alternative:
  max(shark$Age[shark$Fatal == "Y" & shark$Country == "AUSTRALIA"], na.rm = T)

# names of all 20C NZ victims under 16
shark %>% 
  filter(Age < 16 ) %>% 
  filter(Year > 1900 ) %>% 
  filter(Country == "NEW ZEALAND") %>% 
  select(Name)

  # base package alternative:
  shark$Name[shark$Age < 16 & shark$Year > 1900 & shark$Country == "NEW ZEALAND"]
  unique(shark$Name[shark$Age < 16 & shark$Year > 1900 & shark$Country == "NEW ZEALAND"])

### 3.5 Other types of data structures -----

# matrix 
matrix(1:20, nrow=5,ncol=4)

# list
names <- c("Samwise", "Meriadoc", "Peregrin", "Gimli", "Legolas") 
hobbit <- c(TRUE, TRUE, TRUE, FALSE, FALSE) 
age <- c(38, 36, 28, 139, 572) 

# compare 
data.frame(names, hobbit, age)
list(names, hobbit, age)

# the power of lists: different lengths
sample_list <- list(een = c(1,2,3), twee = c(1999,2000,2001, 2002, 2003), drie = c("A", "B", "C", "D", "E", "F"))
sample_list

# subsetting
sample_list[[2]]
sample_list[[2]][1]


### 4. DATA CLEANING AND MANIPULATION -----

# New dataset: Dogs of Zuerich (https://www.kaggle.com/kmader/dogs-of-zurich)
# Data about Dog Owners in Zuerich, Switzerland
dog <- read.csv("https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/DogsOfZuerich.csv", sep=";", na.strings = "")
head(dog)

### 4.1 Data classes -----

# basic data classes:
class(age)
class(hobbit)
class(names)
class(dog)

# also on columns in dataframes
class(dog$BIRTHYEAR)
class(dog$COLOR)

# character versus factor
dog$OWNER_SEX <- as.factor(dog$OWNER_SEX)
dog$OWNER_SEX

# cf. as.numeric(), as.character(), etc.

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
dog$BREED_rcd <- fct_lump_n(dog$BREED, n=15)
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
  mutate(AGE = 2016-dog$BIRTHYEAR) -> dog
table(dog$AGE)

table(dog$BIRTHYEAR)
dog$AGE <- 2016-dog$BIRTHYEAR
table(dog$AGE) # dogs 36 and 54 years old ≠ possible!

# remove outliers: filter()

dog %>% 
  filter(AGE < 30) -> dog
table(dog$AGE) 
hist(dog$AGE)

# reorder rows: arrange()

head(dog) # order by dog age instead of ID
dog %>% 
  arrange(AGE) -> god
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

####--- | exercise: dogs of Zuerich ---####

# Reload the Dogs of Zuerich csv file (https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/DogsOfZuerich.csv).Recode the 'TYPE_BREED' variable into a new 'SIZE' variable. 'K' stands for 'Kleinwüchsig' and represents small dogs, while 'I' and 'II' stand for 'Rassentypenliste I' and 'II', representing larger dogs. Check the proportion of small versus large dogs in Zurich, and check if women are more likely to have small dogs than men. Finally, if you have to buy a dog for your 85 year old grandmother, what specific breed would have the highest probability of her liking it, given her age and gender?

####--- | solution: dogs of Zuerich ---####

# reload
dog <- read.csv("https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/DogsOfZuerich.csv", sep=";", na.strings = "")

# recode
dog$TYPE_BREED <- as.factor(dog$TYPE_BREED)
levels(dog$TYPE_BREED)
dog$SIZE <- fct_recode(dog$TYPE_BREED, "Small" = "K", "Large" = "I", "Large" = "II")
dog$SIZE <- fct_relevel(dog$SIZE, "Small")

# proportion
table(dog$SIZE)
4205/(4205+2601)*100
# alternatives:
table(dog$SIZE)[1]/(table(dog$SIZE)[1]+table(dog$SIZE)[2])*100
prop.table(table(dog$SIZE))

# comparison women v men
table(dog$SIZE[dog$OWNER_SEX=="w"])
3037/(3037+1611)*100
table(dog$SIZE[dog$OWNER_SEX=="m"])
1168/(1168+990)*100 # men are less likely to have small dogs than women
  # alternative:
  prop.table(table(dog$SIZE[dog$OWNER_SEX=="w"]))
  prop.table(table(dog$SIZE[dog$OWNER_SEX=="m"]))
  
# dog breed for 85 year old grandmother
sort(table(dog$BREED[dog$OWNER_SEX == "w" & dog$OWNER_AGE == "81-90"]))

# alternative tidyverse/dplyr
dog %>% 
  filter(OWNER_SEX == "w") %>% 
  filter(OWNER_AGE == "81-90") %>% 
  select(BREED) %>% 
  table() %>% 
  sort(decreasing = T) %>% 
  head(1)

### 4.3 Long and wide data -----

# 1. Wide to long 

# let's load a new data set, with population data of some countries from 1960 to 2015
pop <- read.csv("https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/world_population_wide.csv", sep=",", 
                check.names = F)
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





### EXC: wide to long + merge 


### 4.5  Loading multiple files (loops and lapply)-----
# loop
# alternative: 
files <- list.files(pattern = "file_.*csv")
df_list <- lapply(files, read_csv)
df <- bind_rows(df_list)












































##### 3. LOADING A CORPUS FILE #####

# clear memory
rm(list=ls(all=TRUE))

## load a corpus file (≠ importing data)

# use scan: define what you want to scan (= the file), as what you want to load it (= character data), and how/where you want R to separate what you are loading (= e.g. each line as one element)
corpus.file <- scan(file="Soldiers - 277 1811 KANEGEM.txt", what=character(0), sep="\n")
corpus.file

# alternatively:
  # corpus.file <- scan(file=choose.files(), what=character(0), sep="\n") 
      # Windows
  # corpus.file <- scan(file=file.choose(), what=character(0), sep="\n")
      # Mac / Linux - library(tcltk); tk_choose.files()

# all in lower case
corpus.file.lower <- tolower(scan(file="Soldiers - 277 1811 KANEGEM.txt", what=character(0), sep="\n")) # opposite: toupper()

# encoding problems:
corpus.file <- scan(file="Soldiers - 277 1811 KANEGEM.txt", what=character(0), sep="\n", fileEncoding="UNICODE-1-1") # argument: fileEncoding=""
corpus.file
iconvlist() # all encoding options for platform



##### 4. TEXT MANIPULATION AND BASIC FREQUENCY LISTS #####

#### 4.1 Pasting and splitting ####

### Pasting

# make vector
words <- c("I", "am", "anespeptic,", "phrasmotic,", "even", "compunctious", "to", "have", "caused", "you", "such", "pericombobulation.")

# paste and collapse loose elements together
text <- paste(words, collapse=" ") # collapse pastes all vectors AND all elements within that vector together with the indicated separator
text

### Splitting

# take a character vector
text

# split its elements at the given separator
split <- strsplit(text, " ")
split
unlist(split)

  # compare:
  strsplit(text, "") # what happened? 
  sort(table(unlist(strsplit(text, ""))))   # useful to get a table of what     
                                            # characters occur in your corpus
                                            # helping you decide what to use 
                                            # as the strspl separator

# with more elements
text2 <- c("I am anespeptic, phrasmotic, even compunctious to have caused you such pericombobulation.", "Anything I can do to facilitate your velocitous extramurilisation")

# split at spaces
split <- strsplit(text2, " "); 
split # returns a list (two levels)

# unlist (= collapse into one level)
unlist(split)

#### 4.2 Basic frequency lists ####

## we'll make a frequency list of all the words in the two Blackadder fragments (together)
corpus.file <- c("I am anespeptic, phrasmotic, even compunctious to have caused you such pericombobulation.", "Anything I can do to facilitate your velocitous extramurilisation")

table(unlist(strsplit(corpus.file, " "))) 
# = table of unlisted string-split elements of corpus.file
  # string-split
  # unlist
  # table
  # BUT: unsorted
sort(table(unlist(strsplit(corpus.file, " ")))) # idem, but sorted
  # string-split
  # unlist
  # table
  # sort
  # BUT: punctuation

    ### ASIDE: functions
    
    ## List all characters in a corpus (Gries 2009)

    # cf. above
    table(unlist(strsplit(corpus.file, "")))
    
    # Menu: 'Code' > 'Extract function'...

    charlist <- function (text) {
      table(unlist(strsplit(text, "")))
    }
    
    charlist(corpus.file)
    
    ## Remove punctuation
    
    punctuation.remover <- function (text) {
      #  remove punctuation - cf. 'gsub' later
      temp <- gsub("[,.'…\";:!?-_]", "", text, perl=TRUE)  
      #  remove double spaces
      gsub(" {2,}", " ", temp, perl=TRUE)                 
    }

    corpus.file <- punctuation.remover(corpus.file)

    ## Frequency list

    freqlist <- function (text) {
      sort(table(unlist(strsplit(tolower(text), " "))))
    }

    frequencies <- freqlist(corpus.file)
    frequencies
    
    # cf. to: 
    sort(table(unlist(strsplit(tolower(corpus.file), " ")))) 
    # = without the punctuation remover


## Order alphabetically (instead of sort based on frequency)

# extract 'names' (= words) from frequency table
names(frequencies)

# use order to subset frequency list in alphabetical order (i.e. based on names)
frequencies[order(names(frequencies))]


## Export as txt-file (which you can open in a spreadsheet processor like Calc or MS Excel)

# write.table()
write.table(frequencies, file="output/freqlist_blackadder.txt", sep="\t", quote=FALSE) # make folder 'output' in working directory


####--- | exercise: acronyms  ---####

## Make a new function acronym_maker that takes the first letter of each word in its input, and put those together into an upper-case acronym (e.g. North Atlantic Treaty Organization -> NATO). Test it on a string like 'personal identification number'.

# Schematically:
# how to get from "personal identification number" to "PIN":
# 1. split up into words
# 2. take out first letter of each word substr()
# 3. connect those letters back together
# 4. make upper case

####--- | exercise: soldiers corpus  ---####

## After clearing the working memory, load the "Soldiers - 262 1810 ONBEKEND.txt" and the "Soldiers - 277 1811 KANEGEM.txt" documents from the Napoleonic Soldiers Corpus, and collapse them together into one corpus file vector. Then remove all punctuation from the file and make everything upper case. Next, produce an alphabetical word frequency list based on this corpus, and save it as a text file. You can use the punctuation.remover, but none of the other custom-made functions (charlist, freqlist).


##### 5. LEMMATIZING AND SPELLING NORMALIZATION #####

# manual basics

### Prepare and load data

# clear memory
rm(list=ls(all=TRUE))

# load fragment from Old Bailey Corpus
corpus.file <- c("The three Prisoners came to his House, and having drank two Full Pots of Beer, about a Quarter of an Hour after they were gone missed his Tankard, which was taken out of a Cupboard in the Kitchen. That then he went in Search after them, and having apprehended him, the witness came to his House, and hectored him; that then he apprehended him, and being committed, fell a fighting with the Persons who had him in Custody.")

### List of types and tokens

# load punctuation.remover
punctuation.remover <- function (text) {
  temp <- gsub("[,.'…\";:!?-]", "", text, perl=TRUE)  #  remove punctuation - cf. 'gsub' later
  gsub(" {2,}", " ", temp, perl=TRUE)                 #  remove double spaces
}

# make word list (without punctuation and all lower case)
corpus.file <- punctuation.remover(tolower(corpus.file)); corpus.file
corpus.words <- unlist(strsplit(corpus.file, " "))

# tokens
corpus.words
length(corpus.words) # 78 tokens

# types
unique(corpus.words)
length(unique(corpus.words)) # 52 types

# type frequencies
sort(table(corpus.words))

### Lemmas

# Read in a downloaded form-lemma list 
form_lemma_list <- read.csv("form-lemma list.txt", header=T, sep="\t")  
head(form_lemma_list)
  # Based on GloWbE - 1.8 billion words 
  # (http://corpus.byu.edu/full-text/formats.asp)

# data
head(corpus.words, 15)

# lemmatize: using (match)
lemmatized_list <- data.frame(corpus.words, form_lemma_list$LEMMA[match(corpus.words, form_lemma_list$FORM)])
names(lemmatized_list) <- c("Form_in_corpus", "Lemma") # assign column names
head(lemmatized_list, 10)

# package solution:

library(SnowballC)
wordStem(c("prisoner", "prisoners", "come", "coming", "comes"), language = "english")
wordStem(corpus.words, language = "english")

# also check out: library(tm) - stemDocument


####--- | exercise: spelling normalization ---####

### The same principles we used for lemmatization can also be used to normalize the spelling of a corpus, based on an existing document listing all possible base words along with any possible spelling variants. Starting from the fragment of lower-class writing from the London Lives Project below, draw on a custom-made spelling normalization list ("spelling normalization list.txt") to make a word list containing (a) the original word forms from the corpus, and (b) the normalized spelling forms behind each word from the corpus, separated by an underscore. When the corpus, for instance, reads "trobell", you should get an output of "trobell_trouble". 
# Fragment:
# onred Sur iam sorry to trobell you with this my Child bee Seek for three months on and of and now he is bad again as icant pay him Sur i hope you will think of my child for he is dangers ill
# (Source: London Lives - St Dionis Backchurch Parish: Letters to Parish Officials Seeking Pauper Relief (1758-1759) - http://www.londonlives.org/browse.jsp?div=GLDBPR30800PR308000005)


##### 6. POWERSEARCHING #####

#### 6.1 Grep ####

grep("searchpattern", text) 
  # argument 1: what to search for
  # argument 2: where to search for it
  # optional argument value=T to get the element itself (instead of its position)
  # optional argument ignore.case=TRUE to ignore case (default=FALSE)

witch <- c("If she weighs the same as a duck, she's made of wood, and therefore a witch!", "The suspect has his head placed upon a block, and an axe aimed at his neck.", "If the man is guilty, the axe will bounce off his neck, so we burn him.", "If the man is not guilty, the axe will simply slice his head off.")
witch

grep("duck", witch) # position
grep("duck", witch, value=TRUE, ignore.case=FALSE) # matched element itself

grep("Guilty", witch, value=TRUE, ignore.case=TRUE)
grep("Guilty", witch, value=TRUE, ignore.case=F)

# also very useful: 
grepl() # same, but returns a logical vector (see later for subsetting of corpus!)



####--- | exercise: grep ---####

# Write a regex to capture the names of the last four months of the year

# Write a regex to search for all historical spelling variants of the Dutch PersPron 'ik', where the <i> can also take the form of <j> or <ij>, and the <k> could also occur as <ck> (but not as <c>). Test it on the words: "ik", "ick", "jk", "jck", "ijck", "Ik", "Ick", "Jk", "Jck", "Ijck", "ic".

# Write a regex to capture all words (singular and plural) ending in the suffix -ism. Test it on the words: "fascism", "Bushisms", "antidisestablishmentarianism", "prism".

# Write a regex to capture any word starting in a cluster of three or more consonants and exactly one vowel grapheme. Test it on the words: "spring", "schmuck", "strudel", "scared", "straight".


#### 6.2 Gsub ####

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

####--- | exercise: gsub GerManC---####

# Load the following fragment from the GerManC corpus, and remove all of the tags from the fragment (source: muenchen1702_1.xml).
# GerManC <- c("<p><s>Verwichenen Dienstag seynd <num type=\"cardinal\" value=\"3\">3.</num> Hussaren vor <rs type=\"place\" key=\"DON\">Donauwerth</rs> gekommen/ vnd haben den Hirten mit <num type=\"cardinal\" value=\"40\">40.</num> Pferdten weggetriben;</s> <s>Die Bayrischen haben ihnen zwar gleich mit <num type=\"cardinal\" value=\"20\">20.</num> Pferdten bis; <rs type=\"place\" key=\"HHar\">Harburg</rs> nachgesetzt/ sie aber dannoch nicht angetroffen.</s>") 

####--- | exercise: gsub anonymize---####

# Load the fragment from the Dutch United Kingdom of the Netherlands Corpus below (Vosters 2009). To protect the identity of the people mentioned in this police report, change their names into their initials. You can assume that a name always consists of one capitalized first name and one capitalized last name. 
# policereport <- c("De heer Philip Devaleriola, die den nacht van den zes en twintigsten den zeven en twintigsten april in de fabrijk niet doorgebragt had, op zijnen beurt ondervraagd zijnde, verklaarde dat hij bij zijne vrouw was gaan slapen, in het huis van juffrouw Johanna Roberti alhier te Brussel. Maar de juffrouw Johanna Roberti en Catharina Vanginderachter hare winkel dochter, gaven aan de kommissaris van policie ten antwoord, dat hij dezen nacht bij zijne vrouw geenszins doorgebragt had.")


#### 6.3 Some more regex: anchors & boundaries ####

## Anchors

# start of line/element
words <- c("John S. is coming, but John. D. isn’t.")
gsub("^John", "Johnnie", words, perl=T)

# start and end of line/element
words <- c("over", "overload", "overdosis", "Over")
grep("^over$", words, value=T, ignore.case=T)

## Word boundaries 

words <- c("This is John. John Johnson.")
words

# with \\W
gsub("John\\W", "Bill", words, perl=T) # consumed the \\W

# with \\b
gsub("John\\b", "Bill", words, perl=T) # better!

####--- | exercise: anchors & boundaries ---####

# Write a regex that can transform different sorts of American date notations into European date notations.
# (e.g. "07.24.2014", "02.23.82", "6/1/2014", "03-10-19", "7.24.14")


#### 6.4 Exact matches ####

rm(list=ls(all=TRUE))

### One very useful function: Stefan Gries' EXACT MATCHES - exact.matches()
# = basic concordancing

## load custom function 
source("http://www.linguistics.ucsb.edu/faculty/stgries/exact_matches.r") 
    # alternative: download and place in working directory, and then: 
    # source("exact_matches.r")

## exact.matches()

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
write.table(matches, file="output/matches_BilboBaggins.txt", sep="\t", quote=FALSE)

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
exact.matches("half", corpus, characters.around=10)[[4]]

####--- | exercise: exact matches Old Bailey ---####

# Load each line of the "Old Bailey fragment OBC-17320114.txt" as an item in the corpus vector. Next, search for any instances of the forms 'I', 'he', 'us' and 'him' in the corpus, and create a txt-file where the hits are shown in context, but separated by tabs. Save this file and open it in a spreadsheet processor to inspect the hits. 


##### 7. LOOPS AND CORPORA ####

# So far: one or two corpus files, loaded manually
# To import a whole corpus: for-loops
    
    
    # Loops have the following structure
    for (i in 1:total_iterations) {   # we define a counter 'i', and 
                                      # define that it will run from 1 to
                                      # the total number of iterations
      functions       # functions in the loop 
                      # will be performed i times
    }
    
    # Example
    for (i in 1:50) {     # define counter 'i' and iterate from 1 till 20
      # function cat() (= print on screen) will run for 20 times
      # with the element i in it
      cat("This is iteration number", i, "\n", sep=" ")   
    }

####--- | exercise: multiplication tables ---#####

# Use a for-loop that will generate the result of the multiplication tables of 7 (i.e. 7x1=7, 7x2=14, 7x3=21, …, 7x10=70). First set a counter which is the number (going from 1 to 10) you use to multiply with 7, and then calculate a variable x with the result of the multiplication. Show each result for 'x' on your screen using the 'print()' function.


## Loop to load various corpus files

rm(list=ls(all=TRUE))

# As a preparation: define names of corpus files in a vector called corpus.files
corpus.files <- dir(pattern="Soldiers")
# any file in the working directory with " " in its name
# often you can use: pattern="txt"
corpus.files

# Also, already created an empty character vector into which the whole corpus will be loaded
corpus <- character()

# Start the loop
for (i in 1:length(corpus.files)) {   # iterate over file names 
  # read in corpus file as lower case and save it in current.corpus.file
  current.corpus.file <- tolower(scan(corpus.files[i], what=character(0), sep="\n", quiet=TRUE))
  # append the current.corpus.file to the whole corpus
  corpus <- c(corpus, current.corpus.file)
}

corpus

## Same idea now, but a bit more elaborate.
## The goal is to extract the metalinguistic information in the file name
  # and add it to the elements in the corpus,
  # so that we can later only search those parts we are interested 
  # in (e.g. only the documents written in a specific year)
## The same can be done with information from the header of the corpus file

corpus.files <- dir(pattern="Soldiers") 
corpus <- character()

for (i in 1:length(corpus.files)) {           # iterate over file names 
  # output a 'progress report'
  cat(round(i/length(corpus.files), 2), ":\t", corpus.files[i], "\n")
  
  # read in corpus file as lower case and save it in current.corpus.file
  current.corpus.file <- tolower(scan(corpus.files[i], what=character(0), sep="\n", quiet=TRUE))
  
  # extract and save file name of the current file (in upper case)
  current.filename.tag <- toupper(basename(corpus.files[i]))
  
  # clean up file name: remove .txt 
  current.filename.tag <- gsub("\\.TXT", "", current.filename.tag, perl=T)
  
  # clean up file name: remove "SOLDIERS - "
  current.filename.tag <- gsub("SOLDIERS - ", "", current.filename.tag, perl=T)

  # clean up file name: make info from file name (Letter, Year, Place) into tag
  current.filename.tag <- gsub("^(\\d{3}) (\\d{4}) (.*?)$", "<\\LETTER=\\1, YEAR=\\2, PLACE=\\3>", current.filename.tag)
  
  # append file name tag to sentence
  current.corpus.file <- paste(current.filename.tag, current.corpus.file, sep="")
  
  # append the current.corpus.file to the whole corpus
  corpus <- c(corpus, current.corpus.file)   
} 

head(corpus)

## This corpus can now be used to search (exact.matches)
spl_k <- exact.matches("\\b[ij]k\\b", corpus)[[4]]
spl_ck <- exact.matches("\\b[ij]ck\\b", corpus)[[4]]

# use grepl to subset the corpus (based on extralinguistic criteria)
spl_k_ss <- exact.matches("\\b[ij]k\\b", corpus[grepl("PLACE=ROESELARE", corpus)])[[4]]
spl_k_ss2 <- exact.matches("\\b[ij]k\\b", corpus[grepl("YEAR=18(10|11)", corpus)])[[4]]

# explore results
length(spl_k); length(spl_ck)
head(spl_k)
head(spl_ck)

# prepare output for export
matches <- c(spl_k, spl_ck)
head(matches)
output <- gsub("<\\LETTER=(.*?), YEAR=(.*?), PLACE=(.*?)>", "\\1\t\\2\t\\3\t", matches)

# save output
write.table(output, file="output/matches_spelling.txt", sep="\t", quote=FALSE)


# ## Use loop to load corpus by extracting sentences 
# #  from selected XML corpus files
# ## However: special packages for reading and parsing XML
# #  e.g. library(XML):
# #     "This package provides many approaches for both 
# #      reading and creating XML (and HTML) documents 
# #      (including DTDs), both local and accessible via
# #      HTTP or FTP. It also offers access to an 
# #      XPath interpreter."
# ##  Here: just extracting the sentences for further analysis
# 
# corpus.files <- dir(pattern="GerManC")
# corpus <- character()
# 
# for (i in 1:length(corpus.files)) {           # iterate over file names
#   
# # output a 'progress report'
# cat(round(i/length(corpus.files), 2), ":\t", corpus.files[i], "\n") 
# 
# # read in corpus file as lower case and save it in current.corpus.file
# current.corpus.file <- tolower(scan(corpus.files[i], what=character(0), sep="\n", quiet=TRUE))
# 
# # extract and save file name of the current file (in upper case)
# sentences <- grep("<s>.*?</s>", current.corpus.file, perl=TRUE, value=TRUE)
# 
# # use end of sentence tag to split vector up with strsplit
# sentences <- unlist(strsplit(sentences, "</s>"))
# 
# # keep only sentences starting in <s> (= real sentences)
# sentences <- grep("<s>", sentences, perl=TRUE, value=TRUE)
# 
# # append current sentences to whole corpus
# corpus <- c(corpus, sentences) 
# }
# 
# corpus # result
# head(gsub("<.*?>", "", corpus, perl=T)) # without tags

####--- | exercise: loops and corpora  ---#####

# Use a for-loop to load the available files of the United Kingdom of the Netherlands Corpus ("UKN corpus…"), and extract all verbs from that corpus. Words have a tag structure as follows: <w lemma='vinden' msd='ww'>vond</w>, with verbs being labeled as msd='ww'. Preserve the tag structure, but add the year of writing to each word’s tag (see document header: e.g. <year='1823'/>. You want to get something like: <year='1829' lemma='zijn' msd='ww'>waren</w>. Save this as a vector 'corpus'. Then search this corpus for all instances of the lemma 'zeggen' (to say) occurring in documents written in 1829. 


##### 8. FREQUENCY LISTS AND RELATED INSTRUMENTS #####

#### 8.1 Frequency lists ####

# setwd()

# example: inaugual addresses last two US presidents

# load both corpora, convert to lower case
obama <- scan(file="obama.txt", what=character(0), quote="")
obama <- tolower(obama)
trump <- scan(file="trump.txt", what=character(0), quote="")
trump <- tolower(trump)

# explore
head(obama) # first six items
head(trump)
head(obama, 20); head(trump, 20)
tail(obama, 20)

# simple freq table
freq.obama <- table(obama)
freq.obama # alphabetical
# idem:
freq.trump <- table(trump)
freq.trump 

# sort on frequency (high to low)
freq.obama <- sort(table(obama), decreasing=T)
freq.trump <- sort(table(trump), decreasing=T)

freq.obama # entire
freq.obama[1:75] # idem: head(freq.obama, 75)


freq.obama[1:75]
# punctuation (-> A.)
# function words (-> B.)

### Punctuation 

# new corpus without punctuation
# gsub
obama
obama <- gsub("[,.'…\"”)(“‘’;:!?]", "", obama, perl=TRUE)
obama

# new freq list based on new corpus
freq.obama <- sort(table(obama), decreasing=T)
# 10 most frequent tokens
freq.obama[1:10]

# idem trump
trump <- gsub("[,.'…\"”)(“‘’;:!?]", "", trump, perl=TRUE)
freq.trump <- sort(table(trump), decreasing=T)

# compare
freq.obama[1:10]
freq.trump[1:10]

### Lists of stop words 

# define stoplist
stoplist <- c("the", "and", "of", "our", "we", "to")

# or, load existing stoplist
# https://sites.google.com/site/kevinbouge/stopwords-lists (in working dir)
stoplist <- scan("stopwords_en.txt", what=character(0), sep="\n", fileEncoding = "UTF-8")

# new corpus using stoplist
obama <- obama[!obama %in% stoplist]

# new freq list based on new corpus
freq.obama <- sort(table(obama), decreasing=T)

# 10 most frequent tokens
head(freq.obama, 10)

# idem trump
trump <- trump[!trump %in% stoplist]
freq.trump <- sort(table(trump), decreasing=T)
head(freq.trump, 10)

# compare:
freq.obama[1:10]
freq.trump[1:10]

## graph
barplot(freq.obama[1:15], main="Most frequent words - Obama", ylab="Absolute frequency", ylim=c(0,20), las=2, cex.names = 0.7)
barplot(freq.trump[1:15], main="Most frequent words - Trump", ylab="Absolute frequency", ylim=c(0,20), las=2, cex.names = 0.7)

## export tables

# write.table()
write.table(freq.obama[1:50], file="output/freqtabel_obama.txt", sep="\t", quote=FALSE, col.names=FALSE, row.names=T)
write.table(freq.trump[1:50], file="output/freqtabel_trump.txt", sep="\t", quote=FALSE, col.names=FALSE, row.names=T)
# in freq list: row.names=T (as words = row names)

####--- | exercise: corpus English dialogues  ---#####

# # Load the "CED_example.txt" file from the Corpus of English Dialogues 1560-1760 (CED), and try to make a frequency list (without punctuation) of this corpus, filtering out the words 'sample', 'file' and 'ced'. Limit yourself to the 25 most frequent words, save the frequency list, and visualize the 25 most frequent words in a graph.

####--- | exercise: terrorism in newspapers  ---#####

# We want to know if newspapers nowadays write more often about terrorism than in the past. We will load part of the Dutch-language VU-DNC newspaper corpus, which contains the archives of the NRC newspaper from 1950 and 2002. We'll search that for the words 'terrorisme', 'terreur', 'terrorist' and 'terroristen', and we'll assume that the use of these words is a proxy for dealing with the topic of terrorism.
# 1. Use a loop to load all corpus files from the "nrc1950" and "nrc2002" folders. Load them as separate subcorpora (`corpus.1950` and `corpus.2002`, i.e. two separate loops), and load in each line separately (line by line).
# 2. Compare the number of files for each subcorpus, and use the wordcount() function of the (to be installed) 'ngram'-package to count the number of words in each subcorpus.
# 3. Use 'exact matches' to search for the mentioned words in both subcorpora.
# 4. Compare the number of results per subcorpus, and weigh them over the total number of words in each subcorpus. Can we find an answer to our research question?

#### 8.2 Keyness ####

# Code from Gries (2009)

### LOAD 

rm(list=ls(all=T))

# presidential addresses 
# trump v. other recent presidents (Ronald Reagan, George Bush, Bill Clinton, George W. Bush, Barack Obama)

# load (word for word)
corpus <- scan(file="trump.txt", what=character(0), quote="")
ref.corpus <- scan(file="speeches.txt", what=character(0), quote="")

# remove punctuation
punctuation.remover <- function (text) {
  temp <- gsub("[,.)('…\"”“‘’;:!?]", "", text, perl=TRUE)  #  interpunctie weghalen
  gsub(" {2,}", " ", temp, perl=TRUE)                #  dubbele spaties weghalen
}

# remove capitals and punctuation
corpus <- tolower(punctuation.remover(corpus))
ref.corpus <- tolower(punctuation.remover(ref.corpus))

# remove stop words
stoplist <- scan("stopwords_en.txt", what=character(0), sep="\n", fileEncoding = "UTF-8")
corpus <- corpus[!corpus %in% stoplist]
ref.corpus <- ref.corpus[!ref.corpus %in% stoplist]

# remove empty elements
corpus <- corpus[corpus!=""]
ref.corpus <- ref.corpus[ref.corpus!=""]

### DOUBLE FREQ TABLE 

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


### CHI SQUARE TESTS 

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
result <- result[order(result$X2, decreasing=T),]


### RESULT 

# explore
head(result, 10)

# only keep results where words appear more in corpus than in reference corpus
result <- result[result$Corpus>result$Referencecorpus,]

# if you want: only keep significant keywords (p <= 0.05)
# result_sign <- result[result$p<=0.05,]

# explore
head(result, 10)

# save as file
write.table(result, "output/output_keyness.txt", sep="\t", row.names=T, quote=F)

### GRAPH 

# limit to first ten
result <- result[1:10,]

# extract frequency values for corpus and reference corpus (in new vector: 'to_plot')
to_plot <- rbind(result$Corpus, result$Referencecorpus)
to_plot

# barplot
barplot(to_plot, main="Keywords (not significant)", ylab="Absolute frequency", beside = T, names.arg=rownames(result), las=2, cex.names = 0.75, legend.text=c("Corpus", "Reference corpus"))

####--- | exercise: Netherlandic Dutch  ---#####

# For this exercise, we will try to find out which words are typical for Dutch as spoken in the Netherlands, versus Dutch as spoken in Flanders. We will load component A ('spoken conversations') of the Corpus of Spoken Dutch (CGN), with the Netherlandic Dutch subcomponent (CGN-A-nl.txt) and the Flemish Dutch subcomponent (CGN-A-vl.txt) in separate corpus files. Load "CGN-A-vl.txt" as your corpus, and use "CGN-A-nl.txt" as a reference corpus. Then make a copy of the 'keyness' code above, and try to adjust it so that it will work for this assignment. Make a graph showing your results, but only retain the words with 25 highest X2-values in your graph.

#### 8.3 Word clouds #### 

# The Complete Poetical Works of Samuel Taylor Coleridge (http://www.gutenberg.org/ebooks/29091)

# install.packages("wordcloud")
library("wordcloud")

# load
words <- scan(file = "coleridge.txt", what = character(0), fileEncoding = "UTF-8")
words <- tolower(words)
head(words, 50)

# remove punctuation
words <- gsub("[,.'…\"”)(_“‘’;:!?]", "", words, perl=TRUE)

# stoplist
stoplist <- scan("stopwords_en.txt", what=character(0), sep="\n", fileEncoding = "UTF-8")
words <- words[!words %in% stoplist]

# remove numbers (many years and page/ms. numbers)
nums <- 0:10000
nums <- as.character(nums)
words <- words[!words %in% nums]

# remove empty elements
words <- words[words!=""]

# check
head(words, 50)

# freq table
table_STC <- sort(table(words), decreasing = T)
head(table_STC, 50)

# subset of 100 most frequent
table_STC <- table_STC[1:100]

# word cloud 
wordcloud(words=names(table_STC), freq=table_STC, min.freq=1, max.words=1000, random.order=FALSE, random.color=TRUE, rot.per=0.3, use.r.layout=T, colors=brewer.pal(8, "Dark2"), scale = c(3.9, 0.6))


##### 9. EXPLORATION OF CORPUS RESULTS: CATEGORICAL DV #####

    # DV - IV?
    # What are ordinal and nominal data? 
    # Scales of measure? nominal, ordinal, interval/ratio

#### 9.1 Loading data ####

#                                         #
# inspect data in spreadsheet processor   #
#                                         #

# prep
rm(list=ls(all=TRUE))

# load as dataframe 
neg <- read.table("negation - data.txt", fileEncoding="UTF-16", sep="\t", header=TRUE)
    # based on data coded by Leo (2011)

# explore dataframe
neg # too large
head(neg) # first 6 rows; idem as neg[1:6,]
tail(neg, 10) 

summary(neg)
  # notice: first results - overall distribution of DV
  # notice: NA's
  # other factors (= linguistic, coded into the spreadsheet)

# We could now already start to explore the data…
plot(neg$Negation)

# However: we have some more metadata on these documents in a separate file, such as the name of the scribe who wrote/dictated them, the year in which each letter was written, the exact destination of each letter, and a word count per letter. We can now add these into our dataset with the merge() function...

#### 9.2 Merge - adding metadata ####

# load metadata from separate file
meta <- read.delim("negation - scribe metadata.txt", fileEncoding="UTF-16", header=T)
head(meta)

# compare:
head(neg)

# merge
neg <- merge(neg, meta, by="Letter") # first the two elements which to merge, then by="" (= the column used for merging)

# check
head(neg) # success!

#### 9.3 Exploring and reshaping data ####

summary(neg)

str(neg) # properties per factor (see also: 'Environment' windows)
  # 1068 obs. of  8 variables
  # notice factor types:
      # int = integer, numeric
      # Factor = character-based, with different levels
  # problems:
      # Letter as integer --> should be factor (because: nominal)
      # Year as integer --> should be factor (because: ordinal, not interval/ratio-type data)

# Changing factor types

neg$Letter <- as.factor(neg$Letter) # to factor
neg$Year <- as.factor(neg$Year) # to factor
str(neg) # success

# Order & reorder

str(neg) # mind the order of the factor levels 
levels(neg$WordOrder)   # what if you prefer SOV - SVO - XVS - V1?
                        # important for plots, tables, etc. later

# install.packages("gdata") # only oonce
library(gdata) 
neg$WordOrder <- reorder(neg$WordOrder, new.order = c("SOV", "SVO", "XVS", "V1"))
levels(neg$WordOrder) # fixed


# Attach (cf. supra)
attach(neg)
    ## don't forget: 
    # detach(neg)
    ## also mind: if we reorder the factor levels now again, the already 'attached' factors will stay as they are!

Negation
WordOrder
summary(WordOrder) # cf. summary(neg)

#### 9.4 Descriptive statistics and tables ####

# Remember: dependent variable = categorical (two or more levels)

## simple functions

str(neg)

summary(WordOrder) # different type of output categorical / numeric variables
summary(WordCount)

min(WordCount, na.rm=TRUE) # na.rm=T - avoid errors with NA's (although there are no NA's in this factor here)
max(WordCount, na.rm=T)
mean(WordCount, na.rm=T)
median(WordCount, na.rm=T) 

    # -- difference median and mean?  -- #
    # -- see scatter plot (slides)    -- #

    hist(rnorm(200000, mean=78, sd=5)); norm <- rnorm(2000, mean=78, sd=20)
    hist(WordCount)
    
    # (see later: 'NUMERIC DV' - how to test for a normal distribution)    

# also useful (cf. later)
tapply(WordCount, Scribe, median) # apply function 'median' to factor 'WordCount', split up by factor 'Scribe'
tapply(WordCount, Scribe, sum) # apply function 'sum' to factor 'WordCount', split up by factor 'Scribe'
tapply(WordCount, Year, median) # apply function 'median' to factor 'WordCount', split up by factor 'Year'

## DV - dependent variable

# frequency table
table(Negation)  # table with absolute frequency counts

# totals?
addmargins(table(Negation), FUN=sum) # add extra row with built-in function (sum)
addmargins(table(Negation), FUN=mean) # add extra row with built-in function (mean)

# relative frequency
prop.table(table(Negation)) # table with relative frequency counts (weighed over 1)

# percentage?
prop.table(table(Negation))*100 # over 100 

# round
round(prop.table(table(Negation))*100, 2) # two decimals

# different way, same result:
negation_table <- table(Negation)
negation_prop <- prop.table(negation_table)*100
round(negation_prop, 2)

# save
write.table(round(negation_prop, 2), "output/relative_freqs.txt", sep="\t", quote=FALSE, row.names=F)

## DV + IV: dependent variable and one independent variable

# table with absolute freqs
table(Negation, WordOrder) # 2 dimensions

# row and column totals
addmargins(table(Negation, WordOrder))

# table with relative freqs 
prop.table(table(Negation, WordOrder), 2) # each column totals 100 (= read: relative distribution of DV for each level of IV)

# round?
round(prop.table(table(Negation, WordOrder), 2), 2)

# same, of course, for other variables
round(prop.table(table(Negation, PrecedingPhoneme), 2), 2) # PrecedingPhoneme
round(prop.table(table(Negation, Year), 2), 2) # Year
round(prop.table(table(Negation, Scribe), 2), 2) # Scribe


## DV + 2 IVs: dependent variable and two independent variables

# absolute freqs
ftable(PrecedingPhoneme, WordOrder, Negation) # absolute freqs: IV1 (PrecedingPhoneme), IV2 (WordOrder) and DV (last!)

# relative freqs
round(prop.table(ftable(PrecedingPhoneme, WordOrder, Negation), 1), 2) # check to see if word order effect holds true for each phonetic environment

# change order
round(prop.table(ftable(WordOrder, PrecedingPhoneme, Negation), 1), 2) # check to see if phonetical effect holds true for each syntactic environment

#### 9.5 Descriptive statistics - graphs ####

## barplots: DV - dependent variable

table(Negation) # numerically
barplot(table(Negation)) # visually: basic barplot - version 1

# make temporary object of barplot to remember its x-axis coordinates (used to e.g. add text)
aze <- barplot(table(Negation))
aze #  x-axis coordinates

# add text
text(aze, table(Negation)/2, table(Negation)) 
      # arguments: 
      # 1. x-coord. (= aze) 
      # 2. y-coord. (= table/2 = halfway to the top of each bar)
      # 3. what to plot (= the absolute freqs from table(Negation))

# y-axis too short
barplot(table(Negation))
aze <- barplot(table(Negation), ylim=c(0, 1000)) # set y-axis limit: "ylim=c(minimum, maximum)"

# add more text
text(aze, table(Negation), round(prop.table(table(Negation))*100, 2), pos=3)  # explain?
  # pos = position of text relative to the coordinates given
  # cf. ?text()
  # "Values of 1, 2, 3 and 4, respectively indicate positions below, to the left of, above and to the right"

# and a bit more advanced…

barplot(table(Negation), ylim=c(0, 1000)) 
  # starting from this

aze <- barplot(table(Negation), ylim=c(0, 1000), main="Negation", xlab="Negation variant", ylab="Absolute frequency")
  # main title (main="…")
  # x- en y-axis labels (xlab="…", ylab="…")

text(aze, table(Negation), table(Negation), pos=3) 
  # absolute frequencies on top of bars

abline(h=mean(table(Negation)), lty=2) 
  # horizontal (h) line
  # coordinate: at the mean frequency - mean(table(Negation))
  # line type (lty=…): dotted (lty=2)
  # cf. reference sheet

text(aze[2], mean(table(Negation)), "mean frequency", pos=3, cex=0.75) 
  # text explaining what line represents
  # coordinates: x = at second point of x-axis coordinates (aze[2]), y = same as abline, but pos=3 (above that point)
  # character size at 75% of normal size (cex=.75)


## barplots: DV + IV - dependent variable and one independent variable

# two-dimensional table of relative frequencies of DV, split up by IV WordOrder
barplot(prop.table(table(Negation, WordOrder), 2))
barplot(prop.table(table(Negation, WordOrder), 2)*100)

# even better, and easier:
plot(Negation ~ WordOrder, col=c("green", "darkgreen"))
  # width of the bar represents the absolute frequency!

# bars side by side
barplot(prop.table(table(Negation, WordOrder), 2), beside=TRUE, ylim=c(0,1))

# and a bit more advanced:

p.table <- prop.table(table(Negation, WordOrder), 2) # for clarity: save prop.table into element p.table
aze <- barplot(p.table, main="Negation variants and word order", xlab="Word Order", ylab="Relative frequency", col=c("darkgreen", "darkolivegreen3")) 
  # colors (col=…): see "_R reference color.pdf"
  # 

# add legend
legend("bottom", legend=c("Postverbale negatie", "Tweeledige negatie"), ncol=2, fill=c("darkgreen", "darkolivegreen3"), cex=0.75, inset=0.03)
  # where: either x and y coordinates, 
  #        or: "bottomright", "bottom", "bottomleft", "left", "topleft", "top", "topright", "right", "center"
  # what to write as a legend (legend=)
  # ncol: in one or in more columns 
  # fill: colors used to label legend
  # slightly smaller text (cex=0.75)
  # inset = just a bit above 'bottom'


## barplots: per Scribe/Letter 

barplot(prop.table(table(Negation, Letter), 2), cex.names=0.3, las=2, col=c("darkgreen", "darkolivegreen3")) 
  # smaller labels (cex.names=0.3)
  # rotated labels (las=2)

  # Click in plot window to zoom

# However, better if scribes could be ordered based on relative use of DV

# we start out from our normal prop.table
ptable <- prop.table(table(Negation, Letter),2); ptable

# second row thereof: relative use of second variant (= single negation)
ptable[2,] 

# ptable ordered on the basis of this relative use of single negation (descending)
ptable2 <- ptable[,order(ptable[2,])] 
ptable2 # reordered proptable

# plot this reordered proptable
barplot(ptable2, cex.names=0.3, las=2, col=c("darkgreen", "darkolivegreen3"))

# legend
legend("bottom", legend=c("Postverbal negation", "Bipartite negation "), ncol=2, fill=c("darkolivegreen4", "darkolivegreen1"), inset=0.02, cex=0.75, bg="white")


## Saving graphs 

# 1. Export > Save Plot as PDF (or: Copy plot to clipboard)

# 2. pdf()

pdf(file="output/plot.pdf", width=12, height=8) # open port for pdf file before plotting, and specify format

barplot(ptable2, cex.names=0.3, las=2, col=c("darkgreen", "darkolivegreen3")); legend("bottom", legend=c("Postverbal negation", "Bipartite negation "), ncol=2, fill=c("darkolivegreen4", "darkolivegreen1"), inset=0.02, cex=0.75, bg="white")

dev.off() # and close port to save

# see also: ?pdf()

detach(neg)

####--- | exercise: categorical DV  ---####

# Load the dataset called "spelling - data.txt". It show spelling 
# variation for the Dutch long A in closed syllables, usually
# spelled <aa> or <ae> -- although there may be more variants as
# well. Explore this dataset and add metadata linked to individual
# documents from the "Spelling - metadata.txt". Check if all factor
# types are what they should be, and make any changes necessary. 
# Next, produce a table with the % use of all the spelling variants
# split up, first per Year, and then per Town (= town type: central 
# cities v. smaller, peripheral towns). Produce two simple plots 
# with the relative use for both factors. Then also produce a 
# three-way table to check if any effects of Town type hold true 
# across both years (i.e.: do scribes from Central or Peripheral 
# towns prefer the same variants in 1823 as they do in 1829?). 
# Finally, make a table with the relative use (%) of just the 
# _two_ main spelling variants (<ae>, <aa>) per province. Add the 
# number of tokens per province on the plot, and save it.



##### 10. EXPLORATION OF CORPUS RESULTS: NUMERIC DV #####

# Loan suffix data - Dutch sailing letters corpus (only partial data set)
# Data with suffix rate per scribe (= numeric DV)
# Mostly focus on categorical IVs (as is often the case in HSL) 
# Some very limited information on numeric predictors at the very end

# Selection of the data published in: Rutten, G., R. Vosters & M. van der Wal (2015). “Frenchification in discourse and practice. Loan morphology in Dutch private letters of the eighteenth and nineteenth centuries”. In: C. Peersman, G. Rutten & R. Vosters (eds.), Contact and conflict along language borders. Romance-Germanic encounters in the Low Countries, Boston/Berlin: De Gruyter.

#### 10.1 Loading and preparing data ####

#                                         #
# inspect data in spreadsheet processor   #
#                                         #

# prep
rm(list=ls(all=TRUE))

# load as dataframe 
suf <- read.table("loan suffixes - data.txt", fileEncoding="UTF-16", sep="\t", header=TRUE)

# explore dataframe
head(suf) 
tail(suf) 
str(suf)
  # No problems with factors being read in as integers

summary(suf)
  # notice: order of Age
  # notice: order of Class
  # other factors (= linguistic, coded into the spreadsheet)
levels(suf$Age)
levels(suf$Class)

library(gdata) 
suf$Age = reorder(suf$Age, new.order = c ("Young (0-30)", "Middle (30-50)", "Older (50+)"))
levels(suf$Age) # fixed

suf$Class = reorder(suf$Class, new.order = c ("LC", "LMC", "UMC", "UC"))
levels(suf$Class)

## Generating relative frequencies

# We can see the absolute number of French loan suffixes per scribe in the factor Suffixes (= raw frequencies)
head(suf)
  # However, we also want to know their normalized rates, taking the number of words per scribe into account
  # We normalize by dividing the raw frequencies by the number of words per scribe, 
  # Next, we multiply that by 100.000 (for clarity) to get the Normalized Suffix Frequency (per 100.000 words)
  
# we create a new factor within the suf-dataframe for this
# and we'll call it 'dv' (dependent variable), to make things easy
suf$dv <- ( suf$Suffixes / suf$WordCount ) * 100000
head(suf)

# or better even, rounded:
suf$dv <- round( ( suf$Suffixes / suf$WordCount ) * 100000 , 0)
head(suf)

# Now, we can attach the data:
attach(suf) 
# detach(suf)

#### 10.2 Descriptive statistics and tables ####

### DV: dependent variable

min(dv)
max(dv)
mean(dv)
median(dv)

summary(dv) 

library(psych) 
describe(dv)

## normal distribution? 

# histogram
h = hist(dv, xlab="Normalized suffix frequency", main="Histogram with normal curve")
  # to add a normal curve:
  xfit = seq(min(dv),max(dv),length=40) 
  yfit = dnorm(xfit, mean = mean(dv) , sd=sd(dv)) 
  yfit = yfit * diff(h$mids[1:2]) * length(dv) 
  lines(xfit, yfit, col="blue", lwd=2)

# QQ plot
qqnorm(dv, main="Normal Q-Q Plot")
qqline(dv, col=2)
grid() 

# Shapiro-Wilk Test
shapiro.test(dv)  # p > .05  means normally distributed data
                  # i.e. one of the few times you want to hope for a large p-value

# However, in this case: data obviously not normally distributed


### DV + IV: dependent variable and one independent variable

# Using tapply()

tapply(dv, Class, median) 
  # applies a function (here: 'median') to a DV (here: 'dv') 
  # split up by the levels of an IV (here: 'Class')

# other IVs as well:
tapply(dv, Gender, median) 
tapply(dv, Age, median)

# other functions as well:
tapply(dv, Class, summary) # functie 'summary' toegepast op DV 'dv', opgesplitst o.b.v. IV 'provincie'


## Measures of central tendency and measures of dispersion

# normal data
tapply(dv, Class, mean) 
tapply(dv, Class, sd) # standard deviation, measures amount dispersion from the mean
    # low sd: all values close to mean
    # high sd: many values far from mean (~ "You can drown in a river that has a mean depth of 3 cm")

# non-normal data
tapply(dv, Class, median) 
tapply(dv, Class, IQR) # interquartile range: spread between 25% and 75% quantile (cf. box of boxplot= the middle 50)
    # larger IQR, more heterogenous data (measure of central tendency less useful)
    # cf. 
      boxplot(dv ~ Class) 


### DV + 2 IVs: dependent variable and two (or more) independent variables

# also using tapply, but with a list-function embedded for the IVs)

# DV split up by Class and by Gender
tapply(dv, list(Class, Gender), median)

# also works or three independent variables
tapply(dv, list(Class, Gender, Age), median)

#### 10.3 Descriptive statistics - graphs ####

### DV - dependent variable

# See histogram (supra)

### DV + IV - dependent variable and one independent variable

# Various ways to represent data - let's explore three

# 1 # Barplot of means/medians

aze <- barplot(tapply(dv, Class, median), ylim=c(0, max(tapply(dv, Class, median))*1.15), main="Median loan suffix rate per social class", ylab="Normalized loan suffix rate", col=c("deepskyblue2")); text(aze, tapply(dv, Class, median), round(tapply(dv, Class, median), 0), cex=0.8, pos=3, font=3)
    # you can plug the tapply function straight into the barplot
    # automate the limits of ylim: min = 0, max = 1.15 times the highest score of the data (tapply)
    # then plot the same scores from tapply on the barplot 
    # (at x = coordinates from aze, 
    # and y = the height of the scores from tapply, i.e. just above the bars)
    # font = 3 (italics)

# Or, more easily customizable (with separate, predefined elements)
iv <- 
title <- c(" ")
ylab <- c(" ")
aze <- barplot(tapply(dv, iv, median), ylim=c(0, max(tapply(dv, iv, median))*1.15), main=title, ylab=ylab, col=c("deepskyblue2")); text(aze, tapply(dv, iv, median), round(tapply(dv, iv, median), 2), cex=0.8, pos=3, font=3)

# For instance: Class
iv <- Class
title <- c("Median loan suffix rate per social class")
ylab <- c("Normalized loan suffix rate")
aze <- barplot(tapply(dv, iv, median), ylim=c(0, max(tapply(dv, iv, median))*1.15), main=title, ylab=ylab, col=c("deepskyblue2")); text(aze, tapply(dv, iv, median), round(tapply(dv, iv, median), 2), cex=0.8, pos=3, font=3)

# However:
# One of the main problems with this (very common) way of visualizing your data
# is that it has a very low 'information to ink ratio': it conveys very little
# information (just the median scores) in a lot of space. Here, a simple table
# would probably be just as informative:
  tapply(dv, Class, median)
# Let's therefore have a look at stripcharts, 
# where every data point (here: every scribe) is represented 
# by one point in the plot (= less reduction of data)


# 2 # Stripcharts 

# define some elements beforehand
iv <- Class
title <- c("Loan suffix rates per social class")
ylab <- c("Normalized loan suffix rate")

stripchart(dv ~ iv, method="jitter", vertical=T, main=title, ylab=ylab, pch=1, col="darkgrey");
  # the formula for a stripchart (as for many other types of plots) can be as
      # shown: "dv ~ iv", meaning that we want to plot the variable 'dv' split up
      # over the different levels of 'iv'
  # method = jitter helps us visualize overlapping data better: instead of
      # plotting all the data point of e.g. the LMC with a suffix rate of 500 on top
      # of each other, they are 'jittered' slightly, meaning that some are plotted a
      # bit to the right, some a bit more to the left.
      # cp. to method = overplot
  # vertical=T - cf. to vertical=F
  # 'pch' is the character used to represent each data point - see table or ?pch() 

# we can always add a grid to a plot 
grid()

# we can plot the median score over the stripchart
points(1:length(levels(iv)), tapply(dv, iv, median), type="b", pch=16, lty=3, lwd=2, col="red")

# and a legend
legend("topleft", "median", cex=0.75, col="red", lty=3, lwd=1.5, pch=16, inset=0.02)

# end result
stripchart(dv ~ iv, method="jitter", vertical=T, main=title, ylab=ylab, pch=1, col="darkgrey"); grid(); points(1:length(levels(iv)), tapply(dv, iv, median), type="b", pch=16, lty=3, lwd=2, col="red"); legend("topleft", "median", cex=0.75, col="red", lty=3, lwd=1.5, pch=16, inset=0.02)
  # Note how this chart, in the same space as the previous one, tells us much
  # more. The median scores per social class are there, but we also get a detailed
  # insight into the spread of the data, with each individual data point
  # represented.

# A slightly more fancy version, where the opacity of the color goes up when points overlap

# define color
color <- rgb(0, 0.5, 0, 0.25)
  # rgb function, consisting of: 
  # value for intensity (between 0 and 1) of red, green, blue +  transparency value

# plot
stripchart(dv ~ iv, method="jitter", vertical=T, main=title, ylab=ylab, pch=19, col=color); grid(); points(1:length(levels(iv)), tapply(dv, iv, median), type="b", pch=16, lty=3, lwd=2, col="red"); legend("topleft", "median", cex=0.75, col="red", lty=3, lwd=1.5, pch=16, inset=0.02)


# 3 # boxplot

# Boxplots find a common ground between the two previous ways of visualizing our data. They show more than just plotting means or medians, but they do not show each individual data point.  
    ##! see slides - boxplot !##

iv <- Class
title <- c("Loan suffix rates per social class")
ylab <- c("Normalized loan suffix rate")

boxplot(dv ~ iv, main=title, ylab=ylab, notch=F, col="deepskyblue2")
  # same formula as before
  # notch=F (default); 
    # If notch is TRUE, a notch is drawn in each side of the boxes. 
    # If the notches of two plots do not overlap this is ‘strong evidence’ 
    # that the two medians differ [significantly] (Chambers et al, 1983, p. 62). 

minor.tick(nx=0, ny=5)

# you can also add the means if you want
text(1:length(levels(iv)), tapply(dv, iv, mean, na.rm=T), "+")
  # plot a '+' on the x-axis from 1 to as many levels there are in the IV, 
  # and at the y axis at the height the means (tapply)
mtext("'+' indicates the mean", side=4, font=1, cex=0.7)
  # add text in margin (mtext), at side 4 (1=below, 2=left, 3=above, 4=right)

# take note: different between means and medians

### DV+ 2 IVs: one dependent variable and two independent variables

# With two IVs, barplots are more useful: e.g.
barplot(tapply(dv, list(Class, Gender), median), ylim=c(0,1200), main="Loan suffix rate per class and per gender", ylab="Normalized loan suffix rate", beside=T, col=c("darkolivegreen", "darkolivegreen4", "darkolivegreen3", "darkolivegreen1"))
legend("top", levels(Class), ncol=4, cex=0.7, fill=c("darkolivegreen", "darkolivegreen4", "darkolivegreen3", "darkolivegreen1") )
  # note how it is useful sometimes to define the ylim of the plot a bit larger, to make the legend fit

### DV+ numeric IV: one dependent variable and one numeric independent variables

# DV = Suffixes (Loan suffix rate in absolute numbers)
# IV = WordCount
    # i.e. the rather trivial hypothesis that the WordCount per scribe 
    # helps us predict how many loan suffixes we find in their writing

# plot
plot(Suffixes ~ WordCount, main="The correlation between loan suffixes and word count")

# linear regression line
abline(  lm( Suffixes ~ WordCount )   , col = "red")
    # actually a linear regression model:
    # the higher the word count, the more suffixes

cor(Suffixes, WordCount, method="pearson")
  # a strong positive correlation 

detach(suf)

####--- | exercise: numeric DV ---####

# Load the "PresPart - data.txt" dataset, which will give you (partial) 
# data about Present Participle usage in a corpus of Dutch legal texts. 
# Explore the dataframe and calculate a normalized rate of PresPart 
# usage per 1000 words, using the raw frequency counts and the word 
# counts per document available. Next, check (both visually and with
# a numerical test) if these normalized PresPart rates follow a normal 
# distribution. Then produce a boxplot of normalized PresPart usage per
# scribe (professional v. non-professional scribes), and a stripchart 
# of normalized PresPart use per text type, with the mean of median 
# scores per text type plotted on top. Save both of these plots in 
# the 'output' directory.

