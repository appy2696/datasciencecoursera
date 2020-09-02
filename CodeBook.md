## Getting and Cleaning Data - peer assessment project 03-09-2020


## The original data was transformed by

1. Merging the training and the test sets to create one data set.
2. Extracting only the measurements on the mean and standard deviation for each measurement. 
3. Using descriptive activity names to name the activities in the data set
4. Appropriately labeling the data set with descriptive activity names. 
5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject. 

## About R script
File with R code "run_analysis.R" perform 5 above mentioned steps (in accordance assigned task of course work)

## About variables: 
* `datafile`, `dataurl' contain dataurl and zip file used to download and extract the data
* `feature_list`, `activity' are data frames that contain feature_list.txt and activity_labels.txt files
* `x_train`, `y_train`, `x_test`, `y_test`, `subject_train` and `subject_test` contain the data from the downloaded files.
* `y_test_id`, `y_train_id`, 'tidy_test', 'tidy_train' and `merge_set` merge the previous datasets to further analysis.
* `tidy_data` is used to store and clean the 'merge_set' after applying multiple operations along with 'subid' and 'activity' with all variable containing"sub" and "mean" in them
* `final_data` contains the arranged tidy data along with the summary mean values grouped by "activity" and "subject"
