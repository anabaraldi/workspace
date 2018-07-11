library(dplyr)
library(readxl)
library(weitexl)
library(stringi)

data <- read_excel("~/Downloads/base_contatos_desafio.xlsx")

nrow(data)

data1 <- data %>%
  filter(!is.na(telefone)) %>% 
  mutate(telefone = gsub(' ', '', telefone)) %>%
  mutate(telefone = gsub('-', '', telefone)) %>%
  mutate(telefone = gsub('\\(', '', telefone)) %>%
  mutate(telefone = gsub('\\)', '', telefone))

for(i in 1:nrow(data1)) {
  telefone <- data1[i,]$telefone 
  if(nchar(telefone) == 10) {
    stri_sub(telefone, 3, 2) <- "9"
    data1[i,]$telefone <- telefone
  }
}

nrow(data1)

data2 <- data1 %>% 
  filter(nchar(telefone) == 11)

nrow(data2)

data3 <- data2 %>% 
  filter(!duplicated(telefone)) 
  
nrow(data3)

write_xlsx(data3, "~/Downloads/base_contatos_desafio_limpa.xlsx")

