jiayi2$model <- as.factor(jiayi2$model)
p <-  ggplot(jiayi2, aes(y=AUC, x=model, color = model,label=motif),fill = "transparent") + 
  geom_text(size = 1.7, color = "black")+
  geom_point(size = 1, alpha = 0.2)+
  geom_boxplot()+
  theme_bw()

p
