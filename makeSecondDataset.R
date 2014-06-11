function makeSecondDataset(){
        tapply(allData$tBodyAccmeanX,list(allData$subject,allData$activity),mean)
}