#----------------------------------------------------------------------------------------------------#
#                                  IMPORTING MULTIPLES CSVS FILES INTO R
#----------------------------------------------------------------------------------------------------#

# reading all files from a path

my_files <- list.files("/Users/danielmurta/documents/Notas fiscais looqbox/notas_lqb") 

# setting the path to working directory

setwd("/Users/danielmurta/documents/Notas fiscais looqbox/notas_lqb")

# applying read.csv function to all files

all_csv <- lapply(my_files, read.csv, sep = ";")
