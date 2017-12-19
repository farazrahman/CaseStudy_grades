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

#Separate the Date and Time of submission into two columns
grades_separated <- separate(data = grades_separated, col = submission, into = c("Roll_Num", "Type"), sep = "\\.")
View(grades_separated)

#Separate the Date and Time of submission into two columns
grades_separated <- separate(data = grades_separated, col = submit_time, into = c("Date", "Time"), sep = "\\-")
View(grades_separated)

#Convert the Date column into the Date format of "%Y-%m-%d"
grades_separated$Date <- as.Date(grades_separated$Date, format = "%m/%d/%y")

#Determine the Day of the week from the "Date" column
grades_separated <- mutate(grades_separated, Day = format(grades_separated$Date, "%B %d, %Y"))

grades_separated <-mutate(grades_separated, Time1 =format(strptime(grades_separated$Time, '%H:%M:%S'), '%I:%M %p'))


#Q1. What percentage of students submitted their solutions in .zip format?

ggplot(grades_separated, aes(x = grades_separated$Type)) + geom_bar()
table(grades_separated$Type)

#Q2. How many students submitted the assignment after the first deadline 
#(including the students who submitted after the second deadline) ?

            
first_submission <- mutate(grades_separated, value = if_else(grades_separated$Day < "January 04, 2017", 1, 0))
View(first_submission)

table(first_submission$value)

#Q3. On which date did the most students submit the assignment?

table(grades_separated$Day)
ggplot(grades_separated, aes(x = grades_separated$Day)) + geom_bar()

#Q4. In which hour of the day did most students submit the solution?


table(grades_separated$Time1)

ggplot(grades_separated, aes(x = grades_separated$Time)) + geom_bar()


#Q5. If you plot the distribution of submissions by the hour, what can you observe?


grades_hours <- separate(data = grades_separated, col = Time,into = c("hours", "min", "sec"), sep = "\\:")
View(grades_hours)

ggplot(grades_hours, aes(x = grades_hours$hours)) + geom_bar()
