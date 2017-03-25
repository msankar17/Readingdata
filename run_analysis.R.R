#The script will perform the following activities

#### Merges the training and the test sets to create one data set
#### Extracts only the measurements on the mean and standard deviation for each measurement. 
#### Uses descriptive activity names to name the activities in the data set
#### Appropriately labels the data set with descriptive variable names. 
#### Create an independent tidy data set with the average of each variable for each activity and each subject


#Load the training dataset
data1=read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")

#Load the training dataset
data2=read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")

#Activity 1  --> Merges the data sets data1 and data2
data3=rbind(data1,data2)

#Assign names to the measurements 
name=read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")

#Activity 4 - Appropriately labels the data set with descriptive variable names
#Remove incorrect names from the data
#Expand the names to make them more descriptive
#Change the names in such a way that we can split the column names
names(data3)=gsub("\\(\\)","",name[,2])
names(data3)=gsub("BodyBody","Body",names(data3))
names(data3)=gsub("Acc","Accelerometer",names(data3))
names(data3)=gsub("Gyro","Gyroscope",names(data3))
names(data3)=gsub("Mag","Magnittude",names(data3))
names(data3)=gsub("^[^t|^f]ngle","Angle-",names(data3))
names(data3)[grep("^Angle",names(data3))]=paste(names(data3)[grep("^Angle",names(data3))],"-Angle",sep="")
names(data3)=gsub("^t","Time-",names(data3))
names(data3)=gsub("^f","Fastfourier-",names(data3))

# Activity 2 --> Extracts only the measurements on the mean and standard deviation for each measurement.
data4=data3[,grep("mean|std",name[,2])]

#Read the subject information for both Train/Test data
sub1=read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
sub2=read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
sub3=rbind(sub1,sub2)
names(sub3)="Subject"

#Read the activity information for both test and train data
act1=read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
act2=read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")

act3=rbind(act1,act2)
names(act3)="Activity"

# Activity 3--> Uses descriptive activity names to name the activities in the data set
actname=read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
names(actname)=c("activity","Activitydesc")

#Join to get the activity description  
act3=merge(act3,actname,by.x="Activity",by.y = "activity")

#Merge the measurements with Subject & Activity information
data5=cbind(data3,sub3,Activity=act3$Activitydesc)

#Tidying data, melting the observations into rows
dd=melt(data5,id=c("Subject","Activity"),measure.vars = c(1:561))
dd1=dd %>% separate(variable,c("Domain","Type","Function","Dimension"),sep="-")

#Activity5-creates a second, independent tidy data set with the average of each variable for each activity and each subject.
data6=aggregate(dd1$value,by=list(Subject=dd1$Subject,Activity=dd1$Activity,variable=dd1$Function),mean)
arrange(data6,Subject,Activity)

#Write the output in a CSV file
write.table(data6,file="Tidydata.txt",row.names = FALSE)