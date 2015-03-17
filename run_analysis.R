
################################################################################################

#COURSE PROJECT


#1) a tidy data set as described below, 
#2) a link to a Github repository with your script for performing the analysis, and 
#3) a code book that describes the variables,the data, 
    #and any transformations or work that you performed to clean up the data called CodeBook.md. You should also 
#4) include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected. 





#You should create one R script called run_analysis.R that does the following. 

#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 

#From the data set in step 4, creates a second, independent tidy data set with the average
#of each variable for each activity and each subject.


#- 'features_info.txt': Shows information about the variables used on the feature vector.

#- 'features.txt': List of all features.

#- 'activity_labels.txt': Links the class labels with their activity name.

#- 'train/X_train.txt': Training set.

#- 'train/y_train.txt': Training labels.

#- 'test/X_test.txt': Test set.

#- 'test/y_test.txt': Test labels.

#The following files are available for the train and test data. Their descriptions are equivalent. 

#- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

#- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. 

#- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

#- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample.
#The units are radians/second. 



################################################################################################







setwd("C:\\Users\\massibs\\Desktop\\Coursera Data Science\\03 Getting and Cleaning Data\\UCI HAR Dataset")
getwd()
list.files()




col1 <- c("1 WALKING", "2 WALKING_UPSTAIRS", "3 WALKING_DOWNSTAIRS", "4 SITTING", "5 STANDING", "6 LAYING")                    
col1   


xtest  <- read.table("test//x_test.txt", header = F )
xtrain <- read.table("train//x_train.txt", header = F )     

features <- read.table("features.txt", header = F) # features contains the 561 variable column headers for test and train data
features

#xtest                  
#xtrain           



#dim(xtest)
#dim(xtrain)
#dim(features)


#str(xtest)
#str(xtrain)

xdata <- rbind(xtrain, xtest)



names(xdata) <- features[,2]


head(xdata)




str(xdata)





###############################################################################

act_labels <- read.table("activity_labels.txt", header = F ) 
ytest  <- read.table("test//y_test.txt", header = F )
ytrain <- read.table("train//y_train.txt", header = F ) 

dim(ytest)
dim(ytrain)
dim(act_labels)

act_labels

str(ytest)
str(ytrain)


ydata <- rbind(ytrain, ytest)


head(ydata)


ydata


str(ydata)



ydata2 <- merge(act_labels, ydata, by = 'V1')

ydata2

str(ydata2)



##################################################################

#Subject Files Imported


sub_train <- read.table("train//subject_train.txt", header = F)

sub_test <- read.table("test//subject_test.txt", header = F)


str(sub_train)

str(sub_test)


sub_all <- rbind(sub_train, sub_test)

str(sub_all)
summary(sub_all)

########################################################

#Combining everything into one data frame


test1 <- cbind(sub_all, ydata2, xdata)


str(test1)



summary(test1)



test1

#extracting only those variables related to  MEAN OR STANDARD DEVIATION
test2 <- test1[,c(1:9,44:49,84:89,124:129,164:169,204,205,217,218,230,231,243,244,256,257,269:274,297:299,348:353,376,377,378,427:432,455:457,506,507,519,520,532,533,545,546,555,559:564)]

head(test2)

str(test2)


library(dplyr)

library(plyr)

newnames <- c("Subject", "V2", "Activity", "body_acc_mean_x",  "body_acc_mean_y", "body_acc_mean_z",  "body_acc_std_x", "body_acc_std_y", "body_acc_std_z",
              "tGravityAcc_mean_X",  "tGravityAcc_mean_Y", "tGravityAcc_mean_Z",  "tGravityAcc_std_X",  "tGravityAcc_std_Y",
              "tGravityAcc_std_Z",    "tBodyAccJerk_mean_X", "tBodyAccJerk_mean_Y",    "tBodyAccJerk_mean_Z", "tBodyAccJerk_std_X",
              "tBodyAccJerk_std_Y","tBodyAccJerk_std_Z",   "tBodyGyro_mean_X",   "tBodyGyro_mean_Y",    "tBodyGyro_mean_Z",
              "tBodyGyro_std_X", "tBodyGyro_std_Y",    "tBodyGyro_std_Z",      "tBodyGyroJerk_mean_X",
              "tBodyGyroJerk_mean_Y",    "tBodyGyroJerk_mean_Z",   "tBodyGyroJerk_std_X",     "tBodyGyroJerk_std_Y",
              "tBodyGyroJerk_std_Z",    "tBodyAccMag_mean",   "tBodyAccMag_std",  "tGravityAccMag_mean",
              "tGravityAccMag_std",  "tBodyAccJerkMag_mean",  "tBodyAccJerkMag_std", "tBodyGyroMag_mean",
              "tBodyGyroMag_std", "tBodyGyroJerkMag_mean",   "tBodyGyroJerkMag_std",   "fBodyAcc_mean_X",
              "fBodyAcc_mean_Y",  "fBodyAcc_mean_Z",   "fBodyAcc_std_X", "fBodyAcc_std_Y",   "fBodyAcc_std_Z",
              "fBodyAcc_meanFreq_X",  "fBodyAcc_meanFreq_Y",  "fBodyAcc_meanFreq_Z",   "fBodyAccJerk_mean_X",
              "fBodyAccJerk_mean_Y",   "fBodyAccJerk_mean_Z",   "fBodyAccJerk_std_X", "fBodyAccJerk_std_Y",
              "fBodyAccJerk_std_Z",   "fBodyAccJerk_meanFreq_X","fBodyAccJerk_meanFreq_Y", "fBodyAccJerk_meanFreq_Z",
              "fBodyGyro_mean_X", "fBodyGyro_mean_Y",  "fBodyGyro_mean_Z",  "fBodyGyro_std_X",  "fBodyGyro_std_Y",
              "fBodyGyro_std_Z",   "fBodyGyro_meanFreq_X","fBodyGyro_meanFreq_Y",  "fBodyGyro_meanFreq_Z",
              "fBodyAccMag_mean",  "fBodyAccMag_std", "fBodyBodyAccJerkMag_mean", "fBodyBodyAccJerkMag_std",
              "fBodyBodyGyroMag_mean", "fBodyBodyGyroMag_std", "fBodyBodyGyroJerkMag_mean",  "fBodyBodyGyroJerkMag_std",
              "fBodyBodyGyroJerkMag_meanFreq", "angle_tBodyAccJerkMean_gravityMean_", "angle_tBodyGyroMeangravityMean_",
              "angle_tBodyGyroJerkMeangravityMean_","angle_XgravityMean_","angle_YgravityMean_","angle_ZgravityMean_")




newnames

names(test2) <- newnames


names(test2)






tidy_data <- ddply(test2,~Activity + Subject,summarise,mean=mean(body_acc_mean_x),sd=sd(body_acc_mean_x))

tidy_data



?write.table
write.table(tidy_data, file = "tidy_data_massie.txt", row.name=FALSE)






