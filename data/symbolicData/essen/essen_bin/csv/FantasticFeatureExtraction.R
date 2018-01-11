# Do Fantastic on Essen
setwd("~/Desktop/lsu/classes/digitialHumanities/mus7921/corpus/Monody/Essen/All/csv/")
# MAKE SURE FANTASTIC FILES ARE IN YOUR DIRECTORY!
essenFeatures <- compute.features(melody.filenames = list.files(pattern=".csv"),
                                  dir = ".",use.segmentation = FALSE,write.out = TRUE)
#======================================================================================================