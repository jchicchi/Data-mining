# At-Home Exercises 6, Feb 6, 2017

# If you choose to submit these exercises:

# FIRST Write down your name:
# First name:
# Last name:

# SECOND Change the name of your file to
# firstname_lastname.R
# That is the file you need to submit.

# THIRD Save your answers in this file and submit it 
# before 11:40am, Feb 6 to this url:
# https://www.dropbox.com/request/KLiFGwvngk0YuHCg08VR

# Only provide code and comments, do not copy paste output.

# Topic: 
# Operators
# Dummy variables
# Conditional processing

# Subsequent questions may depend on previous ones.

# Grading:
# Each question has equal weight, there are 3 questions


######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
# Important note before you start.
# 
# When I provide small toy objects (e.g., vectors), such as
# x <- 1:5, I do this to make your life easy so you can check 
# the result of your code easily. It should be obvious that
# your code should work on larger objects with random values.
# 
# The data can always change, as follows:
#   -number of values can change, but object type (vector, matrix, data frame, list) will remain the same
#   -values can change but will remain of same type and will have 
#    the same range
# Your code should be able to handle those changes.

# For example, if I give you this vector:
(x <- c(1,2,2,5,4))
# and ask you to write some code, it should also work on
(x <- sample(1:5,2000,TRUE))
# Note that the length has changed from 5 to 2000, but 
# the object type is still a vector. Note that the values
# have changed, but are still integers, and still have range [1,5].

######################################################################
# Exercise 1:
# Figure out what is wrong here and correct the code.
x <- 5
if (x=5) "x is 5"
# Answer:
if (x==5) "x is 5"

######################################################################
# Exercise 2:
# Consider x. We want to see a TRUE when x equals NA and a FALSE when
# x does not equal NA.
x <- c(1,3,NA,35,NA,5,1,6,NA)
# Answer:

is.na(x)
# Note that you cannot use x==NA because NA is non-comparable.

######################################################################
# Exercise 3:
# Consider x. When does x equal 4 or 6? Return a boolean vector.
(x <- 1:10)
# Answer:

x==4 | x==6
#or
x %in% c(4,6)

#Note that you cannot do 
# x == 4 | 6 
# or
# x == (4 | 6)

