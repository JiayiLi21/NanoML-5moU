
all_AGTTC<- read.csv("/Users/lijiayi/Desktop/NanoML-5mou/temp_code/all_AGTTC.csv",header=T,sep=',')

p <- all_AGTTC[,-1]
p <- p[,-1]
p <- as.matrix(p)
p <- as.vector(p)
p <- p[1:52660]
p1 <- rep(0 , 52660)
data <- cbind(p,p1)
data <- as.data.frame(data)

m1 <- rep("mean_1",2633)
m2 <- rep("mean_2",2633)
m3 <- rep("mean_3",2633)
m4 <- rep("mean_4",2633)
m5 <- rep("mean_5",2633)
sd1 <- rep("sd1",2633)
sd2 <- rep("sd2",2633)
sd3 <- rep("sd3",2633)
sd4 <- rep("sd4",2633)
sd5 <- rep("sd5",2633)
md1 <- rep("md1",2633)
md2 <- rep("md2",2633)
md3 <- rep("md3",2633)
md4 <- rep("md4",2633)
md5 <- rep("md5",2633)
L1 <- rep("L1",2633)
L2 <- rep("L2",2633)
L3 <- rep("L3",2633)
L4 <- rep("L4",2633)
L5 <- rep("L5",2633)
#d <- cbind(m1,m2,m3,m4,m5,sd1,sd2,sd3,sd4,sd4,md1,md2,md3,md4,md5,L1,L2,L3,L4,L5)
d <- cbind(m1,m2,m3,m4,m5,sd1,sd2,sd3,sd4,sd5,md1,md2,md3,md4,md5,L1,L2,L3,L4,L5)
data <- data[-c(52661:55293),] # 2*2633*10+2632
d <- as.data.frame(d)
d <- as.matrix(d)
d <- as.vector(d)

d1 <- d

d1 <- as.data.frame(d1)

data$p1 <- d
mod <- rep(all_AGTTC$label,20)
mod1 <- mod
mod1 <- as.data.frame(mod1)

data1 <- cbind(data,mod1)
AGTTC <- write.csv(data1,file  = "AGTTC.csv")
