# In-Class Assignment 23, Apr 19, 2017

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
# https://www.dropbox.com/request/oENVMcPPrifr2I4p72vp
# If you have submission problems, deleting cookies
# or changing browsers may help. Please do not submit late,
# as this is unfair towards your colleagues.

######################################################################

# Only provide code and comments, do not copy paste output.

# Topic:
# Cross-Validation

# Subsequent questions may depend on previous ones, therefore
# work with your group through the questions one by one.

# Grading:
# There are 2 questions

######################################################################
######################################################################
######################################################################
######################################################################
# Exercise 2: 
# Write a function called tenfoldcv to generate a list. The list has 10 elements and
# each element is a list with 2 elements. The first element in each list of 2 elements
# contains the training indices, and the second element contains the test indices.
# Make sure to follow the rules of ten fold cross-validation.
# Also make sure to call the training indices 'train', and the test indices 'test'.
# The function has only one parameter: the number of rows (integer) in the basetable. 
# Answer:

tenfoldcv <- function(nrows){
  
  bins <- cut(1:nrows, breaks=10, labels=FALSE)
  randomInd <- sample.int(nrows) 
  l <- list()
  
  for (i in 1:10) {
   test <- randomInd[bins == i]  
   train  <- randomInd[bins != i]   
   l[[i]] <- list(train=train, test=test) 
  }
  l
}

tenfoldcv(100)



######################################################################
# Exercise 3: 
# Create a function to execute the Wilcoxon signed-ranks test. The final output of the function should
# be the min(R+,R-) as an integer. We can then use that number to manually look up whether two models are significantly
# different. The function will have two parameters: x (AUC vector of model 1) and y (AUC vector of model).
# Make sure to try out your function and see if it works as intended. 


WilcoxonSRT <- function(x,y){
  difference <- round(y-x,7)
  absdiff <- abs(difference)
  rnk <- rank(absdiff)
  sumranks <- aggregate(rnk,by=list(sign(difference)),sum)
  min(sumranks$x)
}

WilcoxonSRT(x=c(.8, .75,.8,.78,.7,.75,.81,.76,.75,.79),
            y=c(.81, .78 , .72 ,.8 ,.8 ,.76 ,.88 ,.72 ,.79 ,.75))