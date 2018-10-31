# In-Class Assignment 1, Jan 18, 2017

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
# https://www.dropbox.com/request/0Hk6lnztyDvHBJ5rEppi
# If you have submission problems, deleting cookies
# or changing browsers may help. Please do not submit late,
# as this is unfair towards your colleagues.

######################################################################

# Only provide code and comments, do not copy paste output.

# Topic:
# Creating, storing and looking at objects
# Object types

# Subsequent questions may depend on previous ones, therefore
# work with your group through the questions one by one.

# Grading:
# There are 8 questions, and each question gets you 10 points.
# After all questions are graded the total will be rescaled to 
# to 100, and entered in the gradebook.


######################################################################
# Question 6: The str function always shows us 
# the first 10 elements of each colmn. Which parameter controls this?
# What is the default? Read the documentation for that parameter and 
# figure out what the multiplication factor is for the integer 
# vectors in our data frame. How many values will you get if 
# vec.len=1.6?
# Answer:

# Which parameter controls this?
# vec.len

#What is the default?
4

#Read the documentation for that parameter and figure out what the 
# multiplication factor is for the integer vectors in our data frame.
# str() shows 10 first values, when vec.len=4. Therefore the factor is 2.5.

#How many columns will you get if vec.len=1.6
1.6*2.5
# Check if indeed 4:
# str(df,list.len=1, vec.len=1.6)

######################################################################
# Question 7: Consider two character vectors, a, and b. Store them 
# in a data frame. Call it data, and make sure that while storing 
# you print the data frame to the screen at the same time.
a <- LETTERS[1:5]
b <- LETTERS[22:26]
# Answer:
(data <- data.frame(a,b))


######################################################################
# Question 8. Using str() look at the structure of the data of the 
# previous question. You will see that a and b are stored as factors. 
# We do not want that, we want it to be character vectors.
# Now store a and b as a data frame again, and call it data, 
# but make sure a and b are characters.
# Answer:
str(data)
(data <- data.frame(a,b,stringsAsFactors=FALSE))
str(data)


######################################################################
# Question 9: What is the difference in parameters between 
# as.numeric() and numeric(). Ignore the '...'. 
# When would you use as.numeric() and when would you use numeric()? 
# Answer:

?as.numeric

# numeric() has one parameter: length.
# as.numeric() has one parameter: x.

# Use numeric() to create a numeric vector with a given length 
# with each element 0. (Useful to preallocate a vector.)
# For example: 
numeric(10)
# Use as.numeric() to transform vectors of other types to type numeric.
# For example: 
class(a <- 1:10)
class(as.numeric(a))

######################################################################
# Question 10: Transform character vector vec_char to a factor and 
# store it as vec_fact. Use str on vec_fact. How are a, b, a, and a 
# stored? Investigate this further, explain how the integers relate 
# to the labels.
(vec_char <- c('a','b','a','a'))
# Answer:

# Transform character vector vec_char to a factor and 
# store it as vec_fact. Use str on vec fact. 
(vec_fact <- as.factor(vec_char))

# Use str on vec_fact. 
str(vec_fact)

#How are a, b, a, and a stored?
# As integers {1,2}, along with 2 labels {"a","b"}.

# Investigate this further, explain how the integers relate
# to the labels.
# The integers refer to the labels by position.
# For example, 1 refers to the first label (in this case "a"), 
# 2 refers to the second label (in this case "b").

# For example integers 1,2,1,1 and labels "a","b" means that
# -the first element corresponds to the 1st label ("a")
# -the second element corresponds to the 2nd label ("b")
# -the third element corresponds to the 1st label ("a")
# -the fourth element corresponds to the 1st label ("a")
# --> we get a, b, a, a, which is exactly where we started from


######################################################################
# Question 11: Transform integer vector vec_int to a factor 
# and store it as vec_fact. Use str on vec fact. How are the integers 
# stored? Transform vec_fact back to vec_int, make sure to get zeroes 
# and ones.
(vec_int <- c(0,1,0,1,0,1,1,1))
# Answer:

# Transform integer vector vec_int to a factor and store it as vec_fact.
(vec_fact <- as.factor(vec_int))

# Use str on vec fact. 
str(vec_fact)

# How are the integers stored?
# As integers {1,2}, with two labels {"0","1"}

# Transform vec_fact back to vec_int, make sure to get zeroes 
# and ones.
as.integer(as.character(vec_fact))


######################################################################
# Question 12: Consider the following objects: a,b. 
# Store them in a list called l, while at the same time printing it 
# to the screen. Next transform l to a data frame called df, 
# while at the same time printing it to the screen.
a <- 1:10
b <- 11:20
#Answer:
(l <- list(a,b))
(df <- data.frame(l))

######################################################################
# Question 13: Consider the following objects: a, b, c, d. 
# Create a list of those objects and use str on the object. 
# Investigate the structure.
(a <- 1:5)
(b <- seq(0.1,2,by=0.1))
(c <- data.frame(a,b[1:5]))
(d <- matrix(b,ncol=4))
#Answer:
str(list(a,b,c,d))