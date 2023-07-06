library(colorspace)
library(ggplot2)
motif_count$label <- as.factor(motif_count$label)
plot(motif_count)
library(ggthemes)
scale_color_tableau()


ggplot(motif_count, aes(x=kmer, fill = label, y=Motif_Count))+geom_bar(aes(x=kmer ,y = coverage ,fill = label),
                              stat = 'identity',
                              position = position_dodge(1),width = 1)+
  theme_bw()+
  theme(axis.text.x = element_text(angle = 30, hjust = 1, vjust = 1,size = 6))+
  scale_fill_brewer(palette = "BuGn")

p2=ggplot(data=data)+geom_bar(aes(x=x,y=y,fill=z),
                              stat = 'summary',fun=median
                              ,position = position_dodge(0.5),width = 0.4)

p3=ggplot(data=data)+geom_bar(aes(x=x,y=y,fill=z),
                              stat = 'summary',fun=mean
                              ,position = position_dodge(0.5),width = 0.4)
ggarrange(p1,p2,p3,ncol = 3)