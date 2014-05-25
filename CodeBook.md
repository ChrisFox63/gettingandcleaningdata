Tidy Data Cookbook
========================================================

This is an R Markdown document for illustrating the variables in the data set.

Each row identifies the average of each measurement variable for each subject 
who performed in each activity. 

* **activitylabel**: (character) indicates activity name, including:
  * LAYING
  * SITTING
  * STANDING
  * WALKING
  * WALKING_DOWNSTAIRS
  * WALKING_UPSTAIRS
* **subject**: (int)  indicates subject number, ranging from 1 to 30.

The value of following variables are all ranging from -1 to 1.
Variable name is structured in this format: 
  * _"domain signals"_,  't' denote time, indicates result of time domain signals; 'f' denote frequency, indicates result of frequency domain signals
  * _"be seperated into body or gravity"_
  * _"from accelerometer or gyroscope"_,  'acc' denote accelerometer and 'gyro' denote gyroscope
  * _"jerk"_,  optional, if exists indicates that the signals were derived in time to obtain Jerk signals
  * _"mag"_,  optional, if exists indicates that the magnitude of three-dimensional signals were calculated using the Euclidean norm
  * _"calculated by mean value or standard deviation"_,  'mean' denote mean value and 'std' denote standard deviation
  * _"signal direction(x/y/z)"_,  optional, be complementary with "mag"  
  eg: tgravityaccmagmean -> "t" + "gravity" + "acc" + "mag" + "mean"
  
=========================
* **tbodyaccmeanx**: (numeric)
* **tbodyaccmeany**: (numeric)
* **tbodyaccmeanz**: (numeric)
* **tbodyaccstdx**: (numeric)
* **tbodyaccstdy**: (numeric)
* **tbodyaccstdz**: (numeric)
* **tgravityaccmeanx**: (numeric)
* **tgravityaccmeany**: (numeric)
* **tgravityaccmeanz**: (numeric)
* **tgravityaccstdx**: (numeric)
* **tgravityaccstdy**: (numeric)
* **tgravityaccstdz**: (numeric)
* **tbodyaccjerkmeanx**: (numeric)
* **tbodyaccjerkmeany**: (numeric)
* **tbodyaccjerkmeanz**: (numeric)
* **tbodyaccjerkstdx**: (numeric)
* **tbodyaccjerkstdy**: (numeric)
* **tbodyaccjerkstdz**: (numeric)
* **tbodygyromeanx**: (numeric)
* **tbodygyromeany**: (numeric)
* **tbodygyromeanz**: (numeric)
* **tbodygyrostdx**: (numeric)
* **tbodygyrostdy**: (numeric)
* **tbodygyrostdz**: (numeric)
* **tbodygyrojerkmeanx**: (numeric)
* **tbodygyrojerkmeany**: (numeric)
* **tbodygyrojerkmeanz**: (numeric)
* **tbodygyrojerkstdx**: (numeric)
* **tbodygyrojerkstdy**: (numeric)
* **tbodygyrojerkstdz**: (numeric)
* **tbodyaccmagmean**: (numeric)
* **tbodyaccmagstd**: (numeric)
* **tgravityaccmagmean**: (numeric)
* **tgravityaccmagstd**: (numeric)
* **tbodyaccjerkmagmean**: (numeric)
* **tbodyaccjerkmagstd**: (numeric)
* **tbodygyromagmean**: (numeric)
* **tbodygyromagstd**: (numeric)
* **tbodygyrojerkmagmean**: (numeric)
* **tbodygyrojerkmagstd**: (numeric)
* **fbodyaccmeanx**: (numeric)
* **fbodyaccmeany**: (numeric)
* **fbodyaccmeanz**: (numeric)
* **fbodyaccstdx**: (numeric)
* **fbodyaccstdy**: (numeric)
* **fbodyaccstdz**: (numeric)
* **fbodyaccjerkmeanx**: (numeric)
* **fbodyaccjerkmeany**: (numeric)
* **fbodyaccjerkmeanz**: (numeric)
* **fbodyaccjerkstdx**: (numeric)
* **fbodyaccjerkstdy**: (numeric)
* **fbodyaccjerkstdz**: (numeric)
* **fbodygyromeanx**: (numeric)
* **fbodygyromeany**: (numeric)
* **fbodygyromeanz**: (numeric)
* **fbodygyrostdx**: (numeric)
* **fbodygyrostdy**: (numeric)
* **fbodygyrostdz**: (numeric)
* **fbodyaccmagmean**: (numeric)
* **fbodyaccmagstd**: (numeric)
* **fbodybodyaccjerkmagmean**: (numeric)
* **fbodybodyaccjerkmagstd**: (numeric)
* **fbodybodygyromagmean**: (numeric)
* **fbodybodygyromagstd**: (numeric)
* **fbodybodygyrojerkmagmean**: (numeric)
* **fbodybodygyrojerkmagstd**: (numeric)