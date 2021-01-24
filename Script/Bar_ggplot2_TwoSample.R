####################################################
####################################################
#Barplot by ggplot2#################################
####################################################
#Last UpDate 20201014 HY############################
####################################################

#Download packages
install.packages("ggplot2")
install.packages("cowplot")

#load packages
library(ggplot2)
library(cowplot)

#data import
d <- read.csv("Pheno/PhenoDemo.csv",header=TRUE)
d2 <- d[1:6,] 

#Setting of group turn
#d$Light <- factor(d$Light, levels=c("Open","Shading"))
d$Nutrient <- factor(d$Nutrient, levels=c("Cont.","Mg def."))

#Bar graph by ggplot2_cowplotStyle
#setEPS()
#postscript(file ="OutputFig/Barplot_Mg_NL_TwoSample.eps",width=2.5, height=3.0)

pdf(file ="OutputFig/Barplot_Mg_NL_TwoSample.pdf",width=4, height=4)

ggplot(d, aes(y=d$Mg_NL, x=d$Nutrient))+ #Imput Data
  #guides(color=FALSE, fill=FALSE)+ #Label
  stat_summary(fun.y = mean, geom="bar", position="dodge", color="black", size=0.5)+ #Barplot
  geom_point(fill="grey", shape=21, size=2, color="black",position=position_dodge(0.9))+ #Rawdata plot
  stat_summary(fun.ymin = function(x) mean(x) - sd(x), 
               fun.ymax = function(x) mean(x) + sd(x), position =position_dodge(0.9), 
               geom = 'errorbar', size=0.5, width=0.5)+ # Mean cal & Error bar
  theme_cowplot(font_size = 14, line_size = 0.8)+ # cowplot style
  #scale_y_continuous(breaks=seq(0, 6, 1), limits=c(0, 6), expand = c(0,0))+ # Setting of y axis
  theme(axis.text.x = element_text(angle=90, hjust = 1, vjust=0.5))+ # Setting of x axis
  #theme(axis.title.x = element_blank())+ #Not xaxis title
  #theme(axis.title.y = element_blank())+ #Not yaxis title
  scale_x_discrete(limits=c("Cont.","Mg def."))+ #Setting xaxis label
  #scale_fill_manual(values=c("darkorange1", "cyan4"))+ #Setting "fill" color
  #scale_color_manual(values=c("darkorange1", "cyan4"))+ #Setting "color" color
  xlab("Nutrient conditions")+ # xaxis title
  ylab("Mg content (mg/g DW)")+ # yaxis title
  labs(title="Mg content_NL") # Figure title

dev.off()

