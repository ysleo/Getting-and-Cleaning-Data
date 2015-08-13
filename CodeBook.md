# CodeBook 

## Sources

All the data come from the following source : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

It contains : 
 * Mapping data
  * Activities Label : activity_labels.txt
  * Features Label : features.txt
 * Test and Train data with 
  * Subject data : subject_*.txt
  * Sensor data : X_*.txt
  * Activity data : y_*.txt

## Tidy Data Variables

### The dataset includes the following files:

A single file : tidyData.txt

### Each record

The file contains 35 rows with 

 * Subject : Each subject is identified by a number
 * Activity : Each Activity is identified by two column : a number and a label
  * 1 WALKING
  * 2 WALKING_UPSTAIRS
  * 3 WALKING_DOWNSTAIRS
  * 4 SITTING
  * 5 STANDING
  * 6 LAYING
 * All variables are the mean of all the sample aggregated by subject and activity

