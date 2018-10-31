# At-Home Exercises 18, Mar 29, 2017

# If you choose to submit these exercises:

# FIRST Write down your name:
# First name:
# Last name:

# SECOND Change the name of your file to
# firstname_lastname.R
# That is the file you need to submit.

# THIRD Save your answers in this file and submit it 
# before 11:40am to this url:
# https://www.dropbox.com/request/asFAX25ucWNRqBQgVzr2

# Only provide code and comments, do not copy paste output.

# Topic:
# Random forest

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
#Step 1: Grow a single decision tree on the training set
# and predict and evaluate the model on the test set
#Step 2: Grow a bagged decision tree (500 trees) on the training set 
#and predict and evaluate the model on the test set
#Step 3: Grow a bagged decision tree (500 trees) and use for each tree
#a random subset of m features (where m=sqrt(p), with p the total number of variables)  
#on the training set
#and predict and evaluate the model on the test set
#Step 4: Grow a random forest (500 trees) on the training set,
#and predict and evaluate the model on the test set
#Step 5: Print the aucs of each step (auc on y-axis, step on x-axis)
# Answer:

library(AUC)

# Step 1:
library(rpart)
tree <- rpart(ytrain ~ ., train)
predtree <- as.numeric(predict(tree,test,type="prob")[,2])
(aucstep1 <- auc(roc(predtree,ytest)))

# Step 2:
tree <- list()
predtree <- matrix(0,ncol=500,nrow=nrow(test))
for (i in 1:500){
  ind <- sample(1:nrow(train),nrow(train),TRUE)
  tree[[i]] <- rpart(ytrain[ind] ~ ., train[ind,])
  predtree[,i] <- as.numeric(predict(tree[[i]],test,type="prob")[,2])
  print(i)
}
(aucstep2 <- auc(roc(rowMeans(predtree),ytest)))

# Step 3:
tree <- list()
predtree <- matrix(0,ncol=500,nrow=nrow(test))
for (i in 1:500){
  ind <- sample(1:nrow(train),nrow(train),TRUE)
  indcols <- sample(1:ncol(train),round(sqrt(ncol(train))),FALSE)
  tree[[i]] <- rpart(ytrain[ind] ~ ., train[ind,indcols])
  predtree[,i] <- as.numeric(predict(tree[[i]],test,type="prob")[,2])
  print(i)
}
(aucstep3 <- auc(roc(rowMeans(predtree),ytest)))

# Step 4:
# Note that the main difference between step 3 and 4 
# is that in step 4 we use a random set of variables
# at each split.
library(randomForest)
rf <- randomForest(x=train,y=ytrain,ntree=500)
predtree <- as.numeric(predict(rf,test,type="prob")[,2])
(aucstep4 <- auc(roc(predtree,ytest)))

# Step 5:

plot(x=1:4,
     y=c(aucstep1,aucstep2,aucstep3,aucstep4),
     type="b",
     xaxt="n",
     ylab="auc",
     xlab="")
axis(1,1:4,c("Single \n tree","Bagged \n tree","Bagged tree \n (random features)","Random \n forest"), padj=1)
