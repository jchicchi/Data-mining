# In-Class Assignment 19, Apr 5, 2017

######################################################################

# Topic:
# Boosting

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
# Step 1:
# Code the stochastic boosting algorithm step by step (as indicated
# in the beginning of Section 2.5.13, p170). Put that code in a
# function called MyBoost. Code the steps manually. Do not use a package to apply
# the boosting algorithm. You can use the rpart package. Use the AUC for alpha.
# Step 2:
# Create a predict function called predictMyBoost to deploy your MyBoost model.
# Step 3:
# Grow a MyBoost model (train + val), make a prediction with predictMyBoost (test), 
# and compute the AUC
# Answer:

#Step 1:

MyBoost <- function(x, y, iters){
  library(rpart)
  library(AUC)
  levels(y) <- c(-1,1)
  
  #1
  w <- rep(1/nrow(x),nrow(x))

  #2
  alpha <- numeric(iters)
  model <- list()
  for (i in 1:iters){
    #a
    ind <- sample(1:nrow(x),nrow(x),replace=TRUE,prob=w)
    
    #b
    model[[i]] <- rpart(y[ind] ~ ., data=x[ind,])
    pred <- as.numeric(predict(model[[i]],x,type="prob")[,2])
    
    #c
    levels(y) <- c(0,1)
    alpha[i] <- auc(roc(pred,y))
    
    #d
    pred <- ifelse(pred==1, 1-.Machine$double.eps, pred) # sanitize Inf values
    f <- (1/2)*log1p(pred/(1-pred)) 
    
    #e
    levels(y) <- c(-1,1)
    w <- w*exp(-as.integer(as.character(y))*f)
    w <- w/sum(w)
  }
  
  #3
  alpha <- alpha/sum(alpha)

  
  list(model=model,alpha=alpha)
}


#Step 2
predictMyBoost <-  function(object, newdata){
  

  pred <- data.frame(matrix(ncol=length(object$model), nrow=nrow(newdata)))
  for (i in 1:length(object$model)){
        pred[,i] <- as.numeric(predict(object$model[[i]],newdata,type="prob")[,2])
  }
  #4
  rowSums(t(t(pred) * object$alpha))
}


#Step 3
model <- MyBoost(x=rbind(train,val),
                  y=as.factor(c(as.integer(as.character(ytrain)), as.integer(as.character(yval)))),
                  10)
pred <- predictMyBoost(model,test)
auc(roc(pred,ytest))


