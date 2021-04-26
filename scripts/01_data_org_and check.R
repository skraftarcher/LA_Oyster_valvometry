#script to organize valvometry data

#initiated by S.K. Archer March 10, 2021

source("scripts/01a_data_org_and check_functions.R")# this loads the functions
# I've written to automatically bring in the data, assign the date and time the
# measurement was taken, and concatenate datasets downloaded on the same day

# this first function takes the data as its output by the strainmeter and turns it into a useful format
# it should be run on each file you download from the strainmeter
# format.data(path="odata/LSU/F001.csv",
#             ch1="o4_1",ch2="o1_1",ch3="o2_1",ch4="o6_1",
#             outfile="odata/LSU_031021.rds")
# 
# format.data(path="odata/LSU/F004.csv",
#             ch1="o4_1",ch2="o1_1",ch3="o2_1",ch4="o6_1",
#             outfile="odata/LSU_031821.rds")

# format.data(path="odata/LSU/F005.csv",
#             ch1="o4_1",ch2="o1_1",ch3="o2_1",ch4="o6_1",
#             outfile="odata/LSU_040721.rds")

# format.data(path="odata/LSU/F006.csv",
#             ch1="o4_1",ch2="o1_1",ch3="o2_1",ch4="o6_1",
#             outfile="odata/LSU_041421.rds")

# format.data(path="odata/LSU/F007.csv",
#             ch1="o4_1",ch2="o1_1",ch3="o2_1",ch4="o6_1",
#             outfile="odata/LSU_a_042121.rds")
# 
# format.data(path="odata/LSU/F008.csv",
#             ch1="o4_1",ch2="o1_1",ch3="o2_1",ch4="o6_1",
#             outfile="odata/LSU_b_042121.rds")
# 
# format.data(path="odata/LSU/F009.csv",
#             ch1="o4_1",ch2="o1_1",ch3="o2_1",ch4="o6_1",
#             outfile="odata/LSU_c_042121.rds")


# format.data(path="odata/LUMCON/F005.csv",
#             ch1="o3_1",ch2="o5_1",ch3="o7_1",ch4="o8_1",
#             outfile="odata/LUMCON_031021.rds")
# 
# format.data(path="odata/LUMCON/F005.csv",
#             ch1="o3_1",ch2="o5_1",ch3="o7_1",ch4="o8_1",
#             outfile="odata/LUMCON_031821.rds")

# format.data(path="odata/LUMCON/F007.csv",
#             ch1="o3_1",ch2="o5_1",ch3="o7_1",ch4="o8_1",
#             outfile="odata/LUMCON_040721.rds")

# format.data(path="odata/LUMCON/F008.csv",
#             ch1="o3_1",ch2="o5_1",ch3="o7_1",ch4="o8_1",
#             outfile="odata/LUMCON_041421.rds")
# 
# format.data(path="odata/LUMCON/F009.csv",
#             ch1="o3_1",ch2="o5_1",ch3="o7_1",ch4="o8_1",
#             outfile="odata/LUMCON_a_042121.rds")
# 
# format.data(path="odata/LUMCON/F010.csv",
#             ch1="o3_1",ch2="o5_1",ch3="o7_1",ch4="o8_1",
#             outfile="odata/LUMCON_b_042121.rds")
# 
# format.data(path="odata/LUMCON/F011.csv",
#             ch1="o3_1",ch2="o5_1",ch3="o7_1",ch4="o8_1",
#             outfile="odata/LUMCON_c_042121.rds")
# 
# # to run this function just put the download date
# that you want to process within the "" dates are in a mmddyy format so the
# data downloaded on March 10, 2021 is "031021" 
# you only need to run the function above once for each download date.


# org.data(download_date = "031021",file.type="rds",sdate = "2021-03-03")
# org.data(download_date = "031821",file.type="rds",sdate = "2021-03-11")
# org.data(download_date = "040721",file.type="rds",sdate = "2021-03-19")
# org.data(download_date = "041421",file.type="rds",sdate = "2021-04-08")
# org.data(download_date = "042121",file.type="rds",sdate = "2021-04-15")

#if boat detections processed run this code

boat.detections(dataset = "boatnoise_pumphouse.csv",
                env.file="MC_3-3-21_4-23-21.xlsx",
                env.sheet="forR",
                outfile="boat_detections_030221_042121.rds")

## now link with environmental data if available
# you only need to run the function below once for each download date.


env.data(oys.file="data_check_031021.rds",
         env.file="MC_3-3-21_4-23-21.xlsx",
         env.sheet="forR",
         out.file="oys_env_031021.rds")

env.data(oys.file="data_check_031821.rds",
         env.file="MC_3-3-21_4-23-21.xlsx",
         env.sheet="forR",
         out.file="oys_env_031821.rds")

env.data(oys.file="data_check_040721.rds",
         env.file="MC_3-3-21_4-23-21.xlsx",
         env.sheet="forR",
         out.file="oys_env_040721.rds")

env.data(oys.file="data_check_041421.rds",
         env.file="MC_3-3-21_4-23-21.xlsx",
         env.sheet="forR",
         out.file="oys_env_041421.rds")

env.data(oys.file="data_check_042121.rds",
         env.file="MC_3-3-21_4-23-21.xlsx",
         env.sheet="forR",
         out.file="oys_env_042121.rds")

 

# This is where you can add oyster specific calibration information when we have it

#PLACEHOLDER


# "quick" data look - summarizing data by hour 
#- plots mean mm per hour only meaningful in a relative sense 
# mm value is the absolute value
quick.view(pattrn="data_check_*")


# this will combine all data into a single dataset


combine.dsets(outfile = "all_data_042121.rds")
