# Coursera Getting and Cleaning Data Course Project

3. a code book that describes the variables, the data, and any transformations or work performed to clean up the data called CodeBook.md.

run_analysis.R is a R script that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## Steps

1. Download and unzip the dataset. The script checks if dataset folder is already present in working directory, otherwise it downloads it in a temporary file, extracts the archive in working directory and deletes the temporary file.

2. Loading from 'features.txt' and 'activity_labels.txt' names of features and activities in two data frame.

3. Project requests just data on mean and std, so filter the interested features by name and clean the names to make them more readable.
filterFeatures is the list of all ids of interested features and filteredFeaturesNames their names.

4. Load training set data, measurements, activities and subjects. Measurements are filtered by filterFeatures. Activities ids are replaced by its readable form.
Subjects, Activities and Features are merged together to create a single data frame.
To maintain data tidy, columns names are replaced.

5. Same steps of point 4 are executed on test set data, so we have two dataset with the same variables.

6. Training set and test data are merged together in allData data frame as requested by project.

7. Starting from allData, it is created a new dataset avgData to store the average of each variable for each activity and each subject

8. avgData is saved to 'tidyData.txt' file
