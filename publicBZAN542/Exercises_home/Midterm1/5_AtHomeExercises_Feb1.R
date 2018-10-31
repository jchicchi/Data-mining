# At-Home Exercises 5, Feb 1, 2017

# If you choose to submit these exercises:

# FIRST Write down your name:
# First name:
# Last name:

# SECOND Change the name of your file to
# firstname_lastname.R
# That is the file you need to submit.

# THIRD Save your answers in this file and submit it 
# before 11:40am, Feb 1 to this url:
# https://www.dropbox.com/request/iElKx1vBpjQULFKnFey1

# Only provide code and comments, do not copy paste output.

# Topic: 
# Installing and loading packages, missing valuesm, getting help,
# time window, code flowchart

# Subsequent questions may depend on previous ones.

# Grading:
# Each question has equal weight, there are 3 questions



######################################################################
# Exercise 1:
# Install the package called nnet. Provide two ways to load the package
# while storing TRUE or FALSE in a variable called a to denote if loading
# the package was successful or not.
# Answer:

install.packages("nnet")
(a <- library(nnet, logical.return=TRUE))
(a <- require(nnet))

######################################################################
# Exercise 2:
# Load the package called ada, but make sure your code first installs
# the package if, and only if, it is not already installed.
# Answer:

if (!require(ada)){
  install.packages("ada")
  require(ada)
}

######################################################################
# Exercise 3:
# We want to determine if today is a weekend day.
# We found a function that does just that in the chron package
# Select the following two lines of code and run them
install.packages("chron"); require(chron)
is.weekend(Sys.Date())
# Next we install and load the tseries package as follows:
install.packages("tseries"); require(tseries)
# After a while we want to use our function again, but there 
# is an error. What is going on here, and how can we avoid this
# without unloading any packages or restarting R?
is.weekend(Sys.Date())
# Answer:

# Package tseries has as function with exactly the same name.
# Solution:
chron::is.weekend(Sys.Date())


