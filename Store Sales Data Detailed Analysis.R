# Load required libraries
library(ggplot2)
library(dplyr)
library(tidyr)
library(reshape2)
library(plotly)
library(lattice)

# Corrected data frame creation
data <- data.frame(
  Store_ID = 1:32,
  Region = rep(c("North", "South", "East", "West"), 8),
  Month = rep(c("January", "February", "March", "April", "May", "June", "July", "August"), each = 4),
  Total_Sales = c(10000, 15000, 12000, 13000, 9000, 16000, 14000, 11000, 11000, 17000, 13000, 15000, 12000, 18000, 16000, 14000, 13000, 19000, 15000, 16000, 14000, 20000, 17000, 15000, 15000, 21000, 16000, 14000, 16000, 22000, 18000, 20000),
  Number_Of_Customers = c(500, 700, 600, 650, 450, 800, 700, 550, 550, 850, 650, 750, 600, 900, 800, 700, 650, 950, 750, 800, 700, 1000, 850, 750, 750, 1050, 800, 700, 800, 1100, 900, 950),
  Average_Transaction_Value = c(20, 21.43, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 22.5, 21.05)
)

# Ensure 'Month' is a factor with specified levels
data$Month <- factor(data$Month, levels = c("January", "February", "March", "April", "May", "June", "July", "August"))

# Summary of the data
summary(data)

# Structure of the data
str(data)

# Head of the data
head(data)

# Tail of the data
tail(data)

# Create plots
plot1 <- ggplot(data, aes(x = Region, y = Total_Sales, fill = Region)) +
  geom_bar(stat = "identity") +
  ggtitle("Total Sales by Region")

plot2 <- ggplot(data, aes(x = Month, y = Total_Sales, fill = Month)) +
  geom_bar(stat = "identity") +
  ggtitle("Total Sales by Month")

plot3 <- ggplot(data, aes(x = Month, y = Total_Sales, fill = Region)) +
  geom_bar(stat = "identity", position = "dodge") +
  ggtitle("Total Sales by Region and Month")

plot4 <- ggplot(data, aes(x = Region, y = Number_Of_Customers, fill = Region)) +
  geom_bar(stat = "identity") +
  ggtitle("Number of Customers by Region")

plot5 <- ggplot(data, aes(x = Month, y = Number_Of_Customers, fill = Month)) +
  geom_bar(stat = "identity") +
  ggtitle("Number of Customers by Month")

plot6 <- ggplot(data, aes(x = Month, y = Number_Of_Customers, fill = Region)) +
  geom_bar(stat = "identity", position = "dodge") +
  ggtitle("Number of Customers by Region and Month")

plot7 <- ggplot(data, aes(x = Region, y = Average_Transaction_Value, fill = Region)) +
  geom_bar(stat = "identity") +
  ggtitle("Average Transaction Value by Region")

plot8 <- ggplot(data, aes(x = Month, y = Average_Transaction_Value, fill = Month)) +
  geom_bar(stat = "identity") +
  ggtitle("Average Transaction Value by Month")

plot9 <- ggplot(data, aes(x = Month, y = Average_Transaction_Value, fill = Region)) +
  geom_bar(stat = "identity", position = "dodge") +
  ggtitle("Average Transaction Value by Region and Month")

plot10 <- ggplot(data, aes(x = Number_Of_Customers, y = Total_Sales, color = Region)) +
  geom_point() +
  geom_smooth(method = "lm") +
  ggtitle("Total Sales vs Number of Customers")

plot11 <- ggplot(data, aes(x = factor(Store_ID), y = Total_Sales, fill = Region)) +
  geom_bar(stat = "identity") +
  ggtitle("Total Sales by Store")

plot12 <- ggplot(data, aes(x = factor(Store_ID), y = Number_Of_Customers, fill = Region)) +
  geom_bar(stat = "identity") +
  ggtitle("Number of Customers by Store")

plot13 <- ggplot(data, aes(x = Month, y = Total_Sales, group = Region, color = Region)) +
  geom_line() +
  geom_point() +
  ggtitle("Monthly Sales Trend by Region")

plot14 <- ggplot(data, aes(x = Month, y = Number_Of_Customers, group = Region, color = Region)) +
  geom_line() +
  geom_point() +
  ggtitle("Monthly Customer Trend by Region")

plot15 <- plot_ly(data, x = ~Total_Sales, y = ~Number_Of_Customers, z = ~Average_Transaction_Value, color = ~Region, colors = c('#BF382A', '#0C4B8E')) %>%
  add_markers() %>%
  layout(scene = list(xaxis = list(title = 'Total Sales'),
                      yaxis = list(title = 'Number Of Customers'),
                      zaxis = list(title = 'Average Transaction Value')),
         title = "3D Visualization of Sales, Customers, and Average Transaction Value")

# Print plots
print(plot1)
print(plot2)
print(plot3)
print(plot4)
print(plot5)
print(plot6)
print(plot7)
print(plot8)
print(plot9)
print(plot10)
print(plot11)
print(plot12)
print(plot13)
print(plot14)
plot15