all_TGTGC<- read.csv("/Users/lijiayi/Desktop/NanoML-5mou/temp_code/all_TGTGC.csv",header=T,sep=',')

p <- all_TGTGC[,-1]
p <- p[,-1]
p <- as.matrix(p)
p <- as.vector(p)
p <- p[1:276780] #13839*20
p1 <- rep(0 , 276780) 
data <- cbind(p,p1)
data <- as.data.frame(data)

m1 <- rep("mean_1",13839)
m2 <- rep("mean_2",13839)
m3 <- rep("mean_3",13839)
m4 <- rep("mean_4",13839)
m5 <- rep("mean_5",13839)
sd1 <- rep("sd1",13839)
sd2 <- rep("sd2",13839)
sd3 <- rep("sd3",13839)
sd4 <- rep("sd4",13839)
sd5 <- rep("sd5",13839)
md1 <- rep("md1",13839)
md2 <- rep("md2",13839)
md3 <- rep("md3",13839)
md4 <- rep("md4",13839)
md5 <- rep("md5",13839)
L1 <- rep("L1",13839)
L2 <- rep("L2",13839)
L3 <- rep("L3",13839)
L4 <- rep("L4",13839)
L5 <- rep("L5",13839)
#d <- cbind(m1,m2,m3,m4,m5,sd1,sd2,sd3,sd4,sd4,md1,md2,md3,md4,md5,L1,L2,L3,L4,L5)
d <- cbind(m1,m2,m3,m4,m5,sd1,sd2,sd3,sd4,sd5,md1,md2,md3,md4,md5,L1,L2,L3,L4,L5)
#data <- data[-c(52661:55293),] # 2*2633*10+1+2632
data <- data[-c(276781:290619),]#2*13839*10+1+13838
d <- as.data.frame(d)
d <- as.matrix(d)
d <- as.vector(d)

d1 <- d

d1 <- as.data.frame(d1)

data$p1 <- d
mod <- rep(all_TGTGC$label,20)
mod1 <- mod
mod1 <- as.data.frame(mod1)

data1 <- cbind(data,mod1)
AGTTC <- write.csv(data1,file  = "TGTGC_prep.csv")
