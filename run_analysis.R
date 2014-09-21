## The function run_analysis gets  the data from the test
## and train directories and merges the data 
## It then does the following with the merged dataset
## 1. Extracts only the measurements on the mean and standard deviation 
##    for each measurement from the merged dataset
## 2. Labels the activity names in the data set
## 3. Appropriately labels the data set with descriptive variable names
## 4. Using 3, creates a second, independent tidy data set with the average of 
##    each variable for each activity and each subject

run_analysis <- function(){
    
    # Get the test dataset  
    testset <- readtestset()    
    
    # Now do the same for the train data set
    trainset <- readttrainset()    
    
    # Merge the data sets by row binding
    mergedset <- rbind(trainset, testset)
       
    # For each measurement, extract mean and standard deviations
    measureset <- extractmeasurements(mergedset)
    
    # Label activity names
    labelledset <- labelactivities(measureset)
    
    # Name the rest of data set with desciptive names
    entiresetlabelled <- labelentireset(labelledset)

    # Create independent set from labelled set with averages accross activity and subject
    tidyset <- createindependentset(entiresetlabelled)
    
    # Write tidy set to file
    writetidyset(tidyset)
}

# The function readtestset gets the data from the test data set
readtestset <- function() {
    testsubjectset <- read.table("./UCI Har Dataset/test/subject_test.txt", col.names="Subject_Id")
    testyset <-  read.table("./UCI Har Dataset/test/y_test.txt", col.names="Activity_Id")
    # Use the features to label the column names for the features
    testxset <-  read.table("./UCI Har Dataset/test/X_test.txt")
    # Combine the 3 sets together to get the combined test data set  
    testset <- cbind(testsubjectset, testxset, testyset)
}    

# The function readtestset the data from the train data set
readttrainset <- function() {
    trainsubjectset <- read.table("./UCI Har Dataset/train/subject_train.txt", col.names="Subject_Id")
    trainyset <-  read.table("./UCI Har Dataset/train/y_train.txt", col.names="Activity_Id")    
    # Use the features to label the column names for the features
    trainxset <-  read.table("./UCI Har Dataset/train/X_train.txt")
    # Combine the 3 sets together to get the combined train data set  
    trainset <- cbind(trainsubjectset, trainxset, trainyset)
}    

# The function extractmeasurements extracts mean 
# and standard deviations from overall data set
extractmeasurements <- function(dataset, ...){
    # Load dataset into tbl_df
    extractedmeasurement <- tbl_df(dataset)
    # Use contains to get std(), mean() back and make sure to include Subject and Activity
    extractedmeasurement <- select(extractedmeasurement, Subject_Id, Activity_Id, V1:V6, V41:V46, 
                                   V81:V86, V121:V126, V161:V166, V201:V202, V214:V215, V227:V228,
                                   V240:V241, V253:V254, V266:V271, V345:V350, V424:V429,
                                   V503:V504, V516:V517, V529:V530, V542:V543)
    
    # Return extracted set
    extractedmeasurement
}

# This function labels the activities
labelactivities <- function(dataset){
    # Get the activity list names from the 
    activitylabels <-  read.table("./UCI Har Dataset/activity_labels.txt", col.names=c("Activity_Id","Activity_Name"))
    # Use mutate (rather than separate or merge) to label activities  
    labelledactivities <- merge(dataset, activitylabels, by.x="Activity_Id", by.y="Activity_Id", sort=FALSE, all=FALSE)
}

# This function lables all the test x data into descriptive names 
labelentireset <- function(labelledset){
    # Rename Subject_Id to Subject Id, Activity_Id to Activity Id, Activity_Name to Activity Name
    # and name everything else
    columnnames <- c("Activity Id","Subject Id",
                  "Time Of Body Acceleration Mean 3-Axial X Direction",
                  "Time Of Body Acceleration Mean 3-Axial Y Direction",
                  "Time Of Body   Acceleration Mean 3-Axial Z Direction",
                  "Time Of Body Acceleration Standard Deviation 3-Axial X Direction",
                  "Time Of Body Acceleration Standard Deviation 3-Axial Y Direction",
                  "Time Of Body Acceleration Standard Deviation 3-Axial Z Direction",
                  "Time Of Gravity Acceleration Mean 3-Axial X Direction",
                  "Time Of Gravity Acceleration Mean 3-Axial Y Direction",
                  "Time Of Gravity Acceleration Mean 3-Axial Z Direction",
                  "Time Of Gravity Acceleration Standard Deviation 3-Axial X Direction",
                  "Time Of Gravity Acceleration Standard Deviation 3-Axial Y Direction",
                  "Time Of Gravity Acceleration Standard Deviation 3-Axial Z Direction",
                  "Time Of Body Jerk Signal Acceleration Mean 3-Axial X Direction",
                  "Time Of Body Jerk Signal Acceleration Mean 3-Axial Y Direction",
                  "Time Of Body Jerk Signal Acceleration Mean 3-Axial Z Direction",
                  "Time Of Body Jerk Signal Acceleration Standard Deviation 3-Axial X Direction",
                  "Time Of Body Jerk Signal Acceleration Standard Deviation 3-Axial Y Direction",
                  "Time Of Body Jerk Signal Acceleration Standard Deviation 3-Axial Z Direction",
                  "Time Of Body Gyroscope Mean 3-Axial X Direction",
                  "Time Of Body Gyroscope Mean 3-Axial Y Direction",
                  "Time Of Body Gyroscope Mean 3-Axial Z Direction",
                  "Time Of Body Gyroscope Standard Deviation 3-Axial X Direction",
                  "Time Of Body Gyroscope Standard Deviation 3-Axial Y Direction",
                  "Time Of Body Gyroscope Standard Deviation 3-Axial Z Direction",
                  "Time Of Body Jerk Signal Gyroscope Mean 3-Axial X Direction",
                  "Time Of Body Jerk Signal Gyroscope Mean 3-Axial Y Direction",
                  "Time Of Body Jerk Signal Gyroscope Mean 3-Axial Z Direction",
                  "Time Of Body Jerk Signal Gyroscope Standard Deviation 3-Axial X Direction",
                  "Time Of Body Jerk Signal Gyroscope Standard Deviation 3-Axial Y Direction",
                  "Time Of Body Jerk Signal Gyroscope Standard Deviation 3-Axial Z Direction",
                  "Time Of Body Acceleration Mean Magnitude of X,Y and Z signals",
                  "Time Of Body Acceleration Standard Deviation Magnitude of X,Y and Z signals",
                  "Time Of Gravity Acceleration Mean Magnitude of X,Y and Z signals",
                  "Time Of Gravity Acceleration Standard Deviation Magnitude of X,Y and Z signals",
                  "Time Of Body Jerk Signal Acceleration Mean Magnitude of X,Y and Z signals",
                  "Time Of Body Jerk Signal Acceleration Standard Deviation Magnitude of X,Y and Z signals",
                  "Time Of Body Gyroscope Mean Magnitude of X,Y and Z signals",
                  "Time Of Body Gyroscope Standard Deviation Magnitude of X,Y and Z signals",
                  "Time Of Body Jerk Signal Gyroscope Mean Magnitude of X,Y and Z signals",
                  "Time Of Body Jerk Signal Gyroscope Standard Deviation Magnitude of X,Y and Z signals",
                  "Fast Fourier Transform Body Acceleration Mean 3-Axial X Direction",
                  "Fast Fourier Transform Body Acceleration Mean 3-Axial Y Direction",
                  "Fast Fourier Transform Body Acceleration Mean 3-Axial Z Direction",
                  "Fast Fourier Transform Body Acceleration Standard Deviation 3-Axial X Direction",
                  "Fast Fourier Transform Body Acceleration Standard Deviation 3-Axial Y Direction",
                  "Fast Fourier Transform Body Acceleration Standard Deviation 3-Axial Z Direction",
                  "Fast Fourier Transform Body Jerk Signal Acceleration Mean 3-Axial X Direction",
                  "Fast Fourier Transform Body Jerk Signal Acceleration Mean 3-Axial Y Direction",
                  "Fast Fourier Transform Body Jerk Signal Acceleration Mean 3-Axial Z Direction",
                  "Fast Fourier Transform Body Jerk Signal Acceleration Standard Deviation 3-Axial X Direction",
                  "Fast Fourier Transform Body Jerk Signal Acceleration Standard Deviation 3-Axial Y Direction",
                  "Fast Fourier Transform Body Jerk Signal Acceleration Standard Deviation 3-Axial Z Direction",
                  "Fast Fourier Transform Body Gyroscope Mean 3-Axial X Direction",
                  "Fast Fourier Transform Body Gyroscope Mean 3-Axial Y Direction",
                  "Fast Fourier Transform Body Gyroscope Mean 3-Axial Z Direction",
                  "Fast Fourier Transform Body Gyroscope Standard Deviation 3-Axial X Direction",
                  "Fast Fourier Transform Body Gyroscope Standard Deviation 3-Axial Y Direction",
                  "Fast Fourier Transform Body Gyroscope Standard Deviation 3-Axial Z Direction",
                  "Fast Fourier Transform Body Acceleration Mean Magnitude of X,Y and Z signals",
                  "Fast Fourier Transform Body Acceleration Standard Deviation Magnitude of X,Y and Z signals",
                  "Fast Fourier Transform Body Jerk Signal Acceleration Mean Magnitude of X,Y and Z signals",
                  "Fast Fourier Transform Body Jerk Signal Acceleration Standard Deviation Magnitude of X,Y and Z signals",
                  "Fast Fourier Transform Body Gyroscope Mean Magnitude of X,Y and Z signals",
                  "Fast Fourier Transform Body Gyroscope Standard Deviation Magnitude of X,Y and Z signals",
                  "Fast Fourier Transform Body Jerk Signal Gyroscope Mean Magnitude of X,Y and Z signals",
                  "Fast Fourier Transform Body Jerk Signal Gyroscope Standard Deviation Magnitude of X,Y and Z signals",
                   "Activity Name")
    
    # Rename existing columns
    names(labelledset)[] <- columnnames 
    
    labelledset
}

# This functions creates a new independent data set with subject and activity means based
# on data set passed in
createindependentset <- function(dataset){
    # Make sure Subject and Activity are exluded from average
    independentset <- dataset %>%
                      group_by("Activity Name","Subject Id") %>% 
                      summarise_each(funs(mean), -starts_with("Activity"), -starts_with("Subject"))
    
    independentset
}

# This functions writes the tidy data to a tidydata.txt file in the working directory
writetidyset <- function(tidyset){
    write.table(tidyset, "tidyset.txt", sep=" ", row.names=FALSE)
}
