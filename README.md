Data Processing Instruction
========================================================

This is an R Markdown document illustrates the instruction of how to reproduce the data processing work.

**Step 1. File preparation**    
Download raw data file from the following link:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
Unzip the zip file into your working directory.  
(Since the assignment instruction doesn't mention about the operations above to be done in R script, please execute them manually.)  

Use the following script to define the path and names of all the data text files that should be imported into a list named "filelist".  
(Since the assignment instruction doesn't mention about whether all of the text files in the zip file should be imported, the script here includes files in "Inertial Signals" folder.)

```{r}
filedir <- c("UCI HAR Dataset/", "Inertial Signals/")
infofiles <- c("activity_labels", "features")
files <- c("subject", "X", "y", "body_acc_x", "body_acc_y", "body_acc_z", 
           "body_gyro_x", "body_gyro_y", "body_gyro_z", "total_acc_x", 
           "total_acc_y", "total_acc_z")
filelist <- list(paste(filedir[1], infofiles, ".txt", sep=""))
for (i in c("test", "train")){
        tmp1 <- paste(filedir[1], i, "/", files[1:3], "_", i, ".txt", sep="")
        tmp2 <- paste(filedir[1], i, "/", filedir[2], files[4:length(files)], 
                      "_", i, ".txt", sep="")
        filelist <- c(filelist, list(c(tmp1, tmp2)))
}
```
You can print the filelist to see the result:
```{r}
filelist

> filelist
[[1]]
[1] "UCI HAR Dataset/activity_labels.txt" "UCI HAR Dataset/features.txt"       

[[2]]
 [1] "UCI HAR Dataset/test/subject_test.txt"                     
 [2] "UCI HAR Dataset/test/X_test.txt"                           
 [3] "UCI HAR Dataset/test/y_test.txt"                           
 [4] "UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt" 
 [5] "UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt" 
 [6] "UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt" 
 [7] "UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt"
 [8] "UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt"
 [9] "UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt"
[10] "UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt"
[11] "UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt"
[12] "UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt"

[[3]]
 [1] "UCI HAR Dataset/train/subject_train.txt"                     
 [2] "UCI HAR Dataset/train/X_train.txt"                           
 [3] "UCI HAR Dataset/train/y_train.txt"                           
 [4] "UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt" 
 [5] "UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt" 
 [6] "UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt" 
 [7] "UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt"
 [8] "UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt"
 [9] "UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt"
[10] "UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt"
[11] "UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt"
[12] "UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt"
```

**Step 2. Import data files and define variable names**  
Use the following script to import files defined in "filelist" into a new list "datalist" whose struture is corresponding to "filelist".  
Rename the variable names in each data frame in "datalist".

```{r}
datalist <- lapply(filelist, function(x) 
        lapply(x, function(y) read.table(y, stringsAsFactors=F))
        )
names(datalist[[1]]) <- infofiles
names(datalist[[1]][[1]]) <- c("actId", "actLabel")
names(datalist[[1]][[2]]) <- c("ftId", "ftName")
for (i in 2:3){
        names(datalist[[i]]) <- files
        names(datalist[[i]]$subject) <- c("subject")
        names(datalist[[i]]$X) <- datalist[[1]]$features$ftName
        names(datalist[[i]]$y) <- c("actId")
        for(j in 4:length(datalist[[i]])) 
                names(datalist[[i]][[j]]) <- 
                paste(names(datalist[[i]][j]), 
                      names(datalist[[i]][[j]]), sep="")
}
```

!!! Be cautious that "datalist" is too large to use general summarize functions to view its content !!!   

**Step 3. Combine data sets**  
Use the following script to combine data sets into one data set.   
Merge "activity_labels" to get the activity names.

```{r}
## combine "test" data sets
tmp1 <- data.frame(type=rep("test", times=nrow(datalist[[2]][[1]])))
tmp <- lapply(datalist[[2]], function(x) tmp1 <<- cbind(tmp1, x))

## combine "train" data sets
tmp2 <- data.frame(type=rep("train", times=nrow(datalist[[3]][[1]])))
tmp <- lapply(datalist[[3]], function(x) tmp2 <<- cbind(tmp2, x))

## combine all data sets into one data set and name the activities
tidydata1 <- rbind(tmp1, tmp2)
tidydata1 <- merge(tidydata1, datalist[[1]]$activity_labels, by="actId")
```

**Step 4. Extract and rename variables**  
Use the following script to extract the measurements on the mean and sd for each measurement as the assignment instruction requests.  
Rename the variables to make them more readable and understandable. (No underscore, no Cap, no dots, etc..)

```{r}
## extract the measurements on the mean and sd for each measurement
extColNames <- names(tidydata1)[grep("mean\\(|std\\(", names(tidydata1))]
tidydata2 <- tidydata1[, c("actLabel", "subject", extColNames)]

## rename variables
names(tidydata2)[1] <- "activitylabel"
tmp <- names(tidydata2)[3:ncol(tidydata2)]
tmp <- gsub("-|\\(\\)", "", tmp)
tmp <- tolower(tmp)
names(tidydata2)[3:ncol(tidydata2)] <- tmp
```

**Step 5. Create tidy data set**  
Use the following script to create an independent tidy data set with the average of each variable for each activity and each subject as the assignment instruction requests.  
Round the numeric variables to make it more readable. 
Order the data set by activity and subject to make it more structured.
Output the final tidy data set into a text file with columns seperated by "tab".

```{r}
tidydata3 <- aggregate(. ~ activitylabel + subject, data = tidydata2, mean)
tidydata3[, 3:ncol(tidydata3)] <- round(tidydata3[, 3:ncol(tidydata3)], 4)
tidydata3 <- tidydata3[order(tidydata3$activitylabel, tidydata3$subject), ]
write.table(tidydata3, file="tidydata.txt", quote=F, sep="\t", row.names=F)
```

With the tidy data set file, it would be better to open it in excel to check so that it will keep its format. 