# In-Class Assignment 13, Mar 6, 2017
# (deadline: Mar 8, 2017, 12:40pm)

# Collaboration is a crucial component in the learning experience.
# This assignment can be taken anywhere.

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
# https://www.dropbox.com/request/EPUVktqfWnzMwsC2xExI
# Your name (1):
# Other group member name (2):
# Other group member name (3):
# Other group member name (4):

######################################################################

# FIFTH Save your answers in this file and submit it 
# (one file per group) before 1:55pm to this url:
# 
# If you have submission problems, deleting cookies
# or changing browsers may help. Please do not submit late,
# as this is unfair towards your colleagues.

######################################################################

# Only provide code and comments, do not copy paste output.

# Topic:
# Logistic regression

# Subsequent questions may depend on previous ones, therefore
# work with your group through the questions one by one.

# Grading:
# There are 3 questions, and each question gets you 10 points.
# After all questions are graded the total will be rescaled to 
# to 100, and entered in the gradebook.

######################################################################
# Exercise 2:
# Consider the following data frame:
(df <- data.frame(x1=runif(10),x2=rnorm(10),x3=runif(10),y=sample(c(0,1),10,TRUE)))
# We have estimated a model and this are the coefficients:
# B0=-0.13
# B1=1.4
# B2=3.78
# B3=0.1
# Make a prediction using this model. Do it manually. The output 
# should be a probability for each instance.
# Answer:

B0 <- -0.13
B1 <- 1.4
B2 <- 3.78
B3 <- 0.1

logistic <- function(z) exp(z)/(1+exp(z))

logistic(B0+rowSums(t(c(B1,B2,B3)*t(df[,1:3]))))
#OR
logistic(B0+t(c(B1,B2,B3) %*% t(df[,1:3])))


######################################################################
# Exercise 3:
# Consider df:
(df <- data.frame(x1=runif(10),x2=rnorm(10),x3=runif(10),y=sample(c(0,1),10,TRUE)))
# Now consider our model:
(model <- c(B0=0.44, # assume this is always called B0
            B1=1.3,
            B2=0.28,
            B3=2.1))
# Create a function to compute the LASSO log likelihood.
# Call the function lassologlikelihood. The inputs of the function
# are (1) a data frame with predictors (call the parameter X), 
# (2) a vector containing y (call the parameter y),  
# (3) a named vector of coefficients (call the parameter coefficients),
# (4) lambda. 
# Test your function on our df and model. Use a value of 0.1 for lambda.
# Answer:

lassologlikelihood <- function(X, y, coefficients, lambda) {
        Px_i <- logistic(
                coefficients["B0"] + 
                t(coefficients[2:length(coefficients)] %*% t(X))
                )
        - sum(y * log(Px_i) + (1-y)*log(1-Px_i)) + lambda*sum(abs(coefficients))
}

X <- df[, 1:3]
y <- df[, 4]
beta <- model
lambda <- 0.1

lassologlikelihood(X, y, beta, lambda)

######################################################################
# Exercise 4: 
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
#Step 1: Build a regularized logistic regression model on train and ytrain
#Step 2: Tune lambda by selecting the lambda that results in the best auc on val and yval
#Step 3: Build a regularized logistic regression model on train + val + ytrain + yval
#Step 4: Predict on test using the model built on train + val + ytrain + yval, and the optimal lambda
#Step 5: Assess the performance by computing the auc
# Answer:

library(glmnet)

library(AUC)

# Step 1:
# Estimate model on train
(LR <- glmnet(x=data.matrix(train), 
              y=ytrain,
              family="binomial"))

# Step 2:
#Predict and evaluate on val
aucstore <- numeric()
for (i in 1:length(LR$lambda) ) { 
  predglmnet <- predict(LR,
                        newx=data.matrix(val), 
                        type="response", 
                        s=LR$lambda[i])
  aucstore[i] <- AUC::auc(roc(as.numeric(predglmnet),yval))
}

#select optimal lambda
(LR.lambda <- LR$lambda[which.max(aucstore)])

# Step 3:
#Now that we know the optimal lambda we can fit the model 
#on the combination of train and val
LR <- glmnet(x=data.matrix(rbind(train,val)),
              y=c(ytrain,yval),
              family="binomial")

# Step 4: 
#We then use that model with the optimal lambda on test
predLRlas <- as.numeric(predict(LR, 
                                newx=data.matrix(test),
                                type="response",
                                s=LR.lambda))

# Step 5:
#Finally we assess the performance of the model
auc(roc(predLRlas,ytest))
