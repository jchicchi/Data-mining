# At-Home Exercises 16, Mar 22, 2017

# If you choose to submit these exercises:

# FIRST Write down your name:
# First name:
# Last name:

# SECOND Change the name of your file to
# firstname_lastname.R
# That is the file you need to submit.

# THIRD Save your answers in this file and submit it 
# before 11:40am to this url:
# https://www.dropbox.com/request/xhIu2obuwPtjpuBGOTyY

# Only provide code and comments, do not copy paste output.

# Topic:
# Decision Trees

# Subsequent questions may depend on previous ones.

# Grading:
# There is 1 question

# Only provide code and comments, do not copy paste output.
# There is one question.



######################################################################
# Exercise 1: 
#Run the following code:
source("http://ballings.co/hidden/aCRM/code/chapter2/read_data_sets.R")
trainind <- sample(1:nrow(BasetableTRAIN),10000,TRUE)
train <- BasetableTRAIN[trainind,]
ytrain <- yTRAIN[trainind]
valind <- sample(1:nrow(BasetableVAL),10000,TRUE)
val <-   BasetableVAL[valind ,]
yval <- yVAL[valind]
testind <-  sample(1:nrow(BasetableTEST),10000,TRUE)
test <- BasetableTEST[testind,]
ytest <- yTEST[testind]
rm(list=ls()[!ls() %in% c("train","ytrain","val","yval","test","ytest")])
ls()
# Consider the following model:
# node), split, n, loss, yval, (yprob)
#       * denotes terminal node
# 
# 1) root 10000 486 0 (0.95140000 0.04860000)  
#   2) TotalDiscount< 109.9136 9623 304 0 (0.96840902 0.03159098) *
#   3) TotalDiscount>=109.9136 377 182 0 (0.51724138 0.48275862)  
#     6) TotalDiscount>=146.6379 155  13 0 (0.91612903 0.08387097) *
#     7) TotalDiscount< 146.6379 222  53 1 (0.23873874 0.76126126) *

# For all test instances (use test set) compute the predicted probability manually using an approach such as in equation 2.32.
# Answer:

pred <- 0.03159098*ifelse(test$TotalDiscount< 109.9136,1,0)+
        0.08387097*ifelse(test$TotalDiscount>=109.9136 & test$TotalDiscount>=146.6379,1,0) +
        0.76126126*ifelse(test$TotalDiscount>=109.9136 & test$TotalDiscount< 146.6379,1,0)   
#OR SHORTER:
pred <- 0.03159098*ifelse(test$TotalDiscount< 109.9136,1,0)+
        0.08387097*ifelse(test$TotalDiscount>=146.6379,1,0) +
        0.76126126*ifelse(test$TotalDiscount>=109.9136 & test$TotalDiscount< 146.6379,1,0)   
