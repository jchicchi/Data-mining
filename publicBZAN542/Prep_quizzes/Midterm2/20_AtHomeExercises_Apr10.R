# At-Home Exercises 20, Apr 10, 2017

# Topic:
# SVM

######################################################################
# Exercise 1: 
#Run the following code:
source("http://ballings.co/hidden/aCRM/code/chapter2/read_data_sets.R")
train <- BasetableTRAIN
ytrain <- yTRAIN
val <-   BasetableVAL
yval <- yVAL
test <- BasetableTEST
ytest <- yTEST
rm(list=ls()[!ls() %in% c("train","ytrain","val","yval","test","ytest")])
ls()
# Grow a SVM model on "test"   "train"  "val"    "ytest"  "ytrain" "yval" 
# and find the optimal parameter values out of:
# SV.cost <- 2^(-5:13) 
# SV.gamma <-  2^(-15:3) 
# SV.degree <-  c(1,2,3)
# SV.kernel <- c('radial','polynomial')
# This can take more than one hour, depending on your system.
# Write down the optimal parameter values as a comment
# Make predictions, and assess the final model performance.
# Answer:

if (require("e1071")==FALSE) {
  install.packages("e1071",
                   repos="https://cran.rstudio.com/", 
                   quiet=TRUE)  
  require(e1071)
}
#load the package AUC to evaluate model performance
if(require('AUC')==FALSE)  {
  install.packages('AUC',
                   repos="https://cran.rstudio.com/", 
                   quiet=TRUE) 
  require('AUC')
}

#Run an external function to facilitate tuning 
source("http://ballings.co/hidden/aCRM/code/chapter2/tuneMember.R")

#tuning grid

SV.cost <- 2^(-5:13)
SV.gamma <-  2^(-15:3)
SV.degree <-  c(1,2,3)
SV.kernel <- c('radial','polynomial')

result <- list()

for (i in SV.kernel) {
          call <- call("svm", 
                        formula = as.factor(ytrain) ~ ., 
                        data=train, 
                        type = "C-classification",
                        probability=TRUE)
          #the probability model for classification fits a logistic distribution using       
          #maximum likelihood to the decision values of the binary classifier
          
          if (i=='radial'  ) tuning <- list(gamma = SV.gamma, 
                                            cost = SV.cost, 
                                            kernel='radial')
          if (i=='polynomial') tuning <- list(gamma = SV.gamma, 
                                              cost = SV.cost, 
                                              degree=SV.degree, 
                                              kernel='polynomial')
          
          #tune svm
          result[[i]] <- tuneMember(call=call,
                               tuning=tuning,
                               xtest=val,
                               ytest=yval,
                               probability=TRUE)
          
}
result

#select the best set of parameters
auc <- numeric()
for (i in 1:length(result)) auc[i] <- result[[i]]$auc

result <- result[[which.max(auc)]]

# Optimal parameter values:
# > result
# $radial
#       gamma cost kernel       auc
# 201 0.03125   32 radial 0.9169097
# 
# $polynomial (THIS ONE WINS)
#            gamma cost degree     kernel       auc
# 1071 0.001953125 8192      3 polynomial 0.9231775

#now predict using these optimal parameters
SV <- svm(as.factor(ytrain) ~ ., 
          data = train,
          type = "C-classification", 
          kernel = as.character(result$kernel), 
          degree= if (is.null(result$degree)) 3 else result$degree, 
          cost = result$cost, 
          gamma = if (is.null(result$gamma)) 1 / (ncol(train)+ncol(val)) else result$gamma, 
          probability=TRUE,
          cachesize=1000)
            
#Compute the predictions for the test set
predSV <- as.numeric(attr(predict(SV,test, probability=TRUE),"probabilities")[,"1"])

head(predSV)

#Final performance:
AUC::auc(roc(predSV,ytest))

# Note: if your AUC is smaller than 0.5, this means you are overfitting
# We'll see what this means, and how to handle it in subsequent classes.

# Note that svm will produce the following warning:
#   WARNING: reaching max number of iterations

# This warning means that the iterative routine used by svm to solve quadratic 
# optimization problem in order to find the maximum margin hyperplane 
# (i.e., parameters ww and bb) separating your data reached the maximum number of 
# iterations and will have to stop, while the current approximation for w can be 
# further enhanced (i.e., w can be changed to make the value of the objective 
# function more extreme). In short, that means the svm thinks it failed to find the 
# maximum margin hyperplane, which may or may not be true.
# http://stats.stackexchange.com/questions/37669/libsvm-reaching-max-number-of-iterations-warning-and-cross-validation

# In other words: we are having svm try parameter values that result in a difficult
# optimization problem, and it is unable to converge within a reasonble number of 
# iterations. This is nothing to worry about, as the goal is to find the best 
# parameter values and we are focused on prediction; we are only interested in the model 
# performance, and if these warnings are of significance we will catch that by looking at the AUCs.