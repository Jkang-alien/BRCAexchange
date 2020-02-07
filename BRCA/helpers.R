library(tidyverse)


make.df.from.input <- function(input_file) {
  read_delim(input_file, delim = "\t", skip = 15) %>%
    mutate(ir_HGVS_cDNA = paste0(Transcript, ":", Coding))
} 

gene_info <- function(df) {
  BRCAexchange[BRCAexchange$HGVS_cDNA %in% df$ir_HGVS_cDNA, ] %>%
    select(Gene_Symbol, HGVS_Protein, Protein_Change)
}

read_info <- function(df) {
  df %>%
    drop_na(Coding) %>%
    select(ir_HGVS_cDNA, `% Frequency`, Coverage, `Homopolymer Length`)
}