---
output: html_document
---
### Getting-and-Cleansing-Data
  ==========================

This is the repository for my coursework for Getting and Cleansing Data.
Assignment.R is the script that fulfills the course assignment.

  ==========================

Getting and Cleansing Data Assignment.

Samsung Galaxy S Smartphone Data

1. You should create one R script called run_analysis.R that does the following. 

2. Merges the training and the test sets to create one data set.

3. Extracts only the measurements on the mean and standard deviation for each measurement. 

4. Uses descriptive activity names to name the activities in the data set

5. Appropriately labels the data set with descriptive variable names. 

6. From the data set in step 4, creates a second, independent 
tidy data set with the average of each variable for each activity and each subject.

  ==========================
  
The script has been written carefully and commented.
Data is stored at each step of transformation to facilitate testing and readability over elegance or shortening of code.
Each section of the script is logically divided

Section 1 -- ## READ THE DATA

The script assumes that the data files are already downloaded into a local repository.
The code in this section reads each supplied data file into its own data frame.
This includes subjects, activities, features, and raw data associate with 128 observation "windows"

Reading the full data set enabled an initial understanding of the data and helped to plan the remaining work.


Section 2 ## MERGE TRAIN / TEST & FIX ACTIVITY AND VARIABLE NAMES

This section begins by merging the test and training data into 3 data frames -- one for subjects, one for activities, and one
for features.  I chose at this point to "drop" entirely the raw data associated for the 128 vector observations 
as it is not needed for our analysis.

The remaining code in this section  --

1) Creates readable column names for subject, activity, and each of the feature measures
    observing good principles such as full words and general readability

2) Selects just the features were interested in -- as specified in the assignment, mean and std.

3) Merges the separate data frames into a single set, and applies the column names.

At this point the script fulfills steps # 1 - 5 specified by the course instructor  -- stored as master_data


Section 3 -- ## CREATE THE FINAL TIDY SET

To achieve the final objective, the code calculates the dimensions -- # of subjects, # of activities, # of feature measures
and creates an empty data frame to store the averages by subject and by activity.

Nested loops "crawl" through the data set, calculate averages for the data subsets, and stores them in the empty data frame.
This is now stored as "pre_tidy" data as it remains now to apply tidy data principles to the final data table
and deal with any remaining aesthetics not addressed earlier.

The two primary manipulations applied next are:

-- a melt to remove the variables embedded in the column labels and store them properly in the rows as variables

-- a split to remove multiple variables stored in the same column

The second step, the split, is  subjective, but to keep the exercise simple, I have chosen to apply this principle 
to the major measurement type -- total, fourier or angle.  

It is possible to continue to apply the principle further with increasing  granularity, but this would introduce a number of NA's or  other greater inconsistencies given the variety of feature measures included in the data set.  For example, not every feature contains axes, b/c some are composite or multi layered features.  

Thus, I've chosen to simply illustrate the principle and conclude the exercise.  








