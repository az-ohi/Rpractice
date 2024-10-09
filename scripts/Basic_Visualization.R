# load packages

library(tidyverse)
library(GEOquery)
library(ggpubr)
library(openxlsx)
library(naniar)

# import data

data <- read.csv("data/GSE183947_counts.csv")

# visualization structure

# ggplot(data= , aes(x= , y= )) + geom_type()

# bar plot

data |> 
  filter(Gene == "BRCA1") |> 
  ggplot(aes(x= Samples, y = fpkm, fill = Tissue))+
  geom_col()

# box plot

data |> 
  filter(Gene == "BRCA1") |> 
  ggplot(aes(x= Metastasis, y = fpkm, fill = Tissue))+
  geom_boxplot()

# violin plot

data |> 
  filter(Gene == "BRCA1") |> 
  ggplot(aes(x= Metastasis, y = fpkm, fill = Tissue))+
  geom_violin()

# Histogram plot

data |> 
  filter(Gene == "BRCA1") |> 
  ggplot(aes(x= fpkm, fill = Tissue))+
  geom_histogram()

# split figure

data |> 
  filter(Gene == "BRCA1") |> 
  ggplot(aes(x= fpkm, fill = Tissue))+
  geom_histogram()+
  facet_wrap(~Tissue)

# density plot

data |> 
  filter(Gene == "BRCA1") |> 
  ggplot(aes(x= fpkm, fill = Tissue))+
  geom_density()+
  facet_wrap(~Tissue)

# scatter plot

data |> 
  filter(Gene == "BRCA1" | Gene == "BRCA2") |> 
 # column crate for define BRCA1 and BRCA2 gene
   spread(key = Gene, value = fpkm) |> 
  ggplot(aes(x= BRCA1, y= BRCA2, colour = Tissue))+
  geom_point()

# add stat

data |> 
  filter(Gene == "BRCA1" | Gene == "BRCA2") |> 
  spread(key = Gene, value = fpkm) |> 
  ggplot(aes(x= BRCA1, y= BRCA2, colour = Tissue))+
  geom_point()+
  geom_smooth(method = "lm", se = F)

# heatmap

gene_of_interest <- c("BRCA1", "BRCA2", "TP53", "ALK", "MYCN")

data |> 
  filter(Gene %in% gene_of_interest) |> 
  ggplot(aes(x= Samples, y= Gene, fill = fpkm))+
  geom_tile()+
  # coloring
  scale_fill_gradient(low = "white",high = "red")

















































































































