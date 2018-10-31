# In-Class Assignment 11, Feb 22, 2017

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
# https://www.dropbox.com/request/fFqv4WNRb5lCfY0T4qAY
# If you have submission problems, deleting cookies
# or changing browsers may help. Please do not submit late,
# as this is unfair towards your colleagues.

######################################################################

# Only provide code and comments, do not copy paste output.

# Topic:
# data.table package

# Subsequent questions may depend on previous ones, therefore
# work with your group through the questions one by one.

# Grading:
# There are 8 questions, and each question gets you 10 points.
# After all questions are graded the total will be rescaled to 
# to 100, and entered in the gradebook.


######################################################################

require(data.table)

######################################################################
# Exercise 2:
# Run the following code:

download.file("http://kddata.co/data/chapter2/dataICG11.csv",
               destfile="~/desktop/dataICG11.csv")
df <- read.csv("~/desktop/dataICG11.csv", stringsAsFactors=FALSE)
dt <- fread("~/desktop/dataICG11.csv")

# Aggregate V2 and V3 in df and dt by V1. Use the sum as aggregation measure.
# Use the data frame and data table approach. Time both approaches.
# How much faster is the data table approach?
# Answer:

start <- Sys.time()
dfagg <- aggregate(df[,c("V2","V3")], by=list(V1=df$V1), sum)
(dfaggend <- Sys.time() - start)
str(dfagg)

start <- Sys.time()
dtagg <- dt[,.(V2=sum(V2),V3=sum(V3)),by=V1]
(dtaggend <- Sys.time() - start)
str(dtagg)

# How much faster is the data table way?
as.numeric(dfaggend)/as.numeric(dtaggend)

######################################################################
# Exercise 3:
# Consider the following list called l. 
n <- 30000
l <- list(data.frame(V1=sample(letters,n,TRUE),
                V2=1:n,
                V3=runif(n)),
          data.frame(V1=sample(letters,n,TRUE),
                V2=1:n,
                V3=runif(n)),
          data.frame(V1=sample(letters,n,TRUE),
                V2=1:n,
                V3=runif(n)))
# There are only three
# elements in l but your solution should also work
# for thousands of elements without any more typing.
# Stack (rbind) the elements of l the data frame and the data table way.
# Time both approaches. How much faster is the data table way?
# When you're done remove l and the results from your stacking
# from your environment.
# Answer:

start <- Sys.time()
resdf <- do.call('rbind',l)
(enddf <- Sys.time() - start)
str(resdf)

start <- Sys.time()
resdt <- rbindlist(l)
(enddt <- Sys.time() - start)
str(resdt)

# How much faster is the data table way?
as.numeric(enddf) / as.numeric(enddt)

rm(l,resdt,resdf)
ls()

######################################################################
# Exercise 4:
# Extract V3 from dt using the $-sign approach. 
# Display the first 6 values.
# Answer:

head(dt$V3)

######################################################################
# Exercise 5:
# Extract V3 from dt by name, but do not use the $-sign approach.
# Display the first 6 values. Find at least three ways.
# Answer:

head(dt[,V3])
#or
head(dt[,.(V3)]) #equivalent to drop=FALSE in df
#or
head(dt[,"V3", with=FALSE])
#or
head(dt[,"V3"])
#or
head(dt[["V3"]])

######################################################################
# Exercise 6:
# Select both V2 and V3 from dt by name. Your code should be
# as short as possible.
# Answer:

# Best answers:
dt[,V2:V3]
dt[,.(V2,V3)]
# Second best answer:
dt[,list(V2,V3)]
# Third best answer:
dt[,c("V2","V3")]
# Fourth best answer: 
dt[,c("V2","V3"),with=FALSE]


######################################################################
# Exercise 7:
# Select rows 1 to 10 from dt.
# Answer:

dt[1:10,]
# or
dt[1:10]

######################################################################
# Exercise 8:
# Select columns 2 to 3 from dt (use column indices)
# Answer:
dt[,2:3]
#or
dt[,2:3, with=FALSE]

######################################################################
# Exercise 9:
# Add a variable by reference (i.e., do not use "<-") in dt, 
# called V4. V4 equals V3 + 10. Look at the result.
# Answer:

dt
dt[,V4 := V3 + 10]
dt

######################################################################
# Exercise 10: 
# Select all rows of dt where V1 equals "i". Make
# your code as short as possible.
# Answer:

#Shortest way
dt[V1=="i"]
#Somewhat longer:
dt[V1=="i",]
#Longest way:
dt[dt$V1=="i",]
