########################################################
## trump approval from pollster
##
## simon jackman
## simon.jackman@sydney.edu.au
## ussc, univ of sydney
## 2017-06-24 22:39:50
########################################################

theURL <- "http://elections.huffingtonpost.com/pollster/api/v2/questions/00c%20-Pres-45-Trump%20-%20Job%20Approval%20-%20National/poll-responses-clean.tsv"

approval <- read.csv(file=url(theURL),sep="\t")
approval$startDate <- as.Date(approval$start_date)
approval$endDate <- as.Date(approval$end_date)
approval$midDate <- approval$startDate + (approval$endDate-approval$startDate)/2

save("approval",file="approval.RData")


## Gallup at 
## http://www.gallup.com/poll/203198/presidential-approval-ratings-donald-trump.aspx