## Web Scraping Practice - NBA Team Data:

library(rvest)

scrapeteams <- function (url) {
  # Read webpage:
  webpage <- read_html(url)
  
  # Extract team information:
  teams_data_html <- html_nodes(webpage,".Table__TD")
  teams_data <-html_text(teams_data_html)
  col_labels_html <- html_nodes(webpage, ".Table__TH")
  col_labels <- html_text(col_labels_html)
  
  teams <- teams_data[seq(2, 60, 2)]
  teamstats <- matrix(NA, nrow = 30, ncol = 18)
  
  for (i in 1:30) {
    teamstats[i,] <- teams_data[seq((62 + 19*(i-1)), ((62+19*(i-1))+17),1)]
  }
  
  team_df <- data.frame(cbind(teams, teamstats))
  colnames(team_df)[2:19] <- col_labels[4:21]
  
  return(team_df)
}

nba_2017 <- scrapeteams("https://www.espn.com/nba/stats/team/_/season/2017/seasontype/2")
nba_2018 <- scrapeteams("https://www.espn.com/nba/stats/team/_/season/2018/seasontype/2")
nba_2019 <- scrapeteams("https://www.espn.com/nba/stats/team/_/season/2019/seasontype/2")
nba_2016 <- scrapeteams("https://www.espn.com/nba/stats/team/_/season/2016/seasontype/2")
nba_2015 <- scrapeteams("https://www.espn.com/nba/stats/team/_/season/2015/seasontype/2")
nba_2014 <- scrapeteams("https://www.espn.com/nba/stats/team/_/season/2014/seasontype/2")
nba_2013 <- scrapeteams("https://www.espn.com/nba/stats/team/_/season/2013/seasontype/2")
nba_2012 <- scrapeteams("https://www.espn.com/nba/stats/team/_/season/2012/seasontype/2")
nba_2011 <- scrapeteams("https://www.espn.com/nba/stats/team/_/season/2011/seasontype/2")
nba_2010 <- scrapeteams("https://www.espn.com/nba/stats/team/_/season/2010/seasontype/2")


nba_2019_misc <- scrapeteams("https://www.espn.com/nba/stats/team/_/view/differential/season/2019/seasontype/2")
nba_2018_misc <- scrapeteams("https://www.espn.com/nba/stats/team/_/view/differential/season/2018/seasontype/2")
nba_2017_misc <- scrapeteams("https://www.espn.com/nba/stats/team/_/view/differential/season/2017/seasontype/2")
nba_2016_misc <- scrapeteams("https://www.espn.com/nba/stats/team/_/view/differential/season/2016/seasontype/2")
nba_2015_misc <- scrapeteams("https://www.espn.com/nba/stats/team/_/view/differential/season/2015/seasontype/2")
nba_2014_misc <- scrapeteams("https://www.espn.com/nba/stats/team/_/view/differential/season/2014/seasontype/2")
nba_2013_misc <- scrapeteams("https://www.espn.com/nba/stats/team/_/view/differential/season/2013/seasontype/2")
nba_2012_misc <- scrapeteams("https://www.espn.com/nba/stats/team/_/view/differential/season/2012/seasontype/2")
nba_2011_misc <- scrapeteams("https://www.espn.com/nba/stats/team/_/view/differential/season/2011/seasontype/2")
nba_2010_misc <- scrapeteams("https://www.espn.com/nba/stats/team/_/view/differential/season/2010/seasontype/2")


nba_2019$MOV <- nba_2019_misc$PTS
nba_2018$MOV <- nba_2018_misc$PTS
nba_2017$MOV <- nba_2017_misc$PTS
nba_2016$MOV <- nba_2016_misc$PTS
nba_2015$MOV <- nba_2015_misc$PTS
nba_2014$MOV <- nba_2014_misc$PTS
nba_2013$MOV <- nba_2013_misc$PTS
nba_2012$MOV <- nba_2012_misc$PTS
nba_2011$MOV <- nba_2011_misc$PTS
nba_2010$MOV <- nba_2010_misc$PTS

nbadata <- rbind(nba_2019,nba_2018,nba_2017,nba_2016,nba_2015,nba_2014,nba_2013, nba_2012, nba_2011, nba_2010)

write.csv(nbadata, "/Users/mbp/Documents/NYU/APSTA 2123 - Bayesian Inference/Final Project/NBA_data.csv")
