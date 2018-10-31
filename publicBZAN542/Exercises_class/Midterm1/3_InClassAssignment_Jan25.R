# In-Class Assignment 3, Jan 25, 2017

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
# https://www.dropbox.com/request/fv2WERjSPN4U8jgnfPiI
# If you have submission problems, deleting cookies
# or changing browsers may help. Please do not submit late,
# as this is unfair towards your colleagues.

######################################################################

# Only provide code and comments, do not copy paste output.

# Topic:
# Memory management and monitoring
# Reading in data

# Subsequent questions may depend on previous ones, therefore
# work with your group through the questions one by one.

# Grading:
# There are 9 questions, and each question gets you 10 points.
# After all questions are graded the total will be rescaled to 
# to 100, and entered in the gradebook.


######################################################################
######################################################################
# Additional important remarks before you start:
  
# A. 
# In several questions I will ask you to look at your data before
# reading it in. Use Textwrangler (on MacOS) or Notepad (Windows). 
# Never use Excel, Word, TextEdit, Wordpad to look at data because
# they hide certain characters. Only use TextWrangler or Notepad.

#If you are on a Mac, first download and install TextWrangler:
# http://www.barebones.com/products/textwrangler/download.html

#Notepad should come preinstalled on your Windows machine.

# B.
# Important: never change the data files that you are asked to read in.

# C.
# A,B,C and D are column names. Make sure to adapt your code to 
# reflect that.

######################################################################
# This task needs to be completed before starting the first exercise (ex 4)
# This is not an exercise and you do not need to provide an answer here.

# Store the following files in a folder and set your working directory to 
# that folder.

# http://kddata.co/data/chapter2/data1.csv
# http://kddata.co/data/chapter2/data2.csv
# http://kddata.co/data/chapter2/data3.txt
# http://kddata.co/data/chapter2/data4.data
# http://kddata.co/data/chapter2/data5.datafile
# http://kddata.co/data/chapter2/data6.dat
# http://kddata.co/data/chapter2/data7.txt
# http://kddata.co/data/chapter2/data8.txt
  
######################################################################
# Exercise 4:
# Use read.table() to read in data1.csv. 
# Before reading in the data, have a look at it using
# Textwrangler (on MacOS) or Notepad (Windows).
# Missing values are denoted by 99 and -1. Make sure R correctly sets 
# them to NA or <NA>. Look at your result by printing it to the screen.
# Answer:

read.table("data1.csv", 
           header=TRUE,
           sep=",",
           na.strings=c(99,-1))




######################################################################
# Exercise 5:
# Use read.table() to read in data2.csv. Somebody has 
# written comments next to two lines of data. Make
# sure R ignores these comments (i.e., the result
# should not contain these comments). Look at the 
# data first using TextWrangler or Notepad. Print 
# the result to the screen.
# Answer:

read.table("data2.csv", 
           header=TRUE,
           sep=",",
           comment.char="*")



######################################################################
# Exercise 6:
# Use read.table() to read in data3.txt. Look at the 
# data first using TextWrangler or Notepad. Print 
# the result to the screen. Make sure it looks similar
# to the data on file.
# Answer:

read.table("data3.txt", 
           sep=";",
           quote="")


######################################################################
# Exercise 7:
# Read in data4.data using read.table(). We want
# the last three columns to be character vectors, and
# the first one should be integer. First look at the 
# data using TextWrangler or Notepad.
# Print the result to the screen using str().
# Answer:

str(read.table("data4.data", 
               sep=";", 
               stringsAsFactors=FALSE))
# or
str(read.table("data4.data", 
               sep=";", 
               colClasses=c("integer",rep("character",3))))

######################################################################
# Exercise 8:
# Use read.table() to read in data5.datafile. 
# First look at the data using TextWrangler or 
# Notepad. Make sure the second column is stored
# as a factor with 4 levels: "a","d","e","g" and 
# NOT 5 levels "a","a ","d","e".
# Verify with str().
# Answer:

str(read.table("data5.datafile", 
               sep=";", strip.white=TRUE))


######################################################################
# Exercise 9:
# Use read.table to read in data6.dat. Look
# at your data first using TextWrangler or Notepad.
# Make sure the result looks similar. 
# Print the result to the screen.
# Answer:

read.table("data6.dat",
            header=TRUE,
            sep=",",
            fill=TRUE)

######################################################################
# Exercise 10:
# Use read.table() to read in data1.csv. Only read in 
# row 3 to 5. Print the result to the screen.
# Answer:

read.table("data1.csv", 
           header=TRUE,
           sep=",", 
           skip=2,
           nrow=3,
           col.names=colnames(read.table("data1.csv", sep=",",header=TRUE,nrow=0)))


######################################################################
# Exercise 11:
# Use read.table() to read in data7.txt. First look
# at your data using TextWrangler or Notepad.
# Make sure you also read in the lines without data. 
# There should be 6 lines of data.
# Answer:

read.table("data7.txt",
           header=TRUE,
           sep=",",
           blank.lines.skip=FALSE)


######################################################################
# Exercise 12:
# Use read.table() to read in data8.txt. Assign
# the following variable names: A,B,C,D 
# Answer:

read.table("data8.txt",
           sep=",",
           col.names=c("A","B","C","D"))

