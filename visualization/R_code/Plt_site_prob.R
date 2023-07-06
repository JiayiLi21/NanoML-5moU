pAGTTC_mod_prob<- read.csv("jiayi3.csv",header=T,sep=',')
pTGTGC_mod_prob<- read.csv("PSample_TGTGC_mod_prob.csv",header=T,sep=',')
pAGTTC_normal_prob<- read.csv("PSample_AGTTC_normal_prob.csv",header=T,sep=',')
pTGTGC_normal_prob<- read.csv("PSample_TGTGC_normal_prob.csv",header=T,sep=',')



###### plot probability across sites
library(ggpubr)

colors = c('#e8351e',
           '#0f8096',
           '#852f88')
### for mod AGTTC
ggplot(pAGTTC_mod_prob,aes(site,Prob))+
  geom_point(size = 1.5,aes(color = model,fill = model),alpha = 0.5)+
  geom_smooth(aes(color = model,fill = model),linetype = 2,alpha = 0.2)+
  scale_color_manual(values = c('#e8351e',
                                '#0f8096',
                                '#852f88'))+
  scale_y_continuous(limits = c(0,1))+
  theme_bw()+
  theme(panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        panel.border = element_blank(),
        axis.line = element_line(colour = "black",size = 1),
        axis.text.x=element_text(vjust=1, hjust = 1, size = 12, color = "black"),
        axis.text.y = element_text(size = 12, color = "black"),
        axis.title = element_text(size = 15, colour = 'black'))
 
### for mod TGTGC
ggplot(pTGTGC_mod_prob,aes(site,Prob))+
  geom_point(size = 1.5,aes(color = model,fill = model),alpha = 0.5)+
  geom_smooth(aes(color = model,fill = model),linetype = 2,alpha = 0.2)+
  scale_color_manual(values = c('#e8351e',
                                '#0f8096',
                                '#852f88'))+
  scale_y_continuous(limits = c(0.82,1))+
  theme_bw()+
  theme(panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        panel.border = element_blank(),
        axis.line = element_line(colour = "black",size = 1),
        axis.text.x=element_text(vjust=1, hjust = 1, size = 12, color = "black"),
        axis.text.y = element_text(size = 12, color = "black"),
        axis.title = element_text(size = 15, colour = 'black'))


### for normal AGTTC
ggplot(pAGTTC_normal_prob,aes(site,Prob))+
  geom_point(size = 1.5,aes(color = model,fill = model),alpha = 0.5)+
  geom_smooth(aes(color = model,fill = model),linetype = 2,alpha = 0.2)+
  scale_color_manual(values = c('#e8351e',
                                '#0f8096',
                                '#852f88'))+
  scale_y_continuous(limits = c(0,1))+
  theme_bw()+
  theme(panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        panel.border = element_blank(),
        axis.line = element_line(colour = "black",size = 1),
        axis.text.x=element_text(vjust=1, hjust = 1, size = 12, color = "black"),
        axis.text.y = element_text(size = 12, color = "black"),
        axis.title = element_text(size = 15, colour = 'black'))


### for normal TGTGC
ggplot(pTGTGC_normal_prob,aes(site,Prob))+
  geom_point(size = 1.5,aes(color = model,fill = model),alpha = 0.5)+
  geom_smooth(aes(color = model,fill = model),linetype = 2,alpha = 0.2)+
  scale_color_manual(values = c('#e8351e',
                                '#0f8096',
                                '#852f88'))+
  scale_y_continuous(limits = c(0,0.2))+
  theme_bw()+
  theme(panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        panel.border = element_blank(),
        axis.line = element_line(colour = "black",size = 1),
        axis.text.x=element_text(vjust=1, hjust = 1, size = 12, color = "black"),
        axis.text.y = element_text(size = 12, color = "black"),
        axis.title = element_text(size = 15, colour = 'black'))
