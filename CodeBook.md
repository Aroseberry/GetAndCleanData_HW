# GetAndCleanData_HW
## CODE BOOK

This code book describes the variables, data, and any transformations and work performed to clean up the data, as required for the class assignment for the Getting and Cleaning Data course, part of JHU Data Science certificate program on Coursera.

### Objectives:
1. Merge training and test sets to create one data set. Check format of the data sets. Is it okay to append w/col for source?
2. Extract only the measurements on the mean and sd for each measure
3. Use descriptive activity names to name the activities in the data set
4. Appropriately lavel the data set with descriptive variable names
5. From the data set in step 4, create a second, independent data set with the average of each variable for each activity and each subject

### NOTES regarding raw data files 

* All data files appear to be space-delimited, with one or more spaces as the delimiters (use readr:read_table)
  * features_info.txt: info on 561 feature variables
  * features.txt: names of the 561 feature variables (vector)
  * activity_labels.txt: lookup table converting 1:6 into labels

  * X_train.txt: feature data for all training set subject/activities
    * ncol = 561, nrow = 7353
  * y_train.txt: activity values (1:6) (vector, length = 7353)
  * subject_train.txt: subject IDs (anonymized) (vector, length = 7353)

  * X_test.txt: feature data for all test set subject/activities
    * ncol = 561, nrow = 2948
  * y_test.txt: activity values (1:6) (vector, length =2948)
  * subject_test.txt: subject IDs (anonymized) (vector, length = 2948)

  * Inertial signals files should not be required, as the mean and std data needed are provided in the X_train and X-test files
  
  * ALL final data maintain the measurement units, as described in the raw data README file.

### Steps Taken
* Obtain raw data (download and unzip)
  * read data common to both train and test datasets (activity_labels.txt, features.txt)
  * read train data (x_train.txt, y_train.txt, subject_train.txt); combine subject (subject_train.txt) and activity (activity_labels.txt) with x.train data
  * read test data (x_test.txt, y_test.txt, subject_text.txt); combine subject (subject_test.txt) and activity (activity_labels.txt) with x.test data
* Append test data to train data
* Identify the features required in the final tidy data (features that contain "mean" or "std" in the name)
* Change feature names to remove non-alphanumeric characters (dashes, parentheses) andconvert to CamelCase (preferred by my organization)
* Create tidy data set with mean for each feature for each activity and subject
* Write tidy data set as a tab-delimited text file.
