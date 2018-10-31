# In-Class Assignment 2, Jan 23, 2017

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
# https://www.dropbox.com/request/utuZ3o9XJCnmmL6ZCMT5
# If you have submission problems, deleting cookies
# or changing browsers may help. Please do not submit late,
# as this is unfair towards your colleagues.

######################################################################

# Only provide code and comments, do not copy paste output.

# Topic:
# Subsetting

# Subsequent questions may depend on previous ones, therefore
# work with your group through the questions one by one.

# Grading:
# There are 8 questions, and each question gets you 10 points.
# After all questions are graded the total will be rescaled to 
# to 100, and entered in the gradebook.



######################################################################
# Exercise 6
# Consider the following dataframe:
(df <- data.frame(A=1:5,B=letters[1:5],C=seq(1.1,1.5,0.1)))
# Select the fourth element of the first variable. 
# Find four ways to do it.
#Answer:

df[4,1]
df[4,"A"]
df[4,]$A
df[,"A"][4]

######################################################################
# Exercise 7
# Consider the following list. Select the third element. 
# Find four ways.
(l <- list(A=1:5,B=df,C=5))
#Answer:

l[[3]]
l[3][[1]]
l[["C"]]
l$C

######################################################################
# Exercise 8
# Consider the following data frame. 
# Rename the second and third column to D and E.

(df <- data.frame(A=1:5,B=letters[1:5],C=seq(1.1,1.5,0.1)))

# Answer:
colnames(df)[2:3]<- c("D","E")
df

######################################################################
#Exercise 9. Using the same df as in the previous exercise, 
# select data with a matrix. We want to have the third row of column 1,
# rows 2 to 4 of column 2 and row 5 of column 3.

# Answer:
mat <- matrix(FALSE,ncol=3,nrow=5)
mat[3,1] <- mat[2:4,2] <- mat[5,3] <- TRUE
mat

df[mat]

######################################################################
# Exercise 10. Using the same df as the previous exercise, select the third 
# row of column 1, rows 2 to 4 of column 2 and row 5 of column 3. Put these in
# one character vector called b. Make sure to get: "3"   "b"   "c"   "d"   "1.5"
# Answer:

(b <- c(df[3,1],as.character(df[2:4,2]),df[5,3]))

######################################################################
# Exercise 11: Select the first column of df. Make sure the result is still
# a data frame and not an integer vector. Do not use the function data.frame()
# or as.data.frame().
# Answer:

df[,1,drop=FALSE]

######################################################################
#Exercise 12: Consider the following data frame called df. 
# Replace the third value of the third column with value 5.
(df <- data.frame(A=1:5,B=letters[1:5],C=seq(1.1,1.5,0.1)))
# Answer:

df
df[3,3] <- 5
df

######################################################################
#Exercise 13: Use the same data frame as in the previous question.
# Replace rows 1 to 3, and 5, of column 1 with 6, 7, 8, and 9.
# Answer:

df
df[c(1:3,5),1] <- c(6:8,9)
df
