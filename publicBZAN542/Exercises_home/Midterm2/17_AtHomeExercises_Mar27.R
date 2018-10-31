# At-Home Exercises 17, Mar 27, 2017

# If you choose to submit these exercises:

# FIRST Write down your name:
# First name:
# Last name:

# SECOND Change the name of your file to
# firstname_lastname.R
# That is the file you need to submit.

# THIRD Save your answers in this file and submit it 
# before 11:40am to this url:
# https://www.dropbox.com/request/2JVpfRPZELmCym1t632A

# Only provide code and comments, do not copy paste output.

# Topic:
# Bagged trees

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
# Step 1: Create a plot with on the y-axis the AUC on the validation set and on the 
# x-axis (from 1 to 500) the number of trees used in a bagged tree model. 
# The first x-value corresponds to using the first tree only,
# the second value corresponds to using the firsts two trees, the third value corresponds
# to using the first three trees, ... , the 500th value corresponds to using all 500 trees.
# Step 2: Determine the optimal number of trees in the bagged tree ensemble in terms of AUC.
# Step 3: Make a prediction on the test set using the optimal number of trees and compute the AUC

# Your code should not use any hardcoding. If you run the code twice, the
# optimal number of trees will likely be different because of the randomization in the boostraps. 
# Your code should be able to handle that.
# Your code should not take longer than 10 minutes in total
# Answer:

# Step 1:

#load the package AUC to evaluate model performance
if(require('AUC')==FALSE)  {
  install.packages('AUC',
                   repos="https://cran.rstudio.com/", 
                   quiet=TRUE) 
  require('AUC')
}

#load the package rpart to create decision  trees
if(require('rpart')==FALSE)  {
  install.packages('rpart', 
                   repos="https://cran.rstudio.com/", 
                   quiet=TRUE)
  require('rpart')
}

ensemblesize <- 500

ensembleoftrees <- vector(mode='list',length=ensemblesize)

for (i in 1:ensemblesize){
    bootstrapsampleindicators <- sample.int(n=nrow(train),
                                           size=nrow(train),
                                           replace=TRUE)
    ensembleoftrees[[i]] <- rpart(ytrain[bootstrapsampleindicators] ~ .,
                                  train[bootstrapsampleindicators,])
    print(i)
}


baggedpredictions <- data.frame(matrix(NA,ncol=ensemblesize,
                                      nrow=nrow(val)))

for (i in 1:ensemblesize){
  
  baggedpredictions[,i] <- as.numeric(predict(ensembleoftrees[[i]],
                                              val)[,2])
  print(i)
}

aucstore <- numeric(ncol(baggedpredictions))
for (i in 1:ncol(baggedpredictions)){
  finalprediction <- rowMeans(baggedpredictions[,1:i,drop=FALSE])
  aucstore[i] <- AUC::auc(roc(finalprediction,yval))
  print(i)
}

plot(aucstore, type="l")

# Step 2:

optimal_nbr_trees <- which.max(aucstore)

# Step 3:

baggedpredictions <- data.frame(matrix(NA,ncol=optimal_nbr_trees,
                                      nrow=nrow(test)))

for (i in 1:optimal_nbr_trees){
  
  baggedpredictions[,i] <- as.numeric(predict(ensembleoftrees[[i]],
                                              test)[,2])
  print(i)
}


finalprediction <- rowMeans(baggedpredictions)
AUC::auc(roc(finalprediction,ytest))

