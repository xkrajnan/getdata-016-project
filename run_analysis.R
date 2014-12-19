library(data.table)

# read the training data
read.table(file="data/train/subject_train.txt") -> train_subject
read.table(file="data/train/X_train.txt") -> train_features
read.table(file="data/train/y_train.txt") -> train_activity

# read the testing data
read.table(file="data/test/subject_test.txt") -> test_subject
read.table(file="data/test/X_test.txt") -> test_features
read.table(file="data/test/y_test.txt") -> test_activity

# read the descriptive names of the features and activities
read.table(file="data/features.txt")[,2] -> feature_names
read.table(file="data/activity_labels.txt")[,2] -> activity_names

# merge the training and testing data
subject <- rbind(train_subject, test_subject)
features <- rbind(train_features, test_features)
activity <- rbind(train_activity, test_activity)

# set the meaningful names of the features and actions
names(subject) <- c("subject")
names(features) <- feature_names
names(activity) <- c("activity")

# subset the features to the relevant only
# (those that contain "mean" or "std" substring in their name)
relevant_feature_names <- grep("mean|std", feature_names)
features <- features[, relevant_feature_names]

activity[,1] <- as.factor(activity[,1])
levels(activity[,1]) <- activity_names

# make one big table of all the measurements
data <- cbind(subject, activity, features)

# generate the required tidy data table:
# - summarize the data with means over the subject-activity pairs
# - rename the features so they reflect the summarization with mean
tidy_data <- setDT(data)[, lapply(.SD, mean), by=list(subject, activity)]
setnames(tidy_data, old=3:81, new=sub("(.*)", "mean_of_\\1", names(tidy_data)[3:81]))

# save the output data
write.csv(tidy_data, file="tidy_data.csv", row.names=FALSE)
