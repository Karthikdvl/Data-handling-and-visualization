# Load necessary libraries
library(tidyverse)
library(plotly)

# Create the dataset
data <- data.frame(
  CustomerID = 1:30,
  Age = c(35, 28, 42, 25, 38, 45, 23, 34, 40, 30, 29, 50, 32, 47, 36, 27, 41, 33, 39, 26, 48, 31, 44, 37, 43, 24, 46, 49, 21, 22),
  Gender = c("Male", "Female", "Male", "Female", "Male", "Female", "Male", "Female", "Male", "Female", "Male", "Female", "Male", "Female", "Male", "Female", "Male", "Female", "Male", "Female", "Male", "Female", "Male", "Female", "Male", "Female", "Male", "Female", "Male", "Female"),
  PurchaseAmount = c(100, 80, 120, 90, 110, 150, 60, 130, 95, 85, 70, 160, 75, 140, 115, 65, 125, 135, 105, 95, 145, 90, 120, 125, 130, 85, 155, 140, 50, 60),
  MembershipLevel = c("Gold", "Silver", "Bronze", "Bronze", "Silver", "Gold", "Silver", "Gold", "Bronze", "Silver", "Bronze", "Gold", "Silver", "Bronze", "Gold", "Silver", "Bronze", "Gold", "Silver", "Bronze", "Gold", "Silver", "Bronze", "Gold", "Silver", "Bronze", "Gold", "Silver", "Bronze", "Silver")
)

# Data Cleaning - Check for any missing values
sum(is.na(data))

# Data Processing
# Convert categorical variables into factors
data$Gender <- as.factor(data$Gender)
data$MembershipLevel <- as.factor(data$MembershipLevel)

# Summary of the data
summary(data)

# EDA Analysis
# Summary statistics
eda_summary <- data %>% 
  group_by(Gender, MembershipLevel) %>% 
  summarise(
    AverageAge = mean(Age),
    AveragePurchase = mean(PurchaseAmount),
    TotalPurchase = sum(PurchaseAmount),
    Count = n()
  )

print(eda_summary)

# Visualization - 20 plots
# 3D Scatter Plot of Age vs Purchase Amount vs Membership Level
fig1 <- plot_ly(data, x = ~Age, y = ~PurchaseAmount, z = ~as.numeric(MembershipLevel),
                type = 'scatter3d', mode = 'markers',
                color = ~MembershipLevel, symbol = ~Gender) %>%
  layout(scene = list(xaxis = list(title = 'Age'),
                      yaxis = list(title = 'Purchase Amount'),
                      zaxis = list(title = 'Membership Level')))
fig1

# 3D Scatter Plot of Age vs Purchase Amount vs Gender
fig2 <- plot_ly(data, x = ~Age, y = ~PurchaseAmount, z = ~as.numeric(Gender),
                type = 'scatter3d', mode = 'markers',
                color = ~Gender, symbol = ~MembershipLevel) %>%
  layout(scene = list(xaxis = list(title = 'Age'),
                      yaxis = list(title = 'Purchase Amount'),
                      zaxis = list(title = 'Gender')))
fig2

# 3D Bar Plot of Total Purchase by Gender and Membership Level
bar_data <- data %>%
  group_by(Gender, MembershipLevel) %>%
  summarise(TotalPurchase = sum(PurchaseAmount))

fig3 <- plot_ly(bar_data, x = ~Gender, y = ~MembershipLevel, z = ~TotalPurchase,
                type = 'bar', colors = 'Blues') %>%
  layout(scene = list(xaxis = list(title = 'Gender'),
                      yaxis = list(title = 'Membership Level'),
                      zaxis = list(title = 'Total Purchase')))
fig3

# 3D Histogram of Purchase Amount by Age
fig4 <- plot_ly(data, x = ~Age, y = ~PurchaseAmount, type = 'histogram2dcontour') %>%
  layout(scene = list(xaxis = list(title = 'Age'),
                      yaxis = list(title = 'Purchase Amount')))
fig4

# 3D Surface Plot for Purchase Amount Distribution
fig5 <- plot_ly(data, x = ~Age, y = ~PurchaseAmount, z = ~as.numeric(MembershipLevel),
                type = 'surface') %>%
  layout(scene = list(xaxis = list(title = 'Age'),
                      yaxis = list(title = 'Purchase Amount'),
                      zaxis = list(title = 'Membership Level')))
fig5

# 2D Scatter Plot of Age vs Purchase Amount by Gender
fig6 <- ggplot(data, aes(x = Age, y = PurchaseAmount, color = Gender)) +
  geom_point() +
  labs(title = "Age vs Purchase Amount by Gender", x = "Age", y = "Purchase Amount")
print(fig6)

# 2D Scatter Plot of Age vs Purchase Amount by Membership Level
fig7 <- ggplot(data, aes(x = Age, y = PurchaseAmount, color = MembershipLevel)) +
  geom_point() +
  labs(title = "Age vs Purchase Amount by Membership Level", x = "Age", y = "Purchase Amount")
print(fig7)

# Box Plot of Purchase Amount by Gender
fig8 <- ggplot(data, aes(x = Gender, y = PurchaseAmount, fill = Gender)) +
  geom_boxplot() +
  labs(title = "Purchase Amount by Gender", x = "Gender", y = "Purchase Amount")
print(fig8)

# Box Plot of Purchase Amount by Membership Level
fig9 <- ggplot(data, aes(x = MembershipLevel, y = PurchaseAmount, fill = MembershipLevel)) +
  geom_boxplot() +
  labs(title = "Purchase Amount by Membership Level", x = "Membership Level", y = "Purchase Amount")
print(fig9)

# Histogram of Ages
fig10 <- ggplot(data, aes(x = Age)) +
  geom_histogram(binwidth = 5, fill = "blue", color = "black") +
  labs(title = "Histogram of Ages", x = "Age", y = "Count")
print(fig10)

# Density Plot of Purchase Amount
fig11 <- ggplot(data, aes(x = PurchaseAmount)) +
  geom_density(fill = "red", alpha = 0.5) +
  labs(title = "Density Plot of Purchase Amount", x = "Purchase Amount", y = "Density")
print(fig11)

# Pie Chart of Gender Distribution
fig12 <- data %>%
  count(Gender) %>%
  plot_ly(labels = ~Gender, values = ~n, type = 'pie') %>%
  layout(title = 'Gender Distribution')
fig12

# Pie Chart of Membership Level Distribution
fig13 <- data %>%
  count(MembershipLevel) %>%
  plot_ly(labels = ~MembershipLevel, values = ~n, type = 'pie') %>%
  layout(title = 'Membership Level Distribution')
fig13

# Violin Plot of Purchase Amount by Gender
fig14 <- ggplot(data, aes(x = Gender, y = PurchaseAmount, fill = Gender)) +
  geom_violin() +
  labs(title = "Violin Plot of Purchase Amount by Gender", x = "Gender", y = "Purchase Amount")
print(fig14)

# Violin Plot of Purchase Amount by Membership Level
fig15 <- ggplot(data, aes(x = MembershipLevel, y = PurchaseAmount, fill = MembershipLevel)) +
  geom_violin() +
  labs(title = "Violin Plot of Purchase Amount by Membership Level", x = "Membership Level", y = "Purchase Amount")
print(fig15)

# 2D Density Plot of Age vs Purchase Amount
fig16 <- ggplot(data, aes(x = Age, y = PurchaseAmount)) +
  geom_density2d() +
  labs(title = "2D Density Plot of Age vs Purchase Amount", x = "Age", y = "Purchase Amount")
print(fig16)

# Bar Plot of Total Purchase by Gender
fig17 <- ggplot(bar_data, aes(x = Gender, y = TotalPurchase, fill = Gender)) +
  geom_bar(stat = "identity") +
  labs(title = "Total Purchase by Gender", x = "Gender", y = "Total Purchase")
print(fig17)

# Bar Plot of Total Purchase by Membership Level
fig18 <- ggplot(bar_data, aes(x = MembershipLevel, y = TotalPurchase, fill = MembershipLevel)) +
  geom_bar(stat = "identity") +
  labs(title = "Total Purchase by Membership Level", x = "Membership Level", y = "Total Purchase")
print(fig18)

# Line Plot of Purchase Amount by Age
fig19 <- ggplot(data, aes(x = Age, y = PurchaseAmount, color = Gender)) +
  geom_line() +
  labs(title = "Purchase Amount by Age", x = "Age", y = "Purchase Amount")
print(fig19)

# Correlation Plot between Age and Purchase Amount
correlation <- cor(data$Age, data$PurchaseAmount)
fig20 <- ggplot(data, aes(x = Age, y = PurchaseAmount)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = paste("Correlation Plot: Age vs Purchase Amount (Correlation:", round(correlation, 2), ")"), x = "Age", y = "Purchase Amount")
print(fig20)

# Display summary and plots
print(eda_summary)
fig1
fig2
fig3
fig4
fig5
print(fig6)
print(fig7)
print(fig8)
print(fig9)
print(fig10)
print(fig11)
fig12
fig13
print(fig14)
print(fig15)
print(fig16)
print(fig17)
print(fig18)
print(fig19)
print(fig20)