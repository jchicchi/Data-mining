# MIDTERM 2, Apr 3, 2017
# Deadline: 1:45pm

# Exam rules:
# Any collaboration or communication is absolutely NOT allowed.
# You are allowed to use all material provided in class (book,
# solutions, videos), your own notes, and the internet. You 
# are NOT allowed to use a website, tool or application for 
# communication (chat, messaging, email, picture sharing media,
# social media, ...). You are not allowed to talk to anyone except
# the instructor. 

######################################################################

# When you have submitted your answers, do not start talking.
# Come and see the instructor to verify your submission. Then leave the room 
# immediately without talking. Turn off your phone, and put it in your 
# bag (not on the table or under the table).

######################################################################

# UT Honor Code Statement:
# "As a student of the University, I pledge that I will neither 
# knowingly give nor receive any inappropriate assistance in academic 
# work, thus affirming my own personal commitment to honor and integrity."

# Consequences of not abiding by the exam rules and Honor Code:
# Cheating of any sort including plagiarism will not be tolerated and 
# will result in a grade of F for the course (at the instructor’s 
# discretion) and a charge of academic dishonesty against the student(s).

# All student submissions will be automatically verified for plagiarism 
# using specialized software.

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

# SECOND Change the name of your file to 
# firstname_lastname.R (e.g., John_Doe.R)

######################################################################

# THIRD Open the file and make sure that each time 
# you save your file, your file is synced to Dropbox. 
# In case of a crash or other computer problems you will 
# be able to access your file from another computer.

######################################################################

# FOURTH Write down your first and last name: 
#
# Your name (1):

######################################################################

# FIFTH Save your answers in this file and submit it (only this file) 
# before 1:45pm to this url:
# https://www.dropbox.com/request/zG1K1f6s4qZFdx7Sk1e1
# Come and see the instructor to verify your file before you leave the classroom.

######################################################################

# Only provide code and comments, do not copy paste output.

# Topics:
# Session 14: training, validation, and test, naive Bayes (2 questions)
# Session 15: logistic regression (1 question)
# Session 16: neural networks (1 question)
# Session 17: k-nearest neighbors (1 question)
# Session 18: decision trees (1 question)
# Session 19: ensembles methods: bagged trees (1 question)
# Session 20: random forest (2 questions)


######################################################################

# Grading:

# There are 9 questions.
# Questions are weighted uniformly in the grading.
# Some questions are easier than others, yet they will get you the same reward.
# You can drop 2 questions of your choosing. 
# Make a note for the TA: DROPPING THIS QUESTION.
# Questions without that note will be graded and will count towards your total grade.
# Questions without an answer and without that note will result in a 0 for that question,
# regardless of whether you have used up your budget of 2 questions or not.
# Using more than 2 DROPS will result in a penalty of up to 10%
# The TA will first check all questions to verify if you used a maximum of two DROPS.
# These DROPS are a gift, and should be used responsibly, wisely, and respectfully. This means
# that there is no negotiation after the exam regarding these DROPS if you forgot to specify them,
# or used more than 2 DROPS.

######################################################################
# Exercise 1: train, val, test
# Consider the following data frame:
str(data <- data.frame(matrix(runif(1000),ncol=4),
                    y=as.factor(sample(c(0,1,1,1),250,TRUE))))
# Create a training (60% of observations) and test set 
# (remaining 40% of observations). Call them train and test.
# Do this 5 times using a for loop, each time storing train and test
# as a list into another list, called l. In other words, the output needs to be 
# a list, called l, of length 5. Each element in that list is again a list of length 2 (containing
# two elements: the train and test set).
# Verify your result with str.
# Answer:

l <- list()
for (i in 1:5){
trainind <- sample(1:nrow(data),
                   round(0.6*nrow(data)))
train <- data[trainind,]
test <- data[-trainind,]
l[[i]] <- list(train=train,test=test)
}
str(l)

######################################################################
# Exercise 2: Naive Bayes
# Consider the following data frame, called data. The dependent variable 
# is whether a car is a sports car or not. There are two
# predictor variables: color and fuel. Also consider
# a data frame called new. Learn a naive bayes model on data,
# and predict on new to obtain the probability that the new instance is 
# a sportscar. Your code should work if the data in new changes 
# (other values, or more records, ...).
(data <- 
  data.frame(
            color=c("blue","blue","yellow","red",
                     "red","red","yellow","blue",
                     "blue","red","blue","yellow",
                     "yellow","red"),
            fuel=c("electric","electric","electric","gas",
                    "hydrid","hydrid","hydrid","electric",
                    "hydrid","electric","electric","electric",
                    "electric","electric"),
            sportscar=c(0,0,1,1,1,0,1,0,1,1,1,1,1,0)))

(new  <- data.frame(color="red",
                   fuel="gas"))
# Answer:


if (!require("e1071")) {
  install.packages('e1071',
                   repos="https://cran.rstudio.com/", 
                   quiet=TRUE) 
  require('e1071')
}

NB <- naiveBayes(data[,1:2],y=data[,"sportscar"])

# Extract the levels from the training data
(lev <- sapply(data[,1:2],levels))
#Then apply the levels to the new data
res <- data.frame(sapply(1:ncol(new), 
                         function(x) factor(new[,x],
                                            levels=lev[,x]),
                                            simplify=FALSE))
colnames(res) <- colnames(new)
str(res)

#make prediction
predict(NB,
        res,
        type="raw")[,2]

#verify
cbind(data,predict(NB,
        data,
        type="raw")[,2])[4,]
  
######################################################################
# Exercise 3: Logistic regression
# Consider the following data, called Credit:
install.packages("kernelFactory")
library(kernelFactory)
data(Credit)
Credit <- Credit[,c("V1","V2","V3","V8","V9","V10","V11","V12","V14","V15","Response")]
credittrain <- Credit[1:325,]
creditval <- Credit[356:653,]
str(credittrain)
str(creditval)
# Response is the dependent variable. The other variables are predictors.
# Estimate a regularized logistic regression model. 
# Which lambda results in the best model in terms of AUC?
# What is the best AUC?
# Answer:

if (!require("glmnet")) { 
  install.packages('glmnet',
                   repos="https://cran.rstudio.com/",
                   quiet=TRUE) 
  require('glmnet')
}

if (!require("AUC")) { 
  install.packages('AUC',
                   repos="https://cran.rstudio.com/",
                   quiet=TRUE) 
  require('AUC')
}

# Estimate model on credittrain
(LR <- glmnet(x=data.matrix(credittrain[,!names(credittrain) == "Response"]), 
              y=credittrain$Response,
              family="binomial"))

#Predict and evaluate on creditval
aucstore <- numeric()
for (i in 1:length(LR$lambda) ) { 
  predglmnet <- predict(LR,
                        newx=data.matrix(creditval[,!names(creditval) == "Response"]), 
                        type="response", 
                        s=LR$lambda[i])
  aucstore[i] <- AUC::auc(roc(as.numeric(predglmnet),creditval$Response))
}

#select optimal lambda
(LR.lambda <- LR$lambda[which.max(aucstore)])
#What is best auc?
aucstore[which.max(aucstore)]

######################################################################
# Exercise 4: Neural net
#Run the following code:
source("http://ballings.co/hidden/aCRM/code/chapter2/read_data_sets.R")
trainind <- sample(1:nrow(BasetableTRAIN),500,TRUE)
train <- BasetableTRAIN[trainind,]
ytrain <- yTRAIN[trainind]
valind <- sample(1:nrow(BasetableVAL),500,TRUE)
val <-   BasetableVAL[valind ,]
yval <- yVAL[valind]
testind <-  sample(1:nrow(BasetableTEST),500,TRUE)
test <- BasetableTEST[testind,]
ytest <- yTEST[testind]
rm(list=ls()[!ls() %in% c("train","ytrain","val","yval","test","ytest")])
ls()
#Step 1: Grow a single neural network model on the training set, tune it on the validation set,
# and predict and evaluate the model on the test set. Measure how long it takes.
#Step 2: Grow an ensemble of neural networks (20 models) on the training set, each time tuning it on the validation set, 
#and predicting on the test set. Each model is only different in that it has different random starting weights.
# Calculate the performance of the ensemble model.
# Measure how long it takes.
#Step 3: How much better is the ensemble neural network than the single neural network?
#Step 4: How many times slower is fitting the ensemble neural network than the single neural network? Is is exactly 20?
# Answer:

#load the AUC package
if (!require("AUC")) {
  install.packages('AUC',
                   repos="https://cran.rstudio.com/", 
                   quiet=TRUE) 
  require('AUC')
}

#load the AUC package
if (!require("nnet")) {
  install.packages('nnet',
                   repos="https://cran.rstudio.com/", 
                   quiet=TRUE) 
  require('nnet')
}

#Step 1:

buildnnet <- function(){
          #Run an external function to facilitate tuning 
          source("http://ballings.co/hidden/aCRM/code/chapter2/tuneMember.R")
          #first we need to scale the data to range [0,1] avoid numerical problems
          minima <- sapply(train,min)
          scaling <- sapply(train,max)-minima
          
          trainscaled <- data.frame(base::scale(train,
                                                center=minima,
                                                scale=scaling))
          #check
          # sapply(trainscaled,range)
          
          NN.rang <- 0.5 #the range of the initial random weights parameter
          NN.maxit <- 10000 #set high in order not to run into early stopping
          NN.size <- c(5,10,20) #number of units in the hidden layer
          NN.decay <- c(0,0.001,0.01,0.1) #weight decay. 
                                          #Same as lambda in regularized LR. Controls overfitting
                        
          call <- call("nnet", 
                       formula = ytrain ~ ., 
                       data=trainscaled, 
                       rang=NN.rang, maxit=NN.maxit, 
                       trace=FALSE, MaxNWts= Inf)
          tuning <- list(size=NN.size, decay=NN.decay)
                        
          #tune nnet
          #scale validation data              
          valscaled <- data.frame(base::scale(val,
                                              center=minima,
                                              scale=scaling))
                      
          (result <- tuneMember(call=call,
                               tuning=tuning,
                               xtest=valscaled,
                               ytest=yval,
                               predicttype="raw"))
                        
          #Create final model
                        
          
          trainvalscaled <- data.frame(base::scale(rbind(train,val),
                                                            center=minima,
                                                            scale=scaling))
          ytrainval <- as.factor(c(as.numeric(as.character(ytrain)),
                                   as.numeric(as.character(yval))))
          
          NN <- nnet(ytrainval ~ ., 
                    trainvalscaled, 
                    size = result$size, 
                    rang = NN.rang, 
                    decay = result$decay, 
                    maxit = NN.maxit, 
                    trace=FALSE, 
                    MaxNWts= Inf)
          
          
          #predict on test
          
          testscaled <- data.frame(base::scale(test,
                                               center=minima,
                                               scale=scaling))
          
          predNN <- as.numeric(predict(NN,testscaled,type="raw"))
          predNN
}

start <- Sys.time()
predNN <- buildnnet()
step1_time <- Sys.time()-start
(step1_auc <- auc(roc(predNN,ytest)))

#Step 2:
start <- Sys.time()
pred <- data.frame(matrix(NA,ncol=20, nrow=nrow(test)))
for (i in 1:20){
 pred[,i] <- buildnnet() 
 print(i)
}
step2_time <- Sys.time()-start
(step2_auc <- auc(roc(rowMeans(pred),ytest)))

# Step 3:
step2_auc / step1_auc

# Step 4:
as.numeric(step2_time) / as.numeric(step1_time)

######################################################################
# Exercise 5: Random forest
# This question is not a coding question.
# Complete this sentence:
# In random forest, a random subset of candidate variables is selected at each ...
# Answer: 
# ...node of each tree.

######################################################################
# Exercise 6: Random forest
# This question is not a coding question.
# Explain the steps to compute the mean decrease in accuracy in random forest of a variable called x1.
# Answer: 

# For each tree in the forest:
# step 1: predict on OOB data, compute model accuracy (1)
# step 2: scramble x1,  predict on OOB data, compute model accuracy (2)
# step 3: decrease in accuracy =(accuracy 1)-(accuracy 2) 

# The mean decrease in accuracy is the mean of all the accuracies in step 3

######################################################################
# Exercise 7: Bagging
# Why is a decision tree better than logistic regression to use in bagging?
# This question is not a coding question.
# Answer:

# Because decision trees are more sensitive to changes in the data (i.e., they are unstable), 
# they will deliver more diverse ensemble members due to the bootstrap samples. 
# Diversity is key to ensemble performance.

######################################################################
# Exercise 8: Decision tree
# In a decision tree, when is the Gini-Impurity at its maximum in a given node?
# Consider a binary dependent variable, with classes {0,1}
# This question is not a coding question.
# Answer:

# When p=0.5 in a given node, with p being the proportion of 1s in the node.

######################################################################
# Exercise 9: K-Nearest Neighbors.
# Consider the following classification problem. There are two variables x1 and x2, 
# and two classes: circles and crosses. What is the probability that the new instance, 
# the triangle, is a cross, if k=20?
# See the problem here: https://www.dropbox.com/s/4n6q16wtf18tmp8/knn.png?dl=0
# This question is not a coding question.

# Answer:
# Therea are 10 circles, and 10 crosses. That means that the probability is 50%.



######################################################################

# Come and see the instructor to verify your file before you leave the classroom.

######################################################################