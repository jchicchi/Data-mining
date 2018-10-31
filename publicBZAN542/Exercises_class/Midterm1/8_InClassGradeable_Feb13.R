# In-Class Assignment 8, Feb 13, 2017

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
# https://www.dropbox.com/request/mzaJgrksIeVdsjsL12lB
# If you have submission problems, deleting cookies
# or changing browsers may help. Please do not submit late,
# as this is unfair towards your colleagues.

######################################################################

# Only provide code and comments, do not copy paste output.

# Topic:
# Applying functions to lists
# Aggregating
# Merging

# Subsequent questions may depend on previous ones, therefore
# work with your group through the questions one by one.

# Grading:
# There are 9 questions, and each question gets you 10 points.
# After all questions are graded the total will be rescaled to 
# to 100, and entered in the gradebook.


######################################################################
# Exercise 3:
# Consider the following two data frames.
# Do a left outer merge, where a is the left data frame.
(a <- data.frame(identifier=c("0001","0002","0003"), 
                V2=c(1,2,3), 
                V3=c("a","b","c")))
(b <- data.frame(identifier=c("0002","0003","0004"), 
                V4=c(11,12,13), 
                V5=c("x","x","z")))
#Answer:
merge(a,b, all.x=TRUE)

######################################################################
# Exercise 4:
# Use the data frames from exercise 3.
# Do an inner merge.
# Answer:
merge(a,b)

######################################################################
# Exercise 5:
# Use the data frames from exercise 3.
# Do a right outer merge, where the right data frame is b.
# Answer:
merge(a,b, all.y=TRUE)


######################################################################
# Exercise 6:
# Use the data frames from exercise 3.
# Do a full outer merge.
merge(a,b,all=TRUE)

######################################################################
# Exercise 7:
# Consider the data frame called seven.
seven <- data.frame(ID=sample(1:500,1000,TRUE),
                    runif(1000),
                    rnorm(1000))
# Compute the sum of the last two variables by the IDs.
# Answer:
aggregate(seven[,!names(seven) == "ID"], 
          by=list(seven$ID), sum)


######################################################################
# Exercise 8:
# Use the data frame called seven from exercise 7.
# Select the last line of each ID.
# Answer:
aggregate(seven[,!names(seven) == "ID"], 
          by=list(seven$ID), tail,n=1)

######################################################################
# Exercise 9:
# Use the data frame called seven from exercise 7.
# Select the first line of each ID.
# Answer:
aggregate(seven[,!names(seven) == "ID"], 
          by=list(seven$ID), head,n=1)

######################################################################
# Exercise 10:
# Use the data frame called seven from exercise 7.
# Make sure the by variable is called 'identifier'
# in the result and not Group.1.
# Answer:
aggregate(seven[,!names(seven) == "ID"], 
            by=list(identifier=seven$ID), head,n=1)

######################################################################
# Exercise 11:
# Consider the following three data frames. Do a left outer merge
# on all three data frames.
(a <- data.frame(identifier=c("0001","0002","0003"), 
                V2=c(1,2,3), 
                V3=c("a","b","c")))
(b <- data.frame(identifier=c("0002","0003","0004"), 
                V4=c(11,12,13), 
                V5=c("x","x","z"))) 
(d <- data.frame(identifier=c("0001","0003","0005"), 
                V6=c(21,22,23), 
                V7=c("aa","bb","cc")))
# Answer:

Reduce(function(x,y) merge(x,y,by="identifier", all.x=TRUE),list(a,b,d))






