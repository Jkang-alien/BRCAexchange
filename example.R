library(tidyverse)
library(httr)
library(jsonlite)

BRCAexchange <- GET("https://brcaexchange.org/backend/data/?format=json&order_by=Gene_Symbol&direction=ascending&page_num=0&search_term=&include=Variant_in_ENIGMA&include=Variant_in_ClinVar&include=Variant_in_1000_Genomes&include=Variant_in_ExAC&include=Variant_in_LOVD&include=Variant_in_BIC&include=Variant_in_ESP&include=Variant_in_exLOVD&include=Variant_in_Findlay_BRCA1_Ring_Function_Scores&include=Variant_in_GnomAD")

txtbrca <- httr::content(BRCAexchange, as = 'text')


data <- fromJSON(txtbrca)

summary(data)

df <- data$data

# save(df, file = "df.RData")


ir <- read_delim("M20-001146_v1_39100eae-d33f-46e7-b850-fc9545bf39da-2020-02-06-23-31-23-919.tsv",
                 delim = "\t", skip = 15)

data_coding <- ir %>%
  select(Coding)

df %>%
  select(Gene_Symbol, HGVS_cDNA, HGVS_Protein) %>%
  filter(HGVS_cDNA %in% data_coding$ir_HGVS_cDNA)

df %>%
  filter(Gene_Symbol == "BRCA1") %>%
  select(starts_with("HGVS")) %>%
  head()

ir <- read_delim("M20-001146_v1_39100eae-d33f-46e7-b850-fc9545bf39da-2020-02-06-23-31-23-919.tsv",
           delim = "\t", skip = 15)

ir_HGVS_cDNA = paste0()

data_coding <- ir %>%
  mutate(ir_HGVS_cDNA = paste0(Transcript, ":", Coding)) %>%
  select(ir_HGVS_cDNA)


df %>%
  filter()

saveRDS(df, file = "BRCAexchange.rds")

df.1 <- f.1("M20-001146_v1_39100eae-d33f-46e7-b850-fc9545bf39da-2020-02-06-23-31-23-919.tsv")
df.2 <- f.2(df.1)

BRCAdf.2$ir_HGVS_cDNA
f.3(df.2)

BRCAexchange <- readRDS("BRCA/data/BRCAexchange.rds")

read_info(ir)
