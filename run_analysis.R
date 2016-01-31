##
## Coursera Data Science Specialization: Getting and Cleaning Data
## Assignment 4: Course Project - Getting and Cleaning data collected from the accelerometers from the Samsung Galaxy S smartphone
## Pierluigi Grillo
## 2016-01-30
##


## Download and unzip the dataset
## Check if dataset dir exist. If not, download the archive, unzip it in working dir

if(!file.exists("UCI HAR Dataset"))
{
    message('Dataset doesn\'t exists, I download the archive and extract it in working dir')
    temp <- tempfile()
    download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', temp, method="curl")
    unzip(temp, exdir = getwd())
    unlink(temp)
}


## Load features and activities labels

message('Read features and activities labels')
features <- read.table('UCI HAR Dataset/features.txt')
features[,2] <- as.character(features[,2])
activities <- read.table('UCI HAR Dataset/activity_labels.txt')
activities[,2] <- as.character(activities[,2])


## Extract only the data on mean and standard deviation

message('Filter the data on mean and std and tidy features names')
filteredFeatures <- grep('*-mean*|*-std*', features[,2])
filteredFeaturesNames <- features[filteredFeatures, 2]
filteredFeaturesNames <- gsub('-mean', 'Mean', filteredFeaturesNames)
filteredFeaturesNames <- gsub('-std', 'Std', filteredFeaturesNames)
filteredFeaturesNames <- gsub('[-()]', '', filteredFeaturesNames)


## Load training set measurements, activities ids and subjects ids

message('Read the training set and filter only the interested features')
trainSet <- read.table('UCI HAR Dataset/train/X_train.txt')
trainSet <- trainSet[, filteredFeatures]
trainActivities <- read.table('UCI HAR Dataset/train/y_train.txt')
trainSubjects <- read.table('UCI HAR Dataset/train/subject_train.txt')
trainSet <- cbind(trainSubjects, activities[trainActivities[,1], 2], trainSet)
names(trainSet) <- c('subject', 'activity', filteredFeaturesNames)

message('Read the test set and filter only the interested features')
testSet <- read.table('UCI HAR Dataset/test/X_test.txt')
testSet <- testSet[, filteredFeatures]
testActivities <- read.table('UCI HAR Dataset/test/y_test.txt')
testSubjects <- read.table('UCI HAR Dataset/test/subject_test.txt')
testSet <- cbind(testSubjects, activities[testActivities[,1], 2], testSet)
names(testSet) <- c('subject', 'activity', filteredFeaturesNames)


## Merge training and test set together

allData <- rbind(trainSet, testSet)

allData$subject <- as.factor(allData$subject)
allData$activity <- as.factor(allData$activity)


## Create a new dataset starting from the previous results in order to compute the average of each variable for each activity and each subject

avgData <- aggregate(allData[, -(1:2)], by=list(allData$subject, allData$activity), FUN=mean)
names(avgData)[1:2] <- c('subject', 'activity')


## Save avgData to file

write.table(avgData, file = 'tidyData.txt', row.names = FALSE)
