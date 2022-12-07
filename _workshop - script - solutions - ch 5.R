####--- | solution: grep ---####

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

# Replace: gsub()

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


####--- | solution: gsub GerManC---####

GerManC <- c("<p><s>Verwichenen Dienstag seynd <num type=\"cardinal\" value=\"3\">3.</num> Hussaren vor <rs type=\"place\" key=\"DON\">Donauwerth</rs> gekommen/ vnd haben den Hirten mit <num type=\"cardinal\" value=\"40\">40.</num> Pferdten weggetriben;</s> <s>Die Bayrischen haben ihnen zwar gleich mit <num type=\"cardinal\" value=\"20\">20.</num> Pferdten bis; <rs type=\"place\" key=\"HHar\">Harburg</rs> nachgesetzt/ sie aber dannoch nicht angetroffen.</s>") 
GerManC
GerManC_notags <- gsub("<.*?>", "", GerManC, perl=T)
GerManC_notags


####--- | solution: gsub anonymize---####

policereport <- c("De heer Philip Devaleriola, die den nacht van den zes en twintigsten den zeven en twintigsten april in de fabrijk niet doorgebragt had, op zijnen beurt ondervraagd zijnde, verklaarde dat hij bij zijne vrouw was gaan slapen, in het huis van juffrouw Johanna Roberti alhier te Brussel. Maar de juffrouw Johanna Roberti en Catharina Vanginderachter hare winkel dochter, gaven aan de kommissaris van policie ten antwoord, dat hij dezen nacht bij zijne vrouw geenszins doorgebragt had.")
policereport
policereport_anon <- gsub("([A-Z])[a-z]{1,} ([A-Z])[a-z]{2,}", "\\1.\\2.", policereport, perl=T)
policereport_anon


####--- | solution: anchors & boundaries ---####

dates <- c("07.24.2014", "02.23.82", "6/1/2014", "03-10-19", "7.24.14")
dates
gsub("(\\d{1,2})(\\W)(\\d{1,2})(\\W)(\\d{2,4})", "\\3\\2\\1\\4\\5", dates, perl=TRUE)


####--- | solution: corpus English dialogues  ---#####

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
freq_ced <- sort(table(corpus.ced), decreasing=T)
head(freq_ced, 25)
write.table(freqtabel_oef, file="fr_table_dialogues.txt", sep="\t", quote=FALSE, col.names=F, row.names=T)
write_xlsx(as.data.frame(freq_ced), "fr_table_dialogues.xlsx")

# barplot
barplot(freq_ced, main="Most frequent words - CED", ylab="Absolute frequency", ylim=c(0,360), las=2, cex.names = 0.7)


####--- | solution: Dickens  ---####

# load file
cities <- scan(file="Dickens-TwoCities.txt", what=character(0), quote="", encoding = "utf8")
head(cities, 25)

# load punctuation.remover
punctuation.remover <- function (text) {
  temp <- gsub("[,.;:?!_''\"“”‘’…]", "", text, perl=TRUE)
  gsub(" {2,}", " ", temp, perl=TRUE)                
}

# remove punctuation and make upper case
cities <- punctuation.remover(toupper(cities))
cities

# filter out stop words
stoplist <- stopwords(language = 'en', source = "stopwords-iso")
stoplist <- toupper(stoplist)
cities <- cities[!cities %in% stoplist]

# get sorted freq table
frequencies <- sort(table(cities), decreasing = T) 
head(frequencies, 20)

# export as XLSX
frequencies <- as.data.frame(frequencies)
library(writexl)
write_xlsx(frequencies, path = "freqlist_dickens.xlsx")


####--- | solution: Netherlandic Dutch  ---#####

# PREP 

rm(list=ls(all=T))

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

# GRAPH

# only retain the words with 25 highest X2-values
result_sign <- result[1:25,]
result_sign


# extract frequency values for corpus and reference corpus (in new vector: 'to_plot')
to_plot <- rbind(result$Corpus, result$Referencecorpus)
to_plot

# barplot
barplot(to_plot, main="Keywords (top 25)", ylab="Absolute frequency", beside = T, names.arg=rownames(result), las=2, cex.names = 0.75, legend.text=c("Corpus", "Reference corpus"))


####--- | solution: exact matches Old Bailey ---####

# load corpus fragment (Old Bailey)
corpus <- scan(file="OldBaileyFragmentOBC-17320114.txt", what=character(0), sep="\n")
corpus

# load exact matches
source("http://www.linguistics.ucsb.edu/faculty/stgries/exact_matches.r") 

# search for all instances of the forms 'I', 'he' 'us' and 'him' in the corpus
exact.matches("\\b(I|he|us|him)\\b", corpus) 
matches <- exact.matches("\\b(I|he|us|him)\\b", corpus)[[4]]
matches

# export and open as spreadsheet
write.table(matches, file="matches_OldBailey.txt", sep="\t", quote=FALSE)


####--- | solution: terrorism in newspapers  ---#####

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