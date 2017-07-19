########################################################
## scrape Gallup approval ratings
## 
## simon jackman
## simon.jackman@sydney.edu.au
## ussc, univ of sydney
## 2017-06-24 21:58:10
########################################################
options(stringsAsFactors = FALSE)

theURL <- "http://www.gallup.com/poll/116584/presidential-approval-ratings-bill-clinton.aspx"

library(rvest)

foo <- read_html(x=url(theURL))
foo <- html_table(html_nodes(foo,"table"))
approval <- foo[[2]]
approval.pid <- foo[[3]]

names(approval) <- c("date","approve","disapprove","dk")
approval <- subset(approval,!is.na(as.numeric(approve)))

names(approval.pid) <- c("date","rep","ind","dem")
approval.pid <- subset(approval.pid,!is.na(as.numeric(rep)))

approval$startDate <- as.Date(gsub(approval$date,pattern="-[0-9]{1,2}$",replacement=""),
                              format="%y %b %d")
approval$endDate <- as.Date(gsub(approval$date,
                                 pattern="(^[0-9]{2} [A-z]{3}) ([0-9]{1,2})-([0-9]{1,2}$)",
                                 replacement="\\1 \\3"),
                            format="%y %b %d")
approval$midDate <- approval$startDate + (approval$endDate-approval$startDate)/2

approval.pid$startDate <- as.Date(gsub(approval.pid$date,pattern="-[0-9]{1,2}$",replacement=""),
                              format="%y %b %d")
approval.pid$endDate <- as.Date(gsub(approval.pid$date,
                                 pattern="(^[0-9]{2} [A-z]{3}) ([0-9]{1,2})-([0-9]{1,2}$)",
                                 replacement="\\1 \\3"),
                            format="%y %b %d")
approval.pid$midDate <- approval.pid$startDate + (approval.pid$endDate-approval.pid$startDate)/2

clinton <- approval
clinton.pid <- approval.pid

save("clinton","clinton.pid",file="approval.RData")
