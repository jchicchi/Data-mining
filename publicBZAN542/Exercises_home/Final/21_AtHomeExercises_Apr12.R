# At-Home Exercises 21, Apr 12, 2017

# If you choose to submit these exercises:

# FIRST Write down your name:
# First name:
# Last name:

# SECOND Change the name of your file to
# firstname_lastname.R
# That is the file you need to submit.

# THIRD Save your answers in this file and submit it 
# before 11:40am to this url:
# https://www.dropbox.com/request/bhsSokJOWL0mF75KRNEa

# Only provide code and comments, do not copy paste output.

# Topic:
# Rotation forest

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
#Run the following code:
source("http://ballings.co/hidden/aCRM/code/chapter2/read_data_sets.R")
train <- BasetableTRAIN
ytrain <- yTRAIN
val <-   BasetableVAL
yval <- yVAL
test <- BasetableTEST
ytest <- yTEST
rm(list=ls()[!ls() %in% c("train","ytrain","val","yval","test","ytest")])
ls()
# Step 1: 
# Find the optimal L (1:100) on the validation set. 
# Store the rotation forest models in a list and store the auc on the validation
# set in a numeric vector. You will have a list
# with 100 models, and a vector with 100 auc values.

# Step 2: 
# Plot the auc values.
# What can you conclude from your plot: 
# Q1: What is a good value for L if you would use the stored models?
# Q2: What is a good value for L if you would have to reestimate the model (i.e., you would not have stored the models)?

#Step 3:
# Predict on the test set using your best stored model.
# Calculate the auc.

# Answer:


# Step 1:
#load the package AUC to evaluate model performance
if(require('AUC')==FALSE)  {
  install.packages('AUC',
                   repos="https://cran.rstudio.com/", 
                   quiet=TRUE) 
  require('AUC')
}

#load the package ada
if(require('rotationForest')==FALSE)  {
  install.packages('rotationForest',
                   repos="https://cran.rstudio.com/", 
                   quiet=TRUE) 
  require('rotationForest')
}

#Step 1
RoF <- list()
aucstore <- numeric(100)
for (L in 1:100) {
  RoF[[L]] <- rotationForest(x=train,
                        y=as.factor(ytrain),
                        L=L)
  predRoF <- predict(RoF[[L]] ,
                     val)

  aucstore[L] <- AUC::auc(roc(predRoF,yval))
  print(L)
}

#Step 2
plot(1:100,aucstore, type='l')


# Q1: what is a good value for L if you would use the stored models?

# When looking at the plot, use the L with the highest auc value, even if it is an outlier.
which.max(aucstore)

# Q2: what is a good value for L if you would have to reestimate the model (i.e., you would not have stored the models)?

# Look at the trend of the plot (do not consider variation around the trend) and try to determine a good value.
# There is a big jump at 5-10 trees. It makes sense to use 10 trees if computational efficiency is an issue.
# If computational efficiency is not an issue, then more trees is better (in this case 100)

# Note: we look at the trend, because there is randomization involved in the algorithm.
# Only the trend will be reproduced when we reestimate the models, and the variation around the trend will be different.

#Step 3
predRoF <- predict(RoF[[which.max(aucstore)]],
                  test)

AUC::auc(roc(predRoF,ytest))
 

