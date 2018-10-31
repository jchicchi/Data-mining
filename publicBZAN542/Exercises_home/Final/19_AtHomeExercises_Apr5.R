# At-Home Exercises 19, Apr 5, 2017

# If you choose to submit these exercises:

# FIRST Write down your name:
# First name:
# Last name:

# SECOND Change the name of your file to
# firstname_lastname.R
# That is the file you need to submit.

# THIRD Save your answers in this file and submit it 
# before 11:40am to this url:
# https://www.dropbox.com/request/2nsHoFA5z6qsdiriwDgM

# Only provide code and comments, do not copy paste output.

# Topic:
# Boosting

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
#Grow a boosting model with 1000 trees and plot the learning curves.
#Make predictions, and assess the final model performance.
#Answer:

#load the package ada
if(require('ada')==FALSE)  {
  install.packages('ada',
                   repos="https://cran.rstudio.com/", 
                   quiet=TRUE) 
  require('ada')
}

if(require('AUC')==FALSE)  {
  install.packages('AUC',
                   repos="https://cran.rstudio.com/", 
                   quiet=TRUE) 
  require('AUC')
}


#plotting learning curve
ABmodel <- ada(x=train,
               y=ytrain,
               test.x=val,
               test.y=yval,
               iter=1000)
plot(ABmodel,test=TRUE)

predAB <- as.numeric(predict(ABmodel,
                            test,
                            type="probs")[,2])
auc(roc(predAB,ytest))
