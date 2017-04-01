library(tidyverse)

d1 <- read_csv('./louisville-hackathon-mar2017/scraped-ky-enrolled-csv/all_enrolled_house_rep_votes.csv')
d2 <- read_csv('./louisville-hackathon-mar2017/scraped-ky-enrolled-csv/enrolled-vote_history_hsb_161_hb_471 .csv')
d3 <- read_delim('./louisville-hackathon-mar2017/scraped-ky-enrolled-csv/enrolled-vote_history_sb11_sb159.csv', ';')
d4 <- read_delim('./louisville-hackathon-mar2017/scraped-ky-enrolled-csv/sb31.csv',';')
d5 <- read_csv("~/kyleg/louisville-hackathon-mar2017/scraped-ky-law-csv/all_signed_law_house_votes.csv")
d6 <- read_csv("~/kyleg/louisville-hackathon-mar2017/scraped-ky-law-csv/law-hb473_hb540.csv")
d7 <- read_delim('~/kyleg/louisville-hackathon-mar2017/scraped-ky-law-csv/law-sb170-249.csv',';')
# d8 <- read_delim('~/kyleg/louisville-hackathon-mar2017/scraped-ky-law-csv/law-sb3_sb5_votehistory.csv',';')
# d9 <- read_csv('~/kyleg/louisville-hackathon-mar2017/scraped-ky-law-csv/sb2-vote-history.csv')
d10 <- read_csv('~/kyleg/louisville-hackathon-mar2017/scraped-ky-law-csv/votehistory-law.csv') %>% 
  rename(Name = NAME)
d11 <- read_csv('~/kyleg/louisville-hackathon-mar2017/scraped-ky-onehouse-csv/all_passed_onehouse_house_bills.csv')
d12 <- read_delim('~/kyleg/louisville-hackathon-mar2017/scraped-ky-onehouse-csv/onehouse-sb9-247.csv',';')
d13 <- read_csv('~/kyleg/louisville-hackathon-mar2017/ky_ga scraped bills.csv') %>% 
  rename(Name = X1) %>% 
  filter(!is.na(Name))

House_Votes <- left_join(d1, d11) %>% 
  left_join(d5)

Senate_Votes <- left_join(d10, d12) %>% 
  left_join(d13) %>% 
  left_join(d2) %>% 
  left_join(d3) %>% 
  left_join(d4) %>% 
  left_join(d6) %>% 
  left_join(d7) %>% 
  left_join(d8)
