#############################################
###General Statistic Test (Multiple test) ###
#############################################
#Last UpData 20201014 HY#####################
#############################################

#Download packages
install.packages("multcomp")

#Load library
library(multcomp)

#Data import
d <- read.csv("Pheno/PhenoDemo.csv",header=TRUE)

##Multiple Comparison
#One or two-way ANOVA
df <- data.frame(y=d$Mg_NL,A=d$Nutrient, B=d$Light) #y=values, A.B=Factors
twANOVA <- aov(y~A*B, data=df) #One factor=y~A, Two factor=y~A*B
summary(twANOVA) 
attach(df)
interaction.plot(A,B,y)

#Tukey
df <- data.frame(S=d$Group,D=d$Mg_NL) #Select Pheno
df$S = as.factor(df$S)
res1 <- aov(D~S, data=df) #ANOVA
summary(res1)  #Summary of ANOVA test
res2 <- glht(res1, linfct=mcp(S="Tukey")) #Tukey's HSD test
summary(res2) #Summary of Tukey's HSD test
cld(res2, level=0.05, decreasing=T) #Alphabet, Set of threshold P level
boxp_res2 <- cld(res2, level=0.05, decreasing=F) 
plot(boxp_res2)

#Dunnet
df <- data.frame(S=d$Group,D=d$Mg_NL) #Select Pheno
df$S = as.factor(df$S)
res1 <- aov(D~S, data=df)  #ANOVA
summary(res1) 
res2 <- glht(res1, linfct=mcp(S="Dunnett")) #Dunnett test
summary(res2) 

##Two-sample test
#Simple test
#Data arrangement
d2 <- d[1:6,]
d2t <- as.data.frame(t(d2))
d2t_Pheno <- d2t[4:length(d),]
colnames (d2t_Pheno) <- c(d2t[1,])

#Dara arrangement for t-test
a <- d2t_Pheno[1,1:3] # Number of replicate (n)
a <- t(a)
a <- as.numeric(a)
b <- d2t_Pheno[1,4:6] # Number of replicate (n)
b <- t(b) 
b <- as.numeric(b)
df <- cbind.data.frame(a,b)
colnames(df) <- c("a","b")
#Welch's t-test
Welch <- t.test(df$a, df$b, var.equal=F, paird=F, altanative="t")
Welch
Welch$p.value
#Student's t-test
Stud <- t.test(df$a, df$b, var.equal=T, paird=F, altanative="t")
Stud
Stud$p.value


##Repeat test & Multiple comparison correction
#Prepare empty vector
Pvalue <- rep(NA, nrow(d2t_Pheno))
FDR <- rep(NA, nrow(d2t_Pheno))

####################################################################################
#Calculation Pvalue by Welch & FDR 
for (i in 1:nrow(d2t_Pheno)){
  print(i)
  a <- d2t_Pheno[i,1:3] # Number of replicate (n)
  a <- t(a)
  a <- as.numeric(a)
  b <- d2t_Pheno[i,4:6] # Number of replicate (n)
  b <- t(b) 
  b <- as.numeric(b)
  df <- cbind.data.frame(a,b)
  colnames(df) <- c("a","b")
  
  #Welch's t-test (parametric test)
  Welch <- t.test(df$a, df$b, var.equal=F, paird=F, altanative="t")
  Pvalue[i] <- Welch$p.value
}
#FDR
FDR <- p.adjust(Pvalue, "fdr")
#DataMatrix.bind
Mat <- cbind.data.frame(Pvalue,FDR)
rownames(Mat) <- c(rownames(d2t_Pheno))

#Output  
write.csv(Mat,"Stat/Welch_FDR.csv", row.names = TRUE)
####################################################################################



