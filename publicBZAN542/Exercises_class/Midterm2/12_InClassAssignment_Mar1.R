# In-Class Assignment 12, Mar 1, 2017

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
# https://www.dropbox.com/request/hf7VrCZRntEi26hWBFD3
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
# train, validate and test
# Naive Bayes


# Subsequent questions may depend on previous ones, therefore
# work with your group through the questions one by one.

# Grading:
# There are 4 questions, and each question gets you 10 points.
# After all questions are graded the total will be rescaled to 
# to 100, and entered in the gradebook.

######################################################################
# Exercise 2:
# Consider the following data frame:
str(df <- data.frame(matrix(runif(1000),ncol=4),
                    y=as.factor(sample(c(0,1,1,1),250,TRUE))))
# Create a training (80% of observations) and test set 
# (remaining 20% of observations). Call them train and test.
# Answer:

trainind <- sample(1:nrow(df),
                   round(0.8*nrow(df)))
train <- df[trainind,]
test <- df[-trainind,]
nrow(train)
nrow(test)

######################################################################
# Exercise 3:
# Consider the following data frame:
str(df <- data.frame(matrix(runif(10000),ncol=4),
                    y=as.factor(sample(c(0,1,1,1),250,TRUE))))
# Create a function, called partition, to split up 
# a data frame (in this case df) in a train and test set.
# Make sure that the percentage of 1s (and also 0s) in the starting
# data frame (in this case df), train, and test are identical.
# The function should have two parameters: (1) y (in this case df$y) 
# as a vector of type factor, and (2) p (the percentage of
# intances that go into the training set.
# The output of the partition function is a list with two elements, called
# train and test. The former contains the training indices, and the latter
# the test indices.
# For example: partition(y=df$y,p=0.6) outputs a list with two elements:
# train (containing 60% of the row indices) and test (containing 40% of the 
# row indices)
# Verify that your partition function returns training and test indices
# that have an identical percentage of 1s (and 0s) as df$y.
# Answer:

# y: the response factor. must be a factor
# p: the percentage of instances that have to go in the training set
partition <- function(y,p=0.5) {
  
  #STEP 1: split up 0 and 1
  class1_ind <- which(y==as.integer(levels(y)[1]))
  class2_ind <- which(y==as.integer(levels(y)[2]))
  
  l <- list()

  #STEP 2: take subsamples for both 0 and 1
  class1_ind_train <- sample(class1_ind, floor(p*table(y)[1]),replace=FALSE)
  class2_ind_train <- sample(class2_ind, floor(p*table(y)[2]),replace=FALSE)

  class1_ind_test <- class1_ind[!class1_ind %in% class1_ind_train]
  class2_ind_test <- class2_ind[!class2_ind %in% class2_ind_train]

  #STEP 3: combine 0 and 1 for both train and test
  
  l <- list(train=c(class1_ind_train,class2_ind_train),
            test=c(class1_ind_test,class2_ind_test))
  l
}

table(df$y)/sum(table(df$y))

selection <- partition(df$y,p=0.5)
table(df$y[selection$train])/sum(table(df$y[selection$train]))
table(df$y[selection$test])/sum(table(df$y[selection$test]))

######################################################################
# Exercise 4:

# Apply naiveBayes to your train and test set of exercise 2 and compute
# the auc. Do you obtain a good or bad auc?
# Answer:

library(e1071)

model <- naiveBayes(x=train[,!names(train) %in% "y"],
                    y=train$y)
pred <- predict(model, test[,!names(test) %in% "y"], type="raw")[,2]

library(AUC)

auc(roc(pred,test$y))
# Bad auc. Not better than random. This is not surprising, since the
# data is completely random, and hence there are no patterns.
# If you obtained a good auc, it means you were lucky in the 
# randomization process given the small size of the dataset


######################################################################
# Exercise 5:
# Consider the following dataset:
(df <- 
  data.frame(
            churn=c(0,0,1,1,1,0,1,0,1,1,1,1,1,0),
            lor=sample(1:100,14)
  ))
# y=churn, x=lor
# This exercise is about Naive Bayes with continuous predictors.
# We want to compute the probability that a record 
# belongs to class 1 given one continuous predictor. 
# Step 1: 
# Compute the mean and standard deviation of all the 
# records with y=1.
# Step 2:
# Now that we have the mean and the standard deviation we 
# can compute the normal distribution using the
# dnorm() function. The output of the dnorm function
# is the occurence of x assuming a normal
# distribution, given y=1. The output of the dnorm function 
# corresponds to the likelihood term in Equation 
# 2.7 in the book. 
# Step 3: 
# Multiply the output of the dnorm function
# with the prior.
# Step 4:
# Compute the normalizing constant (i.e., do steps 1-3, 
# but now for the records with y=0, and add that to what you 
# had in step 3)
# Step 5:
# Divide the result of what you had in step 3 (before doing step 4)
# by the normalizing constant to obtain the probability that the new record 
# belongs to class 1.
# Step 6:
# Compare your result in step 5 with the result of the
# predict function of the naiveBayes function.
# Answer:

# Step 1
#Compute mean and standard deviation of the class 1
(mn <- mean(df$lor[df$churn==1]))
(sdev <- sd(df$lor[df$churn==1]))

# Step 2:
# Compute posterior
posterior1 <- dnorm(df$lor, mn, sdev)
plot(df$lor[order(df$lor)],
     dnorm(df$lor[order(df$lor)], mn, sdev), type='l')
# Step 3:
prior1 <- as.numeric(table(df[,1])/sum(table(df[,1])))[2]
#Compute numerator of Bayes rule 
numerator1 <- prior1*posterior1

# Step 4:
#Compute mean and standard deviation of the class 0
mn <- mean(df$lor[df$churn==0])
sdev <- sd(df$lor[df$churn==0])
# Compute prior and posterior
posterior0 <- dnorm(df$lor, mn, sdev)
prior0 <- as.numeric(table(df[,1])/sum(table(df[,1])))[1]
#Compute numerator of Bayes rule 
numerator0 <- prior0*posterior0

#Normalizing constant:
denominator <- numerator1 + numerator0

# Step 5:
numerator1/denominator

# Step 6:
NB <- naiveBayes(x=df[,c("lor"),drop=FALSE],
                 y=df[,"churn"])
predict(NB, 
        newdata=df[,c("lor"),drop=FALSE], 
        type="raw")[,2]
#The results in step 5 and 6 are identical


