library(reshape2)

filename <- "wear_set.zip"
if (!file.exists(filename)) {
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url, filename)
}
if (!file.exists("UCI HAR Dataset")) {
  unzip(filename)
}

Labels <- read.table("UCI HAR Dataset/activity_labels.txt")
Labels[,2] <- as.character(Labels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

Want <- grep(".*mean.*|.*std.*", features[,2])
featuresWanted <- features[Want,2]
featuresWanted <- gsub('-mean', 'Mean', featuresWanted)
featuresWanted <- gsub('-std', 'Std', featuresWanted)
featuresWanted <- gsub('-()', '', featuresWanted)

train <- read.table("UCI HAR Dataset/train/X_train.txt")[Want]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[Want]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", featuresWanted)

allData$activity <- factor(allData$activity, levels = Labels[,1], labels = Labels[,2])
allData$subject <- as.factor(allData$subject)

allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)