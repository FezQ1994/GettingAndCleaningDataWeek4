# GettingAndCleaningDataWeek4
Repo for the peer-graded assignment for Getting and Cleaning Data on Coursera
The code, run_analysis.R, uses the wearable computing data from a Samsung device and the R package, "reshape2", to
  1. Download data from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
     if it does not exist already
  2. Load the activity and feature info
  3. Load both the training and test datasets, keeping only those columns which reflect a mean or standard deviation
  4. Load the activity and subject data for each dataset, and merges those columns with the dataset
  5. Merge the two datasets
  6. Convert the subject and activity into factors and
  7. Create a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair

The final result is saved as "tidy.txt"
