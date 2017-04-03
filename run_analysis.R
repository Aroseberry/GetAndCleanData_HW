## 02 April 2017
## ARL
## Final assignment, "Getting & Cleaning Data"
## JHU Data Science Certificate Program (Coursera)

## Goals:
## 1. Merge training and test sets to create one data set
##     Check format of the data sets. Is it okay to append w/col for source?
## 2. Extract only the measurements on the mean and sd for each measure
## 3. Use descriptive activity names to name the activities in the data set
## 4. Appropriately lavel the data set with descriptive variable names
## 5. From the data set in step 4, create a second, independent data set
##     with the average of each variable for each activity and each subject

## NOTES regarding raw data files 

# All data files appear to be space-delimited, with one or more spaces
# as the delimiters (use readr:read_table)

# features_info.txt: info on 561 feature variables
# features.txt: names of the 561 feature variables (vector)
# activity_labels.txt: lookup table converting 1:6 into labels

# X_train.txt: feature data for all training set subject/activities
#     ncol = 561, nrow = 7353
# y_train.txt: activity values (1:6) (vector, length = 7353)
# subject_train.txt: subject IDs (anonymized) (vector, length = 7353)

# X_test.txt: feature data for all test set subject/activities
#     ncol = 561, nrow = 2948
# y_test.txt: activity values (1:6) (vector, length =2948)
# subject_test.txt: subject IDs (anonymized) (vector, length = 2948)

# Inertial signals files should not be required, as the mean and std 
# data needed are provided in the X_train and X-test files

library(readr)
library(dplyr)
library(reshape2)

# obtain raw data
setwd("C:/Users/ann.lincoln/Documents/jhu_ds/GetCleanData/FinalAssignment/GetAndCleanData_HW")
if (!file.exists("./data")) {
    dir.create("./data")
}
setwd("./data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "UCIHARDataset.zip")
dateDownloaded <- date()
unzip("UCIHARDataset.zip", unzip = "internal")

list.files("./UCI HAR Dataset")

# read data common to both train and test datasets
act.labels <- read.delim("./UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = "")
names(act.labels) <- c("activity", "activityName")
features <- read.delim("./UCI HAR Dataset/features.txt", header = FALSE, sep = " ")
labels <- c("subject", "activity", as.vector(features[,2]))

# read train data
x.train <- read_table("./UCI HAR Dataset/train/x_train.txt", col_names = FALSE)
y.train <- read_table("./UCI HAR Dataset/train/y_train.txt", col_names = FALSE)
subject.train <- read.delim("./UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = "")

# combine subject, activity with x.train data
x.train <- cbind(subject.train, y.train, x.train)
names(x.train) <- labels
x.train$dataset <- rep("train", nrow(x.train))

# read test data
x.test <- read_table("./UCI HAR Dataset/test/x_test.txt", col_names = FALSE)
y.test <- read_table("./UCI HAR Dataset/test/y_test.txt", col_names = FALSE)
subject.test <- read.delim("./UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = "")

# combine subject, activity with x.test data
x.test <- cbind(subject.test, y.test, x.test)
names(x.test) <- labels
x.test$dataset <- rep("test", nrow(x.test))

# append test data to train data
x.data <- rbind(x.train, x.test)
x.data <- merge(act.labels, x.data, all=TRUE)

# identify the features required in the final tidy data
use.features <- as.vector(grep("mean|std",features[,2], ignore.case = TRUE, value = TRUE))
use.data <- x.data[,c("activityName", "subject", use.features)]
use.data <- arrange(use.data, subject, desc(activityName))

# change feature names to remove non-alphanumeric characters
names(use.data) <- gsub("-mean","Mean",names(use.data))
names(use.data) <- gsub("-std","Std",names(use.data))
names(use.data) <- gsub("gravity","Gravity",names(use.data))
names(use.data) <- gsub("[[:punct:]]","",names(use.data))

# create data set with mean for each feature for each activity and subject
tidy.data <- use.data %>% group_by(activityName, subject) %>% summarize_all(mean)

write.table(tidy.data, file = "./TidyUCIHARDataset.txt", sep = "\t", col.names = TRUE
            , row.names = FALSE)
