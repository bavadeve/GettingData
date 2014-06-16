######################## 1. Merge datasets ####################################
## Load in train set and it's subjects + activities
dataTrain <- read.table("./UCI HAR Dataset/train/X_train.txt");
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
activityTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")

## create data.frame for the training set, with a column for subject, activity 
## and a column stating it was a training session
dataTrain <- cbind(subject=subjectTrain, activity=activityTrain,set="train",dataTrain)

## Load in test set and it's subjects + activities
dataTest <- read.table("./UCI HAR Dataset/test/X_test.txt"); print("Test data loaded")
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
activityTest <- read.table("./UCI HAR Dataset/test/y_test.txt")

## create data.frame for the test set, with a column for subject, activity 
## and a column stating it was a test session
dataTest <- cbind(subject=subjectTest, activity=activityTest,set="test",dataTest)

## Merge the two sets
firstDataSet <- rbind(dataTrain,dataTest)

## remove cluttering variables
rm("activityTest","activityTrain","dataTest","dataTrain","subjectTest","subjectTrain")

######################## 2. Set activity names ################################
measureName <- read.table("./UCI HAR Dataset/features.txt",colClasses=c("NULL",NA),stringsAsFactors=FALSE)
colnames(firstDataSet) <- c("subject","activity","set",measureName$V2)
rm("measureName")

######################## 3. Extract mean % std ################################
firstDataSet <- firstDataSet[,grep("mean\\(\\)|std\\(\\)|activity|subject|set",names(firstDataSet))]

########################### 4. Label factors ##################################
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt",colClasses=c("NULL",NA),stringsAsFactors=FALSE)
firstDataSet$activity <- factor(firstDataSet$activity, labels = activityLabels$V2)
rm("activityLabels")

################### 5. Clean variable names & save dataset ####################
colnames(firstDataSet) <- gsub("-|\\(\\)","",colnames(firstDataSet)) ## Remove all instances of brackets and hyphens
write.table(firstDataSet, file = "firstDataSet.txt", sep = " ") ## Save File


####################### 6. Make & save second dataset #########################
## Create a second dataset with mean value for each activity seperated by subject
secondDataSet <- aggregate(. ~ subject+activity,data = firstDataSet,FUN=mean)
write.table(firstDataSet, file = "secondDataSet.txt", sep = " ") ## Save File





