# At-Home Exercises 24, Apr 24, 2017

# Topic:
# Understanding classifier performance

######################################################################
# Question 1: First, read in all data:
source("http://ballings.co/hidden/aCRM/code/chapter2/read_data_sets.R")
# Build KNN models for k=1:50. Make predictions on the validation set and plot k against the AUC in black.
# Then make predictions on the training set and plot k against the AUC in blue (add these to the existing plot).
# Describe what you see using the theory that we saw in the 'Understanding classifier performance' section.
# Answer:

if (!require("AUC")) {
  install.packages('AUC',
                   repos="https://cran.rstudio.com/", 
                   quiet=TRUE) 
  require('AUC')
}

#Fast Nearest Neighbor Search Algorithms and Applications
if (!require("FNN")) {
  install.packages('FNN',
                   repos="https://cran.rstudio.com/", 
                   quiet=TRUE) 
  require('FNN')
}

# The main function we will be using is the knnx.index function.
# It find the k-nearest neighbors.The knnx function requires 
# all indicators to be numeric so we first convert our data. 
# In this case they are already numeric, but this is an example
# of how to do it:
trainKNN <- data.frame(sapply(BasetableTRAIN, function(x) as.numeric(as.character(x))))
valKNN <- data.frame(sapply(BasetableVAL, function(x) as.numeric(as.character(x))))

stdev <- sapply(trainKNN,sd)
means <- sapply(trainKNN,mean)

trainKNN <- data.frame(t((t(trainKNN)-means)/stdev))
valKNN <- data.frame(t((t(valKNN)-means)/stdev))


#FOR VAL:

# auc(roc(predKNN,yTEST))
#if we want to tune:
#tuning comes down to evaluating which value for k is best
aucVAL <- numeric()
for (k in 1:50) {
  #retrieve the indicators of the k nearest neighbors of the query data 
  indicatorsKNN <- as.integer(knnx.index(data=trainKNN, 
                                         query=valKNN, 
                                         k=k))
  #retrieve the actual y from the training set
  predKNN <- as.integer(as.character(yTRAIN[indicatorsKNN]))
  #if k > 1 then we take the proportion of 1s
  predKNN <- rowMeans(data.frame(matrix(data=predKNN,
                                        ncol=k,
                                        nrow=nrow(valKNN))))
  
  #COMPUTE AUC 
  aucVAL[k] <- AUC::auc(roc(predKNN,yVAL))
  
  #Print progress to the screen
  if((k %% max(floor(nrow(trainKNN)/10),1))==0) 
    cat(round((k/nrow(trainKNN))*100),"%\n")
}

plot(1:50,aucVAL[1:50],type="l", xlab="k", ylim=c(0.5,1))
#very low values of k result in a very flexible classifier: low bias, high variance
#very high values of k result a very inflexbile classifier: high bias, low variance
#when k equals the the number of training instances then all response values are selected once per new (i.e., validation) data point. 
#Then all values of predKNN will have mean(as.integer(as.character(yTRAIN))).

#NOW FOR TRAIN

aucTRAIN <- numeric()
for (k in 1:50) {
  #retrieve the indicators of the k nearest neighbors of the query data 
  indicatorsKNN <- as.integer(knnx.index(data=trainKNN, 
                                         query=trainKNN, 
                                         k=k))
  #retrieve the actual y from the training set
  predKNN <- as.integer(as.character(yTRAIN[indicatorsKNN]))
  #if k > 1 then we take the proportion of 1s
  predKNN <- rowMeans(data.frame(matrix(data=predKNN,
                                        ncol=k,
                                        nrow=nrow(trainKNN))))
  
  #COMPUTE AUC 
  aucTRAIN[k] <- AUC::auc(roc(predKNN,yTRAIN))
  
  #Print progress to the screen
  if((k %% max(floor(nrow(trainKNN)/10),1))==0) 
    cat(round((k/nrow(trainKNN))*100),"%\n")
}

lines(1:50,aucTRAIN[1:50],type="l", xlab="k", col='blue')


# Describe what you see using the theory that we saw in the 'Understanding classifier performance' section.
# The black line is the prediction performance and the blue line is the training performance.
# When k is very small the AUC on the validation set is low compared to the AUC on the training performance.
# This points to overfitting. As k increases all the way up to 50 the lines seem to converge,
# pointing to underfitting. The optimal k within the 1 to 50 range seems to be around 15.