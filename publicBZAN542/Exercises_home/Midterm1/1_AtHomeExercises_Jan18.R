# At-Home Exercises 1, Jan 18, 2017

# If you choose to submit these exercises:

# FIRST Write down your name:
# First name:
# Last name:

# SECOND Change the name of your file to
# firstname_lastname.R
# That is the file you need to submit.

# THIRD Save your answers in this file and submit it 
# before 11:40am, Jan 18 to this url:
# https://www.dropbox.com/request/oIhGySkhSafh7hr5d6C7

# Only provide code and comments, do not copy paste output.

# Topic:
# Creating, storing and looking at objects
# Object types

# Subsequent questions may depend on previous ones.

# Grading:
# Each question has equal weight
######################################################################
# Question 1: Create a matrix with 100 rows and 1000 colums.
# Store it as mat. The values in the matrix should be integers 
# from 1 to 100000.
# Answer:
?matrix
mat <- matrix(1:100000,nrow=100,ncol=1000)


######################################################################
# Question 2: Transform mat from the previous question into a 
# data frame and call it df.
# Answer:
df <- data.frame(mat)
#or
df <- as.data.frame(mat)


######################################################################
# Question 3: Display the object from the previous question to 
# your screen. Is this helpful to see the structure of the object?
# Answer:
df
#It is not helpful, it does not provide us with a high level 
#overiew of the structure of the data frame.


######################################################################
# Question 4: Compactly display the structure of the data frame in 
# the previous question. We want a function that tells us the 
# type of the object, the dimensions of the object, and its components 
# (columns). We also want to see the types of the columns and the 
# first few values of each column. 
# Answer:
str(df)

######################################################################
# Question 5: While there are 1000 variables, the function in the 
# previous question only shows us 99 columns. It says the output is 
# truncated. Add a parameter to your answer of the previous 
# question to show 1000 columns.
# Answer:
?str
str(df,list.len=1000)

