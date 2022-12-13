library(data.table)
library(dplyr)
library(randomForest)
library(caret)

args = (commandArgs(trailingOnly=TRUE))
pathname = toString(args[1])
pathname2 = toString(args[2])

train <- fread(pathname, select =c("ip", "app", "device", "os", "channel", "is_attributed"),showProgress=F,colClasses=c("ip"="numeric","app"="numeric","device"="numeric","os"="numeric","channel"="numeric","is_attributed"="numeric"))

train <- train[sample(.N, 300000)]

test <- fread(pathname2, select =c("ip", "app", "device", "os", "channel", "is_attributed"),showProgress=F,colClasses=c("ip"="numeric","app"="numeric","device"="numeric","os"="numeric","channel"="numeric","is_attributed"="numeric"))

test <- test[sample(.N, 300000)]

dtrain <- data.table(train)
dval <- data.table(test)

rm(train,test)
gc()

#y <- sampled_train$is_attributed
#train_index <- 1:nrow(sampled_train)

#dtrain <- sampled_train[train_index]
#dval <- sampled_train[-train_index]

dtrain$is_attributed <- as.factor(dtrain$is_attributed)
dval$is_attributed <- as.factor(dval$is_attributed)

rfboth <-randomForest(is_attributed~., data=dtrain,proximity = FALSE)
rfboth

p1 <- predict(rfboth, dval)
df <- caret::confusionMatrix(p1, dval$is_attributed, mode = "prec_recall")

df$byClass['Precision']

df$byClass['Recall']

df$byClass['F1']

print(df)





