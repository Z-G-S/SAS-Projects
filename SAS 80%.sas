proc import datafile='\Users\zaksu\OneDrive\Desktop\Y1 Semester 2\SAS Programming\Coursework 80%\amphibians.xlsx'
	out=amphibians
	dbms=xlsx;
run;

proc means data=amphibians sum maxdec=0 NOLABELS;
	var Green_frogs Brown_frogs Common_toad Fire_bellied_toad Tree_frog Common_newt Great_crested_newt;
	output out=Sites_species_observed (DROP= _TYPE_ _FREQ_)
	sum=/autoname;
	title "Number of Sites Where Species Were Observed";
run;

proc sql;
	select max(Green_frogs Brown_frogs Common_toad Fire_bellied_toad Tree_frog Common_newt Great_crested_newt)
	from sites_species_observed;
quit;











