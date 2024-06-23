# Load necessary libraries
library(ggplot2)
library(ggmosaic)
library(dplyr)

data <- data.frame(
  SCHOOL = c("A", "A", "A", "B", "B", "B", "C", "C", "C", "D", "D", "D"),
  GRADE_LEVEL = c("Grade 1", "Grade 2", "Grade 3", "Grade 1", "Grade 2", "Grade 3", "Grade 1", "Grade 2", "Grade 3", "Grade 1", "Grade 2", "Grade 3"),
  NUMBER_OF_STUDENTS = c(25, 30, 20, 22, 28, 18, 20, 25, 15, 28, 32, 24)
)
ggplot(data) +
  geom_mosaic(aes(weight = NUMBER_OF_STUDENTS, x = product(GRADE_LEVEL), fill = SCHOOL)) +
  labs(title="Mosaic Plot of Number of Students by Grade Level and School",
       x="Grade Level", y="Number of Students")
ggplot(data, aes(x=NUMBER_OF_STUDENTS)) +
  geom_histogram(binwidth=5, fill="skyblue", color="black") +
  labs(title="Histogram of Number of Students",
       x="Number of Students", y="Frequency")
ggplot(data, aes(x=GRADE_LEVEL, y=NUMBER_OF_STUDENTS, color=SCHOOL)) +
  geom_point(size=3) +
  labs(title="Scatter Plot of Number of Students by Grade Level and School",
       x="Grade Level", y="Number of Students")