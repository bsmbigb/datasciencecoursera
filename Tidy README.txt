==================================================================
Coursera getting and cleaning data – readme file
==================================================================
Bryan M
==================================================================

These transformations and data sets were created from the Samsung data provided in the course website.


For each record it is provided:
======================================

xtest is a text file as provided and was read in using read.table 
xtrain is a text file as provided and was read in using read.table

features <- read.table("features.txt", header = F) # features contains the 561 variable column headers for test and train data


xdata was then created using a row bind on the xtrain and xtest data sets - rbind(xtrain, xtest)

the heading names from the data set “features” were then applied to xdata using the “names” function in R

names(xdata) <- features[,2] 



The code includes the following files:
=========================================




- 'README.txt'

 
xtest  <- read.table("test//x_test.txt", header = F )
xtrain <- read.table("train//x_train.txt", header = F )     

features <- read.table("features.txt", header = F) 
# features contains the 561 variable column headers for test and train data
features


xdata <- rbind(xtrain, xtest)

xdata is the training and test data for x bound together

names(xdata) <- features[,2]

the headers for the columns of xdata are the names from the data set “features”.



###############################################################################

act_labels <- read.table("activity_labels.txt", header = F ) 
ytest  <- read.table("test//y_test.txt", header = F )
ytrain <- read.table("train//y_train.txt", header = F ) 

here we are reading the y data and combining the data with the headers being the names from the data set “act_labels”

ydata <- rbind(ytrain, ytest)





ydata2 <- merge(act_labels, ydata, by = 'V1')



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



#extracting only those variables related to  MEAN OR STANDARD DEVIATION
test2 <- test1[,c(1:9,44:49,84:89,124:129,164:169,204,205,217,218,230,231,243,244,256,257,269:274,297:299,348:353,376,377,378,427:432,455:457,506,507,519,520,532,533,545,546,555,559:564)]






tidy_data <- ddply(test2,~Activity + Subject,summarise,mean=mean(body_acc_mean_x),sd=sd(body_acc_mean_x))

tidy_data contains the mean and standard deviation of each subject and each activity.


The units are radians/second. 

Notes: 
======

For more information about this dataset contact: bettheunder@yahoo.com

License:
========

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the author.

Bryan M.
March 2015
