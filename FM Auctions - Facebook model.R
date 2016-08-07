fm.df <- read.csv("fb data.csv")               #read file 

fmtrain.df <- subset(fm.df, !is.na(LicenseFee)) #create training dataset
fmtest.df <- subset(fm.df, is.na(LicenseFee))   #create test dataset

fm.fb <- lm(LicenseFee.lakhs. ~ FB.reach..20.mile., data = fmtrain.df) #build facebook regression model

minmax <- as.data.frame(predict(fm.fb, fmtest.df, interval = 'confidence', level = 0.6)) #prepare limit for 60% confidence
df60 <- cbind(fmtest.df$City, minmax)
df60 <- subset(df60, select = c("fmtest.df$City", "upr"))

minmax <- as.data.frame(predict(fm.fb, fmtest.df, interval = 'confidence', level = 0.8)) #prepare limit for 80% confidence
df80 <- cbind(fmtest.df$City, minmax)
df80 <- subset(df80, select = c("fmtest.df$City", "upr"))

minmax <- as.data.frame(predict(fm.fb, fmtest.df, interval = 'confidence', level = 0.95)) #prepare limit for 95% confidence
df95 <- cbind(fmtest.df$City, minmax)
df95 <- subset(df95, select = c("fmtest.df$City", "upr"))

upperbids.fm <- cbind(df60, df80, df95) #return upper limits for specified confidence intervals
write.csv(upperbids.fm, "upperbids.fm.csv")




