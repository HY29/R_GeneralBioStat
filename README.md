# R_GeneralBioStat

## 生物統計で頻繁に利用される統計検定のRを用いた処理

「Pheno」ディレクトリ内のデータ型を用いて可視化と統計検定が可能

### データの可視化
ggplot2パッケージを用いて、
棒グラフによる平均値とエラーバーの記述、および生データをプロットすることでデータの分布を可視化する．

### 統計検定
2標本検定　Welch's t-test
分散分析 (One-way) ANOVA, Two-way ANOVA
多重補正　FDR etc.
多重検定　Tukey's HSD test, Dunnett's test
Tukey's検定では、処理区間の違いをアルファベットの違いで出力

