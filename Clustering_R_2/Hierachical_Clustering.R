# Package for cluster validity
install.packages("clValid")

library(clValid)

# data load
ploan <- read.csv("Personal Loan.csv")
ploan_x <- ploan[,-c(1,5,10)]
ploan_x_scaled <- scale(ploan_x, center = TRUE, scale = TRUE)

# Compute the similarity using the spearman coefficient
cor_Mat <- cor(t(ploan_x_scaled), method = "spearman")
dist_ploan <- as.dist(1-cor_Mat) 

# Perform hierarchical clustering
hr <- hclust(dist_ploan, method = "complete", members=NULL)

# plot the results
plot(hr)  
plot(hr, hang = -1)
plot(as.dendrogram(hr), edgePar=list(col=3, lwd=4), horiz=T)

# Evaluating the cluster validity measures
ploan_clValid <- clValid(ploan_x_scaled, 2:15, clMethods = "hierarchical", method = "complete",
                        validation = c("internal", "stability"), maxitems=nrow(ploan_x_scaled))
summary(ploan_clValid)

# Make the clusters
mycl <- cutree(hr, k=10) ## 총 10개의 군집으로 나눠라 하는 것
mycl

plot(hr)
rect.hclust(hr, k=10, border="red") ## 군집을 빨간색 선으로 나눔


# Compare each cluster for HC
ploan_hc <- data.frame(ploan_x_scaled, ploanYN = ploan[,10], 
                         clusterID = as.factor(mycl))
hc_summary <- data.frame()

for (i in 1:(ncol(ploan_hc)-1)){
  hc_summary = rbind(hc_summary, 
                     tapply(ploan_hc[,i], ploan_hc$clusterID, mean))
}

colnames(hc_summary) <- paste("cluster", c(1:10))
rownames(hc_summary) <- c(colnames(ploan_x), "LoanRatio")

# Radar chart
par(mfrow = c(2,5))
for (i in 1:10){
  plot_title <- paste("Radar Chart for Cluster", i, sep=" ")
  radial.plot(hc_summary[,i], labels = rownames(hc_summary), 
              radial.lim=c(-2,2), rp.type = "p", main = plot_title, 
              line.col = "red", lwd = 3, show.grid.labels=1)
}
dev.off()

# Compare the cluster 7 & 8
hc_cluster7 <- ploan_hc[ploan_hc$clusterID == 7, c(1:11)]
hc_cluster8 <- ploan_hc[ploan_hc$clusterID == 8, c(1:11)]

# t_test_result
hc_t_result <- data.frame()

for (i in 1:11){
  
  hc_t_result[i,1] <- t.test(hc_cluster7[,i], hc_cluster8[,i], 
                              alternative = "two.sided")$p.value
  
  hc_t_result[i,2] <- t.test(hc_cluster7[,i], hc_cluster8[,i], 
                              alternative = "greater")$p.value
  
  hc_t_result[i,3] <- t.test(hc_cluster7[,i], hc_cluster8[,i], 
                              alternative = "less")$p.value
}

hc_t_result