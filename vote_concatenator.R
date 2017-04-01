library(tidyverse)

d1 <- read_csv('./louisville-hackathon-mar2017/scraped-ky-enrolled-csv/all_enrolled_house_rep_votes.csv')
d2 <- read_csv('./louisville-hackathon-mar2017/scraped-ky-enrolled-csv/enrolled-vote_history_hsb_161_hb_471 .csv')
d3 <- read_delim('./louisville-hackathon-mar2017/scraped-ky-enrolled-csv/enrolled-vote_history_sb11_sb159.csv', ';')
d4 <- read_delim('./louisville-hackathon-mar2017/scraped-ky-enrolled-csv/sb31.csv',';')
d5 <- read_csv("./louisville-hackathon-mar2017/scraped-ky-law-csv/all_signed_law_house_votes.csv")
d6 <- read_csv("./louisville-hackathon-mar2017/scraped-ky-law-csv/law-hb473_hb540.csv")
d7 <- read_delim('./louisville-hackathon-mar2017/scraped-ky-law-csv/law-sb170-249.csv',';')
d8 <- read_delim('./louisville-hackathon-mar2017/scraped-ky-law-csv/law-sb3_sb5_votehistory.csv',';')
# d9 <- read_csv('~/kyleg/louisville-hackathon-mar2017/scraped-ky-law-csv/sb2-vote-history.csv')
d10 <- read_csv('./louisville-hackathon-mar2017/scraped-ky-law-csv/votehistory-law.csv') %>% 
  rename(Name = NAME)
d11 <- read_csv('./louisville-hackathon-mar2017/scraped-ky-onehouse-csv/all_passed_onehouse_house_bills.csv')
d12 <- read_delim('./louisville-hackathon-mar2017/scraped-ky-onehouse-csv/onehouse-sb9-247.csv',';')
d13 <- read_csv('./louisville-hackathon-mar2017/ky_ga scraped bills.csv') %>% 
  rename(Name = X1) %>% 
  filter(!is.na(Name))
d14 <- read_csv('./louisville-hackathon-mar2017/some_missing_senate.csv')
d15 <- read_csv('./louisville-hackathon-mar2017/2missing_house_votes.csv ')
d16 <- read_csv('./louisville-hackathon-mar2017/missing_house_votes.csv ')
d17 <- read_csv('./louisville-hackathon-mar2017/scraped-ky-law-csv/hb281_sb002.csv ')
d18 <- read_csv('./louisville-hackathon-mar2017/three-missing-house-bills.csv')
d19 <- read_csv('./louisville-hackathon-mar2017/scraped-ky-law-csv/SB146.csv ')
d20 <- read_csv('./louisville-hackathon-mar2017/scraped-ky-law-csv/law-sb3_sb5_votehistory.csv ')
d21 <- read_csv('./louisville-hackathon-mar2017/more_missing_house.csv   ')
d22 <- read_csv('./louisville-hackathon-mar2017/rk_house_bills.csv  ')
d23 <- read_csv('./louisville-hackathon-mar2017/scraped-ky-law-csv/hb208_238_274_374_395.csv ')
d24 <- read_csv('./louisville-hackathon-mar2017/some-missing-house-votes.csv  ')


House_Votes <- left_join(d1, d11) %>% 
  left_join(d5) %>% 
  left_join(d15) %>% 
  left_join(d16) %>% 
  left_join(d18) %>% 
  left_join(d21) %>% 
  left_join(d22) %>% 
  left_join(d23) %>% 
  left_join(d24)

House_Votes <- House_Votes[,!grepl("\\_1$", colnames(House_Votes))] #remove duplicates

Senate_Votes <- left_join(d10, d12) %>% 
  left_join(d13) %>% 
  left_join(d2) %>% 
  left_join(d3) %>% 
  left_join(d4) %>% 
  left_join(d6) %>% 
  left_join(d7) %>% 
  left_join(d8) %>% 
  left_join(d14) %>% 
  left_join(d17) %>% 
  left_join(d19) %>% 
  left_join(d20)

Senate_Votes <- Senate_Votes[,!grepl("\\_1$", colnames(Senate_Votes))] #remove duplicate columns

#Uncomment to overwrite csv:
write_csv(Senate_Votes, "./louisville-hackathon-mar2017/Senate_Votes.csv")
write_csv(House_Votes, "./louisville-hackathon-mar2017/House_Votes.csv")
