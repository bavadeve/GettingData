## README-file
Bauke van der Velde

Included following files:
- 'README.md'
- 'firstDataSet.txt': Cleaned dataset with only the mean and std variables for each subject performing each activity
- 'secondDataSet.txt': Cleaned dataset, averaged over activity seperated by subject
- 'run_analysis.R': Analysis script which cleans the samsung data and outputs the two aforementioned datasets
- 'codeBook.md': explanation of analysis script and variables in the two ouput files

The 'run_analysis.R' gives the following output
- 2 variables in the workspace:
	- firstDataSet: dataframe of all the data for only the mean and std variables, together
	with subjects, activity and session columns
	- secondDataSet: dataframe with the aforementioned data averaged over activity per subject
	
- 2 saved .txt-files
	- firstDataSet.txt
	- secondDataSet.txt

For the exact workings of the *run_analysis.R* script, please refer to _codebook.md_

TEST