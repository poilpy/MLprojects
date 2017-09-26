# Support vector machine for Iris dataset using e1071 library

library(RCurl)
library(e1071)
library(caret)

# Load data
urlfile <- 'http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data'
downloaded <- getURL(urlfile, 
                     ssl.verifypeer=FALSE)
connection <- textConnection(downloaded)
irisSet <- read.csv(connection, 
                    header = FALSE)

# Attach names/labels
names(irisSet) <- c("Sepal.Length", 
                    "Sepal.Width", 
                    "Petal.Length", 
                    "Petal.Width", 
                    "Species")

# Separate data into train and test
bound <- floor((nrow(irisSet)/4)*3)
irisSet <- irisSet[sample(nrow(irisSet)), ] # create sample
irisSet.train <- irisSet[1:bound, ]
irisSet.test <- irisSet[(bound+1):nrow(irisSet), ]

# Separate train and test into x and y
irisSet.train.x <- subset(irisSet.train, 
                          select=-Species)
irisSet.train.y <- irisSet.train$Species

irisSet.test.x <- subset(irisSet.train, 
                         select=-Species)
irisSet.test.y <- irisSet.train$Species

# Train Support Vector Machine and print summary
svm_model <- svm(irisSet.train.x, 
                 irisSet.train.y)
print(summary(svm_model))

print("-----------------------------------------")

# Predict and print confusion matrix
pred <- predict(svm_model, 
                irisSet.test.x)
print(table(irisSet.test.y))
print(table(pred, 
            irisSet.test.y))

# Tune svm and plot gamma spread
svm_tune <- tune(svm, 
                 train.x=irisSet.train.x, 
                 train.y=irisSet.train.y, 
                 kernel="radial", 
                 ranges=list(cost=10^(-1:2), 
                             gamma=c(.5,1,2)))
print(svm_tune)

# Remake Svm
svm_model_t <- svm(irisSet.train.x, 
                   irisSet.train.y, 
                   gamma=0.5)
print(summary(svm_model_t))

# Predict and print confusion matrix + accuracy
pred <- predict(svm_model, 
                irisSet.test.x)
print(as.table(confusionMatrix(table(pred, irisSet.test.y))))
print(as.matrix(confusionMatrix(table(pred, irisSet.test.y)), what="overall"))


# 
# Thoughts:
# After tune: 97% accuracy
# 
