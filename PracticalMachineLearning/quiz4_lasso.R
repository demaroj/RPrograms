set.seed(3523)
library(AppliedPredictiveModeling)
library(e1071)
library(caret)
library(forecast)
data("concrete")

inTrain = createDataPartition(concrete$CompressiveStrength, p=3/4)[[1]]
training = concrete[ inTrain, ]
testing = concrete [-inTrain,]
head(training)

set.seed(323)
# mod_lasso <- train(CompressiveStrength ~., data=training, method="lasso")
# library(elasticnet)
# plot.enet(mod_lasso$finalModel, xvar="penalty", use.color=TRUE)
# head(mod_lasso$finalModel)

mod <- svm(CompressiveStrength ~., data=training)

pred <- predict(mod, testing)

