# At-Home Exercises 25, Apr 25, 2017

# Topic:
# Deployment

# Subsequent questions may depend on previous ones.

######################################################################
# Question 1: Method dispatching
# Consider the following code. We are interested in the output of the last line of code: predict(model)
# We want predict(model) to call predict.acquisition(model) using method dispatching.
# In this case predict(model) should output the string "predictions from our model". To make this happen we 
# need to add something to the acquisitionModel function. 
# Add the code that we need at the right place in the acquisitionModel function definition.
# Do not change anything outside the acquisitionModel function definition.
# Test your code.

acquisitionModel <- function(x){
  a <- 'an acquisition model'
  a
}

#do not change anything after this line:
model <- acquisitionModel()

predict.acquisition <- function(object) {
  a <- 'predictions from our model'  
  a
}

predict(model)
#end of do not change

# Answer:

acquisitionModel <- function(x){
  a <- 'an acquisition model'
  class(a) <- 'acquisition' #####This is the new line of code
  a
}

model <- acquisitionModel()
predict(model)