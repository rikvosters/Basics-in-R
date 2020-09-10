####--- | solution: influenza ---####

library(tidyverse)

# load 'DeathRatesforMajorCauses_wide.csv'
dth <- read.csv("https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/DeathRatesforMajorCauses_wide.csv", check.names = F)
dth

# wide to long
dth %>% 
  pivot_longer(cols = `1900`:`2013`, names_to = "Year", values_to = "AgeAdjustedDeathRate") -> dth

# make year numeric
dth$Year <- as.numeric(dth$Year)
dth

# filter out and plot Age Adjusted Death Rate for Influenza and Pneumonia
dth %>% 
  filter(LeadingCauses == "Influenza and Pneumonia") %>% 
  ggplot(aes(x = Year, y = AgeAdjustedDeathRate)) + geom_line()


# filter out and plot Age Adjusted Death Rate for Influenza and Pneumonia
dth %>% 
  filter(LeadingCauses == "Influenza and Pneumonia") %>% 
  ggplot(aes(x = Year, y = AgeAdjustedDeathRate)) + 
  geom_line()


# plot comparing both the death rates per year for 'Influenza and Pneumonia' and for 'Cancer'.

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
df$CancellationCode <- fct_recode(df$CancellationCode, "carrier" = "A", "weather" = "B", "FFA" = "C", "security" = "D")
table(df$CancellationCode)

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

