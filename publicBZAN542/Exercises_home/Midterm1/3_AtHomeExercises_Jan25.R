# At-Home Exercises 3, Jan 25, 2017

# If you choose to submit these exercises:

# FIRST Write down your name:
# First name:
# Last name:

# SECOND Change the name of your file to
# firstname_lastname.R
# That is the file you need to submit.

# THIRD Save your answers in this file and submit it 
# before 11:40am, Jan 25 to this url:
# https://www.dropbox.com/request/KFNubT7yIDKvQau2mE11

# Only provide code and comments, do not copy paste output.

# Topic:
# Memory management and monitoring
# Reading in data

# Subsequent questions may depend on previous ones.

# Grading:
# Each question has equal weight, there are 3 questions

######################################################################
######################################################################
# Additional important remarks before you start:
  
# A. 
# In several questions I will ask you to look at your data before
# reading it in. Use Textwrangler (on MacOS) or Notepad (Windows). 
# Never use Excel, Word, TextEdit, Wordpad to look at data because
# they hide certain characters. Only use TextWrangler or Notepad.

# If you are on a Mac, first download and install TextWrangler:
# http://www.barebones.com/products/textwrangler/download.html

# Notepad should come preinstalled on your Windows machine.

# B.
# Important: never change the data files that you are asked to read in.

# C.
# A,B,C and D are column names. Make sure to adapt your code to 
# reflect that.

######################################################################
######################################################################
# Exercise 1:
# Consider the following object:
a <- rep(letters,1000)
# Would you store it as a factor or as a character, 
# and what is the reason?
# Explain further the reason that you provided.
# Answer:

# Would you store it as a factor or as a character, 
# and what is the reason?
class(a)
object.size(a)
object.size(as.factor(a))
# As a factor, because its object size is smaller.

# Elaborate on the reason that you provided.
# There are only 26 unique values out of 1000 values. That means
# there are very few unique values. Instead of storing a 1000
# characters, it is better to store only 26 characters and 1000 
# integers ranging between 1 and 26 (integers are less expensive 
# than characters). That is exactly what a factor is.


######################################################################
# Exercise 2:
# First go to your desktop and create a folder called datasets.
# Come back to RStudio and use code to determine/do the following:
# What is your current working directory?
# Set your working directory to the folder datasets on your desktop.
# Answer:

#Current wd:
getwd()

#Set wd:
setwd("/Users/michelballings/Desktop/datasets")
#check if setting wd was succesful
getwd()

######################################################################
# Exercise 3:
# Download the following datasets to your working directory 
# using code. Make sure that they have the correct names 
# in your working directory. The correct names are listed after
# the last forward slash in the URLs below. 
# For example, the first file is called data1.csv, and 
# the last one is data8.txt. Make sure to name them exactly 
# as specified because I will be referring to these files by 
# name in subsequent in-class questions.

# http://kddata.co/data/chapter2/data1.csv
# http://kddata.co/data/chapter2/data2.csv
# http://kddata.co/data/chapter2/data3.txt
# http://kddata.co/data/chapter2/data4.data
# http://kddata.co/data/chapter2/data5.datafile
# http://kddata.co/data/chapter2/data6.dat
# http://kddata.co/data/chapter2/data7.txt
# http://kddata.co/data/chapter2/data8.txt

# Answer:

download.file("http://kddata.co/data/chapter2/data1.csv",
              destfile="data1.csv")
download.file("http://kddata.co/data/chapter2/data2.csv",
              destfile="data2.csv")
download.file("http://kddata.co/data/chapter2/data3.txt",
              destfile="data3.txt")
download.file("http://kddata.co/data/chapter2/data4.data",
              destfile="data4.data")
download.file("http://kddata.co/data/chapter2/data5.datafile",
              destfile="data5.datafile")
download.file("http://kddata.co/data/chapter2/data6.dat",
              destfile="data6.dat")
download.file("http://kddata.co/data/chapter2/data7.txt",
              destfile="data7.txt")
download.file("http://kddata.co/data/chapter2/data8.txt",
              destfile="data8.txt")

# or using a loop

files <- c("data1.csv","data2.csv","data3.txt","data4.data","data5.datafile","data6.dat","data7.txt","data8.txt")
for (i in 1:length(files)){
  download.file(paste0("http://kddata.co/data/chapter2/",files[i]),
              destfile=files[i])
}

# Loops will be covered in a subsequent class
# For now just remember that you can do this shorter 
# with a loop.