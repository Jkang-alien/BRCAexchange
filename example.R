library(tidyverse)
library(httr)
library(jsonlite)

BRCAexchange <- GET("https://brcaexchange.org/backend/data/?format=json&order_by=Gene_Symbol&direction=ascending&page_num=0&search_term=&include=Variant_in_ENIGMA&include=Variant_in_ClinVar&include=Variant_in_1000_Genomes&include=Variant_in_ExAC&include=Variant_in_LOVD&include=Variant_in_BIC&include=Variant_in_ESP&include=Variant_in_exLOVD&include=Variant_in_Findlay_BRCA1_Ring_Function_Scores&include=Variant_in_GnomAD")

txtbrca <- httr::content(BRCAexchange, as = 'text')


data <- fromJSON(txtbrca)

summary(data)

df <- data$data

save(df, file = "df.RData")

df %>%
  select(Gene_Symbol, HGVS_cDNA, HGVS_Protein) %>%
  tail()
