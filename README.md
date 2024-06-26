Kaggle link: https://www.kaggle.com/competitions/talkingdata-adtracking-fraud-detection/overview


Contributors: Daniel Ye, David Gao, Wanxin Tu, Yujie Zhao, Zihan Tang

### Project Introduction
To analyze today’s online Ad fraud we used four models to predict whether a download of the app was made by a click, or the download request was sent by a malicious device. To analyze the data we first split the original file into 30 pieces, and then utilize the CHTC to run 30 parallel jobs to extract our training data by using the over sampling method. After we get the extractions, we merge them together as our training data, and then using CHTC to run models: logistics regression, Naive Bayes, Support Vector Machine and Random Forest.

### Directory Information

- All codes for the project are in projectCHTC.tar
- Procedure of running the code
  1. Unarchive the tar file: `tar -xzf projectCHTC.tar`
  2. Submit the dag file to CHTC condor: `condor_submit_dag submit_jobs.dag`
  3. The results will come out as a text file called `model_results.txt`
  4. (The whole process would be around 2.5 hours)

