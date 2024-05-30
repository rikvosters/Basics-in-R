####--- | solution: influenza ---####

# load 'DeathRatesforMajorCauses_wide.csv'
dth <- read.csv("https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/DeathRatesforMajorCauses_wide.csv", check.names = F)
head(dth)

# wide to long
dth %>% 
  pivot_longer(cols = `1900`:`2013`, names_to = "Year", values_to = "AgeAdjustedDeathRate") -> dth

# make year numeric
dth$Year <- as.numeric(dth$Year)
dth

# filter out and plot Age Adjusted Death Rate for Influenza and Pneumonia
dth %>% 
  filter(LeadingCauses == "Influenza and Pneumonia") %>% 
  ggplot(aes(x = Year, y = AgeAdjustedDeathRate)) + 
  geom_line()


# filter out and plot Age Adjusted Death Rate for Influenza and Pneumonia
dth %>% 
  filter(LeadingCauses == "Influenza and Pneumonia") %>% 
  ggplot(aes(x = Year, y = AgeAdjustedDeathRate)) + 
  geom_line()

# barplot with mean death rate per major cause
dth %>% 
  group_by(LeadingCauses) %>% 
  summarize(AgeAdjustedDeathRate = mean(AgeAdjustedDeathRate)) %>% 
  ggplot(aes(x = LeadingCauses, y = AgeAdjustedDeathRate)) +
  geom_bar(stat="identity") +
  labs(title = "Age Adjusted Death Rates across Major Causes", x = "Cause of death", y = "Age Adjusted Death Rate (mean)") +
  theme_bw()

# plot comparing both the death rates per year for different causes

dth %>% 
  group_by(LeadingCauses) %>% 
  ggplot(aes(x = Year, y = AgeAdjustedDeathRate, col = LeadingCauses)) + 
  geom_line()
ggsave("death.pdf", device = "pdf", width = 12, height = 6)


####--- | solution: flights ---####

# load and make into tibble
library(hflights)
df <- hflights
df <- as_tibble(df)
df

# select variables Year, DayOfWeek, DepTime, UniqueCarrier, AirTime, ArrDelay, Dest, Distance, Cancelled, CancellationCode
df %>% 
  select(Year, DayOfWeek, DepTime, UniqueCarrier, AirTime, ArrDelay, Dest, Distance, Cancelled, CancellationCode) -> df

# % cancelled - base
round(prop.table(table(df$Cancelled)),3)*100
barplot(round(prop.table(table(df$Cancelled)),3)*100)

# % cancelled - tidyverse
df %>% 
  group_by(Cancelled) %>% 
  summarise(n_cancelled = n()) %>% 
  mutate(perc_cancelled = n_cancelled/sum(n_cancelled)) %>% 
  ggplot(aes(x = as.factor(Cancelled), y = n_cancelled)) +
  geom_bar(stat="identity") 

# recode CancellationCode ("carrier" = "A", "weather" = "B", "FFA" = "C", "security" = "D") + major cause of cancellations?
df$CancellationCode <- fct_recode(df$CancellationCode, "carrier" = "A", "weather" = "B", "FFA" = "C", "security" = "D", NULL = "")
table(df$CancellationCode)

df$CancellationCode
# plot distance and arrival delay for short-haul flights (< 500 miles)
df %>%
  filter(Distance < 500) %>% 
  ggplot(aes(x = Distance, y = ArrDelay)) +
  geom_point() +
  geom_smooth(method = "lm")

# total airtime per weekday per carrier (AA v EV)
df %>% 
  filter(UniqueCarrier %in% c("AA", "EV")) %>% 
  group_by(DayOfWeek, UniqueCarrier) %>% 
  summarise(Total_Airtime = sum(AirTime, na.rm = T)) -> airtime_days
airtime_days
airtime_days %>%
  ggplot(aes(x = DayOfWeek, y = Total_Airtime)) +
  geom_bar(stat="identity") +        # also possible: geom_line
  facet_wrap(~ UniqueCarrier)

# boxplot/violin plot arrival delay for AA (American Airlines), DL (Delta) and US (US Airways) 
df %>% 
  filter(UniqueCarrier %in% c("AA", "DL", "US")) %>%
  ggplot(aes(x = UniqueCarrier, y = ArrDelay)) +
  geom_boxplot() 
df %>% 
  filter(UniqueCarrier %in% c("AA", "DL", "US")) %>%
  ggplot(aes(x = UniqueCarrier, y = ArrDelay)) +
  geom_violin()

####--- | solution: student numbers ---####

# load
rm(list=ls(all=TRUE))
df <- read.csv("https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/students.csv", sep = ";")
df <- tibble(df)

# 1. flipped boxplot of student numbers per program
df %>% 
  ggplot(aes(x = Program, y = Students)) +
  geom_boxplot(fill="lightblue") +
  coord_flip()

# 2. histograms of student numbers per university (facets)
df %>% 
  ggplot(aes(x = Students)) +
  geom_histogram() +
  facet_wrap(~ University)

# 3. smoother growth in student numbers per university per year
df %>% 
  group_by(University, Year) %>% 
  summarise(N = sum(Students)) %>% 
  ggplot(aes(x = Year, y = N, col = University)) +
  geom_smooth(se = F) +
  scale_x_continuous(breaks=2010:2019, labels=2010:2019)

# 4. table and plot of gender division per program for all universities except for Hasselt
df %>% 
  filter(University != "Universiteit Hasselt") %>% 
  group_by(Program, Sex) %>% 
  summarise(Students = mean(Students, na.rm=T)) -> table; table
table %>% 
  ggplot(aes(x = Program, y = Students, fill = Sex)) +
  geom_bar(stat="identity", position = "dodge") 

# 5. proportion of small, medium and large student group programs per university
df$Students_rcd <- cut(df$Students, breaks = c(0,30,100,10000), labels = c("small", "medium", "large"))
df %>% 
  group_by(University, Students_rcd) %>% 
  summarize(N = n()) %>% 
  ggplot(aes(x = University, y = N, fill = Students_rcd)) +
  geom_bar(stat="identity", position = "fill") 

