fm.df <- read.csv("Analysis.csv")               #read file 

fmtrain.df <- subset(fm.df, !is.na(LicenseFee)) #create training dataset
fmtest.df <- subset(fm.df, is.na(LicenseFee))   #create test dataset

fm.1 <- lm(LicenseFee ~ Category, data = fmtrain.df)  #build regression models
fm.2 <- lm(LicenseFee ~ Category + Dominos, data = fmtrain.df)
fm.3 <- lm(LicenseFee ~ Category + CCD, data = fmtrain.df)
fm.4 <- lm(LicenseFee ~ Category + Hero, data = fmtrain.df)
fm.5 <- lm(LicenseFee ~ Category + CCD + Dominos + Hero, data = fmtrain.df)

minmax <- as.data.frame(predict(fm.1, fmtest.df, interval = 'confidence', level = 0.6)) #prepare limit for 60% confidence
df60 <- cbind(fmtest.df$City, minmax)
df60 <- subset(df60, select = c("fmtest.df$City", "upr"))

minmax <- as.data.frame(predict(fm.1, fmtest.df, interval = 'confidence', level = 0.8)) #prepare limit for 80% confidence
df80 <- cbind(fmtest.df$City, minmax)
df80 <- subset(df80, select = c("fmtest.df$City", "upr"))

minmax <- as.data.frame(predict(fm.1, fmtest.df, interval = 'confidence', level = 0.95)) #prepare limit for 95% confidence
df95 <- cbind(fmtest.df$City, minmax)
df95 <- subset(df95, select = c("fmtest.df$City", "upr"))

bizcon.fm5 <- cbind(df60, df80, df95) #return upper limits for specified confidence intervals
write.csv(bizcon.fm5, "bizcon.fm5.csv") #save file





