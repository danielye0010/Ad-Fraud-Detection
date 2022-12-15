library(data.table)
library(dplyr)
library(randomForest)
library(caret)
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

rfboth <-randomForest(is_attributed~., data=dtrain,proximity = FALSE)

p1 <- predict(rfboth, dval)
df <- caret::confusionMatrix(p1, dval$is_attributed, mode = "prec_recall")

df$byClass['Precision']

df$byClass['Recall']

df$byClass['F1']

print(df)

stat_out <- data.table(
  Accuracy = df$overall['Accuracy'],
  Precision = df$byClass['Precision'],
  Recall = df$byClass['Recall'],
  Balanced_Accuracy = df$byClass['Balanced Accuracy'])

write.table(stat_out,sep=',', file = "randomForest.txt",row.names=FALSE)






