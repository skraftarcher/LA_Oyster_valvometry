#script to organize valvometry data
# load packages

#initiated by S.K. Archer March 10, 2021

source("scripts/01a_data_org_and check_functions.R")# this loads the functions
# I've written to automatically bring in the data, assign the date and time the
# measurement was taken, and concatenate datasets downloaded on the same day

org.data(download_date = "031021")# to run this function just put the download date
# that you want to process within the "" dates are in a mmddyy format so the
# data downloaded on March 10, 2021 is "031021" 
# you only need to run the function above once for each download date.

# this will bring in the organized data
# for a different download date just change the bit at the end (i.e., the 031021)
oys.031021<-read_rds("wdata/data_check_031021.rds")

# This is where you can add oyster specific calibration information when we have it

#PLACEHOLDER


# Look at time series to make sure things are looking good.

ggplot(oys.031021)+
  geom_line(aes(x=measure_datetime,y=mm,group=oyster))+
  facet_wrap(~oyster,scales="free")

ggsave("figures/data_check_031021.jpg")
