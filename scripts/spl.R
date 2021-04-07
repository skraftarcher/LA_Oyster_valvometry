#process spl from recordings in boat noise band (20-100 hz)

# First load functions and packages
if(!require(tidyverse))install.packages("tidyverse");library(tidyverse)
if(!require(lubridate))install.packages("lubridate");library(lubridate)

source('PAM-R/PAMGuide-edited.R')
source('PAM-R/Meta-edited.R')
source('PAM-R/format_dates.R')
source('PAM-R/Viewer.R')

# note: numeric dates are base on origin = "1970-01-01"
# get the calibration number from the ocean instruments site
# http://oceaninstruments.azurewebsites.net/App/#/%23

# for all of Stephanie's hydrophones - only hashtag out needed one

# file_prefix <- "5674"
# calib_value <- -176.6
# 
# file_prefix <- "5678"
# calib_value <- -176.5

file_prefix <- "5679"
calib_value <- -176.8

# file_prefix <- "5680"
# calib_value <- -176.4

set_lcut <- 20 # noise floor for soundtraps
set_hcut <- 100 # change depending on purpose of analysis. This is to find boats so super low freq

## averaging across time produces more reliable measures of random signals such as sound levels in a habitat
set_welch <- 120 # 1 min time resolution

# now run analysis
PAMMeta(
  # atype = "PSD",# this tells it you want to do power spectral density 
  atype = "Broadband",# this option is for doing SPL
  outwrite = 1,# this tells it you want to outwrite the analysis file
  calib = 1, # this tells it you want to use calibration information
  envi = "Wat",# this tells it you recorded in water
  ctype = "EE",# type of calibration, for soundtraps it is end to end
  Si = calib_value,# calibration value from the ocean instruments site
  lcut = set_lcut,# low frequency cut off on Hz
  hcut = set_hcut,# high frequency cut off on Hz
  welch = set_welch,# assuming default of 50% overlap, this is the # seconds x2
  plottype = "none",# tells it whether or not to plot the output
  timestring = paste0(file_prefix, ".%y%m%d%H%M%S.wav"),
  tones=F
  # outdir = here::here("data", paste0(file_prefix, "-meta-", welch_lab, "s")#, paste0("lcut-", set_lcut)
  #   )
)

#format dates
format.dates.spl(file.type="rds",
                 file="E:/5679/Conk_5679_Abs_Broadband_48000ptHannWindow_5000pcOlap.rds",
                 output="odata/spl_lowfreq_March_2_18_21.rds")
