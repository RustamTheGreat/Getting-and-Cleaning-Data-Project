---
title: "CodeBook"
output: html_document
---

# Introduction
The script `run_analysis.R` performs the 5 steps described in the course project's definition.

* First, all the similar data is merged using the `rbind()` function. By similar, we address those files having the same number of columns and referring to the same entities.
* Then, only those columns with the mean and standard deviation measures are taken from the whole dataset. After extracting these columns, they are given the correct names, taken from `features.txt`.
* As activity data is addressed with values 1:6, we take the activity names and IDs from `activity_labels.txt` and they are substituted in the dataset.
* On the whole dataset, those columns with vague column names are corrected.
* Finally, we generate a new dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows). The output file is called `tidy_data.txt`, and uploaded to this repository.

# Variables

* `X`, `y`, `subject` contain the merged data from the downloaded files.
* `features$V2` contains the correct and clean names for the `X` dataset.
* `data` merges needed `X` columns, `y` and `subject` in a big dataset.
* Finally, `data_result` contains the relevant averages which will be later stored in a `.txt` file.
* `subject_id` - Identification of the volunteers in the dataset. Valid values: 1 to 30.
* `activity` - Name of activity performed by volunteers. Valid values: walking, walking_upstairs, walking_downstairs, sitting, standing, laying.