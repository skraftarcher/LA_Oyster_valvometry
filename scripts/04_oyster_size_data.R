# pull and process oyster growth data


if(!require(gsheet))install.packages("gsheet");library(gsheet)
if(!require(tidyverse))install.packages("tidyverse");library(tidyverse)

#assign the google sheet link to url
url<-"https://docs.google.com/spreadsheets/d/1uVUMKzYEz9kDus76rSjvqZDVO2B7ptQKhfAb1-v8gkg/edit?usp=sharing"

# now pull the sheet
oys.grow<-read.csv(text=gsheet2text(url,format='csv'),stringsAsFactors = FALSE)  

# look at oyster size over time

ggplot(data=oys.grow,aes(x=date,y=length,color=oyster))+
  geom_point(size=3)+
  geom_line(aes(group=oyster))
