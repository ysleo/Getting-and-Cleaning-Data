# Download Data  
library(RCurl)
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp, method = "curl")

# Merge Data 
train <- read.table(unz(temp, "UCI HAR Dataset/train/X_train.txt"))
test <- read.table(unz(temp, "UCI HAR Dataset/test/X_test.txt"))
testtrain <- rbind(train, test)

# Name Data 
features <- read.table(unz(temp, "UCI HAR Dataset/features.txt"))
names(testtrain) <- unlist(features[2])

# Clean Data by keeping only mean and std
testtrainext <- testtrain[  grepl( "mean|std" , names( testtrain ) )]

# Add Activity
activitiestest <- read.table(unz(temp, "UCI HAR Dataset/test/y_test.txt"))
activitiestrain <- read.table(unz(temp, "UCI HAR Dataset/train/y_train.txt"))
activities <- rbind(activitiestrain, activitiestest)
names(activities) <- c("Activity")
testtrainactivities <- cbind(testtrainext, activities)
activitiesLabel <- read.table(unz(temp, "UCI HAR Dataset/activity_labels.txt"))
names(activitiesLabel) <- c("Activity", "ActivityName")
testtrainactivitiesmerged <- merge(testtrainactivities, activitiesLabel)

# Add Subject 
subjecttrain <- read.table(unz(temp, "UCI HAR Dataset/train/subject_train.txt"))
subjecttest <- read.table(unz(temp, "UCI HAR Dataset/test/subject_test.txt"))
subject <- rbind(subjecttrain, subjecttest)
names(subject) <- c("Subject")
testtrainfinal <- cbind(testtrainactivitiesmerged, subject)

# Aggregate data
tidyData <-aggregate(. ~ Subject + Activity, testtrainfinal, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$ActivityName),]

# write Data and clean temp file
write.table(tidyData, "tidyData.txt",row.names = FALSE)
unlink(temp)
