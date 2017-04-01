setwd("~/Repos/louisville-hackathon-mar2017/house")
h1 <- read.csv("all_enrolled_house_rep_votes.csv")
h2 <- read.csv("all_passed_onehouse_house_bills.csv")
h3 <- read.csv("all_signed_law_house_votes.csv")

house <- cbind(h1,h2,h3)

setwd("~/Repos/louisville-hackathon-mar2017/senate")

s1 <- read.csv("enrolled-vote_history_hsb_161_hb_471 .csv")
s2 <- read.csv("enrolled-vote_history_sb11_sb159.csv", sep = ';')
s3 <- read.csv("law-hb473_hb540.csv")
s4 <- read.csv("law-sb3_sb5_votehistory.csv", sep = ';')
s5 <- read.csv("onehouse-sb9-247.csv", sep = ';')
s6 <- read.csv("sb31.csv", sep = ';')
s7 <- read.csv("votehistory-law.csv")

head