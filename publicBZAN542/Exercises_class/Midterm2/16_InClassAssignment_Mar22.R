# In-Class Assignment 16, Mar 22, 2017
# (deadline: Mar 22, 2017, 1:55pm)

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
# https://www.dropbox.com/request/fllQH5heMxWuxYOr9thy
# If you have submission problems, deleting cookies
# or changing browsers may help. Please do not submit late,
# as this is unfair towards your colleagues.

######################################################################

# Only provide code and comments, do not copy paste output.

# Topic:
# Decision trees

# Subsequent questions may depend on previous ones, therefore
# work with your group through the questions one by one.

# Grading:
# There are 2 questions, and each question gets you 10 points.
# After all questions are graded the total will be rescaled to 
# to 100, and entered in the gradebook.


######################################################################
######################################################################
######################################################################
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
# The goal is to make predictions using a decision tree model for all test instances.
# Step 1: Determine the optimal cp (0.00001 to 0.4, by 0.001) using train, ytrain, val and yval 
# (depending on your computer step 1 can take a while, e.g., 15 min)
# Step 2: Using the optimal cp, grow a tree on train + val + ytrain + yval 
# Step 3: Make predictions for all instances in test
# Step 4: Assess the performance by computing the auc
# Answer:

library(AUC)
library(rpart)

# Step 1:
candidates <- seq(0.00001,0.4,by=0.001)
aucstore <- numeric(length(candidates))
j <- 0
for (i in candidates) {
  j <- j + 1  
  tree <- rpart(ytrain ~ ., 
                control=rpart.control(cp = i), 
                train)
  predTree <- predict(tree,val)[,2]
  aucstore[j] <- AUC::auc(roc(predTree,yval))
  if (j %% 20==0) cat(j/length(candidates)*100,"% finished\n")
}

plot(aucstore,type="l")
#what is the position of the best auc?
which.max(aucstore)

#Step 2:
ytrainval <- as.factor(c(as.integer(as.character(ytrain)),
                        as.integer(as.character(yval))))
trainval <- rbind(train,val)
tree <- rpart(ytrainval ~ ., 
              control=rpart.control(cp = candidates[which.max(aucstore)]), 
              trainval)

#Step 3:
predTREE <- predict(tree,test)[,2]

# Step 4
auc(roc(predTREE,ytest))


######################################################################
# Exercise 3: 
# Consider the following x and y variables.
(x <- runif(100))
(y <- sample(c(0,1),100,TRUE))
# Determine which value of x results in the best split using
# the decrease in impurity (equation 2.31)
# Hints: loop, subsetting, unique()
# Answer:

j <- 0
res <- numeric(length(unique(x)))
for (i in unique(x)){
  j <- j + 1
  #create left and right child node
  yleft <- y[x < i]
  yright <- y[x >= i]
  #compute decrease of impurity
  leftimpurity <- (length(yleft)/length(y))*mean(yleft)*(1-mean(yleft))
  if (is.nan(leftimpurity)) leftimpurity <- 0
  rightimpurity <- (length(yright)/length(y))*mean(yright)*(1-mean(yright))
  if (is.nan(rightimpurity)) rightimpurity <- 0
  res[j] <- (mean(y)*(1-mean(y)))-(leftimpurity+rightimpurity)
  print(res[j])
}
#Optimal split:
unique(x)[which.max(res)]
