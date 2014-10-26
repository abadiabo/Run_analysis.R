Run_analysis.R
==============

The run_analysis.R is the R script that creates the tidydata for the Smartphones data

# Data Science course: Getting and Cleaning Data 

## Course Project Presentated by Auguste Badiabo
## On October 26, 2014


##Project Description
The purpose of this project is to collect and clean a data set. The goal is to prepare tidy data that can be used for later 
analysis. You will be graded by your peers on a series of yes/no questions related to the project.

You will be required to submit:
1 tidy data set as described below
2 link to a Github repository with your script for performing the analysis, and
3 code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include 
4 README.md in the repo with your scripts. This file explains how all of the scripts work and how they are connected.
One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most 
advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S 
smartphone. A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using
+Smartphones

The data for the project is located at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
You should create one R script called run_analysis.R that does the following.
1 Merges the training and the test sets to create one data set.
2 Extracts only the measurements on the mean and standard deviation for each measurement.
3 Uses descriptive activity names to name the activities in the data set
4 Appropriately labels the data set with descriptive activity names.
Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
What you find in this repository

## Create a CodeBook.md
The CodeBook gives information about raw and tidy data set and elaboration made to transform them.

## README.md
This file explain how run_analysis.R which is R script aimes to transform raw data set in a tidy data set.
#How to create the tidy data set?
* clone this repository
* download compressed raw data
* unzip raw data and copy the directory UCI HAR Dataset to the cloned repository root directory
Used RStudio and Installed the plyr package.
