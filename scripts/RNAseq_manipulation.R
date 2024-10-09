# install R packages

install.packages(c("tidyverse", "ggpubr", "openxlsx", ))
install.packages("naniar")

# install bioconducter

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install(version = "3.19")

# install bioconducter manager

BiocManager::install(c("GEOquery", "TCGAbiolinks","DESeq2", "airway"))

# load packages

library(tidyverse)
library(GEOquery)
library(ggpubr)
library(openxlsx)
library(naniar)


# import raw count data

count_data <- read.csv("data/GSE183947_fpkm.csv")

# metadata

res <- getGEO(GEO = "GSE183947", GSEMatrix = T)
class(res)
res


# get metadata

metadata <- pData(phenoData(res[[1]]))
metadata |> 
  head()


# subset metadata


metadata_subset <- metadata |> 
  select(c(1, 10, 11, 17))


# preprocessing data

metadata_modified <- metadata_subset |> 
  rename(Tissue = characteristics_ch1, Metastasis = characteristics_ch1.1) |> 
  mutate(Tissue = gsub("tissue: ", "", Tissue)) |> 
  mutate(Metastasis = gsub("metastasis: ", "", Metastasis))


# reshaping data

count_data_long <- count_data |> 
  rename(Gene = X) |> 
  pivot_longer(-Gene,
               names_to = "Samples",
               values_to = "fpkm")


# joining data

counts_final <- count_data_long |> 
  left_join(metadata_modified, by =c("Samples" = "description"))


# export data

write.csv(counts_final, "data/GSE183947_counts.csv", row.names = F)





