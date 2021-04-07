format.data<-function(path,ch1,ch2,ch3,ch4,outfile){
  library(tidyverse)
  library(lubridate)
  t1<-read.csv(path,skip=16)
  sdt<-read.csv(path,skip=4,nrows=2,header=F)
  colnames(t1)<-c("seconds",ch1,ch2,ch3,ch4)
  t1<-t1%>%
    mutate(start_datetime=mdy_hms(paste(sdt[1,2],sdt[2,2])),
           measure_datetime=start_datetime+seconds-1)%>%
    pivot_longer(2:5,names_to="oyster",values_to="mm")
  #save as an rds file
  write_rds(t1,outfile)
}

org.data<-function(download_date=NA,file.type=NA){
  library(readxl)
  library(tidyverse)
  t1<-data.frame(file=list.files("odata",pattern=download_date))
  for(i in 1:nrow(t1)){
    if(file.type=="xlsx")assign(paste0("t",1+i),read_excel(paste0("odata/",t1$file[i])))
    if(file.type=="rds")assign(paste0("t",1+i),read_rds(paste0("odata/",t1$file[i])))
    if(i==1)d1<-t2
    if(i!=1)d1<-bind_rows(t2,get(paste0("t",1+i)))
  }
  write_rds(d1,paste0("wdata/data_check_",download_date,".rds"))
}
# link with environmental data

env.data<-function(oys.file,env.file,env.sheet,out.file){
  # installs (if necessary) and loads required packages
  if(!require(tidyverse))install.packages("tidyverse");library(tidyverse)
  if(!require(lubridate))install.packages("lubridate");library(lubridate)
  if(!require(readxl))install.packages("readxl")
  od<-read_rds(paste0("wdata/",oys.file))
  ed<-readxl::read_xlsx(paste0("odata/",env.file),sheet = env.sheet)%>%
    mutate(env.int=as.numeric(rownames(.)))
  od<-od%>%
    mutate(env.int=findInterval(od$measure_datetime,ed$TIMESTAMP))%>%
    left_join(ed)
  write_rds(od,paste0("wdata/",out.file))
}

# concatenate data sets
bind.data<-function(pattrn){
  t1<-list.files("wdata",pattern=pattrn)
  t1<-paste0("wdata/",t1)
  t2<-read_rds(t1[1])
  for(i in 2:length(t1))t2<-bind_rows(t2,read_rds(t1[i]))
  return(t2)
}

# plot data
quick.view<-function(pattrn){
  library(lubridate)
  library(tidyverse)
  t1<-bind.data(pattrn=pattrn)
  t2<-t1%>%
    mutate(yr=year(measure_datetime),
           mnth=month(measure_datetime),
           d=day(measure_datetime),
           hr=hour(measure_datetime),
           datetime=ymd_h(paste(yr,mnth,d,hr)))%>%
    group_by(oyster,datetime)%>%
    summarize(m.mm=mean(abs(mm)))
  p1<-ggplot(data=t2)+
    geom_line(aes(x=datetime,y=m.mm,group=oyster,color=oyster))+
    facet_wrap(~oyster)
  return(p1)
}

