library(tidyverse)
library(stringr)
library(RPostgreSQL)

pw <- {'illfatedcoppertruck'}
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
  Legislators$Initial.Name <- as.character(Legislators$Initial.Name)
  Legislators[which(Legislators$LastUnique=='Johnson DJ'),]$Initial.Name <- 'DJ. Johnson'
  

# Process Legislature
  Legislature <- read.csv(url('https://raw.githubusercontent.com/Data4Democracy/louisville-hackathon-mar2017/master/Legislature.csv'))
  head(Legislature)
  
# Process House Votes
  HouseVotes <- read.csv(url('https://raw.githubusercontent.com/Data4Democracy/louisville-hackathon-mar2017/master/House_Votes.csv'))
  # HouseVotes <- read.csv('c:/Chip/data4lou/House_Votes.csv')
  House_Votes <- gather(HouseVotes, key=Name)
  names(House_Votes) <- c('MemberName', 'BillName', 'Vote')
  House_Votes$Vote <- toupper(House_Votes$Vote)
  House_Votes$session_id <- 'ga2017'
  House_Votes$BillName <- paste0(substr(House_Votes$BillName,1,2), myright(paste0('0000', substr(House_Votes$BillName,3,99)),3))
  House_Votes$BillName <- toupper(House_Votes$BillName)
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
  Senate_Votes$BillName <- toupper(Senate_Votes$BillName)
  Senate_Votes$BillName <- paste0(substr(Senate_Votes$BillName,1,2), myright(paste0('0000', substr(Senate_Votes$BillName,3,99)),3))
  
  Senate_Votes$session_id <- 'ga2017'

  Senate_Votes$bill_id <- paste0(Senate_Votes$session_id, Senate_Votes$BillName);  
  
  Senate_Votes$MemberName <- as.character(Senate_Votes$MemberName)
  # Senate_Votes[which(Senate_Votes$MemberName=='Carroll, Danny'),]$MemberName <- 'Carroll D'
  # Senate_Votes[which(Senate_Votes$MemberName=='Carroll, Julian'),]$MemberName <- 'Carroll J'
  # Senate_Votes[which(Senate_Votes$MemberName=='Embry'),]$MemberName <- 'Embry Jr.'
  # Senate_Votes[which(Senate_Votes$MemberName=='Harris'),]$MemberName <- 'Harris E'
  # Senate_Votes[which(Senate_Votes$MemberName=='Jones'),]$MemberName <- 'Jones II'
  # Senate_Votes[which(Senate_Votes$MemberName=='Meredith'),]$MemberName <- 'Meredith S'
  # Senate_Votes[which(Senate_Votes$MemberName=='Rague Adams'),]$MemberName <- 'Adams'
  # Senate_Votes[which(Senate_Votes$MemberName=='Raque Adams'),]$MemberName <- 'Adams'
  # Senate_Votes[which(Senate_Votes$MemberName=='Stivers'),]$MemberName <- 'Stivers II'
  # Senate_Votes[which(Senate_Votes$MemberName=='Thomas'),]$MemberName <- 'Thomas R'
  # Senate_Votes[which(Senate_Votes$MemberName=='Turner'),]$MemberName <- 'Turner J'
  
  x <- merge(Senate_Votes, Legislators, by.x=c('MemberName'), by.y=c('LastUnique'), all.x=TRUE)
  unique(x[is.na(x$Full.Name),'MemberName'])
  Senate_Votes <- x[,c('bill_id', 'legislator_id', 'MemberName', 'BillName', 'Vote')]
  
  SenateVotes[SenateVotes$Name=='Adams','HB281']  # Should be 'Nay'
  
# Votes
  Votes <- rbind(House_Votes, Senate_Votes);
  unique(Votes$Vote)
  # Votes <- mutate(Votes, Vote = map_chr(Vote, function(i) ifelse(i == 'YAY','YEA',i)))
  # Same as:  
  Votes[which(Votes$Vote=='YAY'),]$Vote <- 'YEA'
  Votes <- unique(Votes)
  
# Process Session
  Session <- read.csv(url('https://raw.githubusercontent.com/Data4Democracy/louisville-hackathon-mar2017/master/Session.csv'))
  head(Session)
  names(Session)[1] <- c('session_id')
  
# Bills
  Bills <- read.csv(url('https://raw.githubusercontent.com/chipmonkey/louisville-hackathon-mar2017/master/bill_table.csv'))
  names(Bills)[3] <- c('bill_id')
  Bills <- Bills[,c(3,1,2)]
  Bills <- Bills[Bills$BillNumber!= '',]
  Bills <- select(Votes, bill_id, BillNumber = BillName) %>% mutate(SessionID = 'ga2017') %>% unique()
  
  
# Sponsors
  HouseSponsors <- read.csv(url('https://raw.githubusercontent.com/Data4Democracy/louisville-hackathon-mar2017/master/scraped-ky-bill-sponsor-csv/house_sponsors.csv'))
  HouseSponsors$sponsors <- as.character(HouseSponsors$sponsors)
  HouseSponsors[which(HouseSponsors$sponsors == 'R. Benvenuti III'),]$sponsors <- 'R. Benvenuti'
  HouseSponsors[which(HouseSponsors$sponsors == 'R. Benevenuti III'),]$sponsors <- 'R. Benvenuti'
  HouseSponsors[which(HouseSponsors$sponsors == 'S. Wells'),]$sponsors <- 'W. Wells'
  HouseSponsors[which(HouseSponsors$sponsors == 'B. Reed'),]$sponsors <- 'W. Reed'
  HouseSponsors[which(HouseSponsors$sponsors == 'S. LeeHB 16'),]$sponsors <- 'S. Lee'
  HouseSponsors[which(HouseSponsors$sponsors == 'J. Stewart III'),]$sponsors <- 'J. Stewart'
  HouseSponsors[which(HouseSponsors$sponsors == 'J. Gooch Jr.'),]$sponsors <- 'J. Gooch'
  HouseSponsors[which(HouseSponsors$sponsors == 'J. Sims Jr'),]$sponsors <- 'J. Sims'
  HouseSponsors[which(HouseSponsors$sponsors == 'G. Brown Jr'),]$sponsors <- 'G. Brown'
  
  
  SenateSponsors <- read.csv(url('https://raw.githubusercontent.com/Data4Democracy/louisville-hackathon-mar2017/master/scraped-ky-bill-sponsor-csv/senate_sponsors.csv'))
  setdiff(HouseSponsors$sponsors, Legislators$Initial.Name)
  setdiff(SenateSponsors$sponsors, Legislators$Initial.Name)
  
  ssx <- merge(SenateSponsors, Legislators, by.x=c('sponsors'), by.y=c('Initial.Name'), all.x=TRUE)
  unique(ssx[is.na(ssx$FirstName),'sponsors'])
  hsx <- merge(HouseSponsors, Legislators, by.x=c('sponsors'), by.y=c('Initial.Name'), all.x = TRUE)
  unique(ssx[is.na(ssx$FirstName), 'sponsors'])
  
  names(SenateSponsors)
  names(HouseSponsors)
  
  ssx$session_id <- 'ga2017'
  ssx$bill <- paste0(substr(ssx$bill,1,2), myright(paste0('0000', substr(ssx$bill,3,99)),3))
  ssx$bill_id <- paste0(ssx$session_id, ssx$bill);
  
  hsx$session_id <- 'ga2017'
  hsx$bill <- paste0(substr(hsx$bill,1,2), myright(paste0('0000', substr(hsx$bill,3,99)),3))
  hsx$bill_id <- paste0(hsx$session_id, hsx$bill);
  
  
  Sponsors <- rbind(ssx[,c('legislator_id', 'bill_id', 'bill', 'sponsors')],
                    hsx[,c('legislator_id', 'bill_id', 'bill', 'sponsors')])
  
  Sponsors <- Sponsors[!is.na(Sponsors$sponsors),]
  
  
   # Post Processing from rkahne
  # legislators_rkahne <- select(Legislators, legislator_id, Initial.Name) %>%
  #   bind_rows(tibble(legislator_id = c(6,55,96,63,117,6,37,113, 10),
  #                    Initial.Name = c('R. Benvenuti III','DJ Johnson','B. Reed',
  #                                     'S. LeeHB 16', 'J. Stewart III', 'R. Benevenuti III',
  #                                     'J. Gooch Jr.','J. Sims Jr', 'G. Brown Jr')))
  # 
  # write.csv(legislators_rkahne, 'legislators_rkahne.csv', row.names = FALSE)
  # write.csv(Legislators, 'Legislators.csv', row.names = FALSE)
  
  # Sponsors_rkahne <- bind_rows(HouseSponsors, SenateSponsors) %>%
  #   filter(!is.na(bill)) %>%
  #   mutate(
  #     bill_id = map_chr(bill, function(i){
  #       num <- str_extract_all(i,'[\\d]') %>% unlist() %>% paste0(collapse = '')
  #       if(str_length(num) == 1) num <- paste0('00',num)
  #       else if(str_length(num) == 2) num <- paste0('0',num)
  #       else num <- num
  #       paste0('ga2017',str_sub(i,1,2),num)
  #     }),
  #     legislator_id = map_dbl(sponsors, function(i){
  #       if(is.na(i)) NA
  #       else legislators_rkahne$legislator_id[which(legislators_rkahne$Initial.Name == i)]
  #     })
  #   )
  # Sponsors_rkahne <- Sponsors_rkahne[,c(4,3,1,2)]
  # write.csv(Sponsors, 'sponsors.csv', row.names = FALSE)
  # write.csv(Sponsors_rkahne, 'sponsors_rkahne.csv', row.names = FALSE)
  
  # Sponsors <- Sponsors_rkahne # just use the new logic -- clean this all up later!

# Overwrite Database
dbWriteTable(con, name='Legislators', value=Legislators, overwrite = TRUE, quote=FALSE, row.names = FALSE);
dbWriteTable(con, name='Legislature', value=Legislature, overwrite = TRUE, quote=FALSE, row.names = FALSE);
dbWriteTable(con, name='House_Votes', value=House_Votes, overwrite = TRUE, quote=FALSE, row.names = FALSE);
dbWriteTable(con, name='Senate_Votes', value=Senate_Votes, overwrite = TRUE, quote=FALSE, row.names = FALSE);
dbWriteTable(con, name='Votes', value=Votes, overwrite = TRUE, quote=FALSE, row.names = FALSE)
dbWriteTable(con, name='Session', value=Session, overwrite = TRUE, quote=FALSE, row.names = FALSE);
dbWriteTable(con, name="Bills", value=Bills, overwrite = TRUE, quote=FALSE, row.names=FALSE);
dbWriteTable(con, name='Sponsors', value=Sponsors, overwrite = TRUE, quote=FALSE, row.names = FALSE);
  
myBills <- dbReadTable(con, 'Bills')
myHouse_Votes <- dbReadTable(con, 'House_Votes')
myLegislators <- dbReadTable(con, 'Legislators')
myLegislature <- dbReadTable(con, 'Legislature')
mySenate_Votes <- dbReadTable(con, 'Senate_Votes')
mySession <- dbReadTable(con, 'Session')
mySponsors <- dbReadTable(con, 'Sponsors')
myVotes <- dbReadTable(con, 'Votes')

write.csv(myBills, 'exports\\Bills.csv', row.names = FALSE)
write.csv(myHouse_Votes, 'exports\\House_Votes.csv', row.names = FALSE)
write.csv(myLegislators, 'exports\\Legislators.csv', row.names = FALSE)
write.csv(myLegislature, 'exports\\Legislature.csv', row.names = FALSE)
write.csv(mySenate_Votes, 'exports\\Senate_Vote.csv', row.names = FALSE)
write.csv(mySession, 'exports\\Session.csv', row.names = FALSE)
write.csv(mySponsors, 'exports\\Sponsors.csv', row.names = FALSE)
write.csv(myVotes, 'exports\\Votes.csv', row.names = FALSE)



