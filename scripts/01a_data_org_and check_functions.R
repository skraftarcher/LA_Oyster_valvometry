get_obs_datetime<-function(d1){d1<-d1%>%
  mutate(start_datetime=start_time)

year(d1$start_datetime)<-year(d1$start_date)
month(d1$start_datetime)<-month(d1$start_date)
day(d1$start_datetime)<-day(d1$start_date)

d1$measure_datetime<-d1$start_datetime+d1$seconds-1

d1<-d1 %>%
  pivot_longer(2:5,names_to="oyster",values_to="mm")
return(d1)
}

org.data<-function(download_date=NA){
  if(!require(tidyverse))install.packages("tidyverse");library(tidyverse)
  if(!require(lubridate))install.packages("lubridate");library(lubridate)
  if(!require(readxl))install.packages("readxl")
  
  fnames<-data.frame(file.name=list.files("odata",pattern=download_date))%>%
    separate(.,file.name,into=c("obj.name","ext"),sep=-5,remove=FALSE)%>%
    mutate(file.name=paste0("odata/",file.name))
  for(i in 1:nrow(fnames)){
    assign(fnames[i,2],readxl::read_xlsx(fnames[i,1]))
    assign(fnames[i,2],get_obs_datetime(get(fnames[i,2])))
  }

  if(nrow(fnames)>=2) oys<-bind_rows(get(fnames[1,2]),get(fnames[2,2]))
  if(nrow(fnames)==1)oys<-get(fnames[1,1])
  write_rds(oys,paste0("wdata/data_check_",download_date,".rds"))
}
