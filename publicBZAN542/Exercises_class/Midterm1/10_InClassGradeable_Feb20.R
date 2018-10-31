# In-Class Assignment 10, Feb 20, 2017

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
# https://www.dropbox.com/request/gBYJjTtzebgvKgeoZQMc
# If you have submission problems, deleting cookies
# or changing browsers may help. Please do not submit late,
# as this is unfair towards your colleagues.

######################################################################

# Only provide code and comments, do not copy paste output.

# Topic:
# Text Mining

# Subsequent questions may depend on previous ones, therefore
# work with your group through the questions one by one.

# Grading:
# There are 8 questions, and each question gets you 10 points.
# After all questions are graded the total will be rescaled to 
# to 100, and entered in the gradebook.

######################################################################

# Virtually all questions depend on each other. Therefore work with your
# group through the questions one question at a time.

######################################################################
# Exercise 3:
documents <- read.csv("http://www.ballings.co/hidden/aCRM/data/chapter2/productreviews.csv", 
                      header=FALSE, 
                      sep="\n",
                      stringsAsFactors=FALSE)[,1]
# Create a volatile corpus of the documents character vector.
# Call the result documents.
# Answer:

for (i in c('SnowballC','slam','tm')){
  if (!require(i, character.only=TRUE)) install.packages(i)
  require(i, character.only=TRUE)
}
(documents <- Corpus(VectorSource(documents)))


######################################################################
# Exercise 4:
# Preprocess documents (output of previous exercise) as follows:
# Run the following code. It will count the number of unique words in 'documents'.
nbrwords <- integer()
unique_word_count <- function(data){
  if (any(class(data) %in% c("VCorpus", "Corpus"))) {
      data <- unlist(sapply(data,'[',"content"))
  }
  uniquewords <- unique(unlist(sapply(
                              strsplit(as.character(data)," "),
                              unique)))
  length(uniquewords)
}
nbrwords[1] <- unique_word_count(documents)
names(nbrwords)[1] <- "unprocessed"
# 1. Convert all words to lower case and store the result in documents
# Count the number of unique words and store the number in the second element of nbrwords.
# 2. Remove punctuation and store the result in documents
# Count the number of unique words and store the number in the third element of nbrwords.
# 3. Remove numbers and store the result in documents
# Count the number of unique words and store the number in the fourth element of nbrwords.
# 4. Remove English stopwords and store the result in documents
# Count the number of unique words and store the number in the fifth element of nbrwords.
# 5. Remove superfluous white space
# Answer:


# 1. 
#transform to lower case
documents <- tm_map(documents, 
                  content_transformer(tolower))
nbrwords[2] <- unique_word_count(documents)
names(nbrwords)[2] <- "lower"

# 2.
#remove punctuation
documents <- tm_map(documents, 
                  removePunctuation)
nbrwords[3] <- unique_word_count(documents)
names(nbrwords)[3] <- "punct"

# 3.
#remove numbers
documents <- tm_map(documents, 
                  removeNumbers)
nbrwords[4] <- unique_word_count(documents)
names(nbrwords)[4] <- "num"

# 4.
#remove stopwords
documents <-  tm_map(documents, 
                   removeWords, 
                   stopwords('english'))
nbrwords[5] <- unique_word_count(documents)
names(nbrwords)[5] <- "stop"

# 5.
#strip white space
documents <-  tm_map(documents, 
                   stripWhitespace)



######################################################################
# Exercise 5:
# 1. Spell- check documents. Store the result in documents_spell_checked. Make sure to measure how long it takes.
# Count the number of unique words and store the number in the sixth element of nbrwords.
# Note that this step easily takes 20 minutes, so you don't want to sit around and wait
# but keep working on the subsequent questions.
# 2. Stem documents_spell_checked.
# Count the number of unique words and store the number in the seventh element of nbrwords.
# 3. Plot nbrwords as a line chart. Which pre-processing step reduced the number
# of unique words the most?
# Answer:

#Download a list of words sorted by frequency of 
#appearance in natural language

wordlist <- 
  readLines("http://www.ballings.co/hidden/aCRM/data/chapter2/wordlist.txt")

#Function to correct misspelled words
correct <- function(word) { 
  # How dissimilar is this word from all words in the wordlist?
  edit_dist <- adist(word, wordlist)
  # Is there a word that reasonably similar? 
  # If yes, which ones?
  # If no, append the original word
  # Select the first result (because wordlist is sorted 
  # from most common to least common)
  c(wordlist[edit_dist <= min(edit_dist,2)],word)[1] 
}


documents <- unlist(sapply(documents,'[',"content"))

#Pre-allocate a vector where we will store the
#spell-checked reviews
documents_spell_checked <- character(length(documents))

#This loop takes a while:
start <- Sys.time()
for (i in 1:length(documents)){
      #Instead of applying correct() to each 
      #word, we fist make them unique
      #The strsplit() function splits the string in words
      count <- table(strsplit(documents[i],' ')[[1]])
      words <- names(count)
      
      #Then we apply our correct function to each 
      # unique word
      words <- as.character(sapply(words,correct))
      
      #Next we reconstruct the original vector, but
      #now spell-checked. We do this because we are
      #going to exploit the tm package, which will
      #count the words for us.
      words <- rep(words,count)
      
      #Concatenate back to a string
      documents_spell_checked[i] <- 
        paste(words, collapse=" ")
      
      #Print progress to the screen
      if((i %% max(floor(length(documents)/10),1))==0) 
          cat(round((i/length(documents))*100),"%\n")
}
Sys.time()-start
nbrwords[6] <- unique_word_count(documents_spell_checked)
names(nbrwords)[6] <- "spell"

# 2.
(documents_spell_checked <- Corpus(VectorSource(documents_spell_checked)))

documents_spell_checked <- tm_map(documents_spell_checked, 
                                stemDocument)
nbrwords[7] <- unique_word_count(documents_spell_checked)
names(nbrwords)[7] <- "stem"

# 3.
plot(nbrwords, type="l",xaxt="n",xlab="",main="Number of unique words")
axis(1,1:length(names(nbrwords)),names(nbrwords))
# Step that reduced the number of unique words the most:
# Remove punctuation

######################################################################
# Exercise 6:
# 1. Create a dtm of documents_spell_checked. Words in the dtm should
# have a minimum of 2 characters. Store the result in dtm_documents.
# 2. How many terms do you have when you set the maximum allowed sparsity for a
# term to 90%?
# Answer:

# 1.
(dtm_documents <- DocumentTermMatrix(
          documents_spell_checked, 
          control = list(wordLengths = c(2, Inf),
                         weighting=function(x) weightTfIdf(x))
                                  )
)

# 2.
#Allow that 90% of the documents do not use a word
(dtm_documents <- removeSparseTerms(dtm_documents, sparse= 0.9))
#68 terms (we came from 1080!)

######################################################################
# Exercise 7:
# 1. Center dtm_documents and apply Singular Value Decomposition, store the result as
# SingValDec
# 2. Use str() to look at the result. Then look at v. What is in the rows, and what is
# in the columns? (e.g., documents, concepts, terms, ...?)
# Answer:

# 1.
dtm_documents <- as.matrix(dtm_documents)
dtm_documents <- t(t(dtm_documents)-colMeans(dtm_documents))

# 2.
SingValDec <- svd(dtm_documents)
str(SingValDec)
#rows: terms, 
#columns: concepts/components/singular vectors

######################################################################
# Exercise 8:
# Then look at u using str(). What do the rows represent, and what are the columns?
# (e.g., documents, concepts, terms, ...?)
# Answer:

str(SingValDec)
# rows: documents
# columns: concepts


######################################################################
# Exercise 9:
# Plot d as a line chart. What would be a good cutoff to drop variables/concepts?
# Answer:

plot(SingValDec$d, type="l")
# There is a dent around 5 concepts. We could drop everything after
# the 5th concept.

######################################################################
# Exercise 10:
# Start from the centered dtm_documents (you centered dtm_documents in ex 7).
# Create train and new as follows:
train <- dtm_documents[1:40,]
new <- dtm_documents[41:86,]
# 1. Perform svd on train, store the result in a variable called SingValDec,
# and extract u.
# 2. Deploy our svd model on new to compute u. Store the result in u_new.
# Answer:

# 1.
SingValDec <- svd(train)
str(SingValDec$u)

# 2. 
u_new <- new %*% SingValDec$v  %*% solve(diag(SingValDec$d))
str(u_new)

