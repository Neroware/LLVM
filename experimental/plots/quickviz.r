## Include libraries
library(ggplot2)
library(data.table)
library(magrittr) # Needed for %>% operator
library(tidyr)
library(ggrepel)
library(stringr)
library(hash)
library(lubridate)

## Set data path
datapath <- "../interconnect_test/result0.log"
bmdata <- read.csv(datapath)