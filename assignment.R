## Getting and Cleansing Data Assignment.
## Samsung Galaxy S Smartphone Data

## 1. You should create one R script called run_analysis.R that does the following. 
## 2. Merges the training and the test sets to create one data set.
## 3. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 4. Uses descriptive activity names to name the activities in the data set
## 5. Appropriately labels the data set with descriptive variable names. 
## 6. From the data set in step 4, creates a second, independent 
##    tidy data set with the average of each variable for each activity and each subject.

library(dplyr)
library(data.table)
library(reshape)

## READ THE DATA
## Assumes data is downloaded to a static location on my hard drive
## Initially, read in all data into "holding" variables and understand dimensions

setwd("~/Desktop/Coursera/UCI_data")
features<-read.table("features.txt")                     ## 561 Variable Names/# -- measurements and calculations
activity_labels<-read.table("activity_labels.txt")       ## 6 activity names -- in column 2
activity_labels<-as.character(activity_labels$V2)        ## Just store the name as a single column of names
activity_labels<-sub("_", " ", activity_labels)          ## Change underscore to space

setwd("~/Desktop/Coursera/UCI_data/test")
x_test<-read.table("x_test.txt")                        ## 561 Variables, 2947 observations
subject_test<-read.table("subject_test.txt")            ## Matches each observation to a subject ID # - 2947 obs
y_test<-read.table("y_test.txt")                        ## Matches each observation to an activity # - 2947 obs

## Read all the test data

setwd("~/Desktop/Coursera/UCI_data/test/Inertial Signals")

body_gyro_x_test<-read.table("body_gyro_y_test.txt")    ## Vector of length 128 for each obs -- 2947 obs
body_gyro_y_test<-read.table("body_gyro_y_test.txt")    ## Vector of length 128 for each obs -- 2947 obs
body_gyro_z_test<-read.table("body_gyro_y_test.txt")    ## Vector of length 128 for each obs -- 2947 obs

total_acc_x_test<-read.table("total_acc_y_test.txt")    ## Vector of length 128 for each obs -- 2947 obs
total_acc_y_test<-read.table("total_acc_y_test.txt")    ## Vector of length 128 for each obs -- 2947 obs
total_acc_x_test<-read.table("total_acc_y_test.txt")    ## Vector of length 128 for each obs -- 2947 obs

body_acc_x_test<-read.table("body_acc_y_test.txt")      ## Vector of length 128 for each obs -- 2947 obs
body_acc_y_test<-read.table("body_acc_y_test.txt")      ## Vector of length 128 for each obs -- 2947 obs
body_acc_z_test<-read.table("body_acc_y_test.txt")      ## Vector of length 128 for each obs -- 2947 obs

## Read all the training data

setwd("~/Desktop/Coursera/UCI_data/train")

x_train<-read.table("x_train.txt")
subject_train<-read.table("subject_train.txt")            ## Matches each observation to a subject ID # 7352 obs
y_train<-read.table("y_train.txt")                        ## Matches each observation to an activity # 7352 obs

setwd("~/Desktop/Coursera/UCI_data/train/Inertial Signals")

body_gyro_x_train<-read.table("body_gyro_y_train.txt")   ## Vector of length 128 for each obs # 7352 obs
body_gyro_y_train<-read.table("body_gyro_y_train.txt")   ## Vector of length 128 for each obs # 7352 obs
body_gyro_z_train<-read.table("body_gyro_y_train.txt")   ## Vector of length 128 for each obs # 7352 obs

total_acc_x_train<-read.table("total_acc_y_train.txt")   ## Vector of length 128 for each obs # 7352 obs
total_acc_y_train<-read.table("total_acc_y_train.txt")   ## Vector of length 128 for each obs # 7352 obs        
total_acc_x_train<-read.table("total_acc_y_train.txt")   ## Vector of length 128 for each obs # 7352 obs

body_acc_x_train<-read.table("body_acc_y_train.txt")     ## Vector of length 128 for each obs # 7352 obs
body_acc_y_train<-read.table("body_acc_y_train.txt")     ## Vector of length 128 for each obs # 7352 obs
body_acc_z_train<-read.table("body_acc_y_train.txt")     ## Vector of length 128 for each obs # 7352 obs

## MERGE THE TRAIN / TEST OBSERVATIONS, FIX ACTIVITIES AND ALL VARIABLE LABELS

## Merge test and train into a single file
## For our use, we require Subject ID,  Activity IDs, and Feature Measurements contained in  x_test / x_train
## The actual vector 128 measures (window sampling) for each observation will not be used 
## These values are raw data and the mean and standard deviation are already calcuated in x_test & x_train
## Thus I am dropping this raw data from the table now.

## Merge test and train rows to 3 single files of 2947 + 7352 observations -- 10299

feature_measures<-rbind(x_test,x_train)
subject_ids<-rbind(subject_test,subject_train)
activities<-rbind(y_test,y_train)

## Preliminary Label Columnns

colnames(feature_measures)<-(features$V2)        ## Second column contains the actual names
colnames(subject_ids)<-c("subject")

## Convert Activity #'s to Actual Activity Names
        
max<-nrow(activities)                   ## Should be 10299 Observations
for (i in 1:max) {
        x<-as.integer(activities[i,1])  ## Determine the right label
        z<-activity_labels[x,1]         ## Select the right label
        activities[i,1]<-z              ## Replace Activity # with Activity Label
        
}

activity_labels<-as.matrix(activity_labels)
colnames(activities)<-c("activity") 

## Extract Mean and Std Calculations

x<-select(feature_measures, contains("mean"))
y<-select(feature_measures, contains("std"))
selected_features<-cbind(x,y)

## Apply descriptive variable names in readable English

names_to_fix<-colnames(selected_features)

names_to_fix<-gsub("([[:lower:]])([[:upper:]])", "\\1 \\2", names_to_fix)  ## Space out the words    
names_to_fix<-sub("t ", "total ", names_to_fix)                            ## Full words, not just letters
names_to_fix<-sub("f ", "fourier ", names_to_fix)

names_to_fix<-sub("-mean()", " mean", names_to_fix)                        ## Other Aesthetics       
names_to_fix<-sub("-std()", " std", names_to_fix)
names_to_fix<-sub("Body Body", "body", names_to_fix)
names_to_fix<-sub("()()-", " - ", names_to_fix)
names_to_fix<-sub("angle", "angle ", names_to_fix)                      
names_to_fix<-sub(",", ", ", names_to_fix)

colnames(selected_features)<-c(names_to_fix)

## COMBINE INTO A SINGLE TABLE -- DIRECTIONS 1 TO 5 NOW COMPLETE

master_set<-cbind(subject_ids, activities, selected_features)


## CREATE THE FINAL, TIDY DATA SET of AVERAGES  - DIRECTION 6

## Calculate Averages, Per Subject, Per Activity and stores all in a "pre-tidy" structure
## Uses three loops to iterate through subjects, activities and our selected feature set
## Uses the original labels set though all are presented as averages of the larger measurement sets

master_set<-arrange(master_set, subject, activity)              # Pre-Sort to facilitate looping

number_subjects<-nrow(unique(subject_ids))                      # Element counts for structure and loop sizing
number_activities<-nrow(activity_labels)
number_selected_features<-length(names_to_fix)

rows_in_pre_tidy<-number_subjects*number_activities             # Determine dimensions for the new data frame
cols_in_pre_tidy<-2+number_selected_features
        
pre_tidy<-as.data.frame(matrix(nrow = rows_in_pre_tidy, ncol = cols_in_pre_tidy))  # Initialize the data frame
colnames(pre_tidy)<-c("subject", "activity", c(names_to_fix))                      # Add in the labels

## Nested loops calculate the mean for sets of data associated with subject and activity
## And store in the proper position on the now initialized "pre-tidy" matrix

loop_counter<-0                                                         # initialize a counter

for (a in 1:number_subjects) {
         by_subject<-filter(master_set, subject==a)
         
         for (b in 1:number_activities) {                                   # Each subject has activities
                by_activity<-filter(by_subject, activity==b)   
                loop_counter<-loop_counter+1
                
                for (c in 1:number_selected_features) {                     
                        by_feature<-select(by_activity[c+2])            # Select each feature in turn
                        meanie<-mean(by_feature[[1]])                   # Calculate the mean
                        pre_tidy[loop_counter,1]<-a                     # Build the row - Subject    
                        pre_tidy[loop_counter,2]<-activity_labels[b]    # Build the row - Activity 
                        pre_tidy[loop_counter,c+2]<-meanie              # Build the row - Means for each Feature
                       
                }}}

##  With all data stored in a single table, it remains now to apply "tidy" data principles in the organization

## Applying tidy data to this case will require
## a) Melting the table to remove variables from the labels and store in columns -- a tall skinny table
## b) Manipulating melted table to ensure "single" variables
## Subjective interpretation required as to what constitutes multi-variable in single variables
## ... kept interpretation simple and chose just to split the measurement type as illustrative
## ... for example, possible to write additional splits for axes  
## ... and make it a "variable" with it's own set of values -- x, y, z or NA

## Make a "long skinny" table  -- removing variables from the labels

melted<-melt(pre_tidy, id=c("subject", "activity"), measure.vars=c(3:88))

##  Clean up any remaining aesthetic issues - capitals

fixed_up<-as.data.frame(sapply(melted, tolower))
          
## Separate measurement type into 3 variables -- Total, Fourier or Angle

rexp <- "^(\\w+)\\s?(.*)$"                      ## separate after initial space
new_cols<-data.frame(measurement=sub(rexp,"\\1",fixed_up$variable), 
                     feature=sub(rexp,"\\2",fixed_up$variable))  

tidy<-cbind(fixed_up, new_cols)                 ## join up the new columns to the old
tidy$variable=NULL                              ## get rid of original variable column
tidy<-tidy[, c(1,2,4,5,3)]                      ## re-order to place "value" as last column

write.table(tidy, "tidy_table.txt", row.name=FALSE) 
