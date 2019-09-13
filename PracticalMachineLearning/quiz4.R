library(ElemStatLearn)
library(caret)
library(randomForest)
data(vowel.train)
data(vowel.test)
vowel.train$y <-as.factor(vowel.train$y)
vowel.test$y <-as.factor(vowel.test$y)

set.seed(33833)

rfp1 <- train(y ~., data=vowel.train, method="rf")
bp1 <- train(y ~ ., data=vowel.train, method = "gbm")

rfpPred <- predict(rfp1, vowel.test)
bpPred <- predict(bp1, vowel.test)

confusionMatrix(rfpPred,vowel.test$y)
confusionMatrix(bpPred, vowel.test$y)

predDF <- data.frame(rfpPred, bpPred, y=vowel.test$y)



