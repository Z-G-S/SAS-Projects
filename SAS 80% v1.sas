/* Q1: Import amphibians.xlsx datafile */
proc import datafile='\Users\zaksu\OneDrive\Desktop\Y1 Semester 2\SAS Programming\Coursework 80%\amphibians.xlsx'
	out=amphibians
	dbms=xlsx;
run;

/* Q2: Compute the summary statistics for each species and output the results to "Sites_species_observed" 
removing decimals and labels, and dropping _TYPE_ and _FREQ_ */
proc means data=amphibians sum maxdec=0 NOLABELS;
	var Green_frogs Brown_frogs Common_toad Fire_bellied_toad Tree_frog Common_newt Great_crested_newt;
	output out=Sites_species_observed (DROP= _TYPE_ _FREQ_)
	sum=/autoname;
	title "Number Of Sites Where Species Were Observed";
run;
/* Q3,Q4: Brown_frogs was observed the most often at 148 sites and Great_crested_newt was observed least often at 21 sites */

/* Q5: Create a new variable "species" that is the sum of the seven amphibian variables showing
the total number of different species observed at the site */
data amphibians;
	set amphibians;
	species = sum(Green_frogs, Brown_frogs, Common_toad, Fire_bellied_toad, Tree_frog, Common_newt, Great_crested_newt);
run;

/* Q6: Proc freq used to produce the frequencies of all values of the variable "species" by 
motorway */
proc freq data=amphibians;
	by Motorway;
	tables species;
	title "Frequencies Of All Values Of The Variable Species By Motorway";
run;
/* Q7,Q8: The largest number of different species observed at any A1 site is 6 and the largest number of different species observed
at any S52 site is 7 */

/* Q9: Create a new binary variable "rich_site" based on the value of the "species" variable that
takes the value of 1 if the value of "species" is greater than 3 and takes the value of
0 if the value of "species" is less than 3, indicating which sites are rich in amphibians */
data amphibians;
	set amphibians;
	if species > 3 then rich_site = 1;
	else if species <= 3 then rich_site = 0;
run;

/* Q10: Proc freq used to produce the frequency of the values of the variable "rich_sites" */
proc freq data = amphibians;
	TABLE rich_site;
	title "Frequency Of All Values Of The Variable rich_site";
run;
/* Q11: 70 sites are rich in amphibians */

/* Q12: Proc corr used to calculate the correlation between "SR" and "NR" variables */
proc corr data=amphibians;
	var SR NR;
	title "Correlation Between SR And NR Variables";
run;
/* Q13: Correlation is positive with value of 0.65276, indicating that variables SR and NR are moderately correlated */

/* Q14: Proc logistic used to develop a logistic regression model predicting the dependent variable 
"rich_site" based on the independent variables; "SR", "NR", "FR" and "RR" */
proc logistic data=amphibians descending;
	model rich_site = SR NR FR RR;
	title "Logistic Regression Model";
run;
/* Q15: The c statistic value is 0.661 which indicates that the model separates the sites which are rich in amphibians poorly
and is a weak classifier due to the low value */

/* Q16: Create a PDF report of the sites with at least 6 different species observed, including the 
variables; ID, Motorway and species whilst suppressing the observation number column and using
Ocean style */
ods pdf file="C:\Users\zaksu\OneDrive\Desktop\Y1 Semester 2\SAS Programming\richest_in_amphibians.pdf" style=ocean;
proc print data=amphibians noobs;
	var ID Motorway species;
	where species>=6;
	title 'Sites Richest in Amphibians';
run;
ods pdf close;










