# In-Class Assignment 6, Feb 6, 2017

# Collaboration is a crucial component in the learning experience.
# Therefore, this Gradeable needs to be completed in class unless you have
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
# (one file per group) before 1:55pm to this url:
# https://www.dropbox.com/request/oxp0T1WDyuMmxpmeYTZz
# If you have submission problems, deleting cookies
# or changing browsers may help. Please do not submit late,
# as this is unfair towards your colleagues.

######################################################################

# Only provide code and comments, do not copy paste output.

# Topic:
# Operators
# Dummy variables
# Conditional processing

# Subsequent questions may depend on previous ones, therefore
# work with your group through the questions one by one.

# Grading:
# There are 9 questions, and each question gets you 10 points.
# After all questions are graded the total will be rescaled to 
# to 100, and entered in the gradebook.

######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
######################################################################
# Important note before you start.
# 
# When I provide small toy objects (e.g., vectors) such as
# x <- 1:5 it is to make your life easy so you can check 
# the result of your code easily. It should be obvious that
# your code should work on larger objects with random values.
# 
# The data can always change, as follows:
#   -dimensions can change, but object type will remain the same
#   -values can change but will remain of same type and will have 
#    the same range
# Your code should be able to handle those changes.

# For example, if I give you this vector:
(x <- c(1,2,2,5,4))
# and ask you to write some code, it should also work on
(x <- sample(1:5,2000,TRUE))
# Note that the dimension has changed from length 5 to 2000, but 
# the object type is still a vector. Note that the values
# have changed, but are still integers, and still have range [1,5].


######################################################################
# Exercise 4:
# Consider x. Subset x to only keep the values that equal 2. Make
# sure that there are no NAs in the result.
(x <- c(1, NA, 3, 2, 4, 2, 5))
# Answer:
x[!is.na(x) & x==2]

######################################################################
# Exercise 5:
# Consider x. Test if x is between 0 and 1.
x <- 5
# Answer:

0 < x & x < 1

# Note that you cannot do 0 < x < 1


######################################################################
# Exercise 6:
# If x is smaller than 5 return 0, otherwise 1. Store the 
# result in y.
x <- 1:10
# Answer:

(y <- ifelse(x < 5,0,1))


######################################################################
# Exercise 7:
# Automatically create dummy variables of all the variables in data. 
# Store the result in a data frame called df.
# Make sure to represent the data **efficiently**.
# The reference categories are "no" and  "now".
(data <- data.frame(V1=c("yes","no","maybe","yes","no"),
                   V2=c("now","today","today","tomorrow","tomorrow")))
# Answer:
if (!require(dummy)) install.packages("dummy"); require(dummy)
(df <- dummy(data))
df$V1_no <- df$V2_now <- NULL
df

######################################################################
# Exercise 8:
# Automatically create dummy variables of all the variables in data. 
# Store the result in a data frame called df.
# Make sure to represent the data efficiently by only making
# dummies for the top 2 categories. This is also an exercise on 
# using the search function.

(data <- data.frame(V1=c("yes","no","maybe","yes","no"),
                   V2=c("now","today","today","tomorrow","tomorrow")))
# Answer:
if (!require(dummy)) install.packages("dummy"); require(dummy)
(df <- dummy(data,p=2))

######################################################################
# Exercise 9:
# Manually create dummy variables of V1 using ifelse. 
# Store the result in a data frame called df. Don't worry about the 
# efficiency issue. Name the columns V1_yes, V1_no, V1_maybe.
(data <- data.frame(V1=c("yes","no","maybe","yes","no")))
# Answer
df <- data.frame(matrix(NA,ncol=3,nrow=nrow(data)))
df[,1] <- ifelse(data$V1=="yes",1,0)
df[,2] <- ifelse(data$V1=="no",1,0)
df[,3] <-  ifelse(data$V1=="maybe",1,0)

colnames(df) <- c("V1_yes", "V1_no", "V1_maybe")
df
######################################################################
# Exercise 10:
# Consider the functions foo and bar. 
# Print "Success" to the screen if either foo()
# or bar() results in TRUE. Make sure your code 
# takes less than 1.1 seconds to execute.
foo <- function() {Sys.sleep(60);TRUE}
bar <- function() {Sys.sleep(1);TRUE}
# Answer:

#Correct answer:
#Approximately 1 second to run:
if (bar()==TRUE || foo()==TRUE) "Success"


#Incorrect answer:
#Approximately 61 seconds to run:
# if (bar()==TRUE | foo()==TRUE) "Success"
# if (foo()==TRUE || bar()==TRUE) "Success"

######################################################################
# Exercise 11:
# Figure out what is wrong here and correct the code.
x <- 4

if (x==1){
  print("x is 1")
} 
else if (x==2){
  print("x is 2")
}
else if (x==3){
  print("x is 3")
} 
else if (x==4){
  print("x is 4")
} 
else if (x==5){
  print("x is 5")
} 
else if (x==6){
  print("x is 6")
} 
else {
  print("x is not 1,2,3,4,5 or 6")
}

# Answer:

if (x==1){
  print("x is 1")
} else if (x==2){
  print("x is 2")
}else if (x==3){
  print("x is 3")
} else if (x==4){
  print("x is 4")
} else if (x==5){
  print("x is 5")
} else if (x==6){
  print("x is 6")
} else {
  print("x is not 1,2,3,4,5 or 6")
}

######################################################################
# Exercise 12:
# Figure out what is wrong here and correct the code.
x <- 1:5
if (x < 3) x else 0
# Answer:
#Don't use if() for vectors. Use ifelse() instead.
ifelse(x < 3,x,0)
