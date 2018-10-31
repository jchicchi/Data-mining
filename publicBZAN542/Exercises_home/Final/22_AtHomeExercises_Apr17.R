# At-Home Exercises 22, Apr 17, 2017

# Topic:
# Performance measures for binary classification models

######################################################################
######################################################################
######################################################################
######################################################################
# Exercise 1: 
# Consider the following prediction vector:
(pred <- runif(10))
# Compute the percentile ranks of pred.
# Answer:

rank(pred)/length(pred)

######################################################################
# Exercise 2: 
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

library(randomForest)
rf <- randomForest(y=ytrain, x= train)
predrf <- as.numeric(predict(rf,test,type="prob")[,2])
# Plot the sensitivity curve using percentile ranks and raw scores
# (Hint: ?sensitivity). Does using the percentile ranks result 
# in different curves?
# Answer:

plot(sensitivity(predrf,ytest))
plot(sensitivity(predrf,ytest,perc.rank=FALSE))
#Yes

