# At-Home Exercises 13, Mar 6, 2017

# If you choose to submit these exercises:

# FIRST Write down your name:
# First name:
# Last name:

# SECOND Change the name of your file to
# firstname_lastname.R
# That is the file you need to submit.

# THIRD Save your answers in this file and submit it 
# before 11:40am to this url:
# https://www.dropbox.com/request/o7LknLqeZNZp7F1vdsSx

# Only provide code and comments, do not copy paste output.

# Topic:
# Logistic regression

# Subsequent questions may depend on previous ones.

# Grading:
# Each question has equal weight, there is 1 question

# Only provide code and comments, do not copy paste output.
# There is one question.

######################################################################
# Exercise 1:
# Consider three instances. The values for the dependent variable are 1, 0, 1.
# We have estimated a logistic regression model, and made a prediction for these 
# instances. The predictions are 0.5, 0.1, and 0.95.
# What is the joint log likelihood for these three instances?
# The result should be one value.
# Answer:

loglikelihood <- function(y_i,Px_i) y_i * log(Px_i) + (1-y_i)*log(1-Px_i)
loglikelihood(y_i= 1,Px_i= 0.5) + loglikelihood(y_i= 0,Px_i= 0.1) + loglikelihood(y_i= 1,Px_i= 0.95)
