#script to organize valvometry data

#initiated by S.K. Archer March 10, 2021

source("scripts/01a_data_org_and check_functions.R")# this loads the functions
# I've written to automatically bring in the data, assign the date and time the
# measurement was taken, and concatenate datasets downloaded on the same day

# this first function takes the data as its output by the strainmeter and turns it into a useful format
# it should be run on each file you download from the strainmeter
# format.data(path="odata/LSU/F005.csv",
#             ch1="o4_1",ch2="o1_1",ch3="o2_1",ch4="o6_1",
#             outfile="odata/LSU_040721.rds")

format.data(path="odata/LSU/F006.csv",
            ch1="o4_1",ch2="o1_1",ch3="o2_1",ch4="o6_1",
            outfile="odata/LSU_041421.rds")

# format.data(path="odata/LUMCON/F007.csv",
#             ch1="o3_1",ch2="o5_1",ch3="o7_1",ch4="o8_1",
#             outfile="odata/LUMCON_040721.rds")

format.data(path="odata/LUMCON/F008.csv",
            ch1="o3_1",ch2="o5_1",ch3="o7_1",ch4="o8_1",
            outfile="odata/LUMCON_041421.rds")

# to run this function just put the download date
# that you want to process within the "" dates are in a mmddyy format so the
# data downloaded on March 10, 2021 is "031021" 
# you only need to run the function above once for each download date.


# org.data(download_date = "031021",file.type="xlsx")
# org.data(download_date = "031821",file.type="xlsx")
# org.data(download_date = "040721",file.type="rds")
# org.data(download_date = "041421",file.type="rds")


## now link with environmental data if available
# you only need to run the function below once for each download date.

env.data(oys.file="data_check_031021.rds",
         env.file="env_data_3_01_10_2021.xlsx",
         env.sheet="forR",
         out.file="oys_env_031021.rds")

# this will bring in the organized data
# for a different download date just change the bit at the end (i.e., the 031021)
oys.031021<-read_rds("wdata/oys_env_031021.rds")
oys.031821<-read_rds("wdata/data_check_031821.rds")



# This is where you can add oyster specific calibration information when we have it

#PLACEHOLDER


# "quick" data look - summarizing data by hour 
#- plots mean mm per hour only meaningful in a relative sense 
# mm value is the absolute value
quick.view(pattrn="data_check_*")

