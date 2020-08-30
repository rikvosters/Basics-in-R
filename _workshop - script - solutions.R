 # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
###                                                           ###
###    Workshop: Introduction to corpus linguistics with R    ###
###                DSh - VUB - June 2018                      ### 
###          Rik Vosters - Vrije Universiteit Brussel         ###
###         Rik.Vosters@vub.ac.be | www.rikvosters.be         ###
###                                                           ###
 # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
###                                                           ###
###               SOLUTIONS EXERCISES                         ###
###                                                           ###
 # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

####--- EXERCISE: create new file ---####



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
x <- c(1530, 1540, 1550, 1560, 1570, 1580, 1590, 1600)
x
y <- c(4, 9, 17, 48, 78, 92, 96, 98)
y
plot(x, y)



####--- EXERCISE: hours of sleep ---####

rm(list=ls(all=TRUE))

slaap <- c(7.0, 6.5, 6.0, 8.5, 6.5, 6.0, 5.5)
mean(slaap)
round(mean(slaap),2)

av <- mean(slaap)
round(av,2)

length(slaap[slaap < 7])

(length(slaap[slaap >= 8])/7)*100

week <- round(mean(slaap[1:5]),2); week
weekend <- round(mean(slaap[6:7]),2); weekend
verschil <- week - weekend; verschil

####--- EXERCISE: Belgian Dutch words ---####

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

####--- EXERCISE: present participles ---####

### Make separate vectors out of the following data:
# Scribes: "Leplae_PJ", "Druwe_F", "De_Brunne_C", "De_Vos_H", "Van_De_Wiele_J", "Landerij_EA", "Plancquel_PJ", "Wijsuer_J", "Malfait_F", "Tuittens_P", "Soenen_E", "Vandenberche_F", "Calleevaart_JF", "Marke_J", "Bruu_P", "Pinson_F", "Gevaert_L", "Van_Den_Briele_J", "De_Jonge_J", "Vermuilen_C", "Landuit_J", "Barts_A", "Van_Coilje_L", "De_Seijne_J", "Bonte_BC", "Spotbeen_P", "Dobbels_J", "Taveiren_J", "Mortier_F", "Malfait_J", "Narauw_J", "Crombeecke_J", "Coucke_PJ", "Vanderstraete_I"
# Raw frequencies of Present Participle use:   1, 10, 0, 2, 1, 0, 0, 2, 2, 2, 0, 0, 1, 2, 4, 1, 3, 4, 5, 3, 4, 5, 3, 6, 4, 5, 5, 3, 4, 3, 3, 2, 3, 3 
# Word counts per scribe
# 254, 1245, 217, 1089, 670, 406, 619, 334, 217, 523, 684, 192, 290, 284, 718, 329, 321, 1441, 294, 277, 153, 678, 230, 368, 446, 604, 605, 532, 278, 374, 487, 396, 870, 263
# Normalized frequencies of Present Participle use (per 1000 words):
#   3.94, 8.03, 0, 1.84, 1.49, 0, 0, 5.99, 9.22, 3.82, 0, 0, 3.45, 7.04, 5.57, 3.04, 9.35, 2.78, 17.01, 10.83, 26.14, 7.37, 13.04, 16.3, 8.97, 8.28, 8.26, 5.64, 14.39, 8.02, 6.16, 5.05, 3.45, 11.41
# Year of writing: 1706, 1738, 1823, 1777, 1687, 1777, 1837, 1753, 1777, 1706, 1767, 1823, 1829, 1709, 1823, 1785, 1823, 1701, 1767, 1706, 1823, 1823, 1709, 1823, 1823, 1829, 1706, 1709, 1709, 1777, 1688, 1777, 1769, 1777

scribes <- c("Leplae_PJ", "Druwe_F", "De_Brunne_C", "De_Vos_H", "Van_De_Wiele_J", "Landerij_EA", "Plancquel_PJ", "Wijsuer_J", "Malfait_F", "Tuittens_P", "Soenen_E", "Vandenberche_F", "Calleevaart_JF", "Marke_J", "Bruu_P", "Pinson_F", "Gevaert_L", "Van_Den_Briele_J", "De_Jonge_J", "Vermuilen_C", "Landuit_J", "Barts_A", "Van_Coilje_L", "De_Seijne_J", "Bonte_BC", "Spotbeen_P", "Dobbels_J", "Taveiren_J", "Mortier_F", "Malfait_J", "Narauw_J", "Crombeecke_J", "Coucke_PJ", "Vanderstraete_I")
freq_raw <- c(1, 10, 0, 2, 1, 0, 0, 2, 2, 2, 0, 0, 1, 2, 4, 1, 3, 4, 5, 3, 4, 5, 3, 6, 4, 5, 5, 3, 4, 3, 3, 2, 3, 3)
woco <- c(254, 1245, 217, 1089, 670, 406, 619, 334, 217, 523, 684, 192, 290, 284, 718, 329, 321, 1441, 294, 277, 153, 678, 230, 368, 446, 604, 605, 532, 278, 374, 487, 396, 870, 263)
freq_norm <- c(3.94, 8.03, 0, 1.84, 1.49, 0, 0, 5.99, 9.22, 3.82, 0, 0, 3.45, 7.04, 5.57, 3.04, 9.35, 2.78, 17.01, 10.83, 26.14, 7.37, 13.04, 16.3, 8.97, 8.28, 8.26, 5.64, 14.39, 8.02, 6.16, 5.05, 3.45, 11.41)
year <- c(1706, 1738, 1823, 1777, 1687, 1777, 1837, 1753, 1777, 1706, 1767, 1823, 1829, 1709, 1823, 1785, 1823, 1701, 1767, 1706, 1823, 1823, 1709, 1823, 1823, 1829, 1706, 1709, 1709, 1777, 1688, 1777, 1769, 1777)


### Check to make sure that there are no scribes who are listed more than once, and convert all of their names to upper case. Also, do a quick check to see if all of the dates fall between 1650 and 1850.
table(scribes)
scribes <- unique(scribes)
scribes <- toupper(scribes); scribes
min(year); max(year)

### Imagine that a problem in the compilation of the corpus has caused the samples written in the 1760s to be unreliably dated. Check to see if the vector with the years of writing includes any documents written during these years, and if so, replace those years of writing by the median year of writing of all of the other documents.

table(year) # two documents written in 1767 and one in 1769

# method one: 
median(year[year < 1760 | year >= 1770])
year[year >= 1760 & year < 1770] <- 1770

# method two:
year[year >= 1760 & year < 1770]  <- median(year[year < 1760 | year >= 1770])

table(year)

### Combine these vectors into one dataframe and give each column an appropriate factor name.
PresPart <- data.frame(scribes, freq_raw, woco, freq_norm, year)
names(PresPart) <- c("Scribe", "FreqRaw", "WordCount", "FreqNorm", "Year")
PresPart

### Draw a histogram -- hist() -- of the normalized frequencies of Present Participle use per scribe, but only include the data of scribes for which we have at least 250 words in our sample.

# Histogram of _all_ scribes:
hist(PresPart$FreqNorm) 
sort(PresPart$FreqNorm)

# Histogram of scribes whose WordCount >= 250:

newdf <- PresPart[PresPart$WordCount>=250,]
hist(newdf$FreqNorm) 

# or:
hist(PresPart$FreqNorm[PresPart$WordCount>=250]) 
sort(PresPart$FreqNorm[PresPart$WordCount>=250])

### Upon closer inspection of the corpus as a whole, the data from some scribes also seem to be unreliable: VERMUILEN_C, VAN_COILJE_L, MALFAIT_F, JOSSENS_F, HOUTEKEER_N, MALFAIT_J, WILLEMS_J. You are not sure, however, if these scribes contributed any tokens to the current data set on PresPart use. Make a stoplist of these unreliable scribes' names (so you can add more later if need be), and check the data you have against that stoplist. If any of the scribes did contribute data to the present dataframe, create a new dataframe with the entries from those scribes excluded.

badscribes <- c("VERMUILEN_C", "VAN_COILJE_L", "MALFAIT_F", "JOSSENS_F", "HOUTEKEER_N", "MALFAIT_J", "WILLEMS_J")
PresPart_ss <- PresPart[!PresPart$Scribe %in% badscribes,]
# alternative: 
# PresPart_ss <- subset(PresPart, !Scribe %in% badscribes)

# Tip: use the function str() to inspect and compare both dataframes (idem in the 'Environment' window!)
str(PresPart)
str(PresPart_ss) # you can see that 4 observations were excluded in the subset

####--- EXERCISE: acronyms  ---####

## Make a new function acronym_maker that takes the first letter of each word in its input, and put those together into an upper-case acronym (e.g. North Atlantic Treaty Organization -> NATO). Test it on a string like 'personal identification number'.

input <- 'personal identification number'

input <- unlist(strsplit(input, " "))
input <- substr(input, 1, 1)
input <- paste(input, collapse="")
input <- toupper(input)
input

acronym_maker <- function(input) {
  input <- unlist(strsplit(input, " "))
  input <- substr(input, 1, 1)
  input <- paste(input, collapse="")
  input <- toupper(input)
  input
}

acronym_maker("personal identification number")
acronym_maker("Journal of Historical Sociolinguistics")

####--- EXERCISE: soldiers corpus ---####

## After clearing the working memory, load the "Soldiers - 262 1810 ONBEKEND.txt" and the "Soldiers - 277 1811 KANEGEM.txt" documents from the Napoleonic Soldiers Corpus, and collapse them together into one corpus file vector. Then remove all punctuation from the file and make everything upper case. Next, produce an alphabetical word frequency list based on this corpus, and save it as a text file. You can use the punctuation.remover, but none of the other custom-made functions (charlist, freqlist).

# clear memory
rm(list=ls(all=TRUE))

# set working directory

# load both files
soldier1 <- scan(file="Soldiers - 262 1810 ONBEKEND.txt", what=character(0), sep="\n")
soldier2 <- scan(file="Soldiers - 277 1811 KANEGEM.txt", what=character(0), sep="\n")

# collapse them together into one corpus file
corpus.file <- paste(soldier1, soldier2, collapse=" "); corpus.file

# load punctuation.remover
punctuation.remover <- function (text) {
  temp <- gsub("[,.'…\";:!?-]", "", text, perl=TRUE)  #  remove punctuation - cf. 'gsub' later
  gsub(" {2,}", " ", temp, perl=TRUE)                 #  remove double spaces
}

# remove punctuation and make upper case
corpus.file.2 <- punctuation.remover(toupper(corpus.file)); corpus.file.2

# stringsplit and unlist
corpus.words <- unlist(strsplit(corpus.file.2, " "))

# get sorted table
frequencies <- sort(table(corpus.words)) # tags still included
frequencies

# order 
frequencies <- frequencies[order(names(frequencies))]
frequencies

# export
write.table(frequencies, file="output/freqlist_soldiers.txt", sep="\t", quote=FALSE)



####--- EXERCISE: spelling normalization ---####


### The same principles we used for lemmatization can also be used to normalize the spelling of a corpus, based on an existing document listing all possible base words along with any possible spelling variants. Starting from the fragment of lower-class writing from the London Lives Project below, draw on a custom-made spelling normalization list ("spelling normalization list.txt") to make a word list containing (a) the original word forms from the corpus, and (b) the normalized spelling forms behind each word from the corpus, separated by an underscore. When the corpus, for instance, reads "trobell", you should get an output of "trobell_trouble". 
# Fragment:
# onred Sur iam sorry to trobell you with this my Child bee Seek for three months on and of and now he is bad again as icant pay him Sur i hope you will think of my child for he is dangers ill
# (Source: London Lives - St Dionis Backchurch Parish: Letters to Parish Officials Seeking Pauper Relief(1758-1759) - http://www.londonlives.org/browse.jsp?div=GLDBPR30800PR308000005)

# load fragment as corpus file
corpus.file <- ("onred Sur iam sorry to trobell you with this my Child bee Seek for three months on and of and now he is bad again as icant pay him Sur i hope you will think of my child for he is dangers ill")

# make word list (without punctuation and all lower case)
corpus.file <- punctuation.remover(tolower(corpus.file)); corpus.file
corpus.words <- unlist(strsplit(corpus.file, " "))
corpus.words # notice limitations of word lists 

# read in spelling normalization list
spl_norm_list <- read.csv("spelling normalization list.txt", header=T, sep="\t")  
head(spl_norm_list, 10)

# attach normalized spelling to original spellings (separated by an underscore)
normalized_wordlist <- paste(corpus.words, spl_norm_list$NORMALIZED[match(corpus.words, spl_norm_list$ORIGINAL)], sep="_")
normalized_wordlist



####--- EXERCISE: grep ---####

# Write a regex to capture the names of the last four months of the year
words <- c("July", "September", "October", "November", "December"); words
grep("(Septem|Octo|Novem|Decem)ber", words, value=T, ignore.case=T)
grep("(September|October|November|December)", words, value=T, ignore.case=T)

# Write a regex to search for all historical spelling variants of the Dutch PersPron 'ik', where the <i> can also take the form of <j> or <ij>, and the <k> could also occur as <ck> (but not as <c>). 
words <- c("ik", "ick", "jk", "jck", "ijck", "Ik", "Ick", "Jk", "Jck", "Ijck", "ic"); words
grep("(i|ij|j)c?k", words, value=T, ignore.case=T)

# Write a regex to capture all words (singular and plural) ending in the suffix -ism
words <- c("fascism", "Bushisms", "antidisestablishmentarianism", "prism"); words
grep("[a-z]{3,}isms?", words, value=T, ignore.case=T)

# Write a regex to capture any word starting in a cluster of three or more consonants and exactly one vowel grapheme
words <- c("spring", "schmuck", "strudel", "scared", "straight"); words
grep("[bcdfghjklmnpqrstvwxz]{3,}[auoeiy]", words, value=T, ignore.case=T)
grep("[^auoeiy]{3,}[auoeiy]", words, value=T, ignore.case=T)


####---  EXERCISE: gsub GerManC ---####

# Load the following fragment from the GerManC corpus, and remove all of the tags from the fragment (source: muenchen1702_1.xml).
# GerManC <- c("<p><s>Verwichenen Dienstag seynd <num type=\"cardinal\" value=\"3\">3.</num> Hussaren vor <rs type=\"place\" key=\"DON\">Donauwerth</rs> gekommen/ vnd haben den Hirten mit <num type=\"cardinal\" value=\"40\">40.</num> Pferdten weggetriben;</s> <s>Die Bayrischen haben ihnen zwar gleich mit <num type=\"cardinal\" value=\"20\">20.</num> Pferdten bis; <rs type=\"place\" key=\"HHar\">Harburg</rs> nachgesetzt/ sie aber dannoch nicht angetroffen.</s>") 

GerManC <- c("<p><s>Verwichenen Dienstag seynd <num type=\"cardinal\" value=\"3\">3.</num> Hussaren vor <rs type=\"place\" key=\"DON\">Donauwerth</rs> gekommen/ vnd haben den Hirten mit <num type=\"cardinal\" value=\"40\">40.</num> Pferdten weggetriben;</s> <s>Die Bayrischen haben ihnen zwar gleich mit <num type=\"cardinal\" value=\"20\">20.</num> Pferdten bis; <rs type=\"place\" key=\"HHar\">Harburg</rs> nachgesetzt/ sie aber dannoch nicht angetroffen.</s>") 
GerManC
GerManC_notags <- gsub("<.*?>", "", GerManC, perl=T)
GerManC_notags

####---  EXERCISE: gsub anonymize ---####

# Load the fragment from the Dutch United Kingdom of the Netherlands Corpus below (Vosters 2009). To protect the identity of the people mentioned in this police report, change their names into their initials. You can assume that a name always consists of one capitalized first name and one capitalized last name. 
# policereport <- c("De heer Philip Devaleriola, die den nacht van den zes en twintigsten den zeven en twintigsten april in de fabrijk niet doorgebragt had, op zijnen beurt ondervraagd zijnde, verklaarde dat hij bij zijne vrouw was gaan slapen, in het huis van juffrouw Johanna Roberti alhier te Brussel. Maar de juffrouw Johanna Roberti en Catharina Vanginderachter hare winkel dochter, gaven aan de kommissaris van policie ten antwoord, dat hij dezen nacht bij zijne vrouw geenszins doorgebragt had.")

policereport <- c("De heer Philip Devaleriola, die den nacht van den zes en twintigsten den zeven en twintigsten april in de fabrijk niet doorgebragt had, op zijnen beurt ondervraagd zijnde, verklaarde dat hij bij zijne vrouw was gaan slapen, in het huis van juffrouw Johanna Roberti alhier te Brussel. Maar de juffrouw Johanna Roberti en Catharina Vanginderachter hare winkel dochter, gaven aan de kommissaris van policie ten antwoord, dat hij dezen nacht bij zijne vrouw geenszins doorgebragt had.")
policereport
policereport_anon <- gsub("([A-Z])[a-z]{1,} ([A-Z])[a-z]{2,}", "\\1.\\2.", policereport, perl=T)
policereport_anon


####--- EXERCISE: anchors & boundaries ---####

# Write a regex that can transform different sorts of American date notations into European date notations.
# (e.g. "07.24.2014", "02.23.82", "6/1/2014", "03-10-19", "7.24.14")

dates <- c("07.24.2014", "02.23.82", "6/1/2014", "03-10-19", "7.24.14")
dates
gsub("(\\d{1,2})(\\W)(\\d{1,2})(\\W)(\\d{2,4})", "\\3\\2\\1\\4\\5", dates, perl=TRUE)



####--- EXERCISE: exact matches Old Bailey ---####

# Load each line of the Old Bailey fragment "OBC-17320114.txt" as an item in the corpus vector. Next, search for any instances of the forms 'I', 'he', 'us' and 'him' in the corpus, and create a txt-file where the hits are shown in context, but separated by tabs. Save this file and open it in a spreadsheet processor to inspect the hits. 

# Load corpus fragment (Old Bailey)
rm(list=ls(all=TRUE))
# setwd()
corpus <- scan(file="Old Bailey fragment OBC-17320114.txt", what=character(0), sep="\n")
corpus

# load exact matches
source("http://www.linguistics.ucsb.edu/faculty/stgries/exact_matches.r") 

# search for all instances of the forms 'I', 'he' 'us' and 'him' in the corpus
exact.matches("\\b(I|he|us|him)\\b", corpus) 
matches <- exact.matches("\\b(I|he|us|him)\\b", corpus)[[4]]
matches

# export and open as spreadsheet
write.table(matches, file="matches_OldBailey.txt", sep="\t", quote=FALSE)



####--- EXERCISE: multiplication tables ---#####

# Use a for-loop that will generate the result of the multiplication tables of 7 (i.e. 7x1=7, 7x2=14, 7x3=21, …, 7x10=70). First set a counter which is the number (going from 1 to 10) you use to multiply with 7, and then calculate a variable x with the result of the multiplication. Show each result for 'x' on your screen using the 'print()' function.

for (i in 1:1000) {  # set counter i
  x <- 7 * i       # define x als result of 7 x i
  print(x)         # show result on screen
}


####--- EXERCISE: loops and corpora ---#####

# Use a for-loop to load the available files of the United Kingdom of the Netherlands Corpus ("UKN corpus…"), and extract all verbs from that corpus. Words have a tag structure as follows: <w lemma='vinden' msd='ww'>vond</w>, with verbs being labeled as msd='ww'. Preserve the tag structure, but add the year of writing to each word’s tag (see document header: e.g. <year='1823'/>. You want to get something like: <year='1829' lemma='zijn' msd='ww'>waren</w>. Save this as a vector 'corpus'. Then search this corpus for all instances of the lemma 'zeggen' (to say) occurring in documents written in 1829. 

# prep
rm(list=ls(all=TRUE))
# setwd
source("http://www.linguistics.ucsb.edu/faculty/stgries/exact_matches.r")
corpus.files <- dir(pattern="UKN corpus")
corpus.files
corpus <- character()

# loop 
for (i in 1:length(corpus.files)) {           # iterate over file names
  
  # output a 'progress report'
  cat(round(i/length(corpus.files), 2), ":\t", corpus.files[i], "\n")
  
  # read in corpus file as lower case and save it in current.corpus.file
  current.corpus.file <- tolower(scan(corpus.files[i], what=character(0), sep="\n", quiet=TRUE))
  
  # extract year from the header and save in a in a separate vector
  current.year.tag <- grep("<year='.*?'/>", current.corpus.file, perl=TRUE, value=TRUE)

  # extract elements containing at least one verb based on the word tag
  current.words <- grep("<w lemma='.*?' msd='ww'.*?</w>", current.corpus.file, perl=TRUE, value=TRUE)
    
  # use beginning of word-tag (<w ) to split vector up with strsplit
  current.words <- unlist(strsplit(current.words, " *<w ", perl=TRUE))
  
  # extract all individual elements starting with "lemma" (i.e. words) 
  # and marked as verb (msd='ww')
  current.words <- grep("^lemma='.*?' msd='ww'.*?", current.words, perl=TRUE, value=TRUE)
  
  # remove any supplementary tags after the closing word tag (</w>) 
  current.words <- gsub("</w>.*?$", "</w>", current.words, perl=TRUE)
  
  # append year tag to each sentence
  current.words <- paste(current.year.tag, current.words, sep="")
  
  # clean up tag structure
  current.words <- gsub("/>lemma", " lemma", current.words, perl=TRUE)
  
  # append the current.corpus.file to the whole corpus
  corpus <- c(corpus, current.words)   
} 

corpus

# search
exact.matches("^<year='1829' lemma='zeggen'.*$", corpus)[[1]]


####--- EXERCISE: corpus English dialogues  ---#####

# # Load the "CED_example.txt" file from the Corpus of English Dialogues 1560-1760 (CED), and try to make a frequency list (without punctuation) of this corpus, filtering out the words 'sample', 'file' and 'ced'. Limit yourself to the 25 most frequent words, save the frequency list, and visualize the 25 most frequent words in a graph.

# load
corpus.ced <- tolower(scan(file="CED_example.txt", what=character(0), quote=""))
corpus.ced

# punctuation
corpus.ced <- gsub("[,.'…\";:!?]", "", corpus.ced, perl=T);
corpus.ced

# stoplist
stoplist <- c("sample", "file", "ced")
corpus.ced <- corpus.ced[!corpus.ced %in% stoplist]

# freq table
freq_ced <- sort(table(corpus.ced), decreasing=T)[1:25]
freq_ced
write.table(freqtabel_oef, file="freqtabel_oef_cgn.txt", sep="\t", quote=FALSE, col.names=F, row.names=T)

# graph
barplot(freq_ced, main="Most frequent words - CED", ylab="Absolute frequency", ylim=c(0,360), las=2, cex.names = 0.7)


####--- EXERCISE: terrorism in newspapers  ---#####

# We want to know if newspapers nowadays write more often about terrorism than in the past. We will load part of the Dutch-language VU-DNC newspaper corpus, which contains the archives of the NRC newspaper from 1950 and 2002. We'll search that for the words 'terrorisme', 'terreur', 'terrorist' and 'terroristen', and we'll assume that the use of these words is a proxy for dealing with the topic of terrorism.
# 1. Use a loop to load all corpus files from the "nrc1950" and "nrc2002" folders. Load them as separate subcorpora (`corpus.1950` and `corpus.2002`, i.e. two separate loops), and load in each line separately (line by line).
# 2. Compare the number of files for each subcorpus, and use the wordcount() function of the (to be installed) 'ngram'-package to count the number of words in each subcorpus.
# 3. Use 'exact matches' to search for the mentioned words in both subcorpora.
# 4. Compare the number of results per subcorpus, and weigh them over the total number of words in each subcorpus. Can we find an answer to our research question?

# define names of corpus files
corpus.files.1950 <- dir(pattern="nrc1950-.*.txt", recursive = T)
corpus.files.2002 <- dir(pattern="nrc2002-.*.txt", recursive = T)
head(corpus.files.1950, 20)
head(corpus.files.2002, 20)

# max number of iteraties is total number of elements in corpus.files vectors
length(corpus.files.1950) # 605 files
length(corpus.files.2002) # 735 files

# prepare two empty text vectors
corpus.1950 <- character()
corpus.2002 <- character()

# first loop

for (i in 1:length(corpus.files.1950)) {
  current.lines <- tolower(scan(corpus.files.1950[i], what=character(0), sep="\n", quote=""))
  corpus.1950 <- c(corpus.1950, current.lines)
}

# second loop

for (i in 1:length(corpus.files.2002)) {
  current.lines <- tolower(scan(corpus.files.2002[i], what=character(0), sep="\n", quote=""))
  corpus.2002 <- c(corpus.2002, current.lines)
}

# check result
head(corpus.1950, 10)
head(corpus.2002, 10)

# load 'exact matches'
source("exact_matches.r")

# carry out two search expressions and save results
hits.1950 <- exact.matches("(terrorisme|terreur|terrorist|terroristen)", corpus.1950)[[1]]
hits.2002 <- exact.matches("(terrorisme|terreur|terrorist|terroristen)", corpus.2002)[[1]]

# count and compare number of hits
result.1950 <- length(hits.1950)
result.1950
result.2002 <- length(hits.2002)
result.2002

# count word count of each subcorpus
# install.packages("ngram")
library("ngram")
woco.1950 <- wordcount(corpus.1950)
woco.2002 <- wordcount(corpus.2002)

# compare results weighed for corpus size
(result.1950/woco.1950)*1000000 # almost 5 mentions of terrorism per million words
(result.2002/woco.2002)*1000000 # over 250 mentions of terrorism per million words

####--- EXERCISE: Netherlandic Dutch  ---#####

# For this exercise, we will try to find out which words are typical for Dutch as spoken in the Netherlands, versus Dutch as spoken in Flanders. We will load component A ('spoken conversations') of the Corpus of Spoken Dutch (CGN), with the Netherlandic Dutch subcomponent (CGN-A-nl.txt) and the Flemish Dutch subcomponent (CGN-A-vl.txt) in separate corpus files. Load "CGN-A-vl.txt" as your corpus, and use "CGN-A-nl.txt" as a reference corpus. Then make a copy of the 'keyness' code above, and try to adjust it so that it will work for this assignment. Make a graph showing your results, but only retain the words with 25 highest X2-values in your graph.

# PREP 

rm(list=ls(all=T))
# setwd()

# LOAD

# corpus: CGN-A-nl.txt
# reference corpus: CGN-A-vl.txt
corpus <- scan(file="CGN-A-nl.txt", what=character(0), quote = "")
ref.corpus <- scan(file="CGN-A-vl.txt", what=character(0), quote = "")

# remove punctuation and capitals
punctuation.remover <- function (text) {
  temp <- gsub("[,.'…\"”)(“‘’;:!?]", "", text, perl=TRUE)  #  interpunctie weghalen
  gsub(" {2,}", " ", temp, perl=TRUE)                #  dubbele spaties weghalen
}
corpus <- tolower(punctuation.remover(corpus))
ref.corpus <- tolower(punctuation.remover(ref.corpus))

# remove empty elements
corpus <- corpus[corpus!=""]
ref.corpus <- ref.corpus[ref.corpus!=""]

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

library(corpora)

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

# RESULT

# explore
head(result, 10)

# only keep results where words appear more in corpus than in reference corpus
result <- result[result$Corpus>result$Referencecorpus,]
result <- result[1:25,]

# if you want: only keep significant keywords (p <= 0.05)
result <- result[result$p<=0.05,]

# explore
head(result, 10)

# save as file
write.table(result, "output/output_keyness.txt", sep="\t", row.names=T, quote=F)

# GRAPH

# only retain the words with 25 highest X2-values
result_sign <- result[1:25,]
result_sign


# extract frequency values for corpus and reference corpus (in new vector: 'to_plot')
to_plot <- rbind(result$Corpus, result$Referencecorpus)
to_plot

# barplot
barplot(to_plot, main="Keywords (top 25)", ylab="Absolute frequency", beside = T, names.arg=rownames(result), las=2, cex.names = 0.75, legend.text=c("Corpus", "Reference corpus"))


####--- EXERCISE: categorical DV ---####

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

rm(list=ls(all=TRUE))
# setwd()

# load as dataframe 
spl <- read.table("spelling - data.txt", fileEncoding="UTF-16", sep="\t", header=TRUE)
    # sample of data used in Vosters (2011)
    # (random selection of 4000 hits)

# explore dataframe
head(spl); tail(spl) 
summary(spl)

# add metadata by merging
meta <- read.delim("Spelling - metadata.txt", fileEncoding="UTF-16", header=T)
head(meta); head(spl) # Needs to be merged by document
spl <- merge(spl, meta, by="Document")
head(spl)

# check and change factor types
str(spl) # Year = integer, should be factor
spl$Year <- as.factor(spl$Year) 

# attach
attach(spl) # detach(spl)

# DV spelling x IV year
round(prop.table(table(Spelling, Year)), 3)*100
plot(Spelling ~ Year)

# DV spelling x IV Town
round(prop.table(table(Spelling, Town)), 3)*100
plot(Spelling ~ Town)

# # DV spelling x IV Town x IV Year
round(prop.table(ftable(Year, Town, Spelling), 1), 2)


# table with relative use (%) two main variants (ae, aa) per province
round(prop.table(table(Spelling[Spelling!="a"], Province[Spelling!="a"]), 2)*100, 0)[2:3,]

# plot relative use (%) two main variants (ae, aa) per province + save
pdf(file="output/plot_spelling.pdf", width=12, height=8) 
aze <- barplot(prop.table(table(Spelling[Spelling!="a"], Province[Spelling!="a"]), 2)*100, main="Main spelling variants per province", ylab="Relative use of two main spelling variants", col=c("darkgreen", "darkolivegreen3"))
text(aze, 1, paste("n=", table(Province), sep=""), pos=3, font=3, cex=0.75)
legend("bottom", legend=c("aa", "ae"), inset=0.15, ncol=2, fill=c("darkgreen", "darkolivegreen3", cex=0.6, bg="white"))
dev.off() # and close port to save

detach(spl)

####--- EXERCISE: numeric DV ---####

# Load the "PresPart - data.txt" dataset, which will give you (partial) 
# data about Present Participle usage in a corpus of 19C Dutch legal texts. 
# Explore the dataframe and calculate a normalized rate of PresPart 
# usage per 1000 words, using the raw frequency counts and the word 
# counts per document available. Next, check (both visually and with
# a numerical test) if these normalized PresPart rates follow a normal 
# distribution. Then produce a boxplot of normalized PresPart usage per
# scribe (professional v. non-professional scribes), and a stripchart 
# of normalized PresPart use per text type, with the mean or median 
# scores per text type plotted on top. Save both of these plots in 
# the 'output' directory.

rm(list=ls(all=TRUE))
# setwd()

# load as dataframe 
PP <- read.table("PresPart - data.txt", fileEncoding="UTF-16", sep="\t", header=TRUE)

# explore dataframe
head(PP) 
tail(PP) 
str(PP)

# change factor type
PP$Document <- as.factor(PP$Document)

# calculate normalize frequency per 1000 words
PP$dv <- round( ( ( PP$Frequency /  PP$WordCount ) *1000 ), 2 )
head(PP)

attach(PP) # detach(PP)

# check if normal - histogram
h = hist(dv, xlab="Normalized PresPart frequency", main="Histogram with normal curve")
  # to add a normal curve:
  xfit = seq(min(dv),max(dv),length=40); yfit = dnorm(xfit, mean = mean(dv) , sd=sd(dv)); yfit = yfit * diff(h$mids[1:2]) * length(dv);   lines(xfit, yfit, col="blue", lwd=2)

# check if normal - Shapiro-Wilk 
shapiro.test(dv)  # not normally distributed

# boxplot of normalized PresPart use per scribe (professional v. non-professional scribes)
pdf(file="output/PresPart - boxplot.pdf", width=9, height=6)
iv <- Scribe
title <- c("PresPart use per scribe")
ylab <- c("Normalized PresPart use (per 1000 words)")
boxplot(dv ~ iv, main=title, ylab=ylab, notch=T, col="deepskyblue2")
dev.off()

# stripchart of normalized PresPart use per text type, plotting the mean or median scores on top
pdf(file="output/PresPart - stripchart.pdf", width=9, height=6)
iv <- TextType
title <- c("PresPart use per text type")
ylab <- c("Normalized PresPart use (per 1000 words)")
color <- rgb(0, 0.5, 0, 0.25)
stripchart(dv ~ iv, method="jitter", vertical=T, main=title, ylab=ylab, pch=19, col=color); grid(); points(1:length(levels(iv)), tapply(dv, iv, median), type="b", pch=16, lty=3, lwd=2, col="red"); legend("top", "median", cex=0.75, col="red", lty=3, lwd=1.5, pch=16, inset=0.02)
dev.off()

detach(PP)

