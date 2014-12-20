#Setting a working directory
setwd('M:/Download/data')
#Loading X_train, X_test data sets and a list of features
trainset<-read.table('X_train.txt', as.is=T)
testset<-read.table('X_test.txt', as.is=T)
featuresnames<-read.table('features.txt', as.is=T)
#Merging train and test data sets
mergedset<-merge(trainset,testset,all=T)
#Extracting the data with mean amd std measuremets
mean_std<-grep("-(mean|std)\\(\\)", featuresnames[, 2])
mergedset<-mergedset[ , mean_std]
#Labeling the data with descriptive variable names
names(mergedset) <- featuresnames[mean_std, 2]
#Loading and naming activities
labelstrain<-read.table('y_train.txt', as.is=T)
labeltest<-read.table ('y_test.txt', as.is=T)
alllabels<-rbind(labelstrain,labeltest)
activities<-read.table('activity_labels.txt', as.is=T)
alllabels[ ,1]<-activities[alllabels[ ,1],2]
names(alllabels)<-'activity'
#Loading and naming subject data
subjecttrain<-read.table('subject_train.txt', as.is=T)
subjecttest<-read.table('subject_test.txt', as.is=T)
subjectall<-rbind(subjecttrain,subjecttest)
names(subjectall)<-'subject'
#Combining final data set to conduct the last step
data<-cbind(mergedset,alllabels,subjectall)
#Computing average of each variable for each activity and each subject
library(plyr)
average<-ddply(data, c('activity', 'subject'),  function(x) colMeans(x[, 1:66]))
#Creating a text file with output tidy data set
write.table(average, "averages_data.txt", row.name=FALSE)
