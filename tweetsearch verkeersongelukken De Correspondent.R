############################################################
# Script geschreven door Arjan Zuidof, 16 januari 2019
# voor analyse De Correspondent over verkeersongelukken
###########################################################

# Dit script regelt de volgende zaken
# 1. verzamelen van tweets over recente verkeersongelukken in NL waarin een URL is opgenomen
# tweets worden verzameld in csv bestand voor latere analyse
# 2. tonen van een grafiek met recente tweets over dit onderwerp (voor trends, breaking news etc.)
# dat laatste is om te zien wat je nog meer met de data kunt doen: bv tijdens spits wordt aanzienlijk meer gerapporteerd

library(rtweet)
library(ggplot2)
library(dplyr) # voor filter
library(lubridate) # voor as_datetime 
library(tidyverse) # voor unnest

# voorbereiding: zoektekst, tijd van de dag (afhankelijk van totaal aantal tweets)
# '-RT' RT's van dezelfde tweet wegzijn overbodig; wegflteren
searchText <-"(fietser OR wandelaar OR voetganger OR automobilist OR bestuurder OR chauffeur OR bromfietser OR fiets OR bromfiets) AND (aanrijding OR botsing OR ongeluk OR ongeval OR letsel OR gewond OR overleden) -RT"
startTime <- "2019-01-14 00:00"

# LET OP Auhenticatie verloopt via een webinterface waarmee je rtweet toegang geeft tot je account
# dit is nodig om de zoekopdracht hieronder te laten werken
# n is aantal uitgevraagde tweets. Bepaal dit aan de hand van het zoekvolume
tmp_tweets2 <-search_tweets(searchText, n=1000, tweet_mode='extended')

# DATA BEWERKINGEN
# a. wegfilteren mentions (niet interessant) en tweets zonder URL's
# b.  selecteren van gewenste kolommen
tmp_tweets2 <- filter(tmp_tweets, is.na(reply_to_screen_name)) %>%
  filter(!is.na(urls_expanded_url)) %>%
  select(screen_name, text, created_at, urls_expanded_url) %>%
  unnest(urls_expanded_url)
# urls_expanded_url is van list type. deze eerst omzetten
tmp_tweets2 <- data.frame(screen_name = tmp_tweets2$screen_name) %>%
               data.frame(text = tmp_tweets2$text) %>%
               data.frame(created_at = tmp_tweets2$created_at) %>%
               mutate(urls_expanded_url = tmp_tweets2$urls_expanded_url %>%
  unlist())
######tmp3 = data.frame(screen_name = tmp_tweets2$screen_name) %>% mutate(urls_expanded_url = tmp_tweets2$urls_expanded_url %>% unlist())

## TODO: meer kolommen verzamelen wanneer analyse van RT's / aantal keer gedeeld gewenst is

# opslaan als R-object en csv-bestand
saveRDS(tmp_tweets2, (file=paste(searchText,'.rds')))
write.csv(file=paste(searchText, '.csv'), x=tmp_tweets2)

## GRAFIEK MET LAATSTE RESULTATEN
# hack voor juiste tijd in NL
tmp_tweets2$created_at <-as_datetime(format(tmp_tweets2$created_at, tz="Europe/Amsterdam"))

ggplot(tmp_tweets2, aes(x=created_at)) + geom_histogram(aes(fill=..count..), binwidth=60*60) +
  ggtitle(paste("Twitter over verkeersongelukken")) + xlab("tijd") +  ylab("tweets per uur")

