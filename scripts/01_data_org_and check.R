#script to organize valvometry data
# load packages

#initiated by S.K. Archer March 10, 2021

source("scripts/01a_data_org_and check_functions.R")

org.data(download_date = "031021")

oys.031021<-read_rds("wdata/data_check_031021.rds")
# This is where you can add oyster specific calibration information when we have it

#PLACEHOLDER

# Look at time series

ggplot(oys.031021)+
  geom_line(aes(x=measure_datetime,y=mm,group=oyster))+
  facet_wrap(~oyster,scales="free")

ggsave("figures/data_check_031021.jpg")
