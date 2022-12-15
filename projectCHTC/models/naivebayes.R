library(data.table)
library(dplyr)
library(e1071)
library(caret)
library(boot)
library(ROSE)

args = (commandArgs(trailingOnly=TRUE))
pathname = toString(args[1])
pathname2 = toString(args[2])

train <- fread(pathname, select =c("ip", "app", "device", "os", "channel", "is_attributed"),showProgress=F,colClasses=c("ip"="numeric","app"="numeric","device"="numeric","os"="numeric","channel"="numeric","is_attributed"="numeric"))

train <- train[sample(.N, 300000)]

dtrain <- data.table(train)

rm(train)
gc()

test <- fread(pathname2, select =c("ip", "app", "device", "os", "channel", "is_attributed"),showProgress=F,colClasses=c("ip"="numeric","app"="numeric","device"="numeric","os"="numeric","channel"="numeric","is_attributed"="numeric"))

test <- test[sample(.N, 200000)]
test <- ovun.sample(is_attributed~., data=test, method = "over")$data
dval <- data.table(test)

rm(test)
gc()

dtrain$is_attributed <- as.factor(dtrain$is_attributed)
dval$is_attributed <- as.factor(dval$is_attributed)

naiveBayes_model <- naiveBayes(is_attributed ~ ., 
                        data = dtrain)

prediction <- predict(naiveBayes_model, dval)

error <- mean(prediction != dval$is_attributed)
accuracy <- 1 - error

accuracy
df <- confusionMatrix(as.factor(prediction), as.factor(dval$is_attributed),mode = "prec_recall", positive="1")
df

stat_out <- data.table(
  Accuracy = df$overall['Accuracy'],
  Precision = df$byClass['Precision'],
  Recall = df$byClass['Recall'],
  Balanced_Accuracy = df$byClass['Balanced Accuracy'])
stat_out

write.table(stat_out,"naivebayes.txt",sep=",",row.names=FALSE)


