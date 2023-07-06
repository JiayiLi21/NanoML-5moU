pAGTTC_mod_prob<- read.csv("jiayi3.csv",header=T,sep=',')
pTGTGC_mod_prob<- read.csv("PSample_TGTGC_mod_prob.csv",header=T,sep=',')
pAGTTC_normal_prob<- read.csv("PSample_AGTTC_normal_prob.csv",header=T,sep=',')
pTGTGC_normal_prob<- read.csv("PSample_TGTGC_normal_prob.csv",header=T,sep=',')





# https://blog.csdn.net/Yif18/article/details/118301906?utm_medium=distribute.pc_relevant.none-task-blog-2~default~baidujs_baidulandingword~default-1-118301906-blog-117127542.235^v38^pc_relevant_anti_vip_base&spm=1001.2101.3001.4242.2&utm_relevant_index=4

p1 <- ggplot(data = pAGTTC_mod_prob , aes(x = model, y = Prob, color = model))+
  geom_boxplot(size = 0.8, width = 0.8, alpha = 0)+   #设置箱线尺寸、箱形宽度、异常点透明度
  geom_jitter(position = position_jitter(0.3), alpha = 0.2, size=1)+   #设置数据点的分散程度、透明度、尺寸
  labs(title = "AGTTC results-5moU modification probability with modified reads as ground truth ")   #添加图形标题
p1


p2 <- ggplot(data = pTGTGC_mod_prob , aes(x = model, y = Prob, color = model))+
  geom_boxplot(size = 0.8, width = 0.8, alpha = 0)+   #设置箱线尺寸、箱形宽度、异常点透明度
  geom_jitter(position = position_jitter(0.3), alpha = 0.2, size=1)+   #设置数据点的分散程度、透明度、尺寸
  labs(title = "TGTGC results-5moU modification probability with modified reads as ground truth ")   #添加图形标题
p2


p3 <- ggplot(data = pAGTTC_normal_prob , aes(x = model, y = Prob, color = model))+
  geom_boxplot(size = 0.8, width = 0.8, alpha = 0)+   #设置箱线尺寸、箱形宽度、异常点透明度
  geom_jitter(position = position_jitter(0.3), alpha = 0.2, size=1)+   #设置数据点的分散程度、透明度、尺寸
  labs(title = "AGTTC results-5moU modification probability with normal reads as ground truth ")   #添加图形标题
p3


p4 <- ggplot(data = pTGTGC_normal_prob , aes(x = model, y = Prob, color = model))+
  geom_boxplot(size = 0.8, width = 0.8, alpha = 0)+   #设置箱线尺寸、箱形宽度、异常点透明度
  geom_jitter(position = position_jitter(0.3), alpha = 0.2, size=1)+   #设置数据点的分散程度、透明度、尺寸
  labs(title = "TGTGC results-5moU modification probability with normal reads as ground truth ")   #添加图形标题
p4
