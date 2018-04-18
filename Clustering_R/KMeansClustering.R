# Package for cluster validity
install.packages("clValid")
install.packages("plotrix")

library(clValid)
library(plotrix)

# Load the Wine dataset
wine <- read.csv("wine.csv") # class 가 와인의 품종

# Remove the class label # 와인에 대한 설명만 쓸 것이므로 class 제거
wine_class <- wine[,1] 
wine_x <- wine[,-1]

# data scaling # distance를 계산할 때는 정규화(scaling) 작업을 하여 평균을 0으로, 표준편차를 1로 해야 각 변수를 동등하게 취급할 수 있게 된다.
wine_x_scaled <- scale(wine_x, center = TRUE, scale = TRUE)

# Evaluating the cluster validity measures # 어떤 군집을 사용하는 것이 좋은지 판단해준다. 
wine_clValid <- clValid(wine_x_scaled, 2:10, clMethods = "kmeans",
                           validation = c("internal", "stability"))
summary(wine_clValid)

# Perform K-Means Clustering with the best K determined by Silhouette
wine_kmc <- kmeans(wine_x_scaled,3) # 따라서 kmeans 에 숫자가 3이 들어감

str(wine_kmc)
wine_kmc$centers
wine_kmc$size
wine_kmc$cluster

# Compare the cluster info. and class labels (정답정보랑, 군집화 정보랑 비교해보자.)
real_class <- wine_class
kmc_cluster <- wine_kmc$cluster
table(real_class, kmc_cluster)

# Compare each cluster for KMC
cluster_kmc <- data.frame(wine_x_scaled, clusterID = as.factor(wine_kmc$cluster))
kmc_summary <- data.frame() # 데이터셋 초기호

## 1번 변수부터 13번까지의 변수 중에서 row를 바인딩하여 (위아래로 붙이화겠다) 클러스터별로 만들겠다.
for (i in 1:(ncol(cluster_kmc)-1)){
  kmc_summary = rbind(kmc_summary, 
                     tapply(cluster_kmc[,i], cluster_kmc$clusterID, mean))
}

colnames(kmc_summary) <- paste("cluster", c(1:3))
rownames(kmc_summary) <- colnames(wine_x)
kmc_summary

# Radar chart
for (i in 1:3){
  plot_title <- paste("Radar Chart for Cluster", i, sep=" ") # 이름을 설정
  radial.plot(kmc_summary[,i], labels = rownames(kmc_summary), # 변수값, 변수 설정
              radial.lim=c(-2,2), rp.type = "p", main = plot_title, #범위, 타입, 타이틀
              line.col = "red", lwd = 3, show.grid.labels=1) #색, 두께, 레이블1 로
}
dev.off()

# Compare the first and the second cluster
kmc_cluster1 <- wine_x[wine_kmc$cluster == 1,]
kmc_cluster2 <- wine_x[wine_kmc$cluster == 2,]

# t_test_result
kmc_t_result <- data.frame()

for (i in 1:13){
  
  kmc_t_result[i,1] <- t.test(kmc_cluster1[,i], kmc_cluster2[,i], 
                              alternative = "two.sided")$p.value  # 양측검정 pvalue
  
  kmc_t_result[i,2] <- t.test(kmc_cluster1[,i], kmc_cluster2[,i], 
                              alternative = "greater")$p.value  # 1번이 더 크다는 것에 대한 pvalue
  
  kmc_t_result[i,3] <- t.test(kmc_cluster1[,i], kmc_cluster2[,i], 
                              alternative = "less")$p.value   # 1번이 더 작다는 것에 대한 pvalue
}

kmc_t_result