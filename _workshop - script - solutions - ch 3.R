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