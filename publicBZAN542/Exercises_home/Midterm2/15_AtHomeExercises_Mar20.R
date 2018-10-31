# At-Home Exercises 15, Mar 20, 2017

# If you choose to submit these exercises:

# FIRST Write down your name:
# First name:
# Last name:

# SECOND Change the name of your file to
# firstname_lastname.R
# That is the file you need to submit.

# THIRD Save your answers in this file and submit it 
# before 11:40am to this url:
# https://www.dropbox.com/request/LwRWzeVQdI99GiwK7rKc

# Only provide code and comments, do not copy paste output.

# Topic:
# K-Nearest Neighbors

# Subsequent questions may depend on previous ones.

# Grading:
# There is 1 question

# Only provide code and comments, do not copy paste output.
# There is one question.

######################################################################
######################################################################
######################################################################
######################################################################
# Exercise 1: 

# Consider the following datasets: df_train and df_new. The dependent 
# variable is churn.

(df <- 
  data.frame(
        churn=c(0,0,1,1,1,0,1,0,1,1,1,1,1,0),
        tenure=c(3,3,1,2,
                2,2,1,3,
                3,2,3,1,
                1,2),
        spend=c(3,3,3,2,
               1,1,1,2,
               1,2,2,2,
               3,2)))

df_train <- df[1:round(0.5*nrow(df),0),]
df_new <- df[(round(0.5*nrow(df),0)+1):nrow(df),]
df_new$churn <- NULL # suppose we don't have this

# Make a prediction for all instances in df_new. 
# Use the five nearest neighbors: k=5. Do the calculations manually 
# (i.e., without using the FNN package), by programming the steps in the 
# k-nearest neighbors algorithm. Do not standardize the variables.
# Answer

#Step 1: compute for each new instance the distance with all training instances
(distance <- data.frame(matrix(NA,
                               ncol=nrow(df_train),
                               nrow=nrow(df_new))))
for (i in 1:nrow(df_new)){
 
  distance[i,1:nrow(df_train)] <- sqrt( ((df_new[i,"tenure"]-df_train[,"tenure"])^2) +
                                        ((df_new[i,"spend"]-df_train[,"spend"])^2))
 
}
distance

# Now we have the new instances in the rows and the 
# training instances in the columns. The values in the 
# object 'distance' are the distances between new and training
# instances.

# Step 2: Next we select the columns per instance with the k
# lowest distances.
k <- 5
(nearestk <-   data.frame(matrix(NA,
                               ncol=k,
                               nrow=nrow(df_new))))
for (i in 1:nrow(distance)){
 nearestk[i,1:k] <- order(as.numeric(distance[i,]))[1:k]
}
nearestk
# For each every new instance (in the rows) we now have the k nearest 
# training instances 
# Note: we ignore ties here

# Step 3: Select the y's of these neighbors
(ys <-   data.frame(matrix(NA,
                          ncol=k,
                          nrow=nrow(df_new))))
for (i in 1:nrow(nearestk)){
  ys[i,1:k] <- df_train[as.integer(nearestk[i,]),"churn"]
}
ys

#Step 4: Compute proportion of 1s

(predictions <- rowMeans(ys))



