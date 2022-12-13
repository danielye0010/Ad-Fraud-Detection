library(data.table)
library(dplyr)
library(e1071)
library(caret)
library(boot)

args = (commandArgs(trailingOnly=TRUE))
pathname = toString(args[1])
pathname2 = toString(args[2])

train <- fread(pathname, select =c("ip", "app", "device", "os", "channel", "is_attributed"),showProgress=F,colClasses=c("ip"="numeric","app"="numeric","device"="numeric","os"="numeric","channel"="numeric","is_attributed"="numeric"))

train <- train[sample(.N, 300000)]
test <- fread(pathname2, select =c("ip", "app", "device", "os", "channel", "is_attributed"),showProgress=F,colClasses=c("ip"="numeric","app"="numeric","device"="numeric","os"="numeric","channel"="numeric","is_attributed"="numeric"))

dtrain <- data.table(train)
dval <- data.table(test)

#y <- sampled_train$is_attributed
#train_index <- 1:nrow(sampled_train)

#dtrain <- sampled_train[train_index]
#dval <- sampled_train[-train_index]

dtrain$is_attributed <- as.factor(dtrain$is_attributed)
dval$is_attributed <- as.factor(dval$is_attributed)

svm_model <- svm(formula = is_attributed ~ ip + app + device + os + channel + hour,
               data = dtrain,
               type = 'C-classification',
               kernel = 'linear')

prediction <- predict(svm_model, dval, type="response")
prediction

error <- mean(prediction != dval$is_attributed)
accuracy <- 1 - error

accuracy
df <- confusionMatrix(as.factor(prediction), as.factor(dval$is_attributed),mode = "prec_recall", positive="1")
df

df$byClass['Precision']

df$byClass['Recall']

df$byClass['F1']

