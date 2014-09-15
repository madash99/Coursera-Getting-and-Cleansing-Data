---
title: "CodeBook.md"
author: "Shannon Mada"
date: "September 14, 2014"
---

This CodeBook describes the variables used through the code in run_analysis.r
It includes both "temporary" variables used for storage and transformation, and the final tidy data set

The following variables are used to read in the initial data from the supplied data files

features:  stores character names for each of the statistical measures supplied across the test and training data
activity_labels: stores activity descriptions as characters, underscore to space via source file activity.txt column 2

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

