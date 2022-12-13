library(data.table)
library(ROSE)


args = (commandArgs(trailingOnly=TRUE))
pathname = toString(args[1])

train <- fread(pathname, select =c("ip", "app", "device", "os", "channel", "is_attributed"),showProgress=F,colClasses=c("ip"="numeric","app"="numeric","device"="numeric","os"="numeric","channel"="numeric","is_attributed"="numeric"))

# Undersampling
balanced_train <- ovun.sample(is_attributed~., data=train, method = "under")$data
balanced_train <- data.table(balanced_train)

sampled_train <- balanced_train
y <- sampled_train$is_attributed
train_index <- 1:nrow(sampled_train)


dtrain <- sampled_train[train_index]
dval <- sampled_train[-train_index]


write.csv(dtrain, file=paste(sep='','train_cleaned',substr(pathname,12,13),'.csv'))



