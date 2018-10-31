# At-Home Exercises 7, Feb 8, 2017

# If you choose to submit these exercises:

# FIRST Write down your name:
# First name:
# Last name:

# SECOND Change the name of your file to
# firstname_lastname.R
# That is the file you need to submit.

# THIRD Save your answers in this file and submit it 
# before 11:40am, Feb 8 to this url:
# https://www.dropbox.com/request/ExbaEmcS4JlgczaprP7x

# Only provide code and comments, do not copy paste output.

# Topic: 
# Timing code
# Loops

# Subsequent questions may depend on previous ones.

# Grading:
# Each question has equal weight, there are 2 questions

######################################################################
# Exercise 1:
# The function rnorm(1) returns a single random 
# number sampled from a normal distribution. 
print(i <- rnorm(1))
# Use a loop to keep on sampling as long as 
# i <= 2.
# Answer:
i <- 0
while (i <= 2){
print(i <- rnorm(1))
}
#or
i <- 0
repeat{
  print(i <- rnorm(1))
  if (i > 2) break
}
######################################################################
# Exercise 2:
# The function rnorm(1) returns a single random 
# number sampled from a normal distribution. 
print(i <- rnorm(1))
# Use a loop to keep on sampling as long as 
# i <= 2. Make sure to use a different type of 
# loop than the one you used in exercise 1.
# Answer:

#If you used a repeat loop in exercise 2
i <- 0
while (i <= 2){
print(i <- rnorm(1))
}

#If you used a while loop in exercise 2
i <- 0
repeat{
  print(i <- rnorm(1))
  if (i > 2) break
}

