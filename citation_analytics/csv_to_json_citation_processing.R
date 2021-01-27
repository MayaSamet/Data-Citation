library(jsonlite)
library(readr)
library(dplyr)
library(knitr)
library(stringr)

regex <- "(?:10\\..*)|(?:urn.*)"

dbo_cits <- read_csv("dbo_cit_raw.csv") %>%
  mutate(article_doi=str_extract(article_doi, regex), 
         dataset_doi=str_extract(dataset_doi, regex)) %>%
  select(c(dataset_doi, article_doi, cit_type)) %>%
  rename(source_id = article_doi, target_id = dataset_doi, relationType = cit_type)

head(dbo_cits)

dbo_cits <- toJSON(dbo_cits)
write(dbo_cits, "dbo_cits.json") 

### abs cit pt 2

abs_cits_2 <- read_csv("adc_publication_keyword_search_september_work.csv") %>%
  mutate(relationType = ifelse(relationType=="isCited", "Cites", relationType)) %>%
  filter(cit=="y") %>%
  select(c(source_id, target_id, relationType))

abs_cits_2 <- toJSON(abs_cits_2)
write(abs_cits_2, "abs_cit_part_2.json") 

### found citation

found_cit <- read_csv("found_citations.csv") %>%
  rename(source_id = article_doi, target_id = dataset_doi) %>%
  select(c(source_id, target_id, relationType))

found_cit <- toJSON(found_cit)
write(found_cit, "found_cit.json") 

### toolik citations
toolik_cit <- read_csv("toolik_citations.csv") %>%
  rename(source_id = article_doi, target_id = dataset_doi, relationType = relation_type) %>%
  filter(!is.na(target_id)) %>%
  select(c(source_id, target_id, relationType))

toolik_cit <- toJSON(toolik_cit)
write(toolik_cit, "toolik_cit.json") 

### abs cit pt 1 citations
abs_cits_1 <- read_csv("adc_citation_keyword_search_part1.csv") %>%
  rename(source_id = article_doi, target_id = dataset_id) %>%
  filter(!is.na(source_id)) %>%
  select(c(source_id, target_id))

abs_cits_1 <- toJSON(abs_cits_1)
write(abs_cits_1, "abs_cit_part_1_complete.json") 

### count

toolik_ct <- fromJSON(toolik_cit)
scythe_ct <- fromJSON("scythe_cit.json")
found_ct <- fromJSON(found_cit)
dbo_ct <- fromJSON(dbo_cits)
abs_ct_2 <- fromJSON(abs_cits_2)
abs_ct_1 <- fromJSON("abs_cit_part_1.json")
abs_ct_1_comp <-fromJSON("abs_cit_part_1_complete.json")

nrow(toolik_ct)
nrow(scythe_ct)
nrow(found_ct)
nrow(dbo_ct)
nrow(abs_ct_2)
nrow(abs_ct_1_comp)
