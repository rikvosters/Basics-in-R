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
prop.table(table(dog$SIZE))*100

# comparison women v men
table(dog$SIZE[dog$OWNER_SEX=="w"])
3037/(3037+1611)*100
table(dog$SIZE[dog$OWNER_SEX=="m"])
1168/(1168+990)*100 # men are less likely to have small dogs than women
# alternative:
prop.table(table(dog$SIZE[dog$OWNER_SEX=="w"]))
prop.table(table(dog$SIZE[dog$OWNER_SEX=="m"]))

dog %>% 
  filter(OWNER_SEX == "w") %>% 
  select(SIZE) %>% 
  table()

dog %>%
  filter(OWNER_SEX == "m") %>% 
  select(SIZE) %>% 
  table()

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


####--- | solution: multiplication tables ---#####

for (i in 1:50) {  # set counter i
  x <- 7 * i       # define x als result of 7 x i
  print(x)         # show result on screen
}

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


####--- | solution: presidential frequency tables ---####

data.files <- list.files(pattern="freqtabel"); data.files
data <- data.frame()
for (i in 1:length(data.files)) {
  current.file <- read.csv(data.files[i])
  data <- rbind(data, current.file)
}
data

# filter out frequencies of 'America'
data %>% 
  filter(Token == "america")


####--- | solution: metal ---####

# load 'metal_data'
metal_data <- read_excel("metal_data.xlsx")
metal_data

# load 'metal_meta'
metal_meta <- read_excel("metal_meta.xlsx")
metal_meta

# merge
metal <- merge(metal_data, metal_meta, by = "ID")
head(metal)

# name of the oldest Iranian metal band still together
metal %>% 
  filter(origin == "Iran") %>% 
  filter(is.na(split)) %>% 
  arrange(formed) %>% 
  head(1)

# Mexican death metal bands
metal %>% 
  filter(origin == "Mexico") %>% 
  filter(str_detect(style, "death"))

# Mexican death metal fan base
metal %>% 
  filter(origin == "Mexico") %>% 
  filter(str_detect(style, "death")) %>% 
  select(fans) %>% 
  sum()


####--- | solution: influenza ---####

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