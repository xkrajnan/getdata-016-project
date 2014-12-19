getdata-016-project
===================

Solution to the getdata-016 project.

The input data can be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and are expected to be unzipped in the "data" folder relative to the preprocessing script.

The preprocessing phase
-----------------------
script name: "run_analysis.R"

preprocessing steps:

1. the training and testing data are read and merged

2. a meaningful data labels are read from the provided files ("features.txt", "activity_labels.txt") and assigned to the created table

3. features are subset to those relevant to the tasl (these are those containing "mean" or "std" in their names)

4. "tidy_data" data set is created by summarizing all the columns by the "mean" function over the (subject, activity) key pairs

5. the tidy data set is output as a TXT file called "tidy_data.txt"

