###############################################
###General Statistic Test (Two sample test) ###
###############################################
#Last UpData 20201014 HY#######################
###############################################

#Data import
d <- read.csv("Pheno/PhenoDemo_TwoSample_Test.csv",header=TRUE)

##Two-sample test
#Simple test
#Welch's t-test
Welch <- t.test(d$Cont., d$Mg.def., var.equal=F, paird=F, altanative="t")
Welch
Welch$p.value
#Student's t-test
Stud <- t.test(d$Cont., d$Mg.def., var.equal=T, paird=F, altanative="t")
Stud
Stud$p.value






