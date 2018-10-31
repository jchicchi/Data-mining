# At-Home Exercises 12, Mar 1, 2017

# Topic:
# Train, validate and test
# Naive Bayes
if (!require("e1071")) {
        install.packages('e1071',
                         repos="https://cran.rstudio.com/", 
                         quiet=TRUE) 
        require('e1071')
}


######################################################################
# Exercise 1:
# This is a question about Naive Bayes. 
# Consider the following dataset df. What is the probability 
# of churn=1 for a new instance that has tenure="medium" and 
# spend="high"? 
# Compute the probability manually (i.e., compute the required
# terms of the equation), and verify your result with the
# naiveBayes and predict functions in the e1071 package.
(df <- 
  data.frame(
            churn=c(0,0,1,1,1,0,1,0,1,1,1,1,1,0),
            tenure=c("long","long","short","medium",
                     "medium","medium","short","long",
                     "long","medium","long","short",
                     "short","medium"),
            spend=c("high","high","high","medium",
                    "low","low","low","medium",
                    "low","medium","medium","medium",
                    "high","medium")))
# Answer:

# Manual computation:

# churn: compute the percentage
(churn <- table(df[,1])/sum(table(df[,1])))

#tenure: compute the percentage by column total
(tenure <- t(t(table(df[,2],df[,1]))/colSums(table(df[,2],df[,1]))))

#spend: compute the percentage by column total
(spend <- t(t(table(df[,3],df[,1]))/colSums(table(df[,3],df[,1]))))

# The above contingency tables are the
# inputs for our model.

# Consider a new instance with the following characteristics:
#   tenure=medium
#   spend=high


# What is the probability of churn?

# P (churn=1 | tenure=medium & spend=high) = 

# Numerator:
#       P( tenure=medium | Y = 1 )
#     x P( spend=high | Y = 1 )
#     x P( churn = 1) =
(Num <- tenure["medium","1"] * 
              spend["high","1"] * 
              churn["1"])

# Denominator:
#     P ( tenure=medium & spend=high )=
#     P( tenure=medium | churn = 0 )
#     x P( spend=high | churn = 0 )
#     x P( churn = 0) 
#   +   P( tenure=medium | churn = 1 )
#     x P( spend=high | churn = 1 )
#     x P( churn = 1) 
(Denom <- 
  tenure["medium","0"] * 
  spend["high","0"] * 
  churn["0"]
  +
  Num)

Num/Denom


#Verify this with the e1071 package:

library(e1071)

NB <- naiveBayes(df[,2:3],y=df[,"churn"])

# Extract the levels from the training data
(lev <- sapply(df[,2:3],levels))

#Then apply the levels to the new data
(new  <- data.frame(tenure="medium",
                   spend="high"))
str(new)

result <- data.frame(sapply(1:ncol(new)
                         , function(x) factor(new[,x], levels=lev[,x])
                         , simplify=FALSE))

colnames(result) <- colnames(new)
str(result)

predict(NB
        , res
        , type="raw")[,2]

#Both result in 0.4545455 (our manual calculation is correct)


