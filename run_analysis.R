	## Created by YL
	## Created on 2015_02_20
	## ETL script to create tidy data set from Human Activity Recognition Using Smartphones Data Set.
	## For more information, refer to CookBook.md
	
	## ---
	
	## Prepare the trainDataSet by uploading:
	## 1. The data set and add the variablenames
	## 2. subject & labels and adding them to the data set
	## => result is trainDataSet with names for all variables including the subjects & labels.
	
	## Upload train data set in trainDataSet
	trainDataSet <- read.table(file ="./UCI HAR Dataset/train/x_train.txt")
	## Add labels to trainDataSet
	features <- read.table(file ="./UCI HAR Dataset/features.txt")
	names(trainDataSet) <- features[,2]

	## Upload train subjects in trainLabels
	trainSubject <- read.table(file ="./UCI HAR Dataset/train/subject_train.txt")
	## Upload train labels in trainLabels
	trainLabels <- read.table(file ="./UCI HAR Dataset/train/y_train.txt")
	
	## Add the subjects and labels as a column to the trainDataSet
	trainDataSet$Subject <- trainSubject$V1
	trainDataSet$ActivityId <- trainLabels$V1
	
	## ---
	
	## Prepare the testDataSet by uploading:
	## 1. The data set and add the variablenames
	## 2. subject & activityId (labels) and adding them to the data set
	## => result is testDataSet with names for all variables including the subjects & labels.
	
	## Upload test data set in testDataSet
	testDataSet <- read.table(file ="./UCI HAR Dataset/test/x_test.txt")
	## Add labels to testDataSet
	names(testDataSet) <- features[,2]
	
	## Upload test subjects in testLabels
	testSubject <- read.table(file ="./UCI HAR Dataset/test/subject_test.txt")
	## Upload test labels in testLabels
	testLabels <- read.table(file ="./UCI HAR Dataset/test/y_test.txt")
	
	## Add the subjects and labels as a column to the testDataSet
	testDataSet$Subject <- testSubject$V1
	testDataSet$ActivityId <- testLabels$V1
	
	## Merge trainDataSet with testDataSet
	fullDataSet <- rbind(trainDataSet, testDataSet)
	
	## ---
	
	## Replace the activity id's with activity labels
	## 1. Upload the activity labels and give the variables
	## 2. Merge the fullDataSet with the activity labels
	## => fullDataSet containing the labels of the activities
	
	## Upload activity labels
	activityLabels <- read.table(file ="./UCI HAR Dataset/activity_labels.txt")
	## Give the activityLabels data.frame names to make the merging easier
	names(activityLabels) <- c("ActivityId", "ActivityLabel")
	## Merge the full dataset with the 
	mergedDataSet <- merge(fullDataSet, activityLabels, "ActivityId")
	
	## ---
	
	## Subset the dataset with only relevant variables
	## 1. Filter out all variables containing '-mean' or '-std' in their names
	## 2. Create a vector containing the indexes of the relevant variables
	## 3. Make sure to include the index of the subject & activity labels variables
	## 4. Subset the dataset based on the index with vectors
	## => Sub setted dataset with only relevant variables containing '-mean' or '-std' including the subject & activity labels variables.
	
	## Subset the variables containing '-mean' or '-std'
	## searchStrings <- c('mean', 'std', 'subject', 'activityLabel')
	searchStrings <- c('mean\\(\\)', 'std\\(\\)', 'Subject', 'ActivityLabel')
	## Put columnNames in dataframe with an index number used for subsetting
	colNames <- data.frame(names(mergedDataSet), seq(along = names(mergedDataSet)))
	## Filter corresponding colNames
	filteredFeatures <- subset(colNames, grepl(paste(searchStrings, collapse= "|"), colNames$names.mergedDataSet.))
	## Convert the first column with the position of the variables into a vector
	columnNumFeatures <- filteredFeatures[,2]
	## Select all the relevant columns based on the columnNumFeatures vector from the labelledDataSet
	subsettedDataSet <- mergedDataSet[,columnNumFeatures]

	## ---
	
	## Calculate the average of each variable for each activity and each subject
	## 1. Create a melted data set so that each variable containing '-mean' or '-std' is expressed as a row
	## 2. Calculate the mean on the melted data set using the dcast function
	## => dataset with all the means for each variable per activity per subject
	
	
	## Need to recast the data.frame
	meltedDataSet <- melt(subsettedDataSet, id=c("Subject", "ActivityLabel"))
	
	## Calculate average per activity and subject
	tidyData <- dcast(meltedDataSet,Subject + ActivityLabel ~ variable, mean)
	
	## Export the tidy dataset.
	write.table(tidyData, "./tidy_data.txt", row.names = FALSE)
