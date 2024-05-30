##############################################################
##### Data visualization for historical sociolinguistics #####
########## Rik Vosters - Vrije Universiteit Brussel ##########
############ HiSoN Summer School - Metochi, 2022 #############
##############################################################

rm(list = ls(all = TRUE))
# devtools::install_github("psyteachr/introdataviz")
library(hrbrthemes)
library(extrafont)
library(readxl)
library(lubridate)
library(introdataviz)
library(ggridges)
library(patchwork)
library(ggmosaic)
library(vcd)
library(treemapify)
library(jtools)
library(scales)
library(ggalluvial)
library(tidyverse)

# set your own working directory
setwd("/Users/rikvosters/Dropbox/@ Documenten/Colleges - courses/_Gastcolleges/2022.07 HiSoN summer school Lesbos data visualization/Visualizations") 

### High school graduation rates -----

x <- 2007:2013
x
y <- c(75, 75, 78, 79, 80, 81, 82)
y
df <- tibble(x = x, y = y)
df
df %>%
  ggplot(aes(x = x, y = y)) +
  geom_bar(stat = "identity") +
  labs(title = , x = "Year", y = "High school graduation rate") +
  scale_x_continuous(labels = 2007:2013, breaks = 2007:2013) +
  theme_ipsum()
ggsave("output/Graduation_rates_good.png", device = "png", width = 4.5, height = 4)

### Third-person singular indicative -s vs. -th -----

# Male informants, 1640–1681
# Nevalainen & Raumolin-Brunberg (2016: 140)

Rank <- c(
  "Royalty", "Nobility", "Gentry", "Clergy", "Social Aspirers",
  "Professionals", "Royalty", "Nobility", "Gentry", "Clergy",
  "Social Aspirers", "Professionals"
)
Freq <- c(0, 10, 45, 35, 23, 36, 55, 158, 635, 217, 170, 200)
Variant <- c(
  "-th", "-th", "-th", "-th", "-th", "-th",
  "-s", "-s", "-s", "-s", "-s", "-s"
)

ThirdSgInd <- tibble(Rank, Freq, Variant)
ThirdSgInd %>%
  pivot_wider(names_from = Variant, values_from = Freq) -> ThirdSgInd

ThirdSgInd %>%
  group_by(Rank) %>%
  mutate(`-th (%)` = `-th` / (`-th` + `-s`) * 100) %>%
  mutate(`-s (%)` = `-s` / (`-th` + `-s`) * 100) %>%
  pivot_longer(
    cols = `-th (%)`:`-s (%)`,
    names_to = "Variant", values_to = "Percentage"
  ) -> ThirdSgInd
ThirdSgInd$Variant <- fct_recode(ThirdSgInd$Variant,
  "-th" = "-th (%)", "-s" = "-s (%)"
)
ThirdSgInd$Rank <- fct_relevel(
  ThirdSgInd$Rank,
  "Royalty", "Nobility", "Gentry", "Clergy",
  "Social Aspirers", "Professionals"
)
ThirdSgInd

# good

ThirdSgInd %>%
  ggplot(aes(x = Rank, y = Percentage, fill = Variant)) +
  geom_bar(stat = "identity") +
  labs(
    title = "3 Sg Ind -s versus -th",
    x = "Social rank", y = "Percentage",
    caption = "Data: Nevalainen & Raumolin-Brunberg \n(2016: 140); male informants, 1640–1681"
  ) +
  theme_ipsum() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
ggsave("output/3SgPres_good.png", device = "png", width = 4, height = 4)

# ugly

theme_ugly <- function(base_size = 13) {
  theme_bw() %+replace%
    theme(
      panel.grid.major = element_line(color = "white"),
      panel.background = element_rect(fill = "lightblue"),
      panel.border = element_rect(color = "lightblue", fill = NA),
      axis.line = element_line(color = "lightblue"),
      axis.ticks = element_line(color = "lightblue"),
      axis.text = element_text(color = "steelblue")
    )
}

ThirdSgInd %>%
  filter(Variant == "-s") %>%
  ggplot(aes(x = Rank, y = Percentage, fill = Rank)) +
  geom_bar(stat = "identity") +
  labs(
    title = "3 Sg Ind -s",
    x = "", y = "Percentage",
    caption = "Data: Nevalainen & Raumolin-Brunberg \n(2016: 140); male informants, 1640–1681"
  ) +
  theme_ugly() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
  theme(legend.position = "none") +
  theme(text = element_text(family = "Comic Sans MS"))
ggsave("output/3SgPres_ugly.png", device = "png", width = 4, height = 4)

rm(theme_ugly)

### Twitter hate speech -----

hate <- read_csv("data/hate_speech.csv")
hate$type <- fct_recode(as_factor(hate$class), "hate_speech" = "0", "offensive_language" = "1", "neither" = "2")
hate

# good

hate %>%
  group_by(type) %>%
  summarize(n = n()) %>%
  ggplot(aes(x = type, y = n)) +
  geom_bar(stat = "identity") +
  labs(
    title = , x = "Type", y = "Number of tweets",
    caption = "Data: www.kaggle.com"
  ) +
  theme_ipsum()
ggsave("output/Hate_speech_good.png", device = "png", width = 5, height = 4)

# wrong

hate %>%
  group_by(type) %>%
  summarize(n = n()) %>%
  ggplot(aes(x = type, y = n)) +
  geom_bar(stat = "identity") +
  labs(
    title = , x = "Type", y = "Number of tweets",
    caption = "Data: www.kaggle.com"
  ) +
  theme_ipsum() +
  theme(
    axis.title.y = element_blank(),
    axis.title.x = element_blank(),
    axis.text.y = element_blank(),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),
    axis.line.x.bottom = element_line(),
    axis.ticks.x.bottom = element_line()
  )

ggsave("output/Hate_speech_wrong.png", device = "png", width = 5, height = 4)

### Dutch relativizers -----

DuRel <- tibble(
  Rank = c("LC", "LMC", "UMC", "UC"),
  `d-relativizer` = c(8, 26, 44, 91),
  `w-relativizer` = c(6, 36, 136, 253)
)
DuRel

DuRel %>%
  group_by(Rank) %>%
  mutate(`d-relativizer (%)` = `d-relativizer` / (`d-relativizer` + `w-relativizer`) * 100) %>%
  mutate(`w-relativizer (%)` = `w-relativizer` / (`w-relativizer` + `d-relativizer`) * 100) %>%
  pivot_longer(
    cols = `d-relativizer (%)`:`w-relativizer (%)`,
    names_to = "Variant", values_to = "Percentage"
  ) %>%
  dplyr::select(Rank, Variant, Percentage) -> DuRel
DuRel$Variant <- fct_recode(DuRel$Variant,
  "d-relativizer" = "d-relativizer (%)",
  "w-relativizer" = "w-relativizer (%)"
)
DuRel$Rank <- fct_relevel(DuRel$Rank, "LC", "LMC", "UMC", "UC")
DuRel

# bad

DuRel %>%
  filter(Variant == "w-relativizer") %>%
  ggplot(aes(x = Rank, y = Percentage)) +
  geom_bar(stat = "identity") +
  labs(
    title = "Relative use w-relativizers", x = "Social rank", y = "Percentage",
    caption = "Data: Rutten & Van der Wal (2014: 298)"
  ) +
  coord_cartesian(ylim = c(40, 80)) +
  theme_ipsum()
ggsave("output/DuRel_bad.png", device = "png", width = 4, height = 4)

DuRel %>%
  filter(Variant == "w-relativizer") %>%
  ggplot(aes(x = Rank, y = Percentage)) +
  geom_bar(stat = "identity") +
  labs(
    title = "Relative use w-relativizers", x = "Social rank", y = "Percentage",
    caption = "Data: Rutten & Van der Wal (2014: 298)"
  ) +
  coord_cartesian(ylim = c(0, 100)) +
  theme_ipsum()
ggsave("output/DuRel_good.png", device = "png", width = 4, height = 4)

### Fox ------

fox <- tibble(
  million = c(7, 9, 13.5, 15),
  date = c(my("12-2007"), my("09-2008"), my("03-2009"), my("06-2010"))
)

fox %>%
  ggplot(aes(x = date, y = million, label = million)) +
  geom_line(aes(group = 1), col = "darkgrey") +
  geom_point() +
  geom_text(vjust = -0.5) +
  labs(x = "Year", y = "Job loss (MM)") +
  ylim(0, 20) +
  theme_ipsum()
ggsave("output/Fox_good.png", device = "png", width = 4, height = 4)


### barplots -----

# bar 1

load("data/FLS.RData") # incomplete dataset for demo purposes only
FLS %>%
  group_by(Class, .drop = F) %>%
  summarize(Mean = mean(TOKENS_100K)) %>%
  filter(is.na(Class) == F) -> to_plot
to_plot

to_plot %>%
  ggplot(aes(x = Class, y = Mean)) +
  geom_bar(stat = "identity") +
  labs(
    title = "French loan suffixes in Dutch",
    x = "Social rank",
    y = "Mean normalized suffix rate (per 10k words)",
    caption = "Data: Letters as Loot Corpus"
  ) +
  scale_fill_brewer(palette = "Set2") +
  theme_ipsum()
ggsave("output/Overview_bar1.png", device = "png", width = 5, height = 4)

# barplot 2 - AE

load("data/DuAE.RData") # incomplete dataset for demo purposes only

ae %>%
  group_by(GENRE, AV) %>%
  summarize(N = n()) %>%
  mutate(Percentage = round(N / sum(N), 3)) -> to_plot
to_plot

to_plot %>%
  filter(AV == "aa") %>%
  ggplot(aes(x = GENRE, y = Percentage)) +
  geom_bar(stat = "identity") +
  labs(
    title = "Rise of <aa> spellings in Dutch",
    subtitle = "Representing long A in closed syllables",
    caption = "Data: Van de Voorde (2021)\n ",
    x = "", y = "Incoming <aa> form (%)"
  ) +
  scale_y_percent(limits = c(0, 0.40)) +
  theme_ipsum()
ggsave("output/Overview_bar2.png", device = "png", width = 5, height = 4)

# bar 3

to_plot %>%
  filter(AV == "aa") %>%
  ggplot(aes(x = reorder(GENRE, desc(Percentage)), y = Percentage)) +
  geom_bar(stat = "identity") +
  labs(
    title = "Rise of <aa> spellings in Dutch",
    subtitle = "Representing long A in closed syllables",
    caption = "Data: Van de Voorde (2021)\n ",
    x = "", y = "Incoming <aa> form (%)"
  ) +
  scale_y_percent(limits = c(0, 0.40)) +
  theme_ipsum()
ggsave("output/Overview_bar3.png", device = "png", width = 5, height = 4)

# bar 4

FLS %>%
  group_by(Class, Gender, .drop = F) %>%
  summarize(Mean = mean(TOKENS_100K)) %>%
  filter(is.na(Class) == F) -> to_plot
to_plot

to_plot %>%
  ggplot(aes(x = Class, y = Mean, fill = Gender)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(
    title = "French loan suffixes in Dutch",
    x = "Social rank",
    y = "Mean normalized suffix rate (per 10k words)",
    caption = "Data: Letters as Loot Corpus"
  ) +
  scale_fill_brewer(palette = "Set2") +
  theme_ipsum()
ggsave("output/Overview_bar4.png", device = "png", width = 5, height = 4)

# bar 5
to_plot %>%
  ggplot(aes(x = Class, y = Mean, fill = Gender)) +
  geom_bar(stat = "identity", position = "stack") +
  labs(
    title = "French loan suffixes in Dutch",
    x = "Social rank",
    y = "Mean normalized suffix rate (per 10k words)",
    caption = "Data: Letters as Loot Corpus"
  ) +
  scale_fill_brewer(palette = "Set2") +
  theme_ipsum()
ggsave("output/Overview_bar5.png", device = "png", width = 5, height = 4)

# bar 6

ae %>%
  group_by(PERIOD, AV) %>%
  summarize(N = n()) %>%
  mutate(Percentage = round(N / sum(N), 3)) -> to_plot
to_plot

to_plot %>%
  ggplot(aes(x = PERIOD, y = Percentage, fill = AV)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(
    title = "Spelling long A in closed syllables",
    caption = "Data: Van de Voorde (2021)",
    x = "", y = "Relative occurrence (%)",
    fill = "Variant"
  ) +
  scale_y_percent() +
  scale_fill_brewer(palette = "Set2") +
  theme_ipsum() -> p1
p1
to_plot %>%
  ggplot(aes(x = PERIOD, y = Percentage, fill = AV)) +
  geom_bar(stat = "identity", position = "fill") +
  labs(
    title = "",
    caption = "Data: Van de Voorde (2021)",
    x = "", y = "Relative occurrence (%)",
    fill = "Variant"
  ) +
  scale_y_percent() +
  scale_fill_brewer(palette = "Set2") +
  theme_ipsum() -> p2
p2
p1 + p2
ggsave("output/Overview_bar6.png", device = "png", width = 8, height = 4)

# bar 7 stacked

load("data/BrotherJohn.RData") # incomplete dataset for demo purposes only; Crombez, Vandenbussche & Vosters (submitted)

BrotherJohn %>%
  group_by(language, date_binned) %>%
  summarise(N = n()) %>%
  ungroup() %>%
  group_by(date_binned) %>%
  mutate(percentage = N / sum(N) * 100) -> to_plot
to_plot

to_plot %>%
  ggplot(aes(x = date_binned, y = percentage, fill = language)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual("Language",
    values = c(
      "French" = "darkolivegreen3",
      "English/French" = "gold",
      "English" = "darkorange"
    )
  ) +
  labs(
    title = "Lexical borrowings",
    subtitle = "Diary of Brother John, Flemish priest in North America",
    caption = "Source: Crombez, Vandenbussche & Vosters (submitted)",
    x = "Period",
    y = "Relative frequency (%)"
  ) +
  theme_ipsum() +
  theme(legend.position = "bottom")
ggsave("output/Overview_bar7.png", device = "png", width = 5, height = 5)

# bar 8 filled

BrotherJohn %>%
  group_by(date_binned, language) %>%
  summarise(N = n()) -> to_plot
to_plot

to_plot %>%
  ggplot(aes(x = date_binned, y = N, fill = language)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_manual("Language",
    values = c(
      "English" = "darkorange",
      "English/French" = "gold",
      "French" = "darkolivegreen3"
    )
  ) +
  labs(
    title = "Lexical borrowings",
    subtitle = "Diary of Brother John, Flemish priest in North America",
    caption = "Source: Crombez, Vandenbussche & Vosters (submitted)",
    x = "Period",
    y = "Absolute frequency"
  ) +
  theme_ipsum() +
  theme(legend.position = "bottom")
ggsave("output/Overview_bar8.png", device = "png", width = 5, height = 5.5)

# bar 9

FLS %>%
  group_by(Class, .drop = F) %>%
  summarize(Mean = mean(TOKENS_100K)) %>%
  filter(is.na(Class) == F) -> to_plot
to_plot

to_plot %>%
  ggplot(aes(x = Class, y = Mean, fill = Class)) +
  geom_bar(stat = "identity") +
  labs(
    title = "French loan suffixes in Dutch",
    x = "Social rank",
    y = "Mean normalized suffix rate (per 10k words)",
    caption = "Data: Letters as Loot Corpus"
  ) +
  scale_fill_brewer(palette = "Set2") +
  theme_ipsum()
ggsave("output/Overview_bar9.png", device = "png", width = 5.5, height = 4)

# bar 10

FLS %>%
  group_by(Class, .drop = F) %>%
  summarize(Mean = mean(TOKENS_100K)) %>%
  filter(is.na(Class) == F) -> to_plot
to_plot

to_plot %>%
  ggplot(aes(x = Class, y = Mean, fill = Class)) +
  geom_bar(stat = "identity") +
  labs(
    title = "French loan suffixes in Dutch",
    x = "Social rank",
    y = "Mean normalized suffix rate (per 10k words)",
    caption = "Data: Letters as Loot Corpus"
  ) +
  scale_fill_manual(values = c(
    "darkolivegreen3", "darkolivegreen3",
    "darkolivegreen", "darkolivegreen3"
  )) +
  theme_ipsum() +
  theme(legend.position = "none")
ggsave("output/Overview_bar10.png", device = "png", width = 5.5, height = 4)


### dotplots -----

# dotplot 1

FLS %>%
  filter(Class == "UC", Gender == "Male") %>%
  ggplot(aes(
    x = reorder(tolower(Scribe), TOKENS_100K),
    y = TOKENS_100K
  )) +
  geom_segment(aes(
    x = reorder(tolower(Scribe), TOKENS_100K),
    xend = reorder(tolower(Scribe), TOKENS_100K),
    y = 0,
    yend = TOKENS_100K
  ),
  size = 0.5
  ) +
  geom_point(col = "tomato2", size = 2) +
  coord_flip() +
  labs(
    title = "French loan suffixes in Dutch",
    subtitle = "Per individual scribe",
    x = "",
    y = "Normalized suffix rate (per 10k words)",
    caption = "Data: Letters as Loot Corpus; only UC men"
  ) +
  ylim(0, 5000) +
  theme_ipsum()
ggsave("output/Overview_dotplot1.png", device = "png", width = 5.5, height = 10)

# dotplot 2

FLS %>%
  filter(Class == "UC", Gender == "Male") %>%
  ggplot(aes(
    x = reorder(tolower(Scribe), TOKENS_100K),
    y = TOKENS_100K
  )) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(
    title = "French loan suffixes in Dutch",
    subtitle = "Per individual scribe",
    x = "",
    y = "Normalized suffix rate (per 10k words)",
    caption = "Data: Letters as Loot Corpus; only UC men from Amsterdam"
  ) +
  ylim(0, 5000) +
  theme_ipsum()
ggsave("output/Overview_dotplot2.png", device = "png", width = 5.5, height = 11)

### heatmaps -----

ae %>%
  add_count(LEMMA) -> ae

ae %>%
  filter(is.na(LEMMA) == FALSE) %>%
  count(LEMMA) %>%
  arrange(desc(n)) %>%
  head(15) %>%
  pull(LEMMA) -> temp
temp

ae %>%
  filter(LEMMA %in% temp) %>%
  mutate(LEMMA = as_factor(LEMMA)) %>%
  filter(is.na(LEMMA) == F) %>%
  group_by(PERIOD, LEMMA, AV, .drop = F) %>%
  summarize(N = n()) %>%
  mutate(
    som = sum(N),
    Percentage = round(N / som * 100, 3)
  ) %>%
  mutate(Percentage = replace_na(Percentage, 0)) -> to_plot
to_plot

to_plot %>%
  filter(AV == "aa") %>%
  ggplot(aes(x = PERIOD, y = reorder(LEMMA, -Percentage), fill = Percentage)) +
  geom_tile(color = "white", size = 0.25) +
  # scale_fill_gradient(low = "white", high = "steelblue")
  scale_fill_viridis_c(
    option = "A", begin = 0.15, end = 0.98,
    limits = c(0, 100),
    guide = guide_colorbar(
      direction = "horizontal",
      label.position = "bottom",
      title.position = "top",
      title = "Percentage <aa> per lemma (selection) and century",
      barwidth = grid::unit(3.5, "in"),
      barheight = grid::unit(0.2, "in")
    )
  ) +
  labs(
    title = "Rise of <aa> spellings in Dutch",
    subtitle = "Representing long A in closed syllables",
    x = "", y = ""
  ) +
  scale_y_discrete(name = NULL, position = "right") +
  theme(
    axis.line = element_blank(),
    axis.ticks = element_blank(),
    axis.ticks.length = grid::unit(1, "pt"),
    legend.position = "top",
    legend.justification = "left",
    legend.title.align = 0.5,
    legend.title = element_text(size = 12 * 12 / 14)
  )
ggsave("output/Overview_heat1.png", device = "png", width = 5.5, height = 6.8)

# heatmap 2
ae %>%
  group_by(PERIOD, REGION, AV, .drop = F) %>%
  summarize(N = n()) %>%
  mutate(
    som = sum(N),
    Percentage = round(N / som * 100, 3)
  ) %>%
  mutate(Percentage = replace_na(Percentage, 0)) -> to_plot
to_plot

to_plot %>%
  filter(AV == "aa") %>%
  ggplot(aes(x = PERIOD, y = REGION, fill = Percentage)) +
  geom_tile(color = "white", size = 0.25) +
  scale_fill_viridis_c(
    option = "D", begin = 0.15, end = 0.98,
    limits = c(0, 100),
    guide = guide_colorbar(
      direction = "horizontal",
      label.position = "bottom",
      title.position = "top",
      title = "Percentage <aa> per region and century",
      barwidth = grid::unit(3.5, "in"),
      barheight = grid::unit(0.2, "in")
    )
  ) +
  labs(
    title = "Rise of <aa> spellings in Dutch",
    subtitle = "Representing long A in closed syllables",
    x = "", y = ""
  ) +
  scale_y_discrete(name = NULL, position = "right") +
  theme(
    axis.line = element_blank(),
    axis.ticks = element_blank(),
    axis.ticks.length = grid::unit(1, "pt"),
    legend.position = "top",
    legend.justification = "left",
    legend.title.align = 0.5,
    legend.title = element_text(size = 12 * 12 / 14)
  )
ggsave("output/Overview_heat2.png", device = "png", width = 5.5, height = 6.8)


### lineplots -----

FLS %>%
  group_by(Class, Gender, .drop = F) %>%
  summarize(Mean = mean(TOKENS_100K)) %>%
  filter(is.na(Class) == F) -> to_plot
to_plot

to_plot %>%
  ggplot(aes(x = Class, y = Mean, col = Gender)) +
  geom_point() +
  geom_line(aes(group = Gender)) +
  labs(
    title = "French loan suffixes in Dutch",
    x = "Social rank",
    y = "Mean normalized suffix rate (per 10k words)",
    caption = "Data: Letters as Loot Corpus"
  ) +
  scale_color_brewer(palette = "Set2") +
  ylim(labels = c(0, 1500)) +
  theme_ipsum()
ggsave("output/Overview_line.png", device = "png", width = 5, height = 4)

### boxplots -----

FLS %>%
  filter(is.na(Class) == F) %>%
  ggplot(aes(x = Class, y = TOKENS_100K, col = Gender)) +
  geom_boxplot() +
  labs(
    title = "French loan suffixes in Dutch",
    x = "Social rank",
    y = "Normalized suffix rate (per 10k words)",
    caption = "Data: Letters as Loot Corpus"
  ) +
  scale_color_brewer(palette = "Set2") +
  theme_ipsum()
ggsave("output/Overview_box.png", device = "png", width = 5.5, height = 4.5)

### scatterplots -----

# scatter 1

set.seed(247)
FLS %>%
  filter(is.na(Class) == F) %>%
  ggplot(aes(x = Class, y = TOKENS_100K)) +
  geom_point(alpha = 1) +
  labs(
    title = "French loan suffixes in Dutch",
    x = "Social rank",
    y = "Mean normalized suffix rate (per 10k words)",
    caption = "Data: Letters as Loot Corpus"
  ) +
  theme_ipsum()
ggsave("output/Overview_scatter1.png", device = "png", width = 5.5, height = 4.5)

# scatter 2

FLS %>%
  filter(is.na(Class) == F) %>%
  ggplot(aes(x = Class, y = TOKENS_100K)) +
  geom_point(alpha = 0.3) +
  labs(
    title = "French loan suffixes in Dutch",
    x = "Social rank",
    y = "Mean normalized suffix rate (per 10k words)",
    caption = "Data: Letters as Loot Corpus"
  ) +
  theme_ipsum()
ggsave("output/Overview_scatter2.png", device = "png", width = 5.5, height = 4.5)

# scatter 3

FLS %>%
  filter(is.na(Class) == F) %>%
  ggplot(aes(x = Class, y = TOKENS_100K)) +
  geom_count() +
  labs(
    title = "French loan suffixes in Dutch",
    x = "Social rank",
    y = "Mean normalized suffix rate (per 10k words)",
    caption = "Data: Letters as Loot Corpus"
  ) +
  theme_ipsum()
ggsave("output/Overview_scatter3.png", device = "png", width = 5.5, height = 4.5)

# scatter 4

FLS %>%
  filter(is.na(Class) == F) %>%
  ggplot(aes(x = Class, y = TOKENS_100K)) +
  geom_jitter(alpha = 0.5, width = 0.25) +
  labs(
    title = "French loan suffixes in Dutch",
    x = "Social rank",
    y = "Mean normalized suffix rate (per 10k words)",
    caption = "Data: Letters as Loot Corpus"
  ) +
  theme_ipsum()
ggsave("output/Overview_scatter4.png", device = "png", width = 5.5, height = 4.5)

# scatter 5

FLS %>%
  filter(is.na(Class) == F) %>%
  ggplot(aes(x = Class, y = TOKENS_100K, col = Gender)) +
  # geom_point(alpha = 0.5) +
  geom_jitter(alpha = 0.5, width = 0.25) +
  labs(
    title = "French loan suffixes in Dutch",
    x = "Social rank",
    y = "Mean normalized suffix rate (per 10k words)",
    caption = "Data: Letters as Loot Corpus"
  ) +
  scale_color_brewer(palette = "Set2") +
  theme_ipsum()
ggsave("output/Overview_scatter5.png", device = "png", width = 5.5, height = 4.5)

# scatter 6

FLS %>%
  filter(is.na(Class) == F) %>%
  ggplot(aes(x = Class, y = TOKENS_100K, col = Gender)) +
  geom_point(
    alpha = 0.5,
    position = position_jitterdodge(
      dodge.width = 0.5,
      jitter.width = 0.3
    )
  ) +
  labs(
    title = "French loan suffixes in Dutch",
    x = "Social rank",
    y = "Mean normalized suffix rate (per 10k words)",
    caption = "Data: Letters as Loot Corpus"
  ) +
  scale_color_brewer(palette = "Set2") +
  theme_ipsum()
ggsave("output/Overview_scatter6.png", device = "png", width = 5.5, height = 4.5)

# scatter 7

ae %>%
  group_by(ID, YEAR, AV) %>%
  summarize(N = n()) %>%
  mutate(Percentage = round(N / sum(N), 3)) -> to_plot

to_plot %>%
  filter(AV == "aa") %>%
  ggplot(aes(x = YEAR, y = Percentage)) +
  geom_point(alpha = 0.5) +
  labs(
    title = "Rise of <aa> spellings in Dutch",
    subtitle = "Representing long A in closed syllables",
    caption = "Data: Van de Voorde (2021)\n ",
    x = "", y = "Incoming <aa> form (%) per document"
  ) +
  scale_y_percent() +
  xlim(1500, 1900) +
  theme_ipsum()
ggsave("output/Overview_scatter7.png", device = "png", width = 5.5, height = 4.5)

# scatter 8

to_plot %>%
  filter(AV == "aa") %>%
  ggplot(aes(x = YEAR, y = Percentage)) +
  geom_point(alpha = 0.5) +
  geom_smooth(col = "red", method = "lm") +
  labs(
    title = "Rise of <aa> spellings in Dutch",
    subtitle = "Representing long A in closed syllables",
    caption = "Data: Van de Voorde (2021)\nSmoother: linear",
    x = "", y = "Incoming <aa> form (%) per document"
  ) +
  scale_y_percent() +
  coord_cartesian(xlim = c(1500, 1900), ylim = c(0, 1)) +
  theme_ipsum()
ggsave("output/Overview_scatter8.png", device = "png", width = 5.5, height = 4.5)

# scatter 9

to_plot %>%
  filter(AV == "aa") %>%
  ggplot(aes(x = YEAR, y = Percentage)) +
  geom_point(alpha = 0.5) +
  geom_smooth(col = "red", method = "loess", se = T, span = 1) +
  labs(
    title = "Rise of <aa> spellings in Dutch",
    subtitle = "Representing long A in closed syllables",
    caption = "Data: Van de Voorde (2021)\nLOESS smoother (span: 1)",
    x = "", y = "Incoming <aa> form (%) per document"
  ) +
  scale_y_percent() +
  coord_cartesian(xlim = c(1500, 1900), ylim = c(0, 1)) +
  theme_ipsum()
ggsave("output/Overview_scatter9.png", device = "png", width = 5.5, height = 4.5)

# scatter 10

to_plot %>%
  filter(AV == "aa") %>%
  ggplot(aes(x = YEAR, y = Percentage)) +
  geom_point(alpha = 0.5) +
  geom_smooth(col = "red", method = "loess", se = T, span = 1) +
  labs(
    title = "Rise of <aa> spellings in Dutch",
    subtitle = "Representing long A in closed syllables",
    caption = "Data: Van de Voorde (2021)\nLOESS smoother (span: 1)",
    x = "", y = "Incoming <aa> form (%) per document"
  ) +
  scale_y_percent() +
  coord_cartesian(xlim = c(1500, 1900), ylim = c(-0.5, 1)) +
  theme_ipsum()
ggsave("output/Overview_scatter10.png", device = "png", width = 5.5, height = 4.5)

# scatter 11

load("data/BrotherJohn_normalized.RData") # incomplete dataset for demo purposes only

BrotherJohn_normalized %>%
  ggplot(aes(x = Year, y = Frequency_norm, col = Language)) +
  geom_point(size = 1.2, alpha = 1) +
  geom_line(size = 0.7, alpha = 0.4) +
  geom_smooth(method = "loess", se = F, size = 1, span = 1) +
  scale_color_manual("Language",
    values = c(
      "French" = "darkolivegreen3",
      "English" = "darkorange"
    )
  ) +
  labs(
    title = "Lexical borrowings",
    subtitle = "Diary of Brother John, Flemish priest in North America",
    caption = "Source: Crombez, Vandenbussche & Vosters (submitted)\nLOESS smoother (span: 1)",
    x = "Year",
    y = "Normalized frequency (per 1,000 words)"
  ) +
  theme_ipsum()
ggsave("output/Overview_scatter11.png", device = "png", width = 6, height = 4.5)

# scatter 12

FLS %>%
  filter(is.na(Class) == F) %>%
  ggplot(aes(
    x = Class, y = TOKENS_100K, col = Gender,
    shape = Century
  )) +
  geom_point(
    alpha = 0.5,
    position = position_jitterdodge(
      dodge.width = 0.5,
      jitter.width = 0.3
    )
  ) +
  labs(
    title = "French loan suffixes in Dutch",
    x = "Social rank",
    y = "Mean normalized suffix rate (per 10k words)",
    caption = "Data: Letters as Loot Corpus"
  ) +
  scale_color_brewer(palette = "Set2") +
  theme_ipsum()
ggsave("output/Overview_scatter12.png", device = "png", width = 5.5, height = 4)

# scatter 13

FLS$Century <- fct_recode(FLS$Century,
  "17th century" = "17th",
  "18th century" = "18th"
)
FLS %>%
  filter(is.na(Class) == F) %>%
  ggplot(aes(x = Class, y = TOKENS_100K, col = Gender)) +
  geom_point(
    alpha = 0.5,
    position = position_jitterdodge(
      dodge.width = 0.5,
      jitter.width = 0.3
    )
  ) +
  labs(
    title = "French loan suffixes in Dutch",
    x = "Social rank",
    y = "Mean normalized suffix rate (per 10k words)",
    caption = "Data: Letters as Loot Corpus"
  ) +
  scale_color_brewer(palette = "Set2") +
  facet_wrap(. ~ Century, nrow = 1) +
  theme_ipsum() +
  theme(legend.position = "bottom")
ggsave("output/Overview_scatter13.png", device = "png", width = 5.5, height = 4.5)

### beeswarm plot -----

FLS %>%
  filter(is.na(Class) == F) %>%
  ggplot(aes(x = Class, y = TOKENS_100K, fill = Gender)) +
  geom_dotplot(
    binaxis = "y",
    stackdir = "center",
    position = position_dodge(0.5),
    binwidth = 50,
    dotsize = 2
  ) +
  labs(
    title = "French loan suffixes in Dutch",
    x = "Social rank",
    y = "Mean normalized suffix rate (per 10k words)",
    caption = "Data: Letters as Loot Corpus"
  ) +
  scale_fill_brewer(palette = "Set2") +
  theme_ipsum()
ggsave("output/Overview_beeswarm.png", device = "png", width = 10, height = 4.5)


### violin/bean -----

FLS %>%
  filter(is.na(Class) == F) %>%
  ggplot(aes(x = Class, y = TOKENS_100K, fill = Gender)) +
  geom_violin(col = "black", scale = "area") +
  labs(
    title = "French loan suffixes in Dutch",
    x = "Social rank",
    y = "Mean normalized suffix rate (per 10k words)",
    caption = "Data: Letters as Loot Corpus"
  ) +
  scale_fill_brewer(palette = "Set2") +
  theme_ipsum()
ggsave("output/Overview_violin.png", device = "png", width = 5.5, height = 4.5)

### scatter-violin -----

FLS %>%
  filter(is.na(Class) == F) %>%
  ggplot(aes(x = Class, y = TOKENS_100K, col = Gender)) +
  geom_violin() +
  geom_point(alpha = 0.2, position = position_dodge(0.9)) +
  labs(
    title = "French loan suffixes in Dutch",
    x = "Social rank",
    y = "Mean normalized suffix rate (per 10k words)",
    caption = "Data: Letters as Loot Corpus"
  ) +
  scale_color_brewer(palette = "Set2") +
  theme_ipsum()
ggsave("output/Overview_scatter_violin.png", device = "png", width = 5.5, height = 4.5)

### ridgeline -----

FLS %>%
  filter(is.na(Class) == F) %>%
  ggplot(aes(x = TOKENS_100K, y = Class, fill = Gender)) +
  geom_density_ridges(scale = 2.5) +
  labs(
    title = "French loan suffixes in Dutch",
    x = "Mean normalized suffix rate (per 10k words)",
    y = "Social rank",
    caption = "Data: Letters as Loot Corpus"
  ) +
  scale_fill_brewer(palette = "Set2") +
  scale_color_brewer(palette = "Set2") +
  facet_wrap(. ~ Gender, nrow = 2) +
  theme_ipsum() +
  theme(legend.position = "none")
ggsave("output/Overview_ridgeline.png", device = "png", width = 4.5, height = 6.5)

### ridgeline raincloud -----

FLS %>%
  filter(is.na(Class) == F) %>%
  ggplot(aes(x = Class, y = TOKENS_100K, fill = Gender, col = Gender)) +
  geom_flat_violin(
    alpha = .4, trim = FALSE, scale = "width",
    position = position_nudge(x = .2, y = 0)
  ) +
  coord_flip() +
  geom_jitter(width = 0.15, alpha = 0.2) +
  labs(
    title = "French loan suffixes in Dutch",
    x = "Social rank",
    y = "Mean normalized suffix rate (per 10k words)",
    caption = "Data: Letters as Loot Corpus"
  ) +
  scale_fill_brewer(palette = "Set2") +
  scale_color_brewer(palette = "Set2") +
  facet_wrap(. ~ Gender) +
  theme_ipsum() +
  theme(legend.position = "none")
ggsave("output/Overview_ridgeline_raincloud.png", device = "png", width = 5.5, height = 4)


### pie charts versus barplots -----

# made up data

Parties <- c("Liberals", "Conservatives", "Nationalists", "Socialists", "Greens")
Election2005 <- c(23, 20, 9, 30, 18)
Election2010 <- c(21, 18, 7, 33, 22)
Election2015 <- c(19, 15, 5, 37, 24)
df <- data.frame(Parties, Election2005, Election2010, Election2015)

# pies

pdf(file = "output/BarsAndPies1.pdf", width = 10, height = 5)
par(mfrow = c(1, 3))
cols <- c("blue2", "darkorange1", "tan4", "red2", "chartreuse3")
pie(df$Election2005, labels = Parties, main = "2005 election results", col = cols)
pie(df$Election2010, labels = Parties, main = "2010 election results", col = cols)
pie(df$Election2015, labels = Parties, main = "2015 election results", col = cols)
par(mfrow = c(1, 1))
dev.off()

# bars

pdf(file = "output/BarsAndPies2.pdf", width = 9, height = 6)
data <- rbind(df$Election2005, df$Election2010, df$Election2015)
barplot(data, names.arg = Parties, cex.axis = 1, ylim = c(0, 40), ylab = "Relative number of votes (%)", beside = T, col = c("darkolivegreen", "darkolivegreen4", "darkolivegreen3"))
legend("top", legend = c("2005 election", "2010 election", "2015 election"), ncol = 1, fill = c("darkolivegreen", "darkolivegreen4", "darkolivegreen3"), cex = 1, inset = 0.03, bg = "white")
dev.off()

### mosaic plot -----

# load was/were (ww)

ww <- read_csv("data/Tagliamonte&Baayen2012.txt")
ww <- ww %>% mutate_if(is.character, as.factor)
ww$Form <- fct_recode(ww$Form, "were" = "R", "was" = "S")

# mosaic 1

ww %>%
  ggplot() +
  geom_mosaic(aes(x = product(Form, AgeGroup), fill = Form)) +
  labs(
    title = "Was/were variation per age group",
    subtitle = "York English corpus",
    x = "Age group", y = "",
    caption = "(Data: Tagliamonte & Baayen 2012)"
  ) +
  theme_minimal() +
  guides(fill = guide_legend(reverse = TRUE))
ggsave("output/Overview_mosaic1.png", device = "png", width = 5.5, height = 4)

# mosaic 2

vcd::mosaic(ww$Form ~ ww$AgeGroup, shade = TRUE)
pdf(file = "output/Overview_mosaic2.pdf", width = 5, height = 5)
vcd::mosaic(structable(ww$Form, ww$AgeGroup),
  shade = TRUE, legend = T,
  main = "Was/were variation per age group",
  sub = "(Data: Tagliamonte & Baayen 2012)"
)
# blue = more observations than expected under null hypothesis; red = less observations
dev.off()

vcd::mosaic(ww$Form ~ ww$AgeGroup, shade = TRUE)
pdf(file = "output/Overview_mosaic3.pdf", width = 5, height = 5)
vcd::assoc(structable(ww$Form, ww$AgeGroup),
  shade = TRUE, legend = T,
  main = "Was/were variation per age group",
  sub = "(Data: Tagliamonte & Baayen 2012)"
)
# blue = more observations than expected under null hypothesis; red = less observations
dev.off()

ww %>%
  group_by(AgeGroup, Form) %>%
  summarize(N = n()) %>%
  mutate(Percentage = formattable::percent(N / sum(N))) -> to_plot
to_plot

to_plot %>%
  filter(Form == "was") %>%
  ggplot(aes(x = AgeGroup, y = Percentage)) +
  geom_bar(stat = "identity") +
  labs(
    title = "Was/were variation per age group",
    subtitle = "York English corpus",
    x = "Age group", y = "Relative use of WAS variant",
    caption = "(Data: Tagliamonte & Baayen 2012)"
  ) +
  theme_minimal() +
  scale_y_percent() +
  guides(fill = guide_legend(reverse = TRUE))
ggsave("output/Overview_tree1.png", device = "png", width = 5.5, height = 4)

to_plot %>%
  filter(Form == "was") %>%
  ggplot(aes(
    fill = AgeGroup, area = Percentage,
    label = paste(AgeGroup, Percentage, sep = "\n")
  )) +
  geom_treemap() +
  geom_treemap_text() +
  labs(
    title = "Was/were variation per age group",
    subtitle = "Relative use of WAS (versus WERE) variant (%)",
    x = "", y = "",
    caption = "(Data: Tagliamonte & Baayen 2012)"
  ) +
  scale_y_percent() +
  theme_minimal() +
  theme(legend.position = "none")
ggsave("output/Overview_tree2.png", device = "png", width = 5.5, height = 4)

to_plot %>%
  filter(Form == "was") %>%
  ggplot(aes(x = "", y = Percentage, fill = AgeGroup)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  geom_text(aes(label = Percentage),
    position = position_stack(vjust = 0.5)
  ) +
  labs(
    title = "Was/were variation per age group",
    subtitle = "York English corpus",
    x = NULL, y = NULL, fill = NULL,
    caption = "(Data: Tagliamonte & Baayen 2012)"
  ) +
  theme_minimal() +
  theme(
    axis.line = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank()
  )
ggsave("output/Overview_tree3_pie.png", device = "png", width = 5.5, height = 4)

### pacman chart -----

pdf(file = "output/Pacman.pdf", width = 6, height = 6)
pie(c(25, 75), init.angle = 310, radius = 1, col = c("black", "yellow1"), labels = c("25%", "75%"), main = "The Pacman chart")
legend("bottom", c("Percentage of chart which looks like Pacman", "Percentage of the chart which does not look like Pacman"), fill = c("yellow1", "black"), inset = -.14, xpd = T)
dev.off()

### models CI -----

load("data/WitnessDepMixEff.RData") # incomplete dataset for demo purposes only
WitnessDep %>%
  ggplot(aes(x = term, y = value, ymin = lower_2.5, ymax = upper_97.5)) +
  geom_bar(stat = "identity") +
  geom_errorbar(width = 0.1, col = "grey50") +
  geom_hline(yintercept = 0, col = "black") +
  ylim(-0.5, 8) +
  labs(
    title = "Use of modals per role in 18th and\n19th-century witness depositions",
    subtitle = "Mixed-effects linear regression",
    x = "", y = "Fixed-effect coefficient",
    caption = "Reference level - Role: witness\nWhiskers represent 95% CI\nData: Serwadczak (in prep.)"
  ) +
  theme_ipsum()
ggsave("output/CI_1.png", device = "png", width = 5, height = 4)

WitnessDep %>%
  ggplot(aes(x = term, y = value, ymin = lower_2.5, ymax = upper_97.5)) +
  geom_errorbar(width = 0.1, col = "grey60") +
  geom_point() +
  geom_hline(yintercept = 0, col = "red", lty = 2) +
  ylim(-2, 8) +
  labs(
    title = "Use of modals per role in 18th and\n19th-century witness depositions",
    subtitle = "Mixed-effects linear regression",
    x = "", y = "Fixed-effect coefficient",
    caption = "Reference level - Role: witness\nWhiskers represent 95% CI\nData: Serwadczak (in prep.)"
  ) +
  coord_flip() +
  theme_ipsum()
ggsave("output/CI_2.png", device = "png", width = 5, height = 4)

# StdDev

FLS %>%
  group_by(Class, .drop = F) %>%
  summarize(
    Mean = mean(TOKENS_100K),
    SD = sd(TOKENS_100K)
  ) %>%
  filter(is.na(Class) == F) -> to_plot
to_plot

to_plot %>%
  ggplot(aes(x = Class, y = Mean, ymin = Mean - SD, ymax = Mean + SD)) +
  geom_bar(stat = "identity") +
  geom_errorbar(width = 0.1, col = "grey60") +
  labs(
    title = "French loan suffixes in Dutch",
    x = "Social rank",
    y = "Mean normalized suffix rate (per 10k words)",
    caption = "Data: Letters as Loot Corpus"
  ) +
  scale_fill_brewer(palette = "Set2") +
  scale_y_continuous(limits = c(0, 2200), oob = scales::squish) +
  theme_ipsum()
ggsave("output/StdDev.png", device = "png", width = 5, height = 4)


to_plot %>%
  ggplot(aes(x = Class, y = Mean, ymin = Mean - SD, ymax = Mean + SD)) +
  geom_point() +
  geom_errorbar(width = 0.1, col = "grey60") +
  labs(
    title = "French loan suffixes in Dutch",
    x = "Social rank",
    y = "Mean normalized suffix rate (per 10k words)",
    caption = "Data: Letters as Loot Corpus"
  ) +
  scale_fill_brewer(palette = "Set2") +
  scale_y_continuous(limits = c(0, 2200), oob = scales::squish) +
  theme_ipsum()
ggsave("output/StdDev2.png", device = "png", width = 5, height = 4)

### Sankey - alluvial -----

ww %>%
  group_by(Form, AgeGroup, Sex) %>%
  dplyr::summarize(Frequency = n()) -> to_plot
to_plot

to_plot %>%
  ggplot(aes(
    axis1 = AgeGroup, axis2 = Form,
    y = Frequency
  )) +
  scale_x_discrete(
    limits = c("Age group", "Form"),
    expand = c(.2, .05)
  ) +
  geom_alluvium(aes(fill = Form)) +
  geom_stratum() +
  geom_text(stat = "stratum", aes(label = after_stat(stratum))) +
  labs(
    title = "Was/were variation per age group",
    subtitle = "York English corpus",
    x = "Age group", y = "",
    caption = "(Data: Tagliamonte & Baayen 2012)"
  ) +
  guides(fill = guide_legend(title = "Variant")) +
  theme_ipsum()
ggsave(
  file = "./Output/Overview_alluvial1.png",
  device = "png", width = 6.5, height = 4
)

to_plot %>%
  ggplot(aes(
    axis1 = AgeGroup, axis2 = Sex,
    y = Frequency
  )) +
  scale_x_discrete(
    limits = c("Age group", "Sex"),
    expand = c(.2, .05)
  ) +
  geom_alluvium(aes(fill = Form)) +
  geom_stratum() +
  geom_text(stat = "stratum", aes(label = after_stat(stratum))) +
  labs(
    title = "Was/were variation per age group",
    subtitle = "York English corpus",
    x = "Age group", y = "",
    caption = "(Data: Tagliamonte & Baayen 2012)"
  ) +
  guides(fill = guide_legend(title = "Variant")) +
  theme_ipsum()
ggsave(
  file = "./Output/Overview_alluvial2.png",
  device = "png", width = 6.5, height = 4
)

