# In-Class Assignment 5, Feb 1, 2017

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
# https://www.dropbox.com/request/fIo7q1pU0Ekan3PzIm0Z
# If you have submission problems, deleting cookies
# or changing browsers may help. Please do not submit late,
# as this is unfair towards your colleagues.

######################################################################

# Only provide code and comments, do not copy paste output.

# Topic:
# Installing and loading packages
# Missing value imputation
# Getting help
# Time window

# Subsequent questions may depend on previous ones, therefore
# work with your group through the questions one by one.

# Grading:
# There are 7 questions, and each question gets you 10 points.
# After all questions are graded the total will be rescaled to 
# to 100, and entered in the gradebook.


######################################################################
# Exercise 4:
# Provide three ways to get the version number of the chron package.
# Answer:

packageVersion("chron")
packageDescription("chron")
library(help=chron)

######################################################################
# Exercise 5:
# Consider the following matrix. How many NAs does each 
# column have?
b <- matrix(sample(c(1:10,NA),1000,TRUE),ncol=100)
# Answer:

colSums(is.na(b))
# OR
sapply(data.frame(is.na(b)),sum)

######################################################################
# Exercise 6:
# Consider traindata and newdata:
traindata <- data.frame(matrix(sample(c(1:100,NA),1000,TRUE),ncol=100))
newdata <- data.frame(matrix(sample(c(1:100,NA),1000,TRUE),ncol=100))
# Compute the missing values on traindata and impute them
# on newdata. Make sure to create indicators of which values in
# which variables were imputed.
# Answer:

library(imputeMissings)

values <- compute(traindata)
imputednewdata <- impute(newdata,object=values,flag=TRUE)
#Check
sum(is.na(newdata))
sum(is.na(imputednewdata))

######################################################################
# Exercise 7:
# This is an exercise on the "getting help" section and will reauire
# you to search for a solution.
# Draw a Cleveland Dot Plot of the following data
(a <- matrix(c(table(sample(1:10,1000,TRUE)),
             c(table(sample(1:10,1000,TRUE)))), ncol=2))
dimnames(a)[[2]] <- c("Series1","Series2")
a
# Series 1 should be on top, while series 2 should be in the 
# bottom of the dot plot. 
# Answer:

dotchart(a)

######################################################################
# Exercise 8:
# If t3=2016/01/01 and t4=2016/03/03 in estimation,
# and t3=2016/05/05 is deployment, what is t4 in deployment?
# To be able to do computations use the as.Date() function
# For example:
as.Date("2016/09/08") - as.Date("2016/09/07") 
# Answer:

(t3esti <- as.Date("2016/01/01") )
(t4esti <- as.Date("2016/03/03"))
(t3depl <- as.Date("2016/05/05"))
(t4depl <- t3depl + (t4esti-t3esti))
  
######################################################################
# Exercise 9:
# We are now 2016/09/07 (t2) and want to deploy our model
# as follows:
# t1: 2005/05/20
# t2: 2016/09/07 
# t3: 2016/09/08
# t4: 2017/09/08 
# How do we best train our model: what will the time window 
# be in the model estimation phase? In other words what is 
# t1, t2, t3, and t4 in model estimation?
# To be able to do computations use the as.Date() function
# For example:
as.Date("2016/09/08") - as.Date("2016/09/07") 
# Answer:

#Model deployment phase:
t1depl <- as.Date("2005/05/20")
t2depl <- as.Date("2016/09/07")
t3depl <- as.Date("2016/09/08")
t4depl <- as.Date("2017/09/08")

#Model estimation phase:
(t4esti <- t2depl)
(t3esti <- t4esti - (t4depl - t3depl))
(t2esti <- t3esti - (t3depl - t2depl))
(t1esti <- t2esti - (t2depl - t1depl))

######################################################################
# Exercise 10:
# Consider the following time window that was used in 
# the model estimation phase: 
# t1: 2001/01/01
# t2: 2013/12/27 
# t3: 2014/01/01
# t4: 2015/01/01 
# We are now 2015/02/01 and we want to deploy our model 
# immediately. What will the time window be in the model 
# deployment phase? In order words what is t1, t2, t3, and 
# t4 in model deployment?
# To be able to do computations use the as.Date() function
# For example:
as.Date("2015/01/01") - as.Date("2014/01/01") 
# Answer:

#Model estimation phase:
t1esti <- as.Date("2001/01/01")
t2esti <- as.Date("2013/12/27")
t3esti <- as.Date("2014/01/01")
t4esti <- as.Date("2015/01/01")

#Model deployment
now <- as.Date("2015/02/01")

(t2depl <- now)
(t3depl <- t2depl + (t3esti-t2esti))
(t4depl <- t3depl + (t4esti-t3esti))
(t1depl <- t2depl - (t2esti-t1esti))


