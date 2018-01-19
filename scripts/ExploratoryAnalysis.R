#======================================================================================================
# Exploratory Analysis of Folk Song Datasets
#======================================================================================================
# Libraries
library(data.table)
library(ggplot2)
library(psych)
#======================================================================================================
# Get Feature Data
densmore <- fread("data/feature_data/densmoreFeatures.csv")
essen <- fread("data/feature_data/essenFeatures.csv")

#--------------------------------------------------
# Write Function for Exploring new features of desnmore that would be good for classification

ggplot(densmore, aes(x = mean.entropy, y = tonal.clarity, color = Country)) + geom_point()

#--------------------------------------------------

# Remove Categorical Varibles created by Fantastic
get.FANTASTIC.numeric <- function(x){
  
  # Write all columns to object 
  y <- x[, .(mean.entropy, mean.productivity,mean.Simpsons.D,mean.Yules.K,mean.Sichels.S,
    mean.Honores.H,p.range,p.entropy,p.std,i.abs.range,i.abs.mean,
    i.abs.std,i.mode,i.entropy,d.range,d.median,d.mode,
    d.entropy,d.eq.trans,d.half.trans,d.dotted.trans,len,glob.duration,
    note.dens,tonalness,tonal.clarity,tonal.spike,int.cont.grad.mean,int.cont.grad.std,
    int.cont.dir.change,step.cont.glob.var,step.cont.glob.dir,step.cont.loc.var)]

  # Write to Global Environment 
  assign(paste0(deparse(substitute(x)),".numeric"), y, envir = .GlobalEnv)
  
}
                                 
get.FANTASTIC.numeric(densmore)
get.FANTASTIC.numeric(essen)

#--------------------------------------------------
# Begin the Search for collinearity 

KMO(densmore.numeric)

densmore.all.item <- fa(densmore.numeric, nfactors = ncol(densmore.numeric), rotate = "none")
plot(densmore.all.item$values, 
     main = "Eigen Values for All Item Model for Densmore Collection",
     xlab = "Number of Factors",
     ylab = "Eigen Values")
fa.parallel(densmore.numeric)
# Parallel analysis says 9

densmore.nine.factor <- fa(densmore.numeric, nfactors = 7, rotate = "none")
# Error City 

#--------------------------------------------------

