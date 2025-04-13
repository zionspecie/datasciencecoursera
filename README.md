---
title: "README"
author: "Me!"
date: "2025-04-13"
output: html_document
---
# Getting and Cleaning Data - Course Project

This project processes the UCI Human Activity Recognition dataset into a tidy dataset that summarizes the average of each variable for each activity and each subject.

## Files

- `run_analysis.R`: The R script that does the data cleaning.
- `tidy_dataset.txt`: The output tidy dataset with the average of each variable by activity and subject.
- `CodeBook.md`: A description of all variables and transformations used in the dataset.

## How the script works

The `run_analysis.R` script:
1. Downloads and unzips the dataset using the download.file() and unzip() functions
2. Reads and merges the X and y training and test datasets, and the subject data for both. I used read.table() to read the tables and rbind() to merge them.
3. Extracts only the measurements on the mean and standard deviation, using regular expressions that finds any column that has mean() or std() in it.
4. Uses descriptive activity names to name the activities in the data set.
5. Appropriately labels the data set with descriptive variable names.
6. Creates a second, independent tidy data set with the average of each variable for each activity and subject.

