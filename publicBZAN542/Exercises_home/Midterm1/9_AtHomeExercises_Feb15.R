# At-Home Exercises 9, Feb 15, 2017

# If you choose to submit these exercises:

# FIRST Write down your name:
# First name:
# Last name:

# SECOND Change the name of your file to
# firstname_lastname.R
# That is the file you need to submit.

# THIRD Save your answers in this file and submit it 
# before 11:40am, Feb 15 to this url:
# https://www.dropbox.com/request/eoakisSptyvFbYNGWinD

# Only provide code and comments, do not copy paste output.

# Topic:
# Basic Version Control
# Working with dates
# Creating functions

# Subsequent questions may depend on previous ones.

# Grading:
# Each question has equal weight, there are 2 questions


# Only provide code and comments, do not copy paste output.


######################################################################
# Exercise 1:
# 1. Create a new R script (File > New File > R Script ;or click the white sheet with the plus symbol).
# 2. Type 'test 1' in your script.
# 3. Save it to your Dropbox and call it test.R (do not close the file)
# 4. Change 'test 1' to 'test 2'
# 5. Save again
# 6. Change 'test 2' to 'test 3'
# 7. Save again
# 8. Use Windows Explorer (Windows) or Finder (Mac) to go test.R in your Dropbox
# 9. Right click the file and click: 'Version History'
# 10. Hover over the oldest version (i.e., the one on the bottom)
# 11. Click the 'Restore' button that appears and 'Restore' in the pop up window
# 12. Wait until you see a green check mark next to the file in Windows Explorer/Finder.
# 13. Click anywhere in RStudio

# Does your R Script in RStudio say 'test 1' or 'test 3'? In other words does RStudio pull
# the restored file or not?

# Answer:

# It shows 'test 1' once you click in RStudio. Yes it does pull the restored file.


######################################################################
# Exercise 2: 
# Consider the following character vector: 2015-10-21
# Convert that character to a date.
# Answer:

as.Date("2015-10-21")

