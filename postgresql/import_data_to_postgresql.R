library(tidyverse)
library(RPostgreSQL)

pw <- {'SETPASSWORDHERE'}
drv <- dbDriver('PostgreSQL')
con <- dbConnect(drv,
                 dbname = 'data4lou', 
                 host='data4dem4lou.cba3kk0t9rmq.us-east-1.rds.amazonaws.com',
                 user='iheartroot', password = pw)


# legi_temp <- read.csv('c:/chip/data4lou/Legislators.csv')
# names(legi_temp)[1] <- 'legislator_id'

myright <- function(x, n) {
  substr(x, nchar(x)-n+1, nchar(x))
}

# Process Legislators
  Legislators <- read.csv(url('https://raw.githubusercontent.com/Data4Democracy/louisville-hackathon-mar2017/master/Legislators.csv'), encoding='UTF-8')
  names(Legislators)[1] <- c('legislator_id')
  head(Legislators)
  dbWriteTable(con, name='Legislators', value=Legislators, overwrite = TRUE, quote=FALSE, row.names = FALSE);

# Process Legislature
  Legislature <- read.csv(url('https://raw.githubusercontent.com/Data4Democracy/louisville-hackathon-mar2017/master/Legislature.csv'))
  head(Legislature)
  dbWriteTable(con, name='Legislature', value=Legislature, overwrite = TRUE, quote=FALSE, row.names = FALSE);
  
# Process House Votes
  HouseVotes <- read.csv(url('https://raw.githubusercontent.com/Data4Democracy/louisville-hackathon-mar2017/master/House_Votes.csv'))
  # HouseVotes <- read.csv('c:/Chip/data4lou/House_Votes.csv')
  House_Votes <- gather(HouseVotes, key=Name)
  names(House_Votes) <- c('MemberName', 'BillName', 'Vote')
  House_Votes$Vote <- toupper(House_Votes$Vote)
  House_Votes$session_id <- 'ga2017'
  House_Votes$BillName <- paste0(substr(House_Votes$BillName,1,2), myright(paste0('0000', substr(House_Votes$BillName,3,99)),3))
  House_Votes$bill_id <- paste0(House_Votes$session_id, House_Votes$BillName);
  House_Votes$MemberName <- as.character(House_Votes$MemberName)
  House_Votes[which(House_Votes$MemberName=='Harris'),]$MemberName <- 'Harris C'
  House_Votes[which(House_Votes$MemberName=='Meredith'),]$MemberName <- 'Meredith M'
  House_Votes[which(House_Votes$MemberName=='Turner'),]$MemberName <- 'Turner T'
  House_Votes[which(House_Votes$MemberName=='Thomas'),]$MemberName <- 'Thomas W'
  # x <- merge(House_Votes, legi_temp, by.x=c('MemberName'), by.y=c('LastUnique'), all.x=TRUE)
  x <- merge(House_Votes, Legislators, by.x=c('MemberName'), by.y=c('LastUnique'), all.x=TRUE)
  unique(x[is.na(x$Full.Name),'MemberName'])
  House_Votes <- x[,c('bill_id', 'legislator_id', 'MemberName', 'BillName', 'Vote')]
  dbWriteTable(con, name='House_Votes', value=House_Votes, overwrite = TRUE, quote=FALSE, row.names = FALSE);
  
# Process Senate Votes
  SenateVotes <- read.csv(url('https://raw.githubusercontent.com/Data4Democracy/louisville-hackathon-mar2017/master/Senate_Votes.csv'))
  # SenateVotes <- read.csv('c:/Chip/data4lou/Senate_Votes.csv')
  # SenateVotes <- SenateVotes[,-c('name')]
  Senate_Votes <- gather(SenateVotes, key=Name)
  names(Senate_Votes) <- c('MemberName', 'BillName', 'Vote')
  
  Senate_Votes$Vote <- toupper(Senate_Votes$Vote)
  Senate_Votes[is.na(Senate_Votes)] <- 'NV'
  
  Senate_Votes$BillName <- gsub("[[:punct:]]", "", Senate_Votes$BillName)
  Senate_Votes$BillName <- gsub("_", "", Senate_Votes$BillName)
  Senate_Votes$BillName <- paste0(substr(Senate_Votes$BillName,1,2), myright(paste0('0000', substr(Senate_Votes$BillName,3,99)),3))
  
  Senate_Votes$session_id <- 'ga2017'

  Senate_Votes$bill_id <- paste0(Senate_Votes$session_id, Senate_Votes$BillName);  
  
  Senate_Votes$MemberName <- as.character(Senate_Votes$MemberName)
  Senate_Votes[which(Senate_Votes$MemberName=='Carroll, Danny'),]$MemberName <- 'Carroll D'
  Senate_Votes[which(Senate_Votes$MemberName=='Carroll, Julian'),]$MemberName <- 'Carroll J'
  Senate_Votes[which(Senate_Votes$MemberName=='Embry'),]$MemberName <- 'Embry Jr.'
  Senate_Votes[which(Senate_Votes$MemberName=='Harris'),]$MemberName <- 'Harris E'
  Senate_Votes[which(Senate_Votes$MemberName=='Jones'),]$MemberName <- 'Jones II'
  Senate_Votes[which(Senate_Votes$MemberName=='Meredith'),]$MemberName <- 'Meredith S'
  Senate_Votes[which(Senate_Votes$MemberName=='Rague Adams'),]$MemberName <- 'Adams'
  Senate_Votes[which(Senate_Votes$MemberName=='Stivers'),]$MemberName <- 'Stivers II'
  Senate_Votes[which(Senate_Votes$MemberName=='Thomas'),]$MemberName <- 'Thomas R'
  Senate_Votes[which(Senate_Votes$MemberName=='Turner'),]$MemberName <- 'Turner J'
  
  x <- merge(Senate_Votes, Legislators, by.x=c('MemberName'), by.y=c('LastUnique'), all.x=TRUE)
  unique(x[is.na(x$Full.Name),'MemberName'])
  Senate_Votes <- x[,c('bill_id', 'legislator_id', 'MemberName', 'BillName', 'Vote')]
  dbWriteTable(con, name='Senate_Votes', value=Senate_Votes, overwrite = TRUE, quote=FALSE, row.names = FALSE);
  
# Votes
  Votes <- rbind(House_Votes, Senate_Votes);
  dbWriteTable(con, name='Votes', value=Votes, overwrite = TRUE, quote=FALSE, row.names = FALSE)
  
# Process Session
  Session <- read.csv(url('https://raw.githubusercontent.com/Data4Democracy/louisville-hackathon-mar2017/master/Session.csv'))
  head(Session)
  names(Session)[1] <- c('session_id')
  dbWriteTable(con, name='Session', value=Session, overwrite = TRUE, quote=FALSE, row.names = FALSE);
  
# Bills
  Bills <- read.csv('c:/Chip/data4lou/bill_table.csv')
  names(Bills)[3] <- c('bill_id')
  Bills <- Bills[,c(3,1,2)]
  Bills <- Bills[Bills$BillNumber!= '',]
  dbWriteTable(con, name="Bills", value=Bills, overwrite = TRUE, quote=FALSE, row.names=FALSE);
