#!/bin/bash

rm -rf model_results.txt

printf "logistic: " >> model_results.txt
cat logistic.txt >> model_results.txt
rm logistic.txt

printf "naiveBayes: " >> model_results.txt
cat naivebayes.txt >> model_results.txt
rm naivebayes.txt

printf "svm: " >> model_results.txt
cat svm.txt >> model_results.txt
rm svm.txt

printf "randomForest: " >> model_results.txt
cat randomForest.txt >> model_results.txt
rm randomForest.txt
