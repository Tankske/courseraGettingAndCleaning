#CodeBook Getting&Cleaning data project

##Purpose of the document

This document describes: 
- the variables,
- the data, and
- any transformations or work performed to clean up the data.

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

##Overview of the variables


---

##Overview of work performed

The following steps have been performed to create the tidy dataset:
1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement. 
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

---

##Detailed work performed

###1. Merge the training and the test sets to create one data set.
The following files have been uploaded and merged:
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
	=> Both files have been uploaded and joined together in order to link the labels to the data set. The result was stored in the variable 'LabeledTrainingSet'.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
	=> Both files have been uploaded and joined together in order to link the labels to the data set. The result was stored in the variable 'LabeledTestSet'.

Both the variable 'LabeledTrainingSet' and 'LabeledTestSet' are then merged together to have all data available in one data set.

###2. Extract only the measurements on the mean and standard deviation for each measurement. 
Upload the file 'features.txt' into the data.frame features
Filter out all the variables containing '-mean' or '-std' in a subset data.frame called filteredFeatures.
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
 
The first column of the data.frame filteredFeatures was then converted into a vector called columnNumFeatures.
columnNumFeatures should look like  [1,2,3,4,5,6, 41, 42, 43, ...]. 

###3. Use descriptive activity names to name the activities in the data set

Link the activity labels found in 'Activity_labels.txt' to the data. We've uploaded the data into the data.frame activityLabels
This was done by replacing the index numbers of the column X with the corresponding values from the data.frame activityLabels.


###4. Appropriately label the data set with descriptive variable names. 

Use the filteredFeatures data.frame and convert the second variable containing the variable names into a vector and apply it to the dataset.

###5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


##Lessons learned

When performing this exercise the following lessons were learned:
- It would be better to extract first the relevant measurements before storing data in a variable and merging multiple data sets. This would be more memory efficient.
- ...
