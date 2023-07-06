data<- read.csv("/Users/lijiayi/Desktop/NanoML-5mou/temp_code/TGTGC_prep.csv",header=T,sep=',')

install.packages("ggstatsplot")
install.packages("rstantools")
install.packages("afex")

# install.packages("rlang")

library(ggstatsplot)



data.m1 <-data[data$feature == 'mean_1',]
data$label <- as.factor(data$label)

m1p <- ggbetweenstats(data = data.m1,x = `label`, y = `value`,type = "nonparametric",ylab='mean_1')
m1p



data.m2 <-data[data$feature == 'mean_2',]
m2p <- ggbetweenstats(data = data.m2,x = `label`, y = `value`,type = "nonparametric",ylab = 'mean_2')
m2p


data.m3 <-data[data$feature == 'mean_3',]
m3p <- ggbetweenstats(data = data.m3,x = `label`, y = `value`,type = "nonparametric",ylab = 'mean_3')
m3p


data.m4 <-data[data$feature == 'mean_4',]
m4p <- ggbetweenstats(data = data.m4,x = `label`, y = `value`,type = "nonparametric",ylab = 'mean_4')
m4p



data.m5 <-data[data$feature == 'mean_5',]
m5p <- ggbetweenstats(data = data.m5,x = `label`, y = `value`,type = "nonparametric",ylab = 'mean_5')
m5p

#library(ggpubr)
#g.p <- ggarrange(m1p,m2p,m3p,m4p,m5p)
#g.p

### for sd
data.sd1 <-data[data$feature == 'sd1',]
sd1p <- ggbetweenstats(data = data.sd1,x = `label`, y = `value`,type = "nonparametric",ylab='sd_1')
sd1p


data.sd2 <-data[data$feature == 'sd2',]
sd2p <- ggbetweenstats(data = data.sd2,x = `label`, y = `value`,type = "nonparametric",ylab='sd_2')
sd2p

data.sd3 <-data[data$feature == 'sd3',]
sd3p <- ggbetweenstats(data = data.sd3,x = `label`, y = `value`,type = "nonparametric",ylab='sd_3')
sd3p


data.sd4 <-data[data$feature == 'sd4',]
sd4p <- ggbetweenstats(data = data.sd4,x = `label`, y = `value`,type = "nonparametric",ylab='sd_4')
sd4p


data.sd5 <-data[data$feature == 'sd5',]
sd5p <- ggbetweenstats(data = data.sd5,x = `label`, y = `value`,type = "nonparametric",ylab='sd_5')
sd5p

### for md
data.md1 <-data[data$feature == 'md1',]
md1p <- ggbetweenstats(data = data.md1,x = `label`, y = `value`,type = "nonparametric",ylab='mdintense_1')
md1p

data.md2 <-data[data$feature == 'md2',]
md2p <- ggbetweenstats(data = data.md2,x = `label`, y = `value`,type = "nonparametric",ylab='mdintense_2')
md2p


data.md3 <-data[data$feature == 'md3',]
md3p <- ggbetweenstats(data = data.md3,x = `label`, y = `value`,type = "nonparametric",ylab='mdintense_3')
md3p


data.md4 <-data[data$feature == 'md4',]
md4p <- ggbetweenstats(data = data.md4,x = `label`, y = `value`,type = "nonparametric",ylab='mdintense_4')
md4p


data.md5 <-data[data$feature == 'md5',]
md5p <- ggbetweenstats(data = data.md5,x = `label`, y = `value`,type = "nonparametric",ylab='mdintense_5')
md5p



### for length (L)
data.L1 <-data[data$feature == 'L1',]
L1p <- ggbetweenstats(data = data.L1,x = `label`, y = `value`,type = "nonparametric",ylab='length_1')
L1p

data.L2 <-data[data$feature == 'L2',]
L2p <- ggbetweenstats(data = data.L2,x = `label`, y = `value`,type = "nonparametric",ylab='length_2')
L2p

data.L3 <-data[data$feature == 'L3',]
L3p <- ggbetweenstats(data = data.L3,x = `label`, y = `value`,type = "nonparametric",ylab='length_3')
L3p

data.L4 <-data[data$feature == 'L4',]
L4p <- ggbetweenstats(data = data.L4,x = `label`, y = `value`,type = "nonparametric",ylab='length_4')
L4p

data.L5 <-data[data$feature == 'L5',]
L5p <- ggbetweenstats(data = data.L5,x = `label`, y = `value`,type = "nonparametric",ylab='length_5')
L5p
