## define the names of txt files 
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

## import txt files into R data sets and define variable names
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

## combine "test" data sets
tmp1 <- data.frame(type=rep("test", times=nrow(datalist[[2]][[1]])))
tmp <- lapply(datalist[[2]], function(x) tmp1 <<- cbind(tmp1, x))

## combine "train" data sets
tmp2 <- data.frame(type=rep("train", times=nrow(datalist[[3]][[1]])))
tmp <- lapply(datalist[[3]], function(x) tmp2 <<- cbind(tmp2, x))

## combine all data sets into one data set and name the activities
tidydata1 <- rbind(tmp1, tmp2)
tidydata1 <- merge(tidydata1, datalist[[1]]$activity_labels, by="actId")

## extract the measurements on the mean and sd for each measurement
extColNames <- names(tidydata1)[grep("mean\\(|std\\(", names(tidydata1))]
tidydata2 <- tidydata1[, c("actLabel", "subject", extColNames)]

## rename variables
names(tidydata2)[1] <- "activitylabel"
tmp <- names(tidydata2)[3:ncol(tidydata2)]
tmp <- gsub("-|\\(\\)", "", tmp)
tmp <- tolower(tmp)
names(tidydata2)[3:ncol(tidydata2)] <- tmp

## Creates a second, independent tidy data set with the average of each variable
## for each activity and each subject
tidydata3 <- aggregate(. ~ activitylabel + subject, data = tidydata2, mean)
tidydata3[, 3:ncol(tidydata3)] <- round(tidydata3[, 3:ncol(tidydata3)], 4)
tidydata3 <- tidydata3[order(tidydata3$activitylabel, tidydata3$subject), ]
write.table(tidydata3, file="tidydata.txt", quote=F, sep="\t", row.names=F)