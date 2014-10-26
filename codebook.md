CodeBook
==============
subject: the subject who performed the activity for each window sample. Its range is from 1 to 30.
activity: is a factor with 6 levels: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

The next 40 features (column 3 to 42) come from the accelerometer and gyroscope 3-axial raw signals, 'Acc' for accelerometer, 'Gyro' for gyroscope. 

These time domain signals (prefix 'time' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. 

Similarly, the acceleration signal was then separated into body and gravity acceleration signals (timeBodyAcc and timeGravityAcc) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing freqBodyAcc, freqBodyAccJerk, freqBodyGyro, freqBodyAccMag, freqBodyAccJerkMagnitude, freqBodyGyroMagnitude, freqBodyGyroJerkMagnitude. The 'freq' to indicate frequency domain signals.

The last component (if present) 'XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

Mean values are coded with 'mean' with a dot to separate it from the feature name. Similarly, Standard Deviations are coded with 'std' with a separator '.'

Features are normalized and bounded within [-1,1]. And each feature vector is a row on the text file.

As a general note, CamelCase is used to name the variables. Given that the names of some features are fairly long, CamelCase is visually easier to interpret the combined words in the variable names. Another effort to promote readability is the use of dots. Dots are used to separate feature names from statistical computation (mean or standard deviation) and axial direction (X, Y, Z).
