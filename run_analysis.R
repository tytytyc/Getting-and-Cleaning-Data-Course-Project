library(dplyr)
library(data.table)

setwd("D:\\study\\r programming\\getting and cleaning data course proj")

# read data files
ytest=read.table("Y_test.txt" ,header = FALSE)
ytrain=read.table("Y_train.txt",header = FALSE)

xtest=read.table("X_test.txt" ,header = FALSE)
xtrain=read.table("X_train.txt",header = FALSE)

subtest=read.table("subject_test.txt",header = FALSE)
subtrain=read.table("subject_train.txt",header = FALSE)

daty=rbind(ytest,ytrain)
datx=rbind(xtest,xtrain)
datsub=rbind(subtest,subtrain)

names(datsub)="subject"
names(daty)="activity"
featuresnames=read.table("features.txt",head = FALSE)
names(datx)=featuresnames$V2

# Merges the training and the test sets to create one data set.
dat=cbind(datsub, daty)
dat1=cbind(datx, dat)

# Extracts only the measurements on the mean and standard deviation for each measurement. 
dat2=subset(dat1,select = c("subject","activity",names(datx)[grep("mean|std",names(datx))]))

# Uses descriptive activity names to name the activities in the data set
activitynames=read.table("activity_labels.txt",header = FALSE)

# Appropriately labels the data set with descriptive variable names. 
names(dat2)=gsub("^t", "time", names(dat2))
names(dat2)=gsub("^f", "frequency", names(dat2))
names(dat2)=gsub("Acc", "Accelerometer", names(dat2))
names(dat2)=gsub("Gyro", "Gyroscope", names(dat2))
names(dat2)=gsub("Mag", "Magnitude", names(dat2))
names(dat2)=gsub("BodyBody", "Body", names(dat2))

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
dat3=aggregate(. ~ subject + activity, dat2, mean)
write.table(dat3,"tidydata.txt",row.names = FALSE)















