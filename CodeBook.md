Script for Reading/Cleansing and creating a Tidy data
=====================================================
Contents
--------
The folder contains 

		*README.md which explains about the different files used in this effort. 
		
		*run_analysis.R The script which would create tidy data
		
		*TidyData.csv The output from the file which is the tiday data

Pre-Requisite:
-------------
	1.Download the data from (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
	2.Store the Zip file in the working directory for R environment
	3.Unzip the files
	4.Execute the script in R 
	5.Output file will be generated in the working directory

Steps Involved in the script:
-----------------------------
	1.Load the training and test data set
	2.Merge the datasets
	3.Assign names to the measurements.
	4.Remove incorrect words, expand other names to be more descriptive
	5.Extract only meansurements on mean and standard deviation 
	6.Read the subject information from another data file and merge it with measurements
	7.Read the activity information from another data file and merge it with measurements
	8.Replace the activity with descriptive name
	9.Tidy data creation by using melt function to make each observation in a seperate row
	10. Create a tidy data with the average of each variable for each activity and each subject.
	11. Write the output in a CSV file and working directory

