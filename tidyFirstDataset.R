tidyFirstDataset <- function(dir){
        setwd(dir)
        if(!file.exists("./UCI HAR Dataset")){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, destfile = "./Smartphones.zip")
        unzip("./Smartphones.zip")
        unlink("./Smartphones.zip"); print("file downloaded and unzipped")
        }
        
        
        ## Merge dataset
        print("start tyding process...")
        
        measureName <- read.table("./UCI HAR Dataset/features.txt",colClasses=c("NULL",NA),stringsAsFactors=FALSE)
        measureName <- measureName[1:561,]
        ##measureName <- gsub("-","",measureName)
        ##measureName <- gsub("\\(\\)","",measureName)
        
        dataTrain <- read.table("./UCI HAR Dataset/train/X_train.txt"); print("Train data loaded")
        colnames(dataTrain) <- measureName
        dataTrain<- dataTrain[,grep("mean\\(\\)|std\\(\\)",names(dataTrain))]
        
        colnames(dataTrain) <- gsub("-|\\(\\)","",colnames(dataTrain))
        
        subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
        activityTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
        activityTrain <- factor(activityTrain$V1)
        levels(activityTrain) <- c("Walking","Walking_upstairs","Walking_downstairs", 
                                   "Sitting","Standing","Laying")
        subjectTrain <- factor(subjectTrain$V1)
        dataTrain <- cbind(subject=subjectTrain, activity=activityTrain,set="train",dataTrain)
        
        print("Train data tydied")
        
        rm("activityTrain","subjectTrain")
        
        dataTest <- read.table("./UCI HAR Dataset/test/X_test.txt"); print("Test data loaded")
        colnames(dataTest) <- measureName
        dataTest <- dataTest[,grep("mean\\(\\)|std\\(\\)",names(dataTest))]
        
        colnames(dataTest) <- gsub("-|\\(\\)","",colnames(dataTest))
        
        subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
        activityTest <- read.table("./UCI HAR Dataset/test/y_test.txt")
        activityTest <- factor(activityTest$V1)
        levels(activityTest) <- c("Walking","Walking_upstairs","Walking_downstairs", 
                                  "Sitting","Standing","Laying")
        subjectTest <- factor(subjectTest$V1)
        dataTest <- cbind(subject=subjectTest, activity=activityTest,set="test",dataTest)
        
        rm("activityTest","subjectTest")
        
        print("Test data tydied")
        
        allData <- rbind(dataTrain,dataTest)
        print("Test and train data merged... dataset done")
        allData
}