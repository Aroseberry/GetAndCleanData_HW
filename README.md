# GetAndCleanData_HW
## README
Class assignment for Getting and Cleaning Data, part of JHU Data Science certificate program on Coursera

### Contents
This folder contains the following files:
-- run_analysis.R -- Code to download, unzip, and modify the UCI HAR Dataset as instructed for the homework assignment
-- README.md -- this file, which explains the repo contents
-- CodeBook.md -- the "instructions" indicating each step taken to move from raw to tidy data
-- TidyUCIHARDataset.txt -- the final, tidy dataset, as required for the homework assignment

#### run_analysis.R
This code performs the following steps:
* it downloads the raw data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip into a "data" subdirectory in the working directory;
* it unzips the data into the "UCI HAR Dataset" directory within "data";
* it merges the training and test data sets to create one, combined data set;
* it extracts the only the measurements on the mean and standard deviation for each measurement;
* it replaces activity IDs (numeric) with descriptive activity names;
* it replaces punctuation in the column names (feature names) and converts names to CamelCase (not preferred by the class instructor, but preferred by my workplace, and therefore good practice for me); and
* it creates a second, independent tidy data set with the average of each selected feature (mean and std dev) for each activity and subject.

#### TidyUCIHARDataset.txt
This dataset summarizes for each activity and subject, the average of each measurement on the mean and standard deviation for each measurement in the raw data set. There are 6 activities and 30 subjects, for a total of 180 rows. There are a total of 86 measurements of mean or standard deviation for each measurement, giving 86 data columns (plus one column each for activity and subject). The file is a tab-delimited text file.

#### Intermediate files
Intermediate files (e.g., raw data files in zipped or unzipped format) are not maintained in this repository, since they are downloaded as part of the working script.
