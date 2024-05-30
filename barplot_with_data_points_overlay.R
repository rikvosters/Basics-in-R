tt <- read.csv(file = "https://raw.githubusercontent.com/rikvosters/Basics-in-R/master/Titanic_training.csv", na.strings = "")
tt <- as_tibble(tt)
tt %>% 
  sample_n(20) ->  tt_small
tt_small %>% 
   group_by(Sex) %>% 
  summarise(mean = mean(Fare)) -> toplot1
  
ggplot() + 
  geom_bar(data = toplot1, aes(x = Sex, y = mean), stat="identity") +
  geom_point(data = tt_small, aes(x = Sex, y = Fare),
             alpha = 0.2, col = "blue",
             position = "jitter")
             position = position_dodge(width=1))
        

