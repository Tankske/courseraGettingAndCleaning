#CodeBook Getting&Cleaning data project

##Purpose of the document

This document describes: 
- the variables,
- the data,
- any transformations or work performed to clean up the data, and
- the result.

---

##Overview of the data used as input

Below are all the data sources listed that are used for the project with their meaning.
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

---

##Overview of the variables in the input files

The variables consist of the following:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

---

##Overview of work performed

The following steps have been performed to create the tidy dataset:
- Merge the training and the test sets to create one data set.
- Extract only the measurements on the mean and standard deviation for each measurement. 
- Use descriptive activity names to name the activities in the data set
- Appropriately label the data set with descriptive variable names. 
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The work has not been performed in the sequence mentioned above. Refer to the following section to see a detailed description of the work performed.

---

##Detailed work performed

In what follows the work performed is described in detail. Refer to 'Run_analysis.R' for the script.

###1. Merge the training and the test sets to create one data set.
Prepare the trainDataSet by uploading:
1. The data set and add the variablenames
2. subject & labels and adding them to the data set
=> result is trainDataSet with names for all variables including the subjects & labels.

Prepare the testDataSet by uploading:
1. The data set and add the variablenames
2. Subject & activityId (labels) and adding them to the data set
=> result is testDataSet with names for all variables including the subjects & labels.	

Union the trainDataSet with testDataSet into the data.frame mergedDataSet

###2. Replace the activity id's with activity labels
1. Upload the activity labels and give the variables
2. Merge the fullDataSet with the activity labels
=> fullDataSet containing the labels of the activities

###3. Extract only the measurements on the mean and standard deviation for each measurement. 
The purpose is to filter out all the variables containing '-mean' or '-std' in a subset data.frame called filteredFeatures.
eg.
1 tBodyAcc-mean()-X
2 tBodyAcc-mean()-Y
3 tBodyAcc-mean()-Z
4 tBodyAcc-std()-X
5 tBodyAcc-std()-Y
6 tBodyAcc-std()-Z
7 tBodyAcc-mad()-X
8 tBodyAcc-mad()-Y
9 tBodyAcc-mad()-Z

should result in
1 tBodyAcc-mean()-X
2 tBodyAcc-mean()-Y
3 tBodyAcc-mean()-Z
4 tBodyAcc-std()-X
5 tBodyAcc-std()-Y
6 tBodyAcc-std()-Z

Subset the dataset with only relevant variables
1. Filter out all variables containing '-mean' or '-std' in their names as described above
2. Create a vector containing the indexes of the relevant variables
3. Make sure to include the index of the subject & activity labels variables
4. Subset the dataset based on the index with vectors
=> Sub setted dataset with only relevant variables containing '-mean' or '-std' including the subject & activity labels variables.
	 
###4. Creates an independent tidy data set with the average of each variable for each activity and each subject.
Calculate the average of each variable for each activity and each subject
1. Create a melted data set so that each variable containing '-mean' or '-std' is expressed as a row
2. Calculate the mean on the melted data set using the dcast function
=> dataset with all the means for each variable per activity per subject

##The result
The script 'Run_Analysis.R' creates a file called 'tidy_data.txt' which contains the means of each variable per subject per activity. The results contains a header row and 180 observastions (unique combinations Subject - ActivityLabel). Next to the variable Subject and ActivityLabel, the result contains 68 smartphone accelerometer-variables consisting of 33 means and 33 deviations.

##Lessons learned

When performing this exercise the following lessons were learned:
- It would be better to extract first the relevant measurements before storing data in a variable and merging multiple data sets. This would be more memory efficient.
