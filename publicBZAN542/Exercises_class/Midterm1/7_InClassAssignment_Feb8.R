# In-Class Assignment 7, Feb 8, 2017

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
# https://www.dropbox.com/request/Snz5sbEjwKQsyQ3x69h9
# If you have submission problems, deleting cookies
# or changing browsers may help. Please do not submit late,
# as this is unfair towards your colleagues.

######################################################################

# Only provide code and comments, do not copy paste output.

# Topic:
# Timing code
# Loops

# Subsequent questions may depend on previous ones, therefore
# work with your group through the questions one by one.

# Grading:
# There are 11 questions, and each question gets you 10 points.
# After all questions are graded the total will be rescaled to 
# to 100, and entered in the gradebook.

######################################################################
# Exercise 3:
# Consider the following data frame:
x <- data.frame(matrix(runif(10000000),ncol=100000))
# Compute and store the mean of all columns using 
# -a loop without preallocation
# -a loop with preallocation
# -sapply()
# -colMeans
# Make sure to measure how long each solution takes.
# In addition look at the first few values using
# head() to make sure the solutions return identical
# values.
# Answer:

# a loop without preallocation
x_mean1 <- numeric()
system.time(
for (i in 1:ncol(x)) x_mean1[i] <- mean(x[,i])
)
head(x_mean1)

# a loop with preallocation
x_mean2 <- numeric(ncol(x))
system.time(
for (i in 1:ncol(x)) x_mean2[i] <- mean(x[,i])
)
head(x_mean2)

#sapply
system.time(
x_mean3 <- sapply(x,mean)
)
head(x_mean3)

#colMeans
system.time(
x_mean4 <- colMeans(x)
)
head(x_mean4)


######################################################################
# Exercise 4:
# Consider the following for- loop. It stops when
# it reaches "0". Make sure R skips the value 
# that causes the error by using the simplest form 
# of error handling that we saw. We want R to 
# continue with the values in the list without 
# breaking out of it when an error occurs.
for (i in list(1,2,4,10,"0",-3,1,2,3)){
  print(i + 5)
}
# Answer:
for (i in list(1,2,4,10,"0",-3,1,2,3)){
  try(print(i + 5))
}

######################################################################
# Exercise 5:
# Consider the following for- loop. 
for (i in list(1,"2",4,10,"0",-3,1,"2",3)){
  cat(i,"+ 5 =",i+5,"\n")
}

# It stops when it reaches "2". Make sure R skips the values 
# that cause the error by using error handling. We want R to 
# continue with the values in the list without 
# breaking out of the loop when an error occurs.
# Write your own error handler to extract the error message, along
# with a note that explains that you apply as.integer(i) when the
# error occurs before adding 5.
# The result should look like this:

# 1 + 5 = 6 
# 2 + 5 = ERROR:  non-numeric argument to binary operator . Computed as.integer( 2 ) + 5 instead= 7 
# 4 + 5 = 9 
# 10 + 5 = 15 
# 0 + 5 = ERROR:  non-numeric argument to binary operator . Computed as.integer( 0 ) + 5 instead= 5 
# -3 + 5 = 2 
# 1 + 5 = 6 
# 2 + 5 = ERROR:  non-numeric argument to binary operator . Computed as.integer( 2 ) + 5 instead= 7 
# 3 + 5 = 8 

# Answer:

for (i in list(1,"2",4,10,"0",-3,1,"2",3)) { 
  tryCatch(
    cat(i,"+ 5 =",i+5,"\n"),
    error=function(x){
      cat(i, "+ 5 = ERROR: ", conditionMessage(x), 
        ". Computed as.integer(",i,") + 5 instead=", as.integer(i)+5,"\n")}
          ) 
}


######################################################################
# Exercise 6:
# Consider the following matrix:
(mat <- matrix(0,ncol=10,nrow=10))
# Create a nested for- loop (a for- loop within a for- loop) 
# to replace the values in mat as follows:
# the values in the matrix should be the result
# of multiplying the row and column number.
# For example, the cell in row 3, column 5, needs
# to be 15.
# The final result should look like this:
# > mat
#       [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
#  [1,]    1    2    3    4    5    6    7    8    9    10
#  [2,]    2    4    6    8   10   12   14   16   18    20
#  [3,]    3    6    9   12   15   18   21   24   27    30
#  [4,]    4    8   12   16   20   24   28   32   36    40
#  [5,]    5   10   15   20   25   30   35   40   45    50
#  [6,]    6   12   18   24   30   36   42   48   54    60
#  [7,]    7   14   21   28   35   42   49   56   63    70
#  [8,]    8   16   24   32   40   48   56   64   72    80
#  [9,]    9   18   27   36   45   54   63   72   81    90
# [10,]   10   20   30   40   50   60   70   80   90   100
# Answer:

for(i in 1:nrow(mat))  # for each row
{
  for(j in 1:ncol(mat)) # for each column
  {
    mat[i,j] <- i*j     # multiply
  }
}
mat

######################################################################
# Exercise 7:
# Consider the following for loop:
for (h in 1:20) {
   print(h)  
} 
# Add some code to break out of the loop when
# h equals 10. Hint ?break
# Answer:

for (h in 1:20) {
  if (h == 10){
    break
  }
 print(h)  
} 


######################################################################
# Exercise 8:
# Consider the following for- loop:
for (h in 1:10) {
   if (!h %in% 3:6) print(h)  
} 
# Rewrite "if (!h %in% 3:6) print(h)" with the "next"
# statement. Hint: ?next
# Answer:

for (h in 1:10) {
  if (h %in% 3:6) next
  print(h)  
} 

######################################################################
# Exercise 9:
# Consider the following vectors and loop. 

(v1 <- 1:10)
(v2 <- 11:20)
(v3 <- integer(length(v1)))

for (i in 1:length(v1)){
    v3[i] <- v1[i] + v2[i]
} 
v3

# What is the vectorized equivalent of this loop?
# Answer:

(v3 <- v1 + v2)


######################################################################
# Exercise 10:
# Consider the data frame called df.
(df <- data.frame(matrix(1:100,ncol=10,nrow=10)))
# Compute and print to the screen 
# the range() of every column. Use a loop. Then 
# go and look up apply(), lapply() and sapply(),
# and use these function to compute the range of
# every column. Investigate how they work, and 
# what the differences are in how they return things.
# Answer:

for (i in 1:ncol(df)){
  print(range(df[,i]))
}

(ap <- apply(df,2,range))
str(ap)
(lap <- lapply(df,range))
str(lap)
(sap <- sapply(df,range))
str(sap)
(sap_f <- sapply(df,sum,simplify=FALSE))
str(sap_f)

######################################################################
# Exercise 11:
# Print ‘This is value i’, for i=[1,10]. 
# This means you have to print 10 times to the screen, 
# and the only thing that changes is i. Use a loop.
# Hint: use the paste function.
# Answer:

for (i in 1:10) print(paste("This is value",i))

#This is the vectorized solution:
i <- 1:10
print(paste("This is value",i))

######################################################################
# Exercise 12:
# Plot a histogram using the hist() function 
# each 0.1 seconds (use the Sys.sleep() function), 
# for 200 times in row. 
# The first plot contains 1 random point, 
# the second plot contains 2 random points, ... , 
# and the 200th plot contains 200 random points. 
# Generate random points first for a normal distribution 
# using rnorm(), and then do it for a uniform distribution
# using runif().
# Answer:

#rnorm
rand <- rnorm(200)
for (i in 1:200){
  hist(rand[1:i])
  Sys.sleep(0.1)
}

#runif
rand <- runif(200)
for (i in 1:200){
 hist(rand[1:i],breaks=seq(0,1,0.1))
 Sys.sleep(0.1)
}

######################################################################
# Exercise 13:
# Consider the following for loop:
for (i in c("Hello,","how","are","you")){
 print(i) 
}
# Change the line that says print(i) to one or multiple 
# lines in which you store the words "Hello,","how","are","you"
# in a vector called sentence. The final length of sentence
# should be 4. Hint: You will probably need to add one or two
# lines of code above the loop too. Do not change this part:
# 'for (i in c("Hello,","how","are","you")){'.
# Answer:

j <- 0
sentence <- character(4)
for (i in c("Hello,","how","are","you")){
 j <- j + 1
 sentence[j] <- i
}
