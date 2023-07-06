jiayi2$model <- as.factor(jiayi2$model)
p <-  ggplot(jiayi2, aes(y=AUC, x=model, color = model,label=motif),fill = "transparent") + 
  geom_text(size = 1.7, color = "black")+
  geom_point(size = 1, alpha = 0.2)+
  geom_boxplot()+
  theme_bw()

p

#作图

library(ggpubr)

colors = c('#e8351e',
           '#0f8096',
           '#852f88')

ggplot(jiayi3,aes(site,Prob))+
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
