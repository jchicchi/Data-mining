# In-Class Assignment 18, Mar 29, 2017
# (deadline: Mar 29, 2017, 1:55pm)

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
# https://www.dropbox.com/request/WMfxq5482GxnVBCKKEZ0
# If you have submission problems, deleting cookies
# or changing browsers may help. Please do not submit late,
# as this is unfair towards your colleagues.

######################################################################

# Only provide code and comments, do not copy paste output.

# Topic:
# Random forest

# Subsequent questions may depend on previous ones, therefore
# work with your group through the questions one by one.

# Grading:
# There are 3 questions

######################################################################
######################################################################
######################################################################
######################################################################
# Question 1
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

#Tune (AUC) the number of variables randomly sampled as candidates at each split.
#Try these values: 1:7. Plot the parameter values on the x-axis and the AUC on the y-axis.
#Answer:

library(randomForest)
library(AUC)

#mtry
auc <- numeric()
for (i in 1:7){
  rf <- randomForest(x=train,y=ytrain, mtry=i)
  predtree <- as.numeric(predict(rf,val,type="prob")[,2])
  (auc[i] <- auc(roc(predtree,yval)))
  print(i)
}
plot(1:7, auc, type='l', xlab='mtry')


######################################################################
# Question 2
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

#Tune (AUC) the maximum number of terminal nodes trees in the forest can have. 
#Try these values: 2:100. Plot the parameter values on the x-axis and the AUC on the y-axis.
#Answer:

auc <- numeric()
ii <- 0
sequence <- 2:100
for (i in sequence){
  ii <- ii + 1
  rf <- randomForest(x=train,y=ytrain, maxnodes=i)
  predtree <- as.numeric(predict(rf,val,type="prob")[,2])
  (auc[ii] <- auc(roc(predtree,yval)))
  print(ii)
}
plot(1:length(sequence), auc, type='l', xaxt='n', xlab='maxnodes')
axis(1,at=1:ii,labels=sequence)

######################################################################
# Question 3
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
# The steps outlined below will help you answer the question (called research question below):
# Is it a good idea to discard predictions if there is a lot of variance in 
# the member predictions? With that I mean, if there is a lot of diversity among the individual 
# predictions of the trees, does that mean we have a bad prediction for that instance,
# and should we then not use these predictions?
# Step 1: Find a way to extract the predictions per tree in the forest.
# Step 2: Compute the variance across the trees, for each instance. Call it variance.
# Step 3: Compute the absolute difference between the ensemble prediction (prob) and y. Call it error.
# Step 4: Plot variance and error, and compute the correlation.
# Step 5: Anser the research question with yes or no.
# Answer:

# Step 1
rf <- randomForest(x=train,y=ytrain)
?predict.randomForest
predtree <- predict(rf,test,type="prob", predict.all=TRUE)$individual
#Look at result
str(predtree)
predtree[1:10,1:10]

# Step 2:
variance <- apply(predtree,1,var)
#or
variance <- apply(predtree,1,function(x) mean(as.numeric(x))*(1-mean(as.numeric(x))))
hist(variance)

#Step 3:
predtree <- predict(rf,test,type="prob", predict.all=FALSE)[,2]
error <- abs(predtree - as.numeric(as.character(ytest)))

# Step 4
plot(variance, error)
cor(variance, error)

# Step 5
# no
