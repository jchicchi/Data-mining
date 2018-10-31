# In-Class Assignment 14, Mar 8, 2017
# (deadline: Mar 10, 2017, 12:40pm)

######################################################################

# Only provide code and comments, do not copy paste output.

# Topic:
# Neural Networks


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
# The goal is to  build a neural network model with one hidden layer
# Step 1: Tune lambda (0,0.001,0.01,0.1,0.3) and the number of hidden nodes (1,5,10,15,20,25) on val and yval 
# (depending on your computer step 1 can take a while, e.g., 15 min)
# Step 2: Build a neural network on train + val + ytrain + yval using the optimal parameter values
# Step 3: Predict on test using the model built on train + val + ytrain + yval
# Step 4: Assess the performance by computing the auc
# Answer:

# Step 1.

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


minima <- sapply(train,min)
scaling <- sapply(train,max)-minima
trainscaled <- data.frame(base::scale(train,
                                      center=minima,
                                      scale=scaling))
#check
sapply(trainscaled,range)

NN.rang <- 0.5 #the range of the initial random weights parameter
NN.maxit <- 10000 #set high in order not to run into early stopping
NN.size <- c(1,5,10,15,20,25)  #number of units in the hidden layer
NN.decay <- c(0,0.001,0.01,0.1,0.3) #weight decay. 
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

source("http://ballings.co/hidden/aCRM/code/chapter2/tuneMember.R")
(result <- tuneMember(call=call,
                     tuning=tuning,
                     xtest=valscaled,
                     ytest=yval,
                     predicttype="raw"))
              
              
              
# Step 2.
              
trainvalscaled <- data.frame(base::scale(rbind(train,val)
                                         , center=minima
                                         , scale=scaling))
NN <- nnet(c(ytrain,yval) ~ ., 
          trainvalscaled, 
          size = result$size, 
          rang = NN.rang, 
          decay = result$decay, 
          maxit = NN.maxit, 
          trace=TRUE, 
          MaxNWts= Inf)


# Step 3.
#predict on test
trainvalscaled <- data.frame(base::scale(test,
                                      center=minima,
                                      scale=scaling))
predNN <- as.numeric(predict(NN,test,type="raw"))

# Step 4.
auc(roc(predNN,ytest))


######################################################################
# Exercise 3: 

# Consider a very simple neural network with one hidden node (x2), 
# one input variable (x1), and a constant (x0=1) to compute the bias.
# What is the value of alpha of z for x2, with alpha being 
# the logistic activation function, for a single instance having a value 
# of 2.5 for x1, and 
# a. b=0 and w=1?
# b. b=1.2 and w=2?
# c. b=2 and w=2.4?
# Answer: 

# a. 
1/(1+exp(-2.5))

# b. 
1/(1+exp(-(1.2*2.5 + 1.2)))

# c. 
1/(1+exp(-(2.4*2.5 + 2)))
