# Build the sponsors table

library(tidyverse)
library(stringr)

# Built by Nick Holt
house_sponsors <- read_csv('./louisville-hackathon-mar2017/scraped-ky-bill-sponsor-csv/house_sponsors.csv')
senate_sponsors <- read_csv('./louisville-hackathon-mar2017/scraped-ky-bill-sponsor-csv/senate_sponsors.csv')


# DB Extracts from Chip
legislators <- read_csv('./louisville-hackathon-mar2017/postgresql/exports/Legislators.csv')

# Add in weird changes
legislators_full <- select(legislators, legislator_id, Initial.Name) %>% 
  bind_rows(tibble(legislator_id = c(6,55,96,63,117,6,37,113, 10), 
                   Initial.Name = c('R. Benvenuti III','DJ Johnson','B. Reed',
                                    'S. LeeHB 16', 'J. Stewart III', 'R. Benevenuti III',
                                    'J. Gooch Jr.','J. Sims Jr', 'G. Brown Jr')))

# Write out table
bind_rows(house_sponsors, senate_sponsors) %>% 
    filter(!is.na(bill)) %>% 
    mutate(
      bill_id = map_chr(bill, function(i){
        num <- str_extract_all(i,'[\\d]') %>% unlist() %>% paste0(collapse = '')
        if(str_length(num) == 1) num <- paste0('00',num)
        else if(str_length(num) == 2) num <- paste0('0',num)
        else num <- num
        paste0('ga2017',str_sub(i,1,2),num)
      }),
      legislator_id = map_dbl(sponsors, function(i){
        if(is.na(i)) NA
        else legislators_full$legislator_id[which(legislators_full$Initial.Name == i)]
      })
    ) %>% 
    write_csv('./louisville-hackathon-mar2017/postgresql/exports/Sponsors.csv')

