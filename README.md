# Getting and Cleaning Data Project

The goal is to prepare tidy data that can be used for later analysis, based on raw data collected from the accelerometers from the Samsung Galaxy S smartphone.

# Project content
 * run_analysis.R : the R script to get and clean data
 * CookBook.md : The mark down file that describe the data

# Steps of the script
 * First step is to collect all needed data by downloading the zip file

```{r}
library(RCurl)
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp, method = "curl")

```

 * Merge Data train and test by concatenating rows

 ```{r}
train <- read.table(unz(temp, "UCI HAR Dataset/train/X_train.txt"))
test <- read.table(unz(temp, "UCI HAR Dataset/test/X_test.txt"))
testtrain <- rbind(train, test)
```

 * Name the data column by using the feature data

 ``{r}
features <- read.table(unz(temp, "UCI HAR Dataset/features.txt"))
names(testtrain) <- unlist(features[2])

```

 * Clean Data by keeping only mean and std column

 ```{r}
testtrainext <- testtrain[  grepl( "mean|std" , names( testtrain ) )]
```

 * Add Activity column by using y_test .txt and y_train.txt

```{r}
activitiestest <- read.table(unz(temp, "UCI HAR Dataset/test/y_test.txt"))
activitiestrain <- read.table(unz(temp, "UCI HAR Dataset/train/y_train.txt"))
activities <- rbind(activitiestrain, activitiestest)
names(activities) <- c("Activity")
testtrainactivities <- cbind(testtrainext, activities)
activitiesLabel <- read.table(unz(temp, "UCI HAR Dataset/activity_labels.txt"))
names(activitiesLabel) <- c("Activity", "ActivityName")
testtrainactivitiesmerged <- merge(testtrainactivities, activitiesLabel)
```

 * Add Subject column by using subject_train.txt and subject_test.txt

```{r}
subjecttrain <- read.table(unz(temp, "UCI HAR Dataset/train/subject_train.txt"))
subjecttest <- read.table(unz(temp, "UCI HAR Dataset/test/subject_test.txt"))
subject <- rbind(subjecttrain, subjecttest)
names(subject) <- c("Subject")
testtrainfinal <- cbind(testtrainactivitiesmerged, subject)
```

 * Aggregate data

 ```{r}
tidyData <-aggregate(. ~ Subject + Activity, testtrainfinal, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$ActivityName),]
```


 * Write tidy data to a file and clean temp file

```{r}
write.table(tidyData, "tidyData.txt",row.names = FALSE)
unlink(temp)
```