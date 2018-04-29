# 데이터 로드
boston_housing <- read.csv("BostonHousing.csv")

nHome <- nrow(boston_housing)
nVar <- ncol(boston_housing)

# Split the data into the training/validation sets
boston_trn_idx <- sample(1:nHome, round(0.7*nHome))
boston_trn_data <- boston_housing[boston_trn_idx,]   ## 학습용
boston_val_data <- boston_housing[-boston_trn_idx,]  ## 검증

# Train the MLR
mlr_boston <- lm(MEDV ~ ., data = boston_trn_data)
mlr_boston
summary(mlr_boston) 

plot(mlr_boston)


# Plot the result
plot(boston_trn_data$MEDV, fitted(mlr_boston), 
     xlim = c(-5,50), ylim = c(-5,50))
abline(0,1,lty=3)

plot(fitted(mlr_boston), resid(mlr_boston), 
     xlab="Fitted values", ylab="Residuals")

# normality test of residuals
boston_resid <- resid(mlr_boston)

m <- mean(boston_resid)
std <- sqrt(var(boston_resid))

hist(boston_resid, density=20, breaks=50, prob=TRUE, 
     xlab="x-variable", main="normal curve over histogram")

curve(dnorm(x, mean=m, sd=std), 
      col="darkblue", lwd=2, add=TRUE, yaxt="n")

skewness(boston_resid)
kurtosis(boston_resid)

# Performance Measure
pref_eval_reg <- function(tgt_y, pre_y){
  # RMSE
  rmse <- sqrt(mean((tgt_y - pre_y)^2))
  # MAE
  mae <- mean(abs(tgt_y - pre_y))
  # MAPE
  mape <-  100*mean(abs((tgt_y - pre_y)/tgt_y))
  
  return(c(rmse, mae, mape))
}

perf_mat <- matrix(0, nrow = 1, ncol = 3)
rownames(perf_mat) <- c("Boston Housing")
colnames(perf_mat) <- c("RMSE", "MAE", "MAPE")
perf_mat

mlr_boston_haty <- predict(mlr_boston, newdata = boston_val_data)

perf_mat[1,] <- pref_eval_reg(boston_val_data$MEDV, mlr_boston_haty)
perf_mat
