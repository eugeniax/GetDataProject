GetDataProject
==============
*Samsung accelerometer data project for Coursera Getting &amp; Cleaning Data course*

**Preparation:**

Original data set (zipped) is downloaded from <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

Subsequently, it is unzipped in the OS which generates a folder 'UCI HAR Dataset' in the working directory. From here onwards, the data file paths are assumed to follow the original data folder structure.

The R script 'run_analysis.R' performs the following data cleaning steps. 

**Step 1: Merges the training and the test sets to create one data set.**

First, Subject ID (coded in 'train/subject_train.txt'), Training labels (coded in y_train.txt) and Training set (coded in 'train/X_train.txt') are loaded into R objects with corresponding variable names.

Then, subject ID and training lables, essentially 'activity' that the subject performed, are prefixed to the training dataset to form a dataframe. The dataframe can be visualized as 

![dataframe structure](https://coursera-forum-screenshots.s3.amazonaws.com/e8/c6c1b0369e11e48d210b3f8c0f996c/Slide2.png) 

*Source: <https://class.coursera.org/getdata-007/forum/thread?thread_id=99>*

In this implementation 'subject' and 'activity' are the first two columns in front of the data (561 measures)

The same operations are performed on test sets before the two dataframes are merged into one single dataframe containing all the data. The final dataframe has 10299 rows (7352 from training and 2947 from test) and 563 columns (subject, activity, 561 features)

**Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.**

First read all the features (coded in 'features.txt') into a R object.

Then use `grep` to match required feature names. 2 types of features are selected:
- mean(): Mean value
- std(): Standard deviation

The numeric vector obtained is used to select the columns of the complete data set. The subset dataframe 'df_mean.std' has a total of 66 features which are either mean or standard deviation are selected.

**Step 3: Uses descriptive activity names to name the activities in the data set**

First, read in activity labels from 'activity_labels.txt'. Then use `factor` to 'translate' the numeric code of activity in the 2nd column of 'df_mean.std' from Step2.

**Step 4: Appropriately labels the data set with descriptive variable names.**

First, use the names of features selected in Step 2 as a starting point. Then, perform the following operations on the names

- Removing illegal variable symbols: (,),-
- Expanding the abbreviations 'Mag' to 'Magnitude'
- Some original feature names have 'BodyBody' E.g. 'fBodyBodyGyroJerkMag-mean()' is meant to be 'fBodyGyroJerkMag-mean()'. Therefore the extra 'Body' is removed
- Replacing the prefix 't' and 'f' with 'time' and 'freq' respectively to make the variable names more descriptive

Name the columns of dataframe 'df_mean.std'. First column is 'subject', second is 'activity', and the rest is obtained from the feature names after the manipulation mentioned above.

**Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.**

Using 'dplyr' package, the dataframe obtained from Step4 was first grouped by activity and subject (in this order), which produces 180 activity and subject pairs. For each pair, the mean of every features is calculated with the function `summarise_each`. 

Finally, the summary dataframe is written into a .txt file.
