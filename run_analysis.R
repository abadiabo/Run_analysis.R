## Data Science Course: Getting and Cleaning Data
## Course Project
## Presented by AUGUSTE BADIABO
## On October 26, 2014
## This Project aims to download the data from UCI HAR Dataset and perform the following tasks:


#1.Merge the training and the test sets to create one data set.
#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
#3.Uses descriptive activity names to name the activities in the data set
#4.Appropriately labels the data set with descriptive variable names.
#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Here the link for the  UCI HAR Dataset
#  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

####  Unzipped Import Data
library(plyr)
getwd()
## Change the working directory and set it to project
setwd("C:/Users/Auguste Ba/Documents/Online Courses/Getting and Cleaning Data/Project/UCI HAR Dataset");
getwd();

## Check the files
list.files();

## Let Read and Import data into R
#Import features_info.txt
features = read.table('./features.txt',header=FALSE); 
head(features);

#Import activity_labels.txt
activityType = read.table('./activity_labels.txt',header=FALSE);
head(activityType);

#Import activity_labels.txt
subjectTrain = read.table('./train/subject_train.txt',header=FALSE); 
head(subjectTrain);

#Import x_train.txt
xTrain = read.table('./train/x_train.txt',header=FALSE);
head(xTrain);

#imports y_train.txthead(training
yTrain = read.table('./train/y_train.txt',header=FALSE);
head(yTrain);

# Let assign names to columns for the data sets
colnames(activityType) = c('activityId','activityType');
colnames(subjectTrain)  = "subjectId";
colnames(xTrain) = features[,2]; 
colnames(yTrain) = "activityId";

## Let merge yTrain, subjectTrain, and xTrain
trainingData = cbind(yTrain,subjectTrain,xTrain);
head(trainingData)

## Let imports subject_test.txt
subjectTest = read.table('./test/subject_test.txt',header=FALSE); 
head(subjectTest);

#importing x_test.txt
xTest = read.table('./test/x_test.txt',header=FALSE); 
head(xTest);

#importing x_test.txt
yTest = read.table('./test/y_test.txt',header=FALSE); 
head(yTest);

# Let Assign column names to the test data sets
colnames(subjectTest) = "subjectId";
colnames(xTest) = features[,2]; 
colnames(yTest) = "activityId";

# Let merge all subjectTest sets in one data set
testData = cbind(yTest,subjectTest,xTest);
head(testData);

# Let Combine the training data set and test data set
training_Test = rbind(trainingData,testData);

# Label columns
colNames  = colnames(training_Test); 
head(training_Test);

###################################################################################################
#
## 2. Extract only the measurements on the mean and standard deviation for each measurement.
#
####################################################################################################

logicalVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & 
                   !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & 
                   !grepl("-std()..-",colNames));

head(training_Test)

# Subset training_Test  table based on the logicalVector 
training_Test = training_Test[logicalVector==TRUE];

######################################################################################
#
## 3. Use descriptive activity names to name the activities in the data set
#
################################################################################################

# Let combine training_Test data set with acitivityType table to include descriptive activity names
training_Test = merge(training_Test,activityType,by='activityId',all.x=TRUE);

# Lst rename the colNames vector to include the new column names after merge
colNames  = colnames(training_Test); 


############################################################################################
#
## 4. Appropriately label the data set with descriptive activity names. 
#
#################################################################################################

# Cleaning up the variable names
for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

# Rename the descriptive column names to the training_Test data set
colnames(training_Test) = colNames;
head(training_Test)

########################################################################################
#
## 5. Create a second, independent tidy data set with the average of each variable 
##    for each activity and each subject. 
#
#####################################################################################

# Create a new table, training_Test without the activityType column
training_Test_NoActivityType  = training_Test[,names(training_Test) != 'activityType'];
head(training_Test_NoActivityType);

## Final Data Set
tidyData = aggregate(training_Test_NoActivityType[,names(training_Test_NoActivityType) != c('activityId','subjectId')],
                     by=list(activityId=training_Test_NoActivityType$activityId,subjectId = training_Test_NoActivityType$subjectId),mean);

# Merging the tidyData with activityType to include descriptive acitvity names
tidyData    = merge(tidyData,activityType,by='activityId',all.x=TRUE);
head(tidyData);

### Export the tidyData set
getwd();

write.table(tidyData, './tidyData.txt',row.names=TRUE,sep='\t');



