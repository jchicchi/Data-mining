# At-Home Exercises 2, Jan 23, 2017

# If you choose to submit these exercises:

# FIRST Write down your name:
# First name:
# Last name:

# SECOND Change the name of your file to
# firstname_lastname.R
# That is the file you need to submit.

# THIRD Save your answers in this file and submit it 
# before 11:40am, Jan 18 to this url:
# https://www.dropbox.com/request/M0f1YRkJ8JHuBxu7VIQV

# Only provide code and comments, do not copy paste output.

# Topic:
# Subsetting

# Subsequent questions may depend on previous ones.

# Grading:
# Each question has equal weight

######################################################################
# Exercise 1:
# Consider the following numeric vector. Extract the fifth element 
# and print it to the screen.
(num_vector <- as.numeric(seq(from=1,to=2,by=0.1)))
# Answer:

num_vector[5]

######################################################################
# Exercise 2
# Using the same vector as in the previous exercise, 
# extract the third to 9th element. 
#Answer:

num_vector[3:9]


######################################################################
# Exercise 3
# Using the same vector as in the previous exercise, extract the 
# elements 1,4,5,6,7, and 9.
#Answer:

num_vector[c(1,4:7,9)]


######################################################################
# Exercise 4
# Using the same vector as in the previous exercise, extract all 
# elements but elements 5 and 8.
#Answer:

num_vector[-c(5,8)]

######################################################################
# Exercise 5
# Consider the following data frame. Extract the second column 
# and print it to the screen. Find four ways to do it.
(df <- data.frame(A=1:5,B=letters[1:5],C=seq(1.1,1.5,0.1)))
#Answer:

df$B
df[,2]
df[,"B"]
df[,c(FALSE,TRUE,FALSE)]