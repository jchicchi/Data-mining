# At-Home Exercises 14, Mar 8, 2017

# If you choose to submit these exercises:

# FIRST Write down your name:
# First name:
# Last name:

# SECOND Change the name of your file to
# firstname_lastname.R
# That is the file you need to submit.

# THIRD Save your answers in this file and submit it 
# before 11:40am to this url:
# https://www.dropbox.com/request/oD7YcUzHcMZIrWXs2PyQ

# Only provide code and comments, do not copy paste output.

# Topic:
# Neural Networks

# Subsequent questions may depend on previous ones.

# Grading:
# There is 1 question

# Only provide code and comments, do not copy paste output.
# There is one question.

######################################################################
######################################################################
######################################################################
######################################################################
# Exercise 1: 
# Consider the neural network in Figure 2.8 in the book. I have trained 
# that network and I have copied the weights and biases below:

w1 <- -0.5
w2 <- -0.2
w3 <- +0.3
w4 <- +0.2
w5 <- +0.4
w6 <- -0.1
w7 <- +0.2
w8 <- +0.4
b1 <- 1.5
b2 <- 0.5
b3 <- -1.1

# Now consider a new instance with the following values:

x1 <-2.2
x2 <-1.3
y <-1

# Assume the following value for lambda in the objective function:
lambda<-0.1

# a. Compute the value of y-hat for the single new instance
# b. Compute the value of the objective function for the single new instance
# (assuming the network would have been trained on this instance)

# Answer:

# a. y-hat:
x0 <- 1

#Compute x3, x4  and yhat

z3 <- w1*x1 + w3*x2 + b1*x0
(x3 <- 1/(1+exp(-z3)))

z4 <- w2*x1 + w4*x2 + b2*x0
(x4 <- 1/(1+exp(-z4)))

z <- w7*x1 + w5*x3 + w8*x2 +w6*x4 + b3*x0
(y_hat <- 1/(1+exp(-z)))
# Value of y-hat:
# 0.5192904

#b. Objective function:
      
E <- - y*log(y_hat) + (1-y) * log(1-y_hat)
regterm <- (lambda/2) * sum(c(w1,w2,w3,w4,w5,w6,w7,w8)^2)
E+regterm
# Value of the objective function:
# 0.6947919


