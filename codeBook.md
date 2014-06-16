## CodeBook for samsung dataset
Bauke van der Velde

This codebook describes the variables in the two supplied datasets and explains
how these datasets were created.

## Variables in datasets
### ID variables:
subject: subjectID
activity: performed activity ("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
set: whether the data was gathered from the test or train session

### Value variables
The features selected for this database come from the accelerometer and gyroscope 
3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) 
were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 
3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. 
Similarly, the acceleration signal was then separated into body and gravity acceleration 
signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with 
a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to 
obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these 
three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, 
tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing 
fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. 
(Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAccXYZ
tGravityAccXYZ
tBodyAccJerkXYZ
tBodyGyroXYZ
tBodyGyroJerkXYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAccXYZ
fBodyAccJerkXYZ
fBodyGyroXYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean: Mean value
std: Standard deviation

## Process of cleaning the original data set
The original data can be downloaded from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Please, check the README file supplied with the original dataset for information regarding the files in that 
dataset.

The _run_analysis.R_ file performs the following steps
1. Checks whether the dataset is present in the working directory. If not, the data is downloaded 
from aformentioned link to "./Smartphones.zip" and unzipped. The original .zip-file is then deleted

2. Loads the data ('X_train.txt'), subjectID ('subject_train.txt') and activityID ('y_train.txt') files into
R and cbinds these together with a column setting this data to train date, creating the train dataframe

3. This process is repeated with the test data, creating a seperate test dataframe

4. The two dataframes are merged into the variable firstDataSet by binding the rows together

5. Variable names are loaded from './features.txt' and used as colnames for the dataframe

6. Dataframe is cleaned by removing all, but the value variables of interest(mean() & std())

7. The activityID is labelled according to './activity_labels.txt'

8. firstDataSet variable names are cleaned by removing all instances of hyphen and brackets 

9. firstDataSet is saved into 'firstDataSet.txt' for future use

10. secondDataSet is created by averaging each activity for each subject

11. secondDataSet is saved into 'secondDataSet.txt' for future use












