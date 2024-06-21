install.packages("ggplot2")
library(ggplot2)

data <- data.frame(
  Category = c("A", "B", "C", "D"),
  Value = c(10, 15, 7, 20)
)

# Create bar plot
ggplot(data, aes(x = Category, y = Value)) +
  geom_bar(stat = "identity", fill = "blue") +
  ggtitle("Bar Plot Example") +
  xlab("Categories") +
  ylab("Values")