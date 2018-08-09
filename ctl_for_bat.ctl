load data
infile "file_for_bat.csv" badfile "" discardfile ""
append
into TABLE aa_bat_test
FIELDS TERMINATED BY ';' TRAILING NULLCOLS
(
id, 
name
)