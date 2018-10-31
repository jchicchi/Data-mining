# In-Class Assignment 9, Feb 15, 2017

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
# (one file per group) before 1:55pm to this url:
# https://www.dropbox.com/request/JptrYVkSwvOMN8LAp6U5
# If you have submission problems, deleting cookies
# or changing browsers may help. Please do not submit late,
# as this is unfair towards your colleagues.

######################################################################

# Only provide code and comments, do not copy paste output.

# Topic:
# Basic Version Control
# Working with dates
# Creating functions

# Subsequent questions may depend on previous ones, therefore
# work with your group through the questions one by one.

# Grading:
# There are 8 questions, and each question gets you 10 points.
# After all questions are graded the total will be rescaled to 
# to 100, and entered in the gradebook.


######################################################################
# Exercise 3:
# Consider the following integer: 14001
# Change that integer to a date using the default origin of your 
# system:
# Answer:

as.Date(14001, origin=Sys.Date()-as.integer(Sys.Date()))
#or
as.Date(14001, origin="1970-01-01")
#or
as.Date(14001, origin=as.Date("1970-01-01"))

######################################################################
# Exercise 4:
# Consider the following character vector: "2015-10-21"
# How many days are there between that date and today?
# Your code should give the correct number of days each time
# your run it (e.g., when you run it tomorrow).
# Answer:

Sys.Date() - as.Date("2015-10-21")

######################################################################
# Exercise 5:
# Consider the following character vector: "10/20/2010"
# Convert it to a date.
# Answer:

as.Date("10/20/2010", format="%m/%d/%Y")


######################################################################
# Exercise 6:
# Create a loop to convert the following character vector to a date 
# and print it to the screen:
# 10/20/i where i denotes the year and takes on the values 0 to 99
# (i.e., 10/20/0 all the way up to 10/20/99). 
# From which i to which i does R interpret the year as being in the two thousands (i.e., 21st century) (e.g., 2001)?
# From which i to which i does R interpret the year as being in the 19 hundreds (i.e., 20th century) (e.g., 1999)? 
# Answer:

for (i in 0:99){
  print(as.Date(paste0("10/20/",i), format="%m/%d/%y"))
}
# From i=0 to i=68 R interprets the year as being in the two thousands (i.e., 2000-2068).
# From i=69 to i=99 R interprets the year as being in the 19 hundreds (i.e., 1969-1999).

######################################################################
# Exercise 7:
# Consider the following data: http://kddata.co/data/chapter2/ex7.txt
# Read the data into R. Make sure that you read in the first column
# as a date by setting colClasses. Do NOT read it in first as a character 
# or factor and then convert it to a date.
#Answer:

setClass("nDate")
setAs(from="character",
      to="nDate",
      def=function(from) as.Date(from, format="%d/%b/%Y"))

read.table("http://kddata.co/data/chapter2/ex7.txt",
           sep=",", 
           header=TRUE,
           colClasses=c("nDate","integer"))


######################################################################
# Exercise 8:
# 1. Create a function called bar that takes a parameter called a
# and creates a matrix with 5 columns out of a. The parameter a
# should be an integer vector of unspecified length.
# 2. Try your function out using the following vector for a.
# Make sure your function does not print to the screen when you simply call
# bar without storing the result.
# We only want to see the result if we store the 
# result of bar into an object and print that object.
vector <- sample(1:100)
# Answer:

#1. 
bar <- function(a){
  result <- matrix(a,ncol=5)
}

# 2. 
# Try out:
bar(vector)

# Checks
#does it print to the screen?
#no

#does it print to the screen when we store it into an object (b) and print
# that object?
(b <- bar(vector))
#yes


######################################################################
# Exercise 9:
# 1. Create a function called foo with two parameters: a and b. 
# Function foo should define another 
# function called bar with the same parameters. 
# Function bar returns the result of multiplying a and b 
# and function foo adds the result of function bar to a.
# Have foo return a list containing the result of that addition as
# its first element and function bar as its second element.
# 2. Call foo with a=1 and b=2 and store it in an object called d.
# 3. Then use d to call function bar with a=1 and b=2.
# Answer:

#1. Create function:
foo <- function(a,b){
    bar <- function(a,b){
      a*b
    }
    list(a + bar(a,b),bar)
}

# 2. Call 'foo' with a=1 and b=2 and store it in an object called 'd'
d <- foo(1,2)

# 3. Then use 'd' to call function 'bar' with a=1 and b=2.
d[[2]](1,2)


######################################################################
# Exercise 10:
# Create a function called foo with one parameter: x.
# foo should return 'hello' when x=1, 'world' when x=2, and '!' when x=3.
# foo should not print anything to the screen when we store the result
# of foo into an object like a <- foo(3).

# Answer
foo <- function(x){
  if (x==1){
    return("hello")
  } else if (x==2){
    return("world")
  }else if (x==3){
    return("!")
  }
}

a <- foo(3)



# Following is incorrect because it prints 
# to the screen when storing result:

foo <- function(x){
  if (x==1){
    print("hello")
  } else if (x==2){
    print("world")
  }else if (x==3){
    print("!")
  }
}

a <- foo(3)
