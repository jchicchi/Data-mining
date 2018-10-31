# In-Class Assignment 25, Apr 26, 2017

# Topic:
# Deployment

######################################################################
# Exercise 2: 
# Method dispatching.
# Consider the following object.
a <- runif(100)
class(a) <- 'abcd'
str(a)
# Create a summary function, that you can call as follows: summary(a). 
# The default behavior of summary() is to print the min, Q1, median, mean, Q3, max
# for numeric vectors. Your summary function should plot a histogram instead.
# (1) First find out which summary functions exist in the environment. 
# (2) Then create yours using method dispatching, 
# and do not overwrite any existing summary functions.
# (3) Test summary(a) to see if it plots a histogram, and test summary(runif(100)) to see if 
# it prints the min, Q1, median, mean, Q3, max
# Answer:

# (1)
apropos('summary\\.')

# (2)

#This is incorrect:
# summary <- function(x){
#   hist(x)
# }

#This is correct:
summary.abcd <- function(x){
  hist(x)
}

# (3)
#This should plot a histogram
summary(a)
#This should print the min, Q1, median, mean, Q3, max:
summary(runif(100))

######################################################################
# Exercise 3: 
# Run the following code:
.test <- function(x) print(x)
rm(list=ls())
.test(1:10)
# As you can see, even after clearing the environment, .test() is still there.
# Adapt rm(list=ls()) to make sure .test() is removed when you call it.
# Answer:

rm(list=ls(all.names=TRUE))
.test(1:10)


######################################################################
# Exercise 4: ellipsis

# Consider the following function call:
  foo(a=1,b=2,c=3,d=4,e=5)
# Define foo() to print a + 2, b + 4, c + 1, d + 7, and e + 9, one after the other, using ellipsis. 
# It should also work if other arguments are added to the call.
# The definition of foo() cannot have any named arguments.
# Answer:

foo <- function(...){
    print(list(...)$a + 2)
    print(list(...)$b + 4)
    print(list(...)$c + 1)
    print(list(...)$d + 7)
    print(list(...)$e + 9)
}

#test
foo(a=1,b=2,c=3,d=4,e=5)

  
