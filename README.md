## Overview
The run_analysis script assumes that all the test and train data is in a UCI HAR Dataset subdirectory.

The script contains one main function run_analyis which calls a number of sub functions. To run the entire script, just call the main function.

===================
## Determining elements to include from Test and Train Dataset:
The main function calls readtestset and then readttrainset

The readtestset method reads the following files:
* ./UCI Har Dataset/test/subject_test.txt (to get the list of subjects)
* ./UCI Har Dataset/test/y_test.txt (to get the actiivities)
* ./UCI Har Dataset/train/X_train.txt (to get the features)
and then binds all the columns together

The readttrainset does exactly the same with the equivalent files in the train folder.

The two datasets are then merged by row binding the entire set. The entire dataset gives 10299 observations of 563 variables and is stored in a mergedset variable within the main method.

===================
## Extracting Mean And Standard Deviation Measurements:
1. At this stage, the merged data set has 10299 rows with 563 variables, 2 of which are labelled 
 'Activity_Id' and 'Subject_Id'
2. The following are the mean and standard deviations in the data set corresponding to the following columns:
    # 1. V1-V6
    # 2. V41-V46
    # 3. V81-V86
    # 4. V121-V126
    # 5. V161-V166
    # 6. V201-V202
    # 7. V214-V215
    # 8. V227-V228
    # 9. V240-V241
    # 10. V253-V254
    # 11. V266-V271
    # 12. V345-V350
    # 13. V424-V429
    # 14. v503-V504
    # 15. V516-V517
    # 16. V529-V530
    # 17. V542-V543
3. I have not considered meanfreq (v294-v296, v373-356, v452-454, V513, v526, v539, V552) or any of the angle measurements (V555-561) as a mean or standard deviation measurement as these are not noted as such in the features_info.txt file.   
4. As all of the measurements in (2) above contain the text mean() or std(), I have selected those     elements only from the dataset to and removed all the other elements from the method. The elements are extracted using the select dplyr function, so the dplyr library needs to be loaded for the script to work.
5. The merged dataset is passed to the function extractmeasurements which returns the extracted dataset.
6. The returned dataset from this method is then used as a basis for labelling the activies.

===================
## Labelling Activities:
The activities are labelled in the function labelactivities function. The function gets the labels from the ./UCI Har Dataset/activity_labels.txt file, using read.table. This activities data frame is merged with the main dataset, based on the id of the Activity. The new dataset is then used as the basis for labelling the descriptive variable names.

===================
## Labelling Descriptive Variable Names:

From the features_info.txt file, we can determine the following:
t = time
Body = Body
gravity = Gravity
acc = acceleration
f = Fast Fourier Transform
Gyro = gyroscope
Jerk = Jerk Signal
Mag = Magnitude of X,Y and Z signals
X = 3-Axial X Direction
Y = 3-Axial Y Direction
Z = 3-Axial Z Direction

So, on the basis the 1st column in features.txt file _tBodyAcc-mean()-X_ can be given a descriptive name of: _Time Of Body Acceleration Mean 3-Axial X Direction_

All the columns have been renamed based on this evaluation in the method labelentireset. The method creates a character array with all the new names and then applies the new names to the dataset passed to the method. It then returns this data set back to the main method.

===================
## Creating the Independent Data Set

The labelled dataset is passed to the createindependentset method. This method:

* groups the dataset by Activity Name and Subject Id
* summarises the mean on all columns except the grouped columns and Activity Id, which is removed from the dataset

The new independent tidy data dataset is returned to the main method.

===================
## Writing to file

Finally, the main method passes the new independent data set to the method writetidyset. This writes to a tidyset.txt file, making sure row.names = FALSE as per instructions. The method assumes the file is written to the working directory.