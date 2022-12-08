####--- | solution: metal fan base ---#####

# load 'metal_data'
metal_data <- read_excel("metal_data.xlsx")
metal_data

metal_meta <- read_excel("metal_meta.xlsx")
metal_meta

metal <- merge(metal_data, metal_meta, by = "ID")
metal

# correlation year formed and number of fans
metal %>% 
  ggplot(aes(x = formed, y = fans)) +
  geom_point() +
  geom_smooth(method = "lm")

shapiro.test(metal$fans); shapiro.test(metal$formed) # both not normal

cor(metal$fans, metal$formed, use = "complete.obs", method = "spearman")
cor.test(metal$fans, metal$formed, method = "spearman")

# lump countries of origin together into 2 most frequent countries + 'other'
metal$origin <- fct_lump_n(metal$origin, n = 2)
metal$origin

# check differences in fan base between two most common countries
metal %>% 
  filter(!is.na(origin)) %>% 
  group_by(origin) %>% 
  summarise(mean_fans = mean(fans),
            median_fans = median(fans),
            sd_fans = sd(fans),
            IQR_fans = IQR(fans)) -> metal_means
metal_means %>% 
  ggplot(aes(x = origin, y = mean_fans)) +
  geom_bar(stat="identity", fill="gold") +
  labs(title = "Metal fan base per country of band origin", x = "", y = "Fan base") 

hist(metal$fans) # no normal distribution
tapply(metal$fans, metal$origin, shapiro.test) # no normal distribution

tapply(metal$fans, metal$origin, mean) # different means
tapply(metal$fans, metal$origin, median) # different medians
wilcox.test(metal$fans[metal$origin=="USA"|metal$origin=="Sweden"] ~ metal$origin[metal$origin=="USA"|metal$origin=="Sweden"]) # Wilcoxon rank sum test (U-test) instead of t-test


####--- | solution: female chess players ---#####

# load from csv and convert to tibble
ch <- read.csv("https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/women_chess.csv")
ch <- as_tibble(ch)
ch

# remove variables 'Inactive_flag' and 'Gender'
ch %>% 
  select(-Inactive_flag, -Gender) -> ch
ch

# make variable 'Age' and split into 3 groups (young = under 30, middle = 30-60, older = 60+)
ch %>% 
  mutate(Age = 2020 - Year_of_birth) -> ch
ch$Age <- cut(ch$Age, breaks = c(0, 30, 60, 101), labels = c("young", "middle", "older"))

# automatically split variable 'Standard_Rating' into 3 groups ("low", "medium", "high")
ch$Rating_ordinal <- cut(ch$Standard_Rating, breaks = 3, labels = c("low", "medium", "high"))

# check out association between ordinal Rating and ordinal Age, numerically
round(prop.table(table(ch$Rating_ordinal, ch$Age),2),2)*100

# check out association between ordinal Rating and ordinal Age, graphically
library(vcd)
assoc(table(ch$Rating_ordinal, ch$Age), shade=TRUE, legend = T) # blue = more observations than expected under null hypothesis

# check out association between ordinal Rating and ordinal Age, statistically
test <- chisq.test(table(ch$Rating_ordinal, ch$Age))
test
test$residuals # notice large deviations
test$expected # test assumptions: enough data points in all expected cells
library(DescTools)
CramerV(table(ch$Rating_ordinal, ch$Age)) # Cramer's V to show strength of association (= effect size); from 0 to 1 (= perfect association)

# convert to long
ch %>% 
  pivot_longer(cols = `Standard_Rating`:`Blitz_rating`, names_to = "Type", values_to = "Rating") -> ch_long
ch_long

# plot year of birth and rating (but only for the Blitz_rating type), for Russian (RUS), Polish (POL) and Chinese (CHN) players in different colors, and add a LOESS smoother (method = "loess") for each group
ch_long %>% 
  filter(Federation %in% c("RUS", "POL", "CHN")) %>% 
  filter(Type == "Blitz_rating") %>% 
  group_by(Federation) %>% 
  ggplot(aes(x = Year_of_birth, y = Rating, col = Federation)) +
  geom_point() +
  geom_smooth(method = "loess")

