---
title: "CodeBook.md"
author: "Shannon Mada"
date: "September 14, 2014"
---
 
This CodeBook describes the variables used through the code in run_analysis.r
It includes both "temporary" variables used for storage and transformation, and the final tidy data set.

 ==========================

The original data set describes the accelermoeter and gyroscope raw signals and how the data was processed and subsequently stored in its original format:

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean
 
The complete list of variables of each feature vector is available in 'features.txt'
 ==========================



run_analysis.r processing variables are described in logical sets below


The following variables are used to read in the initial data from the supplied data files

features:  stores character names for each of the statistical measures supplied across the test and training data
activity_labels: stores activity descriptions as characters, underscore to space via source file activity.txt column 2

Orignal source was :

1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING

The next set of variables store all of the "test" data.  Source file names match the selecte variable names

x_test:         561 variables, 2947 observations  -- a numeric for each feature
subject_test:   Matches each observation to a subject id, numeric
y_test :        Matches each observation to an activity, numweric

The following storage variables read in the numeric observations associated with the 128 window samples -- test data.
Again, source file names match the selected variable names.

body_gyro_x_test        ## Vector of length 128 for each obs -- 2947 obs
body_gyro_y_test        ## Vector of length 128 for each obs -- 2947 obs
body_gyro_z_test        ## Vector of length 128 for each obs -- 2947 obs
total_acc_x_test        ## Vector of length 128 for each obs -- 2947 obs
total_acc_y_test        ## Vector of length 128 for each obs -- 2947 obs
total_acc_z_test        ## Vector of length 128 for each obs -- 2947 obs
body_acc_x_test         ## Vector of length 128 for each obs -- 2947 obs
body_acc_y_test         ## Vector of length 128 for each obs -- 2947 obs
body_acc_z_test         ## Vector of length 128 for each obs -- 2947 obs

The next set of variables store all of the "test" data.  Source file names match the selecte variable names

x_train:        561 variables, 7352 observations -- a numeric for each feature
subject_train:  Matches each observation to a subject id, numeric
y_train:        Matches each observation to an activity, numeric

The following storage variables read in the numeric observations associated with the 128 window samples -- training data.
Again, source file names match the selected variable names.

body_gyro_x_train       ## Vector of length 128 for each obs # 7352 obs
body_gyro_y_train       ## Vector of length 128 for each obs # 7352 obs
body_gyro_z_train       ## Vector of length 128 for each obs # 7352 obs
total_acc_x_train       ## Vector of length 128 for each obs # 7352 obs
total_acc_y_train       ## Vector of length 128 for each obs # 7352 obs        
total_acc_x_train       ## Vector of length 128 for each obs # 7352 obs
body_acc_x_train        ## Vector of length 128 for each obs # 7352 obs
body_acc_y_train        ## Vector of length 128 for each obs # 7352 obs
body_acc_z_train        ## Vector of length 128 for each obs # 7352 obs

The following variables are used to hold data to be transformed and combined  -- all numeric.

features_measures:  x_test and x_train rows are bound into a single column of measurement values
subject_ids:        subject_test and subject_train rows are bound into consolidated column of subjects range of 1:30  
activities:         y_test and y_train are bound into a single row of activity numbers

These variables store just the features / measurements we are interested in -- Mean and Std

x:                      used to temporarily store an extract of features_measures containing string "mean"
y:                      used to temporarily store an extract of features_measures containting string "std"
selected_features:      combined x and y into data frame of just the features (columns) selected -- mean & std

names_to_fix:           a character vector used to store and manipulate the feature names into readable English

master_set:  combines the features_measures, subject_ids and activities into a single data frame of numeric data

These variables count the dimensions of our data for the purposes of structure and loop sizing within the code
They are used to build the pre_tidy matrix

number_subjects:                holds the unique number of subjects -- 30
number_activities:               holds the unique number of activities  -- 6
number_of_selected_features:    counts the number of features we selected across mean and std -- 86

rows_in_pre_tidy:       # of unique subjects * number of activities
col_in_pre_tidy         # total columns are subject, activity plus the number of selected features:  2+86

loop_counter:           a helper variable to ensure that as 
meanie:                 holds the average of the selected feature value for a given subject id and activity
pre_tidy:               assembled data frame of numeric subject, char activity & averaged numeric value
                        note that matching activity_labels are substituted in the palce of activity numeric

The next set of variables are used to assemble the final "tidy" data frame
And constructed to extract variables from column headers and multi variables from single columns

melted:                 new data frame -- numeric subject, character activity, variable (measurement feature), and values
fixed_up:               a new data frame which simply converts melted to all lower case -- same columns
rexp:                   specifies in appropriate syntax pattern to seprate columns after first space  -- character
new_cols:               stores the result of applying a subest statement to separate measurement and feature

tidy:                   the final data table assembled by manipulating fixed_up -- new_cols replaces the variable column
                        final columns are subject numeric, activity numeric, measurement char, feature char, value numeric

 