library(openintro)
library(dplyr)


#----------------------------------------------------------------------------------------------------#
#                                       SAMPLING IN R
#                                 SRS and STRATIFIED SAMPLE
#----------------------------------------------------------------------------------------------------#

data(county)

# removing columbia district

county_noDC <- county %>% 
  filter(state != "District of Columbia")

rm(county)

# Simple Random Sample of 200 counties

county_srs <- county_noDC %>% 
  sample_n(size = 200)

# state distribution

county_srs %>% 
  group_by(state) %>% 
  count()

# to get equal distribution about all states we should use Stratified sample

county_str <- county_noDC %>% 
  group_by(state) %>% 
  sample_n(size = 3)
