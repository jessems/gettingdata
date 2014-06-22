Only `run_analysis.R` is used as a script file.

## First we load in all the files we can use

```{r}
X_train <- read.table("../UCI HAR Dataset/train/X_test.txt")
y_train <- read.table("../UCI HAR Dataset/train/y_train.txt")
X_test <- read.table("../UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("../UCI HAR Dataset/test/y_test.txt")
features <- read.table("../UCI HAR Dataset/features.txt")
subject_train <- read.table("../UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("../UCI HAR Dataset/test/subject_test.txt")
activity_labels <-read.table("../UCI HAR Dataset/activity_labels.txt")
```
## Then we combine the different text files into one giant dataframe

```{r}
subject <- rbind(subject_train,subject_test)

X_tot <- rbind(X_train,X_tot)
```

### Use the given feature names as our column headers
```{r}
colnames(X_tot) <- features[,2]
```

### Stick the training and testing labels together
```{r}
y_tot <- rbind(y_train,y_tot)
```

### Stick the labels and the measurements together
```{r}
tot <- cbind(y_tot,X_tot)
```

### Stick the measurement + labels together with the subjects
```{r}
df <- cbind(subject,tot)
```

## Now we tidify our file a bit by adding nicer labels
#### Use the given activity labels on our measurements
```{r}
df[,2] <- factor(df[,2],levels=1:6,labels=activity_labels[,2])
```

### Include nice labels for the first two columns as well
```{r}
colnames(df)[1] <- "Subject"
colnames(df)[2] <- "Label"
```

## Now we extract only mean and std measurements:
```{r]
df[,c("tBodyAcc-mean()-X","tBodyAcc-mean()-Y","tBodyAcc-mean()-Z","tBodyAcc-std()-X","tBodyAcc-std()-Y","tBodyAcc-std()-Z")]

df_tidy <- ddply(df, .(Subject,Label), colwise(mean))
```

## Write our new tidy data file to a file
```{r}
write.data(df_tidy,"tidy.txt")
```
