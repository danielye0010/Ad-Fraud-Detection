library(ggplot2)
library(ROSE)
library(randomForest)
library(caret)
library(e1071)

rm(list=ls())
#library(smotefamily)#SMOTE Balancing
#rm(list=ls())
dir=getwd()
setwd(dir)
#setwd("/Users/wanxintu/Documents/GitHub/STAT605_Project")
mydata <- read.csv('train_sample.csv')

#feature

####https://www.kaggle.com/code/swamysm/fraud-detection-by-random-forest-dt-and-svm
####App was downloaded v/s App id for marketing
p2=ggplot(mydata,aes(x=app,fill=is_attributed))+
  geom_density()+facet_grid(is_attributed~.)+
  scale_x_continuous(breaks = c(0,50,100,200,300,400))+
  ggtitle("Application ID v/s Is_attributed")+
  xlab("App ID") +
  labs(fill = "is_attributed")  

p2

###App was downloaded vs OS version id of user mobile phone
p5=ggplot(mydata,aes(x=os,fill=is_attributed))+
  geom_density()+facet_grid(is_attributed~.)+
  scale_x_continuous(breaks = c(0,50,100,200,300,400))+
  ggtitle("Os version v/s Is_attributed ")+
  xlab("Os version") +
  labs(fill = "is_attributed")

p5

###App was downloaded v/s ip address of click.
p8=ggplot(mydata,aes(x=ip,fill=is_attributed))+
  geom_density()+facet_grid(is_attributed~.)+
  scale_x_continuous(breaks = c(0,50,100,200,300,400))+
  ggtitle("IP Address v/s Is_attributed")+
  xlab("Ip Adresss of click") +
  labs(fill = "is_attributed")  

#data banlancing
barplot(prop.table(table(mydata$is_attributed)),
        col = rainbow(2),
        ylim = c(0, 1),
        main = "is_attribute Distribution")
##over sampling
over <- ovun.sample(is_attributed~., data = mydata, method = "over")$data
table(over$is_attributed)

#smote balancing
#smote_data = SMOTE(is_attributed ~ ., data  = mydata)                         
 

