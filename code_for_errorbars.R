load("WitnessDepMixEff.RData") # incomplete dataset for demo purposes only
WitnessDep
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
  ) 

