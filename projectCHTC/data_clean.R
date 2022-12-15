library(data.table)
library(ROSE)


args = (commandArgs(trailingOnly=TRUE))
pathname = toString(args[1])

train <- fread(pathname, select =c("ip", "app", "device", "os", "channel", "is_attributed"),showProgress=F,colClasses=c("ip"="numeric","app"="numeric","device"="numeric","os"="numeric","channel"="numeric","is_attributed"="numeric"))

# Oversampling
balanced_train <- ovun.sample(is_attributed~., data=train, method = "over")$data
balanced_train <- data.table(balanced_train)

sampled_train <- balanced_train[sample(.N, 10000)]
y <- sampled_train$is_attributed
train_index <- 1:nrow(sampled_train)


dtrain <- sampled_train[train_index]


write.csv(dtrain, file=paste(sep='','train_cleaned',substr(pathname,12,13),'.csv'))



