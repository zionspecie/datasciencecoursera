url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(url, "UCI_HAR_Dataset.zip")

unzip("UCI_HAR_Dataset.zip")

# Step 1: Merging the training and the test sets to create one data set

# I'll first read the features and activity labels
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("index", "name"))
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

# Reading the training data
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

# Readng the test data
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

# I'll now merge the datasets
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

# Set the feature names
colnames(x_data) <- features$name

# Combining all into one dataset
all_data <- cbind(subject_data, y_data, x_data)

# Step 2: Extracting only the measurements on the mean and standard deviation
mean_std_columns <- grepl("mean\\(\\)|std\\(\\)", features$name)
x_data_filtered <- x_data[, mean_std_columns]
filtered_data <- cbind(subject_data, y_data, x_data_filtered)

# Step 3: Using descriptive activity names
filtered_data$activity <- factor(filtered_data$activity, 
                                 levels = activity_labels$code, 
                                 labels = activity_labels$activity)

# Step 4: Appropriately labeling the dataset with descriptive variable names
names(filtered_data) <- gsub("^t", "Time", names(filtered_data))
names(filtered_data) <- gsub("^f", "Frequency", names(filtered_data))
names(filtered_data) <- gsub("Acc", "Accelerometer", names(filtered_data))
names(filtered_data) <- gsub("Gyro", "Gyroscope", names(filtered_data))
names(filtered_data) <- gsub("Mag", "Magnitude", names(filtered_data))
names(filtered_data) <- gsub("BodyBody", "Body", names(filtered_data))

# Step 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject
library(dplyr)
tidy_dataset <- filtered_data %>%
  group_by(subject, activity) %>%
  summarise_all(mean)

# Output the tidy data
write.table(tidy_dataset, "tidy_dataset.txt", row.name = FALSE)
