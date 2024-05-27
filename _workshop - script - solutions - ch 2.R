####--- | solution: hours of sleep (bis) ---####

rm(list=ls(all=TRUE))

sleep <- c(7.0, 6.5, 6.0, 8.5, 6.5, 6.0, 5.5)
mean(sleep)
round(mean(sleep),2)

av <- mean(sleep)
round(av,2)

length(sleep[sleep < 7])

(length(sleep[sleep >= 8])/7)*100

week <- round(mean(sleep[1:5]),2)
week
weekend <- round(mean(sleep[6:7]),2)
weekend
diff <- week - weekend; diff


####--- | solution: Belgian Dutch words ---####

# load 
belgicisms <- c("Afgevaardigd Beheerder", "Ajuin", "Alcoholieker", "Alleszins", "Ardeens", "Autostrade", "Autotaks", "Allergisch Aan", "Aftrekker", "Afkuisen", "Baxter", "Bedanking", "Bedelen", "Beenhouwer", "Begankenis", "Bekwaam Om", "Benadeligen", "Bereide Schotel", "Beschaamd", "Beteugelen", "Betoelagen", "Betonneren", "Betrachten", "Betrachting", "Betrouwen", "Bic", "Bijhuis", "Binnendoen", "Binnenkoer", "Baxter", "Botermelk", "Boerenbuiten", "Brol", "Brossen", "Buitensmijten", "Bureel")

# convert to lower
belgicisms <- tolower(belgicisms)

# table for double entries
sort(table(belgicisms)) # baxter = 2x

# remove double entries
belgicisms <- unique(belgicisms)

# check if three words appear in list
words_to_check <- c("beschaamd", "bisser", "boterkoek")
words_to_check[words_to_check %in% belgicisms] # cf.: words_to_check %in% belgicisms
