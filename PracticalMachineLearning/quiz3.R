library(ElemStatLearn)
library(caret)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]

missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}

set.seed(13234)
modelSA <- train(chd~age+alcohol+obesity+tobacco+typea+ldl, data=trainSA, method="glm", family="binomial")

missClass(trainSA$chd,predict(modelSA, newdata=trainSA))
testMis <-missClass(testSA$chd, predict(modelSA, newdata=testSA))
testMis

data("vowel.train")
data("vowel.test")
