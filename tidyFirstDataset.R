function tidyFirstDataset(dir){
        setwd(dir)
        if(!file.exists("./data")){dir.create("./data")}
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, destfile = "./data/Smartphones.zip",method="curl")
        unzip("./data/Smartphones.zip", exdir=("./data"))
        unlink("./data/Smartphones.zip")
        
        filesToMove <- dir("./data/UCI HAR Dataset/",full.names=TRUE)
        file.copy(from=filesToMove, to="./data/", 
                  overwrite = FALSE, recursive = TRUE, 
                  copy.mode = TRUE)
        
        unlink("./data/UCI HAR Dataset", recursive = TRUE, force = TRUE)
        
        ## Merge dataset
        measureName <- read.table("./data/features.txt",colClasses=c("NULL",NA),stringsAsFactors=FALSE)
        measureName <- measureName[1:561,]
        ##measureName <- gsub("-","",measureName)
        ##measureName <- gsub("\\(\\)","",measureName)
        
        dataTrain <- read.table("./data/train/X_train.txt")
        colnames(dataTrain) <- measureName
        dataTrain<- dataTrain[,grep("mean\\(\\)|std\\(\\)",names(dataTrain))]
        
        colnames(dataTrain) <- gsub("-|\\(\\)","",colnames(dataTrain))
        
        subjectTrain <- read.table("./data/train/subject_train.txt")
        activityTrain <- read.table("./data/train/y_train.txt")
        activityTrain <- factor(activityTrain$V1)
        levels(activityTrain) <- c("Walking","Walking_upstairs","Walking_downstairs", 
                                   "Sitting","Standing","Laying")
        subjectTrain <- factor(subjectTrain$V1)
        dataTrain <- cbind(subject=subjectTrain, activity=activityTrain,set="train",dataTrain)
        
        rm("activityTrain","subjectTrain")
        
        dataTest <- read.table("./data/test/X_test.txt")
        colnames(dataTest) <- measureName
        dataTest <- dataTest[,grep("mean\\(\\)|std\\(\\)",names(dataTest))]
        
        colnames(dataTest) <- gsub("-|\\(\\)","",colnames(dataTest))
        
        subjectTest <- read.table("./data/test/subject_test.txt")
        activityTest <- read.table("./data/test/y_test.txt")
        activityTest <- factor(activityTest$V1)
        levels(activityTest) <- c("Walking","Walking_upstairs","Walking_downstairs", 
                                  "Sitting","Standing","Laying")
        subjectTest <- factor(subjectTest$V1)
        dataTest <- cbind(subject=subjectTest, activity=activityTest,set="test",dataTest)
        
        rm("activityTest","subjectTest")
        
        allData <- rbind(dataTrain,dataTest)
        
        rm("dataTest","dataTrain", "measureName")
}