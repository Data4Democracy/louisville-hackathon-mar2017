library(tidyverse)
library(RPostgreSQL)

pw <- {'SETPASSWORDHERE'}
drv <- dbDriver('PostgreSQL')
con <- dbConnect(drv,
                 dbname = 'data4lou', 
                 host='data4dem4lou.cba3kk0t9rmq.us-east-1.rds.amazonaws.com',
                 user='iheartroot', password = pw)
dbExistsTable(con, 'members')
dbGetQuery(con, 'select * from members')
dbGetQuery(con, 'select * from ky_ga_bill_votes')


# Process House Votes
  HouseVotes <- read.delim(url('https://raw.githubusercontent.com/Data4Democracy/louisville-hackathon-mar2017/master/House_Votes.csv'), 
                  sep = ';')
  votes <- gather(HouseVotes, key=Name)
  names(votes) <- c('MemberName', 'BillName', 'Vote')
  dbWriteTable(con, name='votes', value=votes, overwrite = TRUE, quote=FALSE, row.names = FALSE);

  # Process Legislators
  Legislators <- read.csv(url('https://raw.githubusercontent.com/Data4Democracy/louisville-hackathon-mar2017/master/Legislators.csv'), encoding='UTF-8')
  names(Legislators)[1] <- c('legislator_id')
  head(Legislators)
  dbWriteTable(con, name='Legislators', value=Legislators, overwrite = TRUE, quote=FALSE, row.names = FALSE);
   
# Process Legislature
  Legislature <- read.csv(url('https://raw.githubusercontent.com/Data4Democracy/louisville-hackathon-mar2017/master/Legislature.csv'))
  head(Legislature)
  dbWriteTable(con, name='Legislature', value=Legislature, overwrite = TRUE, quote=FALSE, row.names = FALSE);
  
  
# Process Session
  Session <- read.csv(url('https://raw.githubusercontent.com/Data4Democracy/louisville-hackathon-mar2017/master/Session.csv'))
  head(Session)
  dbWriteTable(con, name='Session', value=Session, overwrite = TRUE, quote=FALSE, row.names = FALSE);
