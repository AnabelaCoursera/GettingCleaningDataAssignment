## Load and Unzip DataSet.zip to /data directory
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")
unzip(zipfile="./data/Dataset.zip",exdir="./data")
setwd("./Data/UCI HAR Dataset")
###Load required packages
library(dplyr)
library(data.table)
## Read Global Files and set names to variables
activity <- read.table("activity_labels.txt")
colnames(activity) <- c("codActivity","descActivity")
features <- read.table("features.txt")
colnames(features) <- c("codFeature","descFeature")
### Read Train Files and set names to variables
setwd("./train")
## Subject Train: 7352 obs --> 21 People = 70% by Group volunteers 
subjectTrain <- read.table("./subject_train.txt")
colnames(subjectTrain) <- c("numberPeople")
## Activity Train: 7352 obs  --> str(unique(activityTrain)) 6 Activity
activityTrain <- read.table("./y_train.txt")
colnames(activityTrain) <- c("codActivity")
## Features Train: 7352 obs of 561 variables  
featureTrain <- read.table("./x_train.txt")
colnames(featureTrain) <- features$descFeature
### Read Test Files and set names to variables
setwd("../test")
## Subject Test: 2947 obs --> 9 People = 30% by Group volunteers 
subjectTest <- read.table("./subject_test.txt")
colnames(subjectTest) <- c("numberPeople")
## Activity Test: 2947 obs  --> str(unique(activityTest)) 6 Activity
activityTest <- read.table("./y_test.txt")
colnames(activityTest) <- c("codActivity")
## Featrure Test: 2947 obs of 561 variables  
featureTest <- read.table("./x_test.txt")
colnames(featureTest) <- features$descFeature
## 
## 1.Merges the training and the test sets to create one data set.
## 1.1 First concatenate (same) data files
dataSubject <- rbind(subjectTrain, subjectTest)     ## 10299 obs
dataActivity<- rbind(activityTrain, activityTest)   ## 10299 obs
dataFeature <- rbind(featureTrain, featureTest)     ## 10299 obs of 561 variables
## 1.2 Second Merge (different) data files to create One Data Set. 
data <- cbind(dataSubject,dataActivity,dataFeature)
##
## 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
featureFilter <- grep("mean\\(\\)|std\\(\\)",names(dataFeature),value = TRUE)
data <- subset(data,select=c("numberPeople","codActivity",featureFilter))
## 
## 3.Uses descriptive activity names to name the activities in the data set
data <- merge(activity,data,by="codActivity")
##
## 4.Appropriately labels the data set with descriptive variable names. 
names(data)<-gsub("^t", "time", names(data))
names(data)<-gsub("^f", "frequency", names(data))
names(data)<-gsub("Acc", "Accelerometer", names(data))
names(data)<-gsub("Gyro", "Gyroscope", names(data))
names(data)<-gsub("Mag", "Magnitude", names(data))
names(data)<-gsub("BodyBody", "Body", names(data))
##
## 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
setwd("../")
library(plyr)
secondData <- data[,-2]
secondData <- aggregate(. ~numberPeople + codActivity, secondData, mean)
secondData <- merge(activity,secondData,by="codActivity")
arrange(secondData,numberPeople,codActivity)
write.table(secondData, file = "tidy.txt",row.name=FALSE)


