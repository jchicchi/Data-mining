# At-Home Exercises 10, Feb 20, 2017

# If you choose to submit these exercises:

# FIRST Write down your name:
# First name:
# Last name:

# SECOND Change the name of your file to
# firstname_lastname.R
# That is the file you need to submit.

# THIRD Save your answers in this file and submit it 
# before 11:40am, Feb 15 to this url:
# https://www.dropbox.com/request/mDe69SzpuAcI8AsR7vJA

# Only provide code and comments, do not copy paste output.

# Topic:
# Text Mining

# Subsequent questions may depend on previous ones.

# Grading:
# Each question has equal weight, there are 2 questions


# Only provide code and comments, do not copy paste output.

######################################################################
# Exercise 1:
# Consider the following dtm. The values are term frequencies. 
(dtm <- matrix(sample(c(rep(0,100),1:100),100),ncol=10))
# Weigh the values to give more emphasis to rare terms. Do not
# use the tm package. Use the idf.
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
# Exercise 2:
# 1. Read in the entire dataset given at: 
# http://www.ballings.co/hidden/aCRM/data/chapter2/productreviews.csv
# Store it as a character vector and call the result documents.
# 2. Plot a histogram showing the number of words on the x-axis and number
# of documents on the y-axis.
# 3. Compute how many unique words there are.
# Answer:

# 1.
documents <- read.csv("http://www.ballings.co/hidden/aCRM/data/chapter2/productreviews.csv", 
                      header=FALSE, 
                      sep="\n",
                      stringsAsFactors=FALSE)[,1]
str(documents)

# 2.
hist(sapply(strsplit(documents," "),length), 
    main="Number of words per document")

# 3. 
unique_word_count <- function(data){

  uniquewords <- unique(unlist(sapply(
                              strsplit(as.character(data)," "),
                              unique)))
  length(uniquewords)
}

unique_word_count(documents)


