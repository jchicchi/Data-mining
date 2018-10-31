# In-Class Assignment 20, Apr 10, 2017

# Collaboration is a crucial component in the learning experience.
# Therefore, this assignment needs to be completed in class unless you have
# permission from the instructor to take it from home.

######################################################################

# To get started make sure you have Dropbox installed
# on your computer (https://www.dropbox.com/downloading). 
# The application should be up and running as indicated by a symbol
# of an opened box in the toolbar of your computer.

######################################################################

# FIRST
# Move this file to your Dropbox folder 
# immediately after downloading.

######################################################################

# SECOND Change the name of your file to your group ID like
# Group_x.R
# Examples: Group_001.R, Group_020.R
# This is the file you need to submit.
# If, and only if, you are making the Gradeable alone, 
# name it like: firstname_lastname.R

######################################################################

# THIRD Open the file and make sure that each time 
# you save your file, your file is synced to Dropbox. 
# In case of a crash or other computer problems you will 
# be able to access your file from another computer.

######################################################################

# FOURTH Write down the first and last names of your group members, 
# including yourself:
# 
# Your name (1):
# Other group member name (2):
# Other group member name (3):
# Other group member name (4):

######################################################################

# FIFTH Save your answers in this file and submit it 
# (one file per group) to this url:
# https://www.dropbox.com/request/xSJZ03WPY9VjLE5xz88s
# If you have submission problems, deleting cookies
# or changing browsers may help. Please do not submit late,
# as this is unfair towards your colleagues.

######################################################################

# Only provide code and comments, do not copy paste output.

# Topic:
# SVM

# Subsequent questions may depend on previous ones, therefore
# work with your group through the questions one by one.

# Grading:
# There is 1 question

######################################################################
######################################################################
######################################################################
######################################################################
# Question 1
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
#Step 1:
#Cross validate C and gamma when using a radial basis kernel.
#Build a grid (data frame) that shows the AUC in the cells, with in the
#columns gamma and in the rows C. Print that grid to the screen.
#Step 2:
#Select the best combination of gamma and C and build your final svm.
# Sep 3:
#Compute the final AUC
# Answer

#Step 1

if (require("e1071")==FALSE) {
  install.packages("e1071",
                   repos="https://cran.rstudio.com/", 
                   quiet=TRUE)  
  require(e1071)
}
#load the package AUC to evaluate model performance
if(require('AUC')==FALSE)  {
  install.packages('AUC',
                   repos="https://cran.rstudio.com/", 
                   quiet=TRUE) 
  require('AUC')
}

SV.cost <-  2^(-5:13)
SV.gamma <- 2^(-15:3)

aucstore <- data.frame(matrix(NA,ncol=length(SV.gamma),nrow=length(SV.cost)))
for (i in 1:length(SV.cost) ) {
  for (j in 1:length(SV.gamma) ) {
    
    SV <- svm(as.factor(ytrain) ~ ., 
              data = train,
              type = "C-classification", 
              kernel = "radial", 
              cost = SV.cost[i], 
              gamma = SV.gamma[j], 
              probability=TRUE)
                
    predSV <- as.numeric(attr(predict(SV,val, probability=TRUE),"probabilities")[,"1"])
    
    aucstore[i,j] <- AUC::auc(roc(predSV,yval))
    

  }
}

aucstore

#Step 2:
(ind <- which(as.matrix(aucstore)==max(aucstore), arr.ind=TRUE))

BestC <- SV.cost[ind[1]]
BestGamma <- SV.gamma[ind[2]]

# Step 3:
#now predict using these optimal parameters
#use train + val if you want
SV <- svm(as.factor(ytrain) ~ ., 
              data = train,
              type = "C-classification", 
              kernel = "radial", 
              cost = BestC, 
              gamma = BestGamma, 
              probability=TRUE)
                
#Compute the predictions for the test set
predSV <- as.numeric(attr(predict(SV,test, probability=TRUE),"probabilities")[,"1"])
    
#Final performance
AUC::auc(roc(predSV,ytest))
