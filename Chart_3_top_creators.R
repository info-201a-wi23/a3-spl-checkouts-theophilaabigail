library(dplyr)
library(ggplot2)

# load the dataset
df <- read.csv("/Users/theophilasetiawan/Documents/INFO 201 (main)/Info201code/a3-spl-checkouts-theophilaabigail/2017-2023-10-Checkouts-SPL-Data.csv")

# filter books only
books3 <- filter(df, MaterialType == "BOOK")

# group by creator and calculate total checkouts
creators <- books3 %>%
  group_by(Creator) %>%
  summarize(total_checkouts = sum(Checkouts), .groups = "drop")

creators <- creators[creators$Creator != "",]

# reorder creator names based on total checkouts
creators <- creators[order(creators$total_checkouts, decreasing = TRUE),]
creators$Creator <- reorder(creators$Creator, creators$total_checkouts)

# get top 5 creators
top_creators <- head(creators, n = 5)

# create histogram
ggplot(top_creators, aes(x = Creator, y = total_checkouts, fill = Creator)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("#2196F3", "#FFC107", "#4CAF50", "#9C27B0", "#E91E63")) +
  labs(x = "Creator", y = "Total Checkouts", title = "Top 5 Creators by Checkouts")
