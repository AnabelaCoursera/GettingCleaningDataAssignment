# GettingCleaningDataAssignment
Assignment: Getting and Cleaning Data Course Project
You can call the R script typing > source("run_analysis.R"). The script does the following:

1.Download the dataset if it does not already exist in the working directory and unzip dataset.zip
2.Load required packages
3.Read global files (activity and features) and set names to varaiables
3.Read both the training and test datasets and set names to variables
4.Merge the training and the test sets to create one data set
5.Extracts only the measurements on the mean and standard deviation for each measurement
6.Uses descriptive activity names to name the activities in the data set
7.Appropriately labels the data set with descriptive variable names
8.Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair

The end result is shown in the file  tidy.txt .
