############### Check if data exists. If not download: and unzip ##############
if(!file.exists("./UCI HAR Dataset")){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, destfile = "./Smartphones.zip")
        unzip("./Smartphones.zip")
        unlink("./Smartphones.zip"); print("file downloaded and unzipped")
}

######################## 1. Merge datasets ####################################
## Load in train set and it's subjects + activities
dataTrain <- read.table("./UCI HAR Dataset/train/X_train.txt");
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
activityTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")

## create data.frame for the training set, with a column for subject, activity 
## and a column stating it was a training session
dataTrain <- cbind(subject=subjectTrain, activity=activityTrain,session="train",dataTrain)

## Load in test set and it's subjects + activities
dataTest <- read.table("./UCI HAR Dataset/test/X_test.txt");
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
activityTest <- read.table("./UCI HAR Dataset/test/y_test.txt")

## create data.frame for the test set, with a column for subject, activity 
## and a column stating it was a test session
dataTest <- cbind(subject=subjectTest, activity=activityTest,session="test",dataTest)

## Merge the two sets
firstDataSet <- rbind(dataTrain,dataTest)

## remove cluttering variables
rm("activityTest","activityTrain","dataTest","dataTrain","subjectTest","subjectTrain")

######################## 2. Set variable names ################################
measureName <- read.table("./UCI HAR Dataset/features.txt",colClasses=c("NULL",NA),stringsAsFactors=FALSE)
colnames(firstDataSet) <- c("subject","activity","session",measureName$V2)
rm("measureName")

###### 3. Extract mean % std, leave in activity, subject, session variables ###
firstDataSet <- firstDataSet[,grep("mean\\(\\)|std\\(\\)|activity|subject|session",names(firstDataSet))]

########################### 4. Label activity names ###########################
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt",colClasses=c("NULL",NA),stringsAsFactors=FALSE)
firstDataSet$activity <- factor(firstDataSet$activity, labels = activityLabels$V2)
rm("activityLabels")

################### 5. Clean variable names & save dataset ####################
colnames(firstDataSet) <- gsub("-|\\(\\)","",colnames(firstDataSet)) ## Remove all instances of brackets and hyphens
write.table(firstDataSet, file = "firstDataSet.txt", sep = " ") ## Save File

####################### 6. Make & save second dataset #########################
## Create a second dataset with mean value for each activity seperated by subject
secondDataSet <- aggregate(. ~ subject+activity,data = firstDataSet,FUN=mean)
write.table(secondDataSet, file = "secondDataSet.txt", sep = " ") ## Save File





