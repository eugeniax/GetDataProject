## load all training data into R objects
if(!exists("X_train")) X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
if(!exists("y_train")) y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
if(!exists("subject_train")) subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

## load all test data into R objects
if(!exists("X_test")) X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
if(!exists("y_test")) y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
if(!exists("subject_test")) subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

## construct a dataframe in the form of 'subject' 'activity' 'variables'
df_train <- cbind(subject_train,y_train,X_train)
df_test <- cbind(subject_test,y_test,X_test)

## merge training data with test data
df_all <- rbind(df_train,df_test)

## load features list into R object
if(!exists("features")) features <- read.table("./UCI HAR Dataset/features.txt")
## find out which variables are mean and standard deviation, 
## retain the numbers to be used to select columns of 'df_all'
meanSelect <- grep("mean()", features[,2], fixed=T)
stdSelect <- grep("std()", features[,2])
colSelect <- sort(c(meanSelect,stdSelect))
features_selected <- features[colSelect,]
## subset 'df_all' to have subject, activity, mean and standard deviation measures
df_mean.std <- df_all[,c(1,2,colSelect+2)] ##recreate a clean data set!

## read in activity labels
if(!exists("activity_labels")) activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
## translate activity code (1-6) to its descriptive names 
df_mean.std[,2] <- factor(df_mean.std[,2], levels=activity_labels[,1], labels=activity_labels[,2])


## extract feature names and clean up the illegal symbols ( ) -
colNames <- as.character(features_selected[,2])
colNames <- gsub("\\(", "", colNames)
colNames <- gsub("\\)", "", colNames)
colNames <- gsub("\\-", ".", colNames)
## expand abbreviations:
## 'Mag' to 'Magnitude'
colNames <- gsub("Mag", "Magnitude", colNames)
## remove the extra 'Body' in 'BodyBody'
colNames <- sub("BodyBody", "Body", colNames)
## prefix 't' to 'time', prefix 'f' to 'freq'
for(i in 1:length(colNames)) {
    if (substr(colNames[i],1,1)=="t")
        colNames[i] <- sub("t","time",colNames[i])
    if (substr(colNames[i],1,1)=="f")
        colNames[i] <- sub("f","freq",colNames[i])
}

colnames(df_mean.std) <- c("subject", "activity", colNames)

## group the data by activity and subject, then compute the average of
## all the feature columns
library(dplyr)
df_summary <- df_mean.std %>% tbl_df %>%
    group_by(activity, subject) %>% 
    summarise_each(funs(mean))
## the final result is written into a .txt file for exporting
write.table(df_summary, "tidydata.txt", row.name=FALSE)
