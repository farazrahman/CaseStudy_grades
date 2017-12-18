#Case_Sudy - Analysis of student's submission time
#Author- Faraz Rahman

#Load the necessary packages
library(readr)
library(dplyr)
library(tidyr)
library(stringr)
library(ggplot2)

#Read the csv file
grades <- read_csv("grades.csv")
View(grades)

#View the summary of the file "grades"
summary(grades)

#Separate the Roll Numbers of the students 
grades_separated <- mutate(grades, submission = word(grades$submission,6,sep = "\\/"))
View(grades_separated)

#Separate the Date and Time of submission into two columns
grades_separated <- separate(data = grades_separated, col = submit_time, into = c("Date", "Time"), sep = "\\-")
View(grades_separated)

#Convert the Date column into the Date format of "%Y-%m-%d"
grades_separated$Date <- as.Date(grades_separated$Date, format = "%m/%d/%y")

#Determine the Day of the week from the "Date" column
grades_separated <- mutate(grades_separated, Day = weekdays(grades_separated$Date))
