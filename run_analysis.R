library(dplyr)

#Merges the training and the test sets to create one data set.

X <- rbind(tbl_df(read.table('train/X_train.txt')), tbl_df(read.table('test/X_test.txt')))
y <- rbind(tbl_df(read.table('train/y_train.txt')), tbl_df(read.table('test/y_test.txt')))
subject <- rbind(tbl_df(read.table('train/subject_train.txt')), tbl_df(read.table('test/subject_test.txt')))
activitylabels <- tbl_df(read.table('activity_labels.txt'))
features <- read.table('features.txt', stringsAsFactors = F)

#Appropriately labels the data set with descriptive variable names.
names(subject) <- 'subjectid'
names(y) <- 'activityid'

features$V2 <- tolower(features$V2)
features$V2 <- gsub('\\(|\\)','',features$V2)
features$V2 <- gsub('-|,','_',features$V2)
names(X) <- features$V2
names(activitylabels) <- c('activityid', 'activity')

#Extracts only the measurements on the mean and standard deviation for each measurement.

data <- X[,grep(pattern = '_mean_|_mean$|_std_|_std$', names(X))]

#Uses descriptive activity names to name the activities in the data set

data <- cbind(y,subject,data)
data <- inner_join(activitylabels, data, 'activityid')
data <- select(data, -activityid)

#Creates a second, independent tidy data set with the average of each
#variable for each activity and each subject.

data_result <- aggregate(data[,3:ncol(data)], by = list(activity=data$activity, subjectid=data$subjectid), FUN = mean)
names(data_result)[3:ncol(data_result)] <- paste0('average_',names(data_result)[3:ncol(data_result)])

write.table(data_result, 'tidy_data.txt')
