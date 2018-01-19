#======================================================================================================
# Add Meta-Classification to Folk Song Feature Dataset
# David John Baker 
#======================================================================================================
# Libraries
library(data.table)
#======================================================================================================
# Load Features
essenFeatures <- fread("data/feature_data/EssenChinaFeatures.csv")
densmoreFeatures <- fread("data/feature_data/desnmoreFeatures.csv")
# americanFeatures <- fread("data/feature_data/americanFeatures.csv")
#======================================================================================================
# Add Regional To Essen
#--------------------------------------------------
essenFeatures
setnames(essenFeatures,"file.id","folksong")

# Create Country Variable
essenFeatures[, Country := gsub(pattern = "[[:digit:]]",
                                replacement = "",
                                x = essenFeatures$folksong)]

# Get ID variable for Indexing
essenFeatures[, Country.ID := gsub(pattern = "[[:alpha:]]",
                                replacement = "",
                                x = essenFeatures$folksong)]

essenFeatures$Region <- "NA"

# Assign ESAC Subdirectory Names 
deut <- essenFeatures[Country == "deut"]

deut[, Country.ID := as.numeric(Country.ID)]

deut[Country.ID >= 3663  &  Country.ID <= 3772,]$Region <- "allerkbd" 
deut[Country.ID >= 3773  &  Country.ID <= 4081,]$Region <- "altdeu1" 
deut[Country.ID >= 4082  &  Country.ID <= 4397,]$Region <- "altdeu2" 
deut[Country.ID >= 2976  &  Country.ID <= 3662,]$Region <- "ballad " 
deut[Country.ID >= 2272  &  Country.ID <= 2975,]$Region <- "boehme " 
deut[Country.ID >= 4398  &  Country.ID <= 4503,]$Region <- "dva" 
deut[Country.ID >= 567   &  Country.ID <= 1629,]$Region <- "erk1" 
deut[Country.ID >= 1630  &  Country.ID <= 2271,]$Region <- "erk2" 
deut[Country.ID >= 1     &  Country.ID <= 566,]$Region <-  "fink" 
deut[Country.ID >= 5146  &  Country.ID <= 5157,]$Region <- "test" 
deut[Country.ID >= 5120  &  Country.ID <= 5245,]$Region <- "variant" 
deut[Country.ID >= 4504  &  Country.ID <= 5119,]$Region <- "zuccal"

deut[, (.N), by = Region]
deut[, Country.ID := as.character(Country.ID)]

essenFeatures[Country == "deut"] <- deut
essenFeatures[, (.N), by = Region]

#--------------------------------------------------
# Add Region To Densmore 
densmoreFeatures
setnames(densmoreFeatures, "file.id","folksong")

densmoreFeatures[, Country := gsub(pattern = "[[:digit:]]",
                                replacement = "",
                                x = densmoreFeatures$folksong)]
# Is it right to use the tribe names as synonym for country ?!
#======================================================================================================
# Write Files
fwrite(densmoreFeatures,"data/feature_data/densmoreFeatures.csv")
fwrite(essenFeatures, "data/feature_data/essenFeatures.csv")
#======================================================================================================