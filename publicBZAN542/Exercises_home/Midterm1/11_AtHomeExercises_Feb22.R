# At-Home Exercises 11, Feb 22, 2017

# If you choose to submit these exercises:

# FIRST Write down your name:
# First name:
# Last name:

# SECOND Change the name of your file to
# firstname_lastname.R
# That is the file you need to submit.

# THIRD Save your answers in this file and submit it 
# before 11:40am, Feb 22 to this url:
# https://www.dropbox.com/request/QiYeZAAiRz2AZblZ32xG

# Only provide code and comments, do not copy paste output.

# Topic:
# data.table package

# Subsequent questions may depend on previous ones.

# Grading:
# Each question has equal weight, there are 2 questions


# Only provide code and comments, do not copy paste output.
# There is one question.

######################################################################

require(data.table)

######################################################################
# Exercise 1:
# Download the following dataset to your disk as follows 
# (you may need to adapt the destfile argument):
download.file("http://kddata.co/data/chapter2/dataICG11.csv",
               destfile="~/desktop/dataICG11.csv")
# Read it in into R using read.csv and fread. Store the result 
# of read.table into an object called df, and the result of fread
# into an object called dt.
# How long does it take for read.csv to read in the dataset,
# and how long does it take for fread to read in the dataset?
# How much faster is fread?
# Answer:

# How long does it take to read in the data set using read.csv?
start <- Sys.time()
df <- read.csv("~/desktop/dataICG11.csv", stringsAsFactors=FALSE)
(dfend <- Sys.time() - start)
str(df)


# How long does it take to read in the data set using fread?
start <- Sys.time()
dt <- fread("~/desktop/dataICG11.csv")
(dtend <- Sys.time() - start)
str(dt)

# How much faster is fread?
# fread is 
as.numeric(dfend)/as.numeric(dtend)
# times faster on this data set

