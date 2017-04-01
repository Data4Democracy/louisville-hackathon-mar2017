# louisville-hackathon-mar2017

## Who
This project is a product of the #city-louisville data for democracy team.  We had about 25 people show up on both March 31, 2017 and April 1, 2017 to work on this project.  Our group was diverse in many ways, and came together to do a great project.  The Mayor even showed up!

## What
We built an API of the 2017 Kentucky General Assembly.  This API can be used to build front end applications or do data analysis.  The url is [derby-pie-politics.herokuapp.com](https://derby-pie-politics.herokuapp.com/), and there is documentation about endpoints there.  We also have csv extracts of the tables in this repository and we will host them on data.world.

## Why
The Kentucky Legislative Research Commission does amazing work.  One of their dozens of responsibilities is to make available to the public the votes of the legislature.  The information about votes that they make available on their website are difficult to search and present significant challenges to analysis. We've augmented their work in this project.

## How
The biggest and hardest step in this process was scraping the LRC website for all the votes taken this session.  We were able to use R in some cases to scrape some bills, but for many, we depended on our team to hand scrape much of the data from the website directly.  We then utilized R to concatenate the scraped data, and spun up a PostgreSQL database and used Java to build the API.

This project was great -- we had a great time teaching, learning, and doing.  This project will help Kentuckians improve government in our commonwealth!
