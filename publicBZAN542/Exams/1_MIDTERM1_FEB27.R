# MIDTERM 1, Feb 27, 2017

# Exam rules:
# Any collaboration or communication is absolutely NOT allowed.
# You are allowed to use all material provided in class (book,
# solutions, videos), your own notes, and the internet. You 
# are NOT allowed to use a website, tool or application for 
# communication (chat, messaging, email, picture sharing media,
# social media, ...). You are not allowed to talk to anyone except
# the instructor. When you have submitted your answers, leave the room 
# immediately without talking. Turn off your phone, and put it in your 
# bag (not on the table or under the table).

# UT Honor Code Statement:
# "As a student of the University, I pledge that I will neither 
# knowingly give nor receive any inappropriate assistance in academic 
# work, thus affirming my own personal commitment to honor and integrity."

# Consequences of not abiding by the exam rules and Honor Code:
# Cheating of any sort including plagiarism will not be tolerated and 
# will result in a grade of F for the course (at the instructor’s 
# discretion) and a charge of academic dishonesty against the student(s).

# All student submissions will be automatically verified for plagiarism 
# using specialized software.

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

# SECOND Change the name of your file to 
# firstname_lastname.R (e.g., John_Doe.R)

######################################################################

# THIRD Open the file and make sure that each time 
# you save your file, your file is synced to Dropbox. 
# In case of a crash or other computer problems you will 
# be able to access your file from another computer.

######################################################################

# FOURTH Write down your first and last name: 
#
# Your name (1):

######################################################################

# FIFTH Save your answers in this file and submit it (only this file) 
# before 1:55pm to this url:
# https://www.dropbox.com/request/lCshGOEas3WdOt8S7zFh

######################################################################

# Only provide code and comments, do not copy paste output.

# Topic:
# Session 3: Subsetting
# Session 4: Memory Management and reading data
# Session 5: Data exploration
# Session 6: Installing and loading packages, missing values getting help, time window
# Session 7: operators, dummy variables, conditional processing
# Session 8: timing code, loops
# Session 9: applying functions to lists, aggregating, merging
# Session 10: dates, creating functions
# Session 11: text mining
# Session 12: data.table package

######################################################################

# Grading:

# There are 17 questions.
# You can drop 2 questions of your choosing. 
# Make a note for the TA: DROPPING THIS QUESTION.
# Questions are weighted uniformly in the grading.

######################################################################

# My strategy in this exam is to have you do many easy exercises, as opposed
# to a few difficult exercises. This strategy is intentional as I want to
# diversify the risk: I do not want you to be penalized if you do not master
# one particular topic. If you master the material, you should be able to complete 
# a question each 5 minutes.

######################################################################
# Question 1: Transform integer vector int into a factor 
# and store it as fact. Use str on fact. Transform fact back to 
# int, make sure to get zeroes and ones.
(int <- sample(c(0,1),1000,TRUE))
# Answer:

# Transform integer vector vec_int to a factor and store it as vec_fact.
(fact <- as.factor(int))

# Transform fact back to int, make sure to get zeroes 
# and ones.
as.integer(as.character(fact))


######################################################################
# Exercise 2
# Consider the following data frame:
data <- data.frame(A=sample(1000),
                   B=letters[sample(1:26,1000,TRUE)],
                   C=runif(1000))
# Select the last element of the third variable. 
# Find four ways to do it. Make sure you code works
# when 'data' grows or shrinks in terms of number of rows.
#Answer:

data[nrow(data),3]
data[nrow(data),"C"]
data[nrow(data),]$C
data[,"C"][nrow(data)]

######################################################################
# Exercise 3
# Consider the following list. Select the second element. 
# Find four ways.
(l <- list(A=matrix(25,ncol=5,nrow=5),
           B="G",
           C=7000000000000))
#Answer:

l[[2]]
l[2][[1]]
l[["B"]]
l$B

######################################################################
# Exercise 4:
# Use read.table() to read in this file:
# http://kddata.co/data/chapter2/data10.ddd 
# Look at the data first using TextWrangler, Notepad, or your
# browser. Print the result to the screen. Make sure it 
# looks similar to the data on file. There should be 4 
# columns and 6 rows in your result.
# Answer:

setwd("/Users/michelballings/Desktop")
writeLines(c("10;c;b;c",
             "32;i;e;22",
             "2000;'a;f;j",
             "55;e;b;6",
             "000;8;e;f",
             "99;g;'h;11111111111"),
            con=file("data10.ddd"))


read.table("http://kddata.co/data/chapter2/data10.ddd ", 
           sep=";",
           quote="")

######################################################################
# Exercise 5: 
# What is the correlation between a and b in df?
df <- data.frame(a=sample(c(1:50,NA),200,TRUE),
                 b=sample(1:50,200,TRUE))
#Answer:
cor(df$a[!is.na(df$a)],df$b[!is.na(df$a)])
#or
cor(df$a,df$b,use="complete.obs")
# or
cor(df$a,df$b,use="na.or.complete")
# or
cor(df$a,df$b,use="pairwise.complete.obs")

######################################################################
# Exercise 6: 
# Make a scatter plot of 'a' (x-axis) and 'b' 
# (y-axis) of df. Add a regression line to the plot.
df <- data.frame(a=sample(c(1:50),200,TRUE),
                 b=sample(1:50,200,TRUE))
# Answer:

plot(df$a,df$b)
abline(lm(b ~ a, df))

######################################################################
# Exercise 7:
# Consider data1 and data2:
data1 <- data.frame(matrix(sample(c(1:100,NA),10000,TRUE),ncol=200))
data2 <- data.frame(matrix(sample(c(1:100,NA),10000,TRUE),ncol=200))
# A.Give the names of the variables that have missing values in data2.
# B.Compute the missing values on data1 and impute them
# on data2. Make sure to create indicators of which values in
# which variables were imputed.
# Answer:

# A.
colnames(data2)[colSums(is.na(data2))>0]

# B.
library(imputeMissings)

values <- compute(data1)
imputednewdata <- impute(data2,object=values,flag=TRUE)
#Check
sum(is.na(data2))
sum(is.na(imputednewdata))

######################################################################
# Exercise 8:
# If x is greater than or equal to 6, or x is NA, return 0, otherwise 1. Store the 
# result in v.
x <- c(1:10,NA)
# Answer:

(v <- ifelse(x >= 6 | is.na(x),0,1))

######################################################################
# Exercise 9:
# Consider the following data frame and loop
data <- data.frame(matrix(runif(10000000),ncol=100000))
a <- numeric()
for (i in 1:ncol(data)) a[i] <- var(data[,i])
head(a)
# Develop a solution that is at least 10 times faster
# to accomplish an identical result.
# Answer:

# First measure runtime original solution:
a <- numeric()
system.time(
  for (i in 1:ncol(data)) a[i] <- var(data[,i])
)
head(a)

#Then measure our solution
system.time(
  a <- sapply(data,var)
)
head(a)
#It is approximately 17 times faster on my machine.

######################################################################
# Exercise 10:
# Consider the following for loop:
for (i in 1:10){
 print(i+runif(1)) 
}
# Change the line that says print(i+runif(1)) so that it stores 
# i+runif in a vector called 'result'. Your solution has to include 
# 'for (i in 1:10){'. You can change everything else. 
# Do not use a vectorized solution, use a loop.

# Answer:
j <- 0
result <- numeric(10)
for (i in 1:10){
 j <- j + 1
 result[j] <- i+runif(1)
}

# A vectorized solution would of course be a lot better, but
# the question asked to use the loop.
# This is what it would look like: (result <- 1:10+runif(10))

######################################################################
# Exercise 11:
# Consider the following list. Return for each element of the list
# TRUE or FALSE indicating whether it is a data frame or not.
# The output should be a boolean (i.e., logical ) vector.
# Your code should also work if the number of elements in lll changes.
lll <- list(
          data.frame(matrix(runif(25),nrow=5,ncol=5)),
          10,
          numeric(1000),
          matrix(runif(25),nrow=5,ncol=5))
str(lll)
# Answer:

unlist(lapply(lll,is.data.frame))
######################################################################
# Exercise 12:
# Consider the data frame called df.
df <- data.frame(ID=sample(1:500,1000,TRUE),
                 ID2=sample(1:2,1000,TRUE),
                 runif=runif(1000),
                 rnorm=rnorm(1000))
# Aggregate the last two variables by the combination of ID and ID2.
# The column names should be: ID ID2 runif rnorm
# Answer:
head(aggregate(df[,!names(df) == c("ID","ID2")], 
          by=list(ID=df$ID,ID2=df$ID2), sum))


######################################################################
# Exercise 13:
# Consider the following five data frames. Do a full outer merge efficiently
# on all five data frames.
(a <- data.frame(ID=c("0001","0002","0003"), 
                V2=c(1,2,3), 
                V3=c("a","b","c")))
(b <- data.frame(ID=c("0002","0003","0004"), 
                V4=c(11,12,13), 
                V5=c("x","x","z"))) 
(d <- data.frame(ID=c("0001","0003","0005"), 
                V6=c(21,22,23), 
                V7=c("aa","bb","cc")))
(e <- data.frame(ID=c("0001","0003","0005"), 
                V8=c(21,22,23), 
                V9=c("aa","bb","cc")))
(f <- data.frame(ID=c("0001","0003","0005"), 
                V10=c(21,22,23), 
                V11=c("aa","bb","cc")))
# Answer:

Reduce(function(x,y) merge(x,y,by="ID", all=TRUE),list(a,b,d,e,f))

######################################################################
# Exercise 14:
# Consider the following data: http://kddata.co/data/chapter2/ex4.txt
# Read the data into R. Make sure that you read in the first column
# as a date by setting colClasses. Do NOT read it in first as a character 
# or factor and then convert it to a date. Verify with str() that indeed
# V1 is a date and also verify that the dates are correctly read in.
#Answer:
setClass("nDate")
setAs(from="character",
      to="nDate",
      def=function(from) as.Date(from, format="%B/%d/%Y"))

(res <- read.table("http://kddata.co/data/chapter2/ex4.txt",
           sep=";", 
           header=TRUE,
           colClasses=c("nDate","integer")))
str(res)
#V1 needs to be a Date

######################################################################
# Exercise 15:
# Create a function called 'omni' with two parameters: x1 and x2.
# x1 and x2 should be numeric scalars (i.e., length 1). 
# The first thing omni should do is check if x1 and x2 are numeric scalars.
# If that is not the case use the stop() function to print the following:
# 'Make sure x1 and x2 are numeric scalars' as follows: stop('Make sure x1 and x2 are scalars').
# Next, the function needs to compute the sum, product, and variance of
# x1 and x2.
# Finally omni needs to return a list with the three elements 
# called sum, product, variance.
# Test omni with x1=4 and x2=5. The output should look like this:
# > omni(4,5)
# $sum
# [1] 9
# 
# $product
# [1] 20
# 
# $variance
# [1] 0.5
# Answer:

omni <- function(x1,x2){
  if (!(is.numeric(x1) &&
      is.numeric(x2) &&
      length(x1)==1 && 
      length(x2)==1)) stop('Make sure x1 and x2 are scalars')
  list(sum=sum(c(x1,x2)),
       product=x1*x2,
       variance=var(c(x1,x2)))
}
omni(4,5)

######################################################################
# Exercise 16:
# Consider the following document by term matrix. 
# The values are term frequencies. 
dtm <- matrix(sample(c(rep(0,1000),1:1000),1000),ncol=10)
# Weight the values using the idf. Do not
# use the tm package.
# Store the result in a matrix called dtm_weighted
# Answer:

#compute idf
(idf <- nrow(dtm)/colSums(dtm >= 1))
#transform vector of idf to a matrix so we can multiply it elementwise 
(idf_mat <- matrix(idf[sapply(1:ncol(dtm), 
                  function(x) rep(x,nrow(dtm)))],nrow=nrow(dtm)))
#apply weight
(dtm_weighted <- dtm * idf_mat)


######################################################################
# Exercise 17:
# Consider the data table called dt.
library(data.table)
dt <- data.table(ID=sample(1:500,1000,TRUE),
                 ID2=sample(1:2,1000,TRUE),
                 runif=runif(1000),
                 rnorm=rnorm(1000))
# Using the data table way, compute the sum of the last two variables 
# by the combination of ID and ID2 (i.e., aggregate).
# The column names should be: ID ID2 runif rnorm
# Answer:
dt[,.(runif=sum(runif),rnorm=sum(rnorm)), .(ID,ID2)]
