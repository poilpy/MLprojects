# Support vector machine for Iris dataset using e1071 library

library(RCurl)
library(e1071)
library(caret)

# Load data
urlfile <- 'http://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data'
downloaded <- getURL(urlfile, 
                     ssl.verifypeer=FALSE)
connection <- textConnection(downloaded)
adultSet <- read.csv(connection, 
                    header = FALSE)

