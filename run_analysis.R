#Step 0: Prepare:Downloading and extracting data files

library(dplyr)

datafile<-"dataset.zip"
if(!file.exists("datafile")){
  dataurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(dataurl,datafile)
}
if(!file.exists("UCI HAR Dataset")){
  unzip(datafile)
}

#Step 0: Reading Datasets and appropriately naming variables 

feature_list<-read.table("./UCI HAR Dataset/features.txt",col.names = c("no","feature"))
activity<-read.table("./UCI HAR Dataset/activity_labels.txt",col.names = c("id","activity"))

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subid")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = feature_list$feature)
y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt", col.names = "id")
y_test_id <- left_join(y_test, activity, by = "id")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subid")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = feature_list$feature)
y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt", col.names = "id")
y_train_id <- left_join(y_train, activity, by = "id")

#Step i: Tidying and merging test and train Data sets

tidy_test <- cbind(subject_test, y_test_id, x_test)
tidy_test <- select(tidy_test, -id)

tidy_train <- cbind(subject_train, y_train_id, x_train)
tidy_train <- select(tidy_train, -id)

merge_set <- rbind(tidy_test, tidy_train)

#Step ii: Extract only mean and standard deviation for each measurement

tidy_data <- merge_set %>% select(subid, activity, contains("mean"), contains("std"))

#Step iii: Descriptive Activity Names(Already performed along with Step i)

#Step iv: Appropriate labels for the data set with descriptive variable names
          # Tried to perform the task within a time constraint so consider

names(tidy_data)<-gsub("^t", "Time", names(tidy_data))
names(tidy_data)<-gsub("Acc", "Accelerometer", names(tidy_data))
names(tidy_data)<-gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data)<-gsub("^t", "Time", names(tidy_data))
names(tidy_data)<-gsub("^f", "Frequency", names(tidy_data))
names(tidy_data)<-gsub("angle", "Angle", names(tidy_data))
names(tidy_data)<-gsub("gravity", "Gravity", names(tidy_data))
names(tidy_data)<-gsub("-std()", "STD", names(tidy_data),ignore.case=TRUE)
names(tidy_data)<-gsub("Acc", "Accelerometer", names(tidy_data))
names(tidy_data)<-gsub("-mean()", "Mean", names(tidy_data),ignore.case=TRUE)
names(tidy_data)<-gsub("BodyBody", "Body", names(tidy_data))
names(tidy_data)<-gsub("Mag", "Magnitude", names(tidy_data))
names(tidy_data)<-gsub("tBody", "TimeBody", names(tidy_data))
names(tidy_data)<-gsub("-freq()", "Frequency", names(tidy_data),ignore.case=TRUE)

#Step v: Arranging and Writing files

final_data<-tidy_data %>%
  group_by(subid, activity) %>%
  summarise_all(list(mean))

write.table(final_data, "Tidy_data.txt", row.name=FALSE)
  
  
  
  