CodeBook for tidy data
======================
This codebook describes the data, variables and transformations to produce the tidy dataset under the Getting and Cleaning Data Project.
Data source
-----------
The raw data for the project were posted [online](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). A full description of the data is available at on the [Human Activity Recognition](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) website.
Variables
---------
The raw data archive contains two ascii files describing the data: README.txt and features_info.txt. The features in the database come from accelerometer and gyroscope three-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. The dataset includes 561 feature (signal) variables, from which only the mean() and std() summary variables were selected (n=86).
Transformations
---------------
The tidy dataset presents the mean and standard deviation feature variables averaged by subject and activity type. The following data transformations were applied to the original data (using the script: run_analysis.R): (1) the raw train and test datasets were merge train, (2) the mean and standard deviation variables were extracted from feature vector variables, (3) descriptive activity names were added to activity categorical variable, (4) feature variables were labelled with descriptive activity names, and (5) the data were averaged by activity and subject to create a tidy dataset (written out as tidy-means.txt).
