# In-Class Assignment 21, Apr 12, 2017

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
# https://www.dropbox.com/request/n3HutE58csw7KPYmgHxH
# If you have submission problems, deleting cookies
# or changing browsers may help. Please do not submit late,
# as this is unfair towards your colleagues.

######################################################################

# Only provide code and comments, do not copy paste output.

# Topic:
# Rotation Forest

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
# Step 1: 
# Store the auc values on the validation set for all combinations of K (choose sensible values) and L (1:20). 

# Step 2: 
# Plot the auc values, with L on the x-axis and for each K a line.
# What can you conclude from your plot?

# Step 3:
# Predict on the test set using the optimal parameter values.
# Calculate the auc.
# Answer:

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
i <- 0
aucstore <- data.frame(matrix(ncol=3,nrow=60))
colnames(aucstore) <- c('K','L','AUC')
for (L in 1:20) {
  for (K in 1:3){
      i <- i + 1
      RoF[[i]] <- rotationForest(x=train,
                            y=as.factor(ytrain),
                            L=L,
                            K=K)
      predRoF <- predict(RoF[[i]] ,
                         val)
    
      aucstore[i,] <- c(K,L,AUC::auc(roc(predRoF,yval)))
      print(i)
  }
}

#Step 2
plot(aucstore$L[aucstore$K==1],aucstore$AUC[aucstore$K==1], type='l', ylim=c(min(aucstore$AUC),max(aucstore$AUC)))
lines(aucstore$L[aucstore$K==2],aucstore$AUC[aucstore$K==2], type='l', lty=2)
lines(aucstore$L[aucstore$K==3],aucstore$AUC[aucstore$K==3], type='l', lty=3)

# Higher L is better
# K does not seem to matter


#Step 3
#Note you can grow the forest on train or train and val
RoF <- rotationForest(x=rbind(train,val),
                      y=as.factor(c(as.integer(as.character(ytrain)),as.integer(as.character(yval)))),
                      L=aucstore$L[which.max(aucstore$AUC)],
                      K=aucstore$K[which.max(aucstore$AUC)])
predRoF <- predict(RoF,
                   test)
AUC::auc(roc(predRoF,ytest))