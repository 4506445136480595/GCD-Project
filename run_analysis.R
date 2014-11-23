# run_analysis.R
# Getting and Cleaning Data: Course project
#
# Script to merge and summarise the UCI HAR Dataset
# The script carries out the folowing:
# 1. Merge train and test datasets.
# 2. Extract only mean and standard deviation varaibles from feature vector variables (n = 561).
# 3. Add descriptive activity names to activity class ID.
# 4. Label variables with descriptive activity names.
# 5. Create tidy data set with the average of each variable by activity and subject.
# Raw data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# set working directory to UCI HAR Dataset
setwd("./UCI HAR Dataset")

# load dependencies
library(reshape2)

# read in feature and activity labels
# subset features describing mean and standard deviation statistics
features <- read.table("features.txt",header=F)
xfeatures <- grepl("[Mm]ean|[Ss]td", features[,2])
activity_labels <- read.table("./activity_labels.txt", header=F, col.names = c("activityId","activityType"))

# read in training datasets and add column names
subject_train <- read.table("./train/subject_train.txt", header=F, col.names = "subjectId")
x_train <- read.table("./train/x_train.txt",header=F,col.names=features[,2])
y_train <- read.table("./train/y_train.txt",header=F,col.names="activityId")

# bind train datasets
train <- cbind(y_train,subject_train,x_train[,xfeatures])

# read in test datasets and add column names
subject_test <- read.table("./test/subject_test.txt",header=F,col.names="subjectId")
x_test <- read.table("./test/x_test.txt",header=F,col.names=features[,2])
y_test <- read.table("./test/y_test.txt",header=F,col.names="activityId")

# bind test datasets
test <- cbind(y_test,subject_test,x_test[,xfeatures])

# bind train and test datasets
data <- rbind(train,test)

# merge descriptive activity names
fdata <- merge(activity_labels,data,by="activityId",all.x=T)
fdata <- fdata[,names(fdata) != "activityId"]

# clean up names here
dnames<-names(fdata)
dnames<-gsub("\\()","",dnames)
dnames<-gsub("\\.\\.","",dnames)
dnames<-gsub(".std","StdDev",dnames)
dnames<-gsub(".mean","Mean",dnames)
dnames<-gsub("^(t)","time",dnames)
dnames<-gsub("^(f)","freq",dnames)
names(fdata)<-dnames

# melt and cast data to summarise variables by subject ID and activity type
mdata <- melt(fdata, id=c("subjectId", "activityType"))
tdata<-dcast(mdata, subjectId + activityType~variable, mean) 

# write out tidy mean data set
write.table(tdata, "tidy-means.txt", row.names = F)
