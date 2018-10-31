# At-Home Exercises 8, Feb 13, 2017

# If you choose to submit these exercises:

# FIRST Write down your name:
# First name:
# Last name:

# SECOND Change the name of your file to
# firstname_lastname.R
# That is the file you need to submit.

# THIRD Save your answers in this file and submit it 
# before 11:40am, Feb 13 to this url:
# https://www.dropbox.com/request/0iXnqscOJVRjAoJ34C0Q

# Only provide code and comments, do not copy paste output.

# Topic:
# Applying functions to lists
# Aggregating
# Merging

# Subsequent questions may depend on previous ones.

# Grading:
# Each question has equal weight, there are 2 questions

######################################################################
# Exercise 1:
# Consider the following list with 4 data frames
l <- list(
  data.frame(matrix(runif(25),nrow=5,ncol=5)),
  data.frame(matrix(runif(25),nrow=5,ncol=5)),
  data.frame(matrix(runif(25),nrow=5,ncol=5)),
  data.frame(matrix(runif(25),nrow=5,ncol=5)))
str(l)
# Stack (put one on top of the other) the data frames. 
# Make your code as short as possible.
#Answer
do.call(rbind,l)
######################################################################
# Exercise 2:
# Using the same list as in exercise 1,
# compute the variance of each column in each 
# data frame.
# Answer:
lapply(l,function(x) sapply(x,var))





