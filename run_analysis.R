X_train <- read.table("UCI HAR Dataset/train/X_test.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
features <- read.table("UCI HAR Dataset/features.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
activity_labels <-read.table("UCI HAR Dataset/activity_labels.txt")

subject <- rbind(subject_train,subject_test)

X_tot <- rbind(X_train,X_tot)

## Use the given feature names as our column headers
colnames(X_tot) <- features[,2]

## Stick the training and testing labels together
y_tot <- rbind(y_train,y_tot)

## Stick the labels and the measurements together
tot <- cbind(y_tot,X_tot)

## Stick the measurement + labels together with the subjects
df <- cbind(subject,tot)

## Use the given activity labels on our measurements
df[,2] <- factor(df[,2],levels=1:6,labels=activity_labels[,2])

## Include nice labels for the first two columns as well
colnames(df)[1] <- "Subject"
colnames(df)[2] <- "Label"

## Only mean and std measurements:
df[,c("tBodyAcc-mean()-X","tBodyAcc-mean()-Y","tBodyAcc-mean()-Z","tBodyAcc-std()-X","tBodyAcc-std()-Y","tBodyAcc-std()-Z")]

df_tidy <- ddply(df, .(Subject,Label), colwise(mean))

## Write our new tidy data file to a file
write.data(df_tidy,"tidy.txt")
