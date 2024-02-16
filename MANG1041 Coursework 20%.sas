/* Import names.csv datafile */
proc import datafile='\Users\zaksu\OneDrive\Desktop\Y1 Semester 2\SAS Programming\Coursework 20%\names.csv'
	out=names
	dbms=CSV;
run;

/* Create a new data set "female_names" */
data female_names;
/* Set the input dataset to "Names"  */
	set Names;
/* Select names given to female babies */
	where gender = 'F';
/* Keep the variables "Name" and "Count" */
	keep name count;
run; 

/* Create a new variable called "Fraction" in the "female_names dataset */
data female_names;
	set female_names;
/* Make the variable equal to the count divided by the total number of female babies */
	fraction = count/180623104;
run;

/* Sort the dataset "female_names" by count in descending order */
proc sort data=female_names;
	by descending count;
run; 

/* print the first 35 observations from the sorted female_names dataset */
proc print data=female_names (obs=35);
run;

/* Create a new dataset "Male_names" */
data male_names;
/* Set the input dataset to "Names"  */
	set Names;
/* Select names given to male babies */
	Where gender = 'M';
/* Keep the variables "Name" and "Count" */
	keep name count;
run; 

/* Create a new variable called "Fraction" in the "Male_names dataset */
data male_names;
	set male_names;
/* Make the variable equal to the count divided by the total number of male babies */
	fraction = count/184775046;
run; 

/* Sort the dataset "male_names" by fraction in descending order */
proc sort data=male_names;
	by descending fraction;
run; 

/* Print the data where fraction is greater than 0.005 in the sorted male_names dataset */
proc print data=male_names;
	where fraction > 0.005;
run;


