get_obs_datetime<-function(d1){
  d1<-d1%>%
  mutate(start_datetime=start_time)# creates a new variable that will have both the date and the time the instrument started recording

year(d1$start_datetime)<-year(d1$start_date) # assigns the correct year
month(d1$start_datetime)<-month(d1$start_date)# assigns the correct month
day(d1$start_datetime)<-day(d1$start_date)#assigns the correct day

d1$measure_datetime<-d1$start_datetime+d1$seconds-1 # adds the seconds into the recording and subtracts 1- assuming the instruments takes a measurement when it starts recording.

d1<-d1 %>%
  pivot_longer(2:5,names_to="oyster",values_to="mm")# makes the dataset longer instead of each oyster being a column
return(d1)
}

org.data<-function(download_date=NA){
  # installs (if necessary) and loads required packages
  if(!require(tidyverse))install.packages("tidyverse");library(tidyverse)
  if(!require(lubridate))install.packages("lubridate");library(lubridate)
  if(!require(readxl))install.packages("readxl")
  
  # find the files to bring in
  fnames<-data.frame(file.name=list.files("odata",pattern=download_date))%>%
    separate(.,file.name,into=c("obj.name","ext"),sep=-5,remove=FALSE)%>%
    mutate(file.name=paste0("odata/",file.name))
  #import and reorganize the files
  for(i in 1:nrow(fnames)){
    assign(fnames[i,2],readxl::read_xlsx(fnames[i,1]))
    assign(fnames[i,2],get_obs_datetime(get(fnames[i,2])))
  }
  # create one data file per download date
  if(nrow(fnames)>=2) oys<-bind_rows(get(fnames[1,2]),get(fnames[2,2]))
  if(nrow(fnames)==1)oys<-get(fnames[1,1])
  #save as an rds file
  write_rds(oys,paste0("wdata/data_check_",download_date,".rds"))
}
