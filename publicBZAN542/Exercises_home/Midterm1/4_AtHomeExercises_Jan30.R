# At-Home Exercises 4, Jan 30, 2017

# If you choose to submit these exercises:

# FIRST Write down your name:
# First name:
# Last name:

# SECOND Change the name of your file to
# firstname_lastname.R
# That is the file you need to submit.

# THIRD Save your answers in this file and submit it 
# before 11:40am, Jan 30 to this url:
# https://www.dropbox.com/request/BeFqVubc97KJH8UcGXdc

# Only provide code and comments, do not copy paste output.

# Topic: 
# data exploration

# Subsequent questions may depend on previous ones.

# Grading:
# Each question has equal weight, there are 3 questions


######################################################################
# Before you start:
# You will need this dataset for the exercises:

subs <- read.table("http://ballings.co/hidden/aCRM/data/chapter2/subscriptions.txt",
                   header=TRUE, sep=";")

######################################################################
# Exercise 1:
# What is the class of subs? 
# Answer:

# The Value section in ?read.table states that the subs will be 
# a data.frame. We can confirm that as follows:
class(subs)
#or 
str(subs)
# Yes it is a data.frame.

######################################################################
# Exercise 2:
# Print subs compactly to the screen.  
# Display variable names, their type, and a few examples of their values.
# Answer:

str(subs)

######################################################################
# Exercise 3:
# We have briefly touched upon sapply(). 
# Read up on the first two arguments in the sapply documentation
# and use sapply() to provide the min, quartiles, mean, and max of
# the following variables: TotalDiscount, TotalPrice, TotalCredit. 
# This is what you should get:

#         TotalDiscount TotalPrice TotalCredit
# Min.            0.000        0.0    -123.000
# 1st Qu.         0.000       79.0       0.000
# Median          0.000      148.0       0.000
# Mean            7.744      163.1      -1.073
# 3rd Qu.         0.000      267.0       0.000
# Max.          129.000      274.4       0.000
# NA's           10.000       10.0      10.000

# Answer:

sapply(subs[,19:21],summary)

#you can also use summary() on a data frame directly, but then it shows
#us superfluous information:
summary(subs[,19:21])
