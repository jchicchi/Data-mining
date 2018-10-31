# In-Class Assignment 4, Jan 30, 2017

# Collaboration is a crucial component in the learning experience.
# Therefore, this Gradeable needs to be completed in class unless you have
# permission from the instructor to take it from home.

######################################################################

# To get started make sure you have Dropbox installed
# on your computer (https://www.dropbox.com/downloading). 
# The application should be up and running as indicated by a symbol
# of an opened box in the toolbar of your computer.

######################################################################

# FIRST
# Move this file to your Dropbox folder 
# immediately after downloading.

######################################################################

# SECOND Change the name of your file to your group ID like
# Group_x.R
# Examples: Group_001.R, Group_020.R
# This is the file you need to submit.
# If, and only if, you are making the Gradeable alone, 
# name it like: firstname_lastname.R

######################################################################

# THIRD Open the file and make sure that each time 
# you save your file, your file is synced to Dropbox. 
# In case of a crash or other computer problems you will 
# be able to access your file from another computer.

######################################################################

# FOURTH Write down the first and last names of your group members, 
# including yourself:
#
# Your name (1):
# Other group member name (2):
# Other group member name (3):
# Other group member name (4):

######################################################################

# FIFTH Save your answers in this file and submit it 
# (one file per group) before 1:55pm to this url:
# https://www.dropbox.com/request/xWwfTU0kaHXHcJgX4Fo8
# If you have submission problems, deleting cookies
# or changing browsers may help. Please do not submit late,
# as this is unfair towards your colleagues.

######################################################################

# Only provide code and comments, do not copy paste output.

# Topic:
# Data Exploration

# Subsequent questions may depend on previous ones, therefore
# work with your group through the questions one by one.

# Grading:
# There are 16 questions, and each question gets you 10 points.
# After all questions are graded the total will be rescaled to 
# to 100, and entered in the gradebook.



######################################################################
# Before you start:
# You will need this dataset for the exercises:

subs <- read.table("http://ballings.co/hidden/aCRM/data/chapter2/subscriptions.txt",
                   header=TRUE, sep=";")


######################################################################
# Exercise 4:
# How many rows and columns does subs have? Give three solutions.
# Answer:

dim(subs)
nrow(subs);ncol(subs)
str(subs)

######################################################################
# Exercise 5:
# Print the first and last row of subs to the screen.
# Answer:

head(subs,n=1)
tail(subs,n=1)
# OR
subs[1,]
subs[nrow(subs),]

######################################################################
# Exercise 6:
# Confirm that a has 1000 values
a <- as.character(1:1000)
# Answer:

length(a)


######################################################################
# Exercise 7:
# What are the names of the rows of the subs table
# Answer:

rownames(subs)

######################################################################
# Exercise 8:
# Compute the proportions of the values 
# (i.e., % of occurrence of each unique value) 
# in the TotalCredit variable of the subs table.
# Make sure the number of NAs are also display if there
# are any.
# Answer:

table(subs$TotalCredit,useNA="ifany")/length(subs$TotalCredit)

######################################################################
# Exercise 9:
# Compute the minimum, maximum, quartiles, and mean of the TotalCredit
# variable.
# Answer:

summary(subs$TotalCredit)

######################################################################
# Exercise 10:
# What is the mean of FormulaDiscount?
# Answer:

mean(subs$FormulaDiscount, na.rm=TRUE)

######################################################################
# Exercise 11:
# What is the range of FormulaDiscount?
# Answer:

range(subs$FormulaDiscount,na.rm=TRUE)

######################################################################
# Exercise 12:
# Remove rows 10 to 85 from the subs data frame.
# What is the variance of TotalPrice after having them removed?
# Answer:

var(subs[-c(10:85),]$TotalPrice,na.rm=TRUE)



######################################################################
# Exercise 13:
# Using code, determine which variables are numeric. Use sapply.
# Answer:

sapply(subs,is.numeric)
 
#better:
colnames(subs)[sapply(subs,is.numeric)] #note that is.numeric is a test to denote whether
                                        #a vector can be interpreted as a number (class integer or numeric)
                                        #is.numeric() tests the mode, and not the class
                                        #(see ?is.numeric)
                                        #this is usually what we want, but if you strictly want numeric class vectors
                                        #and exclude integer class vectors then use the following:
colnames(subs)[which(sapply(subs,class) == "numeric")] #if you want to work with class instead of mode
                                                       #i.e., exclude integers

#As a general note, an object has a class, mode and type
#class (class()) is used to define an object from the point of view of object-oriented programming
#type (typeof()) is used to define an object from R's point of view
#mode (mode()) is was used in S (precursor of R) to define an object from Becker, Chambers & Wilks (1988) point of view

#We are only concerned with class

######################################################################
# Exercise 14:
# What is the standard deviation of TotalPrice?
# Answer:

sd(subs$TotalPrice,na.rm=TRUE)

######################################################################
# Exercise 15: 
# Make a scatter plot of TotalDiscount (x-axis) and NetNewspaperPrice 
# (y-axis). Add a regression line to the plot.
# Answer:

plot(subs$TotalDiscount,subs$NetNewspaperPrice)
abline(lm(NetNewspaperPrice ~ TotalDiscount, subs))

######################################################################
# Exercise 16: 
# How many missing values are there in total in the subs data frame?
# How many values are non-missing?
# Answer:

# Missing:
sum(is.na(subs))

# Not missing:
sum(!is.na(subs))
# Long way is very inefficient:
ncol(subs)*nrow(subs)-sum(is.na(subs))

######################################################################
# Exercise 17: 
# What are the main sections in help files? Go to the nrow() helpfile
# and write down the main section titles.
# Answer:

# Description
# Usage
# Arguments
# Value
# References
# See Also
# Examples

######################################################################
# Exercise 18: 
# What does the Value section describe (I am not asking what is in that
# section of the nrow() function)? 
# Answer:

# Whatever the function will return when you run it.

######################################################################
# Exercise 19: 
# What is the correlation between NbrStart and FormulaDiscount?
# Answer:

cor(subs$NbrStart[!is.na(subs$FormulaDiscount)],
    subs$FormulaDiscount[!is.na(subs$FormulaDiscount)])
#or
cor(subs$NbrStart,
    subs$FormulaDiscount, use='complete.obs')
