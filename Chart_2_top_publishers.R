# Load library

library(ggplot2)
library(dplyr)

# Load the dataset 
df <- read.csv("/Users/theophilasetiawan/Documents/INFO 201 (main)/Info201code/a3-spl-checkouts-theophilaabigail/2017-2023-10-Checkouts-SPL-Data.csv")

# Filter the data frame to include only book MaterialType
books <- filter(df, MaterialType == "BOOK")

# Group the filtered data frame by Publisher, and sum the Checkouts for each publisher across all years
books_by_publisher <- books %>%
  group_by(Publisher) %>%
  summarize(total_checkouts = sum(Checkouts)) %>%
  arrange(desc(total_checkouts)) %>%
  slice(1:5)

# Group the books data frame by CheckoutYear and Publisher, and sum the Checkouts for each publisher and year
books_by_publisher_year <- books %>%
  group_by(Publisher, CheckoutYear) %>%
  summarize(total_checkouts = sum(Checkouts)) %>%
  arrange(desc(total_checkouts)) %>%
  filter(Publisher %in% books_by_publisher$Publisher)

# Create a plot of total checkouts for each publisher by year
ggplot(books_by_publisher_year, aes(x = CheckoutYear, y = total_checkouts, fill = Publisher)) +
  geom_col(position = "dodge") +
  geom_line(aes(color = Publisher), position = "dodge") +
  scale_fill_manual(values = c("#2196F3", "#FFC107", "#4CAF50", "#9C27B0", "#FF5722")) +
  scale_color_manual(values = c("#2196F3", "#FFC107", "#4CAF50", "#9C27B0", "#FF5722")) +
  ggtitle("Top 10 Publishers by Checkouts Throughout the Years") +
  xlab("Checkout Year") +
  ylab("Total Checkouts")
