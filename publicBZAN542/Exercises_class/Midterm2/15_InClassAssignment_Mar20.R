# In-Class Assignment 15, Mar 20, 2017
# (deadline: Mar 22, 2017, 12:40pm)

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
# https://www.dropbox.com/request/eW2fc3c5cq6Oks4dETx6
# If you have submission problems, deleting cookies
# or changing browsers may help. Please do not submit late,
# as this is unfair towards your colleagues.

######################################################################

# Only provide code and comments, do not copy paste output.

# Topic:
# K-Nearest Neighbors

# Subsequent questions may depend on previous ones, therefore
# work with your group through the questions one by one.

# Grading:
# There are 2 questions, and each question gets you 10 points.
# After all questions are graded the total will be rescaled to 
# to 100, and entered in the gradebook.

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
# The goal is to make predictions using a KNN model for all test instances.
# Step 1: Determine the optimal k (1,20, 40,..., 2001) using train, ytrain, val and yval 
# (depending on your computer step 1 can take a while, e.g., 15 min)
# Step 2: Make predictions for all instances in test by selecting the k nearest neighbors out of train + val + ytrain + yval using the optimal k 
# Step 3: Assess the performance by computing the auc
# Note: remember to standardize the predictors.
# Answer:

if (!require("AUC")) {
  install.packages('AUC',
                   repos="https://cran.rstudio.com/", 
                   quiet=TRUE) 
  require('AUC')
}

#Fast Nearest Neighbor Search Algorithms and Applications
if (!require("FNN")) {
  install.packages('FNN',
                   repos="https://cran.rstudio.com/", 
                   quiet=TRUE) 
  require('FNN')
}

#Combine train and val
trainval <- rbind(train,val)
ytrainval <- c(as.integer(as.character(ytrain)),as.integer(as.character(yval)))

#Standardize predictors
stdev <- sapply(train,sd)
means <- sapply(train,mean)

trainval <- data.frame(t((t(trainval)-means)/stdev))
train <- data.frame(t((t(train)-means)/stdev))
val <- data.frame(t((t(val)-means)/stdev))
test <- data.frame(t((t(test)-means)/stdev))

#tune k
auc <- numeric()
j <- 0
for (k in seq(1,1201,20)) {
  j <- j + 1
  #retrieve the indicators of the k nearest neighbors of the query data 
  indicatorsKNN <- as.integer(knnx.index(data=train, 
                                         query=val, 
                                         k=k))
  #retrieve the actual y from the training set
  predKNN <- as.integer(as.character(ytrain[indicatorsKNN]))
  #if k > 1 then we take the proportion of 1s
  predKNN <- rowMeans(data.frame(matrix(data=predKNN,
                                        ncol=k,
                                        nrow=nrow(val))))
  
  #COMPUTE AUC 
  auc[j] <- AUC::auc(roc(predKNN,yval))
  
  #Print progress to the screen
  print(k)
}

plot(seq(1,1201,20),auc,type="l", xlab="k")

(k <- seq(1,1201,20)[which.max(auc)])

#retrieve the indicators of the k nearest neighbors of the query data 
indicatorsKNN <- as.integer(knnx.index(data=trainval, 
                                       query=test, 
                                       k=k))
#retrieve the actual y from the tarining set
predKNNoptimal <- 
  as.integer(as.character(ytrainval[indicatorsKNN]))
#if k > 1 then we take the proportion of 1s
predKNNoptimal <- 
  rowMeans(data.frame(matrix(data=predKNNoptimal,
                             ncol=k,
                             nrow=nrow(test))))

auc(roc(predKNNoptimal,ytest))


######################################################################
# Exercise 3: 
# Run the following code:
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
# When using a KNN model with k=20, how much higher is the auc when you 
# standardize the data versus not standardizing the data? 
# Use train + val as training instances, and predict on test.
# Answer:

if (!require("AUC")) {
  install.packages('AUC',
                   repos="https://cran.rstudio.com/", 
                   quiet=TRUE) 
  require('AUC')
}

#Fast Nearest Neighbor Search Algorithms and Applications
if (!require("FNN")) {
  install.packages('FNN',
                   repos="https://cran.rstudio.com/", 
                   quiet=TRUE) 
  require('FNN')
}

#Combine train and val
trainval <- rbind(train,val)
ytrainval <- c(as.integer(as.character(ytrain)),as.integer(as.character(yval)))

#########################Not Standardized#########################


k <- 20
#retrieve the indicators of the k nearest neighbors of the query data 
indicatorsKNN <- as.integer(knnx.index(data=trainval, 
                                       query=test, 
                                       k=k))
#retrieve the actual y from the training set
predKNN <- as.integer(as.character(ytrainval[indicatorsKNN]))
#if k > 1 then we take the proportion of 1s
predKNN <- rowMeans(data.frame(matrix(data=predKNN,
                                      ncol=k,
                                      nrow=nrow(test))))

(auc1 <- auc(roc(predKNN,ytest)))

#########################Standardized#########################

#Standardize predictors

stdev <- sapply(train,sd)
means <- sapply(train,mean)

trainval <- data.frame(t((t(trainval)-means)/stdev))
test <- data.frame(t((t(test)-means)/stdev))

#Standardized


k <- 20
#retrieve the indicators of the k nearest neighbors of the query data 
indicatorsKNN <- as.integer(knnx.index(data=trainval, 
                                       query=test, 
                                       k=k))
#retrieve the actual y from the training set
predKNN <- as.integer(as.character(ytrainval[indicatorsKNN]))
#if k > 1 then we take the proportion of 1s
predKNN <- rowMeans(data.frame(matrix(data=predKNN,
                                      ncol=k,
                                      nrow=nrow(test))))

(auc2 <- auc(roc(predKNN,ytest)))


#Added value of standardization:
auc2-auc1

