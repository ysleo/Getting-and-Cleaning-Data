# Getting and Cleaning Data Project

The goal is to prepare tidy data that can be used for later analysis, based on raw data collected from the accelerometers from the Samsung Galaxy S smartphone.

# Project content
 * run_analysis.R : the R script to get and clean data
 * CookBook.md : The mark down file that describe the data

# Steps of the script
 * First step is to collect all needed data by downloading the zip file
 * Merge Data train and test by concatenating rows
 * Name the data column by using the feature data
 * Clean Data by keeping only mean and std column
 * Add Activity column by using y_test .txt and y_train.txt
 * Add Subject column by using subject_train.txt and subject_test.txt
 * Aggregate data
 * Write tidy data to a file and clean temp file
