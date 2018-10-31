# In-Class Assignment 21, Apr 12, 2017

######################################################################

# Topic:
# Performance measures for binary classification models


######################################################################
######################################################################
######################################################################
######################################################################
# Exercise 3: 
# Consider the following data:
library(AUC)
data(churn)
#predictions of model 1
churn$predictions
#predictions of model 2
churn$predictions2
#dependent variable:
churn$labels

# Step 1: Compute the single cutoff sensitivity for the cutoff corresponding to
# the top 13% of instances in each model. Which model is best?
# Step 2: Which model is best in terms of sensitivity if we use all possible cutoffs?
# Step 3: Plot the sensitivity curve for model 1 and 2 in one plot. 
# Also plot a vertical line at cutoff=0.87
# Answer:


# Step 1: 
sum((ifelse((rank(churn$predictions)/length(churn$predictions)) >= 0.87,1,0)==as.integer(as.character(churn$labels)))[churn$labels==1])/sum(churn$labels==1)
sum((ifelse((rank(churn$predictions2)/length(churn$predictions2)) >= 0.87,1,0)==as.integer(as.character(churn$labels)))[churn$labels==1])/sum(churn$labels==1)
# model 1

# Step 2:
library(AUC)
AUC::auc(sensitivity(churn$predictions,churn$labels))
AUC::auc(sensitivity(churn$predictions2,churn$labels))
# model 2

# Step 3:
plot(sensitivity(churn$predictions,churn$labels))
plot(sensitivity(churn$predictions2,churn$labels), add=TRUE, col="blue")
abline(v=0.87)

######################################################################
# Exercise 4: 
#Run the following code:
source("http://ballings.co/hidden/aCRM/code/chapter2/read_data_sets.R")
trainind <- sample(1:nrow(BasetableTRAIN),10000,TRUE)
train <- BasetableTRAIN[trainind,]
ytrain <- yTRAIN[trainind]
valind <- sample(1:nrow(BasetableVAL),10000,TRUE)
val <-   BasetableVAL[valind ,]
yval <- yVAL[valind]
testind <-  sample(1:nrow(BasetableTEST),10000,TRUE)
test <- BasetableTEST[testind,]
ytest <- yTEST[testind]
rm(list=ls()[!ls() %in% c("train","ytrain","val","yval","test","ytest")])
ls()

library(rpart)
tree <- rpart(ytrain ~ ., train)
predtree <- as.numeric(predict(tree,test,type="prob")[,2])

library(glmnet)
LR <- glmnet(x=data.matrix(train), y=ytrain,
               family="binomial")

predglmnet <- predict(LR,
                      newx=data.matrix(test), 
                      type="response", s=LR$lambda[20])

# We now have the predictions of two models: predtree (a decision tree) and
# predglmnet (a logistic regression). 
# Step 1: Plot the distribution of the predictions
# of both models in one plot (hint: plot() and density()).
# Step 2: Plot the distributions of the percentile ranks
# of both models in one plot.
# Step 3: Explain why step 2 does not show perfectly uniform
# distributions as discussed in the book and video.
# Answer:

# Step 1:
plot(density(predglmnet),xlim=c(0,1))
lines(density(predtree), col="blue")

# Step 2:
plot(density(rank(predglmnet)/length(predglmnet)), ylim=c(0,10))
lines(density(rank(predtree)/length(predtree)))

# Step 3:
table(predtree)
# Because of ties in the predictions. Nothing, not even 
# percentile ranks, can overcome ties.

######################################################################
# Exercise 5: 
# Consider the following data frame:
(df <- data.frame(predictions=c(0.782989666797221, 0.396416301606223, 0.303133016685024, 0.923368541989475, 
                                0.319885071134195, 0.125285075511783, 0.11375162191689, 0.432317626429722, 
                                0.208641356555745, 0.768129289150238, 0.260139840887859, 0.390128860948607, 
                                0.262222028337419, 0.0803461223840714, 0.708388309692964),
                  dependent=c(1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 1, 1)))
# Create a calibrator dataset with 3 bins. 
# The midpoints are the means of the predictions in the bins.                      
# Hints: cut(), aggregate()
# Answer:

x_bin <- cut(df$predictions, breaks=seq(0,1,by=1/3) ,labels=FALSE)
x_mean <- data.frame(aggregate(df$predictions,by=list(x_bin),mean)$x)
names(x_mean) <- "x_mean"
y_prop <- aggregate(as.integer(as.character(df$dependent)),by=list(x_bin),mean)$x
(calibratordataset <- data.frame(x_mean,y_prop))


