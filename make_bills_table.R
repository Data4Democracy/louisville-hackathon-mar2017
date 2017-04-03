library(tidyverse)

votes <- read_csv('./louisville-hackathon-mar2017/postgresql/exports/Votes.csv')

votes <- votes %>% 
  mutate(BillName = map_chr(BillName, function(i){
    if(i == 'hb540') 'HB540'
    else if(i == 'hb473') 'HB473'
    else i
  }),
  bill_id = map_chr(bill_id, function(i){
    if(i == 'ga2017hb540') 'ga2017HB540'
    else if(i == 'ga2017hb473') 'ga2017HB473'
    else i
  }))

select(votes, bill_id, BillNumber = BillName) %>% 
  mutate(SessionID = 'ga2017') %>% 
  unique() %>% 
  write_csv('./louisville-hackathon-mar2017/postgresql/exports/Bills.csv')
