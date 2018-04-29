# �ʿ��� ���(��Ű��) �ε�
install.packages("moments")
library(moments)

setwd("C:/workspaces/multivariate/Study/MultipleLinearRegression_R") # ���� ��� ����


# =====���� ���� ȸ�� �м�===== #

# 1. ������ �ε� �� ��ó��

# 1-1. ������ �ε�
corolla <- read.csv("ToyotaCorolla.csv") # ������ �ε�
nCar <- nrow(corolla) # �� ���� ��ȯ
nVar <- nrow(corolla) # �� ���� ��ȯ

# 1-2. �ʿ���� ���� ����
id_idx <-c(1,2)
corrlla_del <- corolla[,-c(id_idx)]

# 1-3. ī�װ�����(������) ������ ������ ������ ��ȯ

## ������ ī�װ����� ���� �ε��� ��������
p_idx <- which(corrlla_del$Fuel_Type == "Petrol")
d_idx <- which(corrlla_del$Fuel_Type == "Diesel")
c_idx <- which(corrlla_del$Fuel_Type == "CNG")

## �ε����� �ش��ϸ� 1, �ƴϸ� 0�� ������ �ִ� ���� ��� ����
dummy_p <- rep(0, nCar)
dummy_d <- rep(0, nCar)
dummy_c <- rep(0, nCar)

dummy_p[p_idx] <- 1
dummy_d[d_idx] <- 1
dummy_c[c_idx] <- 1

## ������� ���͸� �̿��� ������ ������ ���� (�̸��� ī�װ������� ����)
Fuel <- data.frame(dummy_p, dummy_d, dummy_c)
names(Fuel) <- c("Petrol","Diesel","CNG")

## ������ ������ �������������� �����Ͽ� ������ ����
category_idx <- 6 # ī�װ��� ���� �ε���
corolla_mlr_data <- cbind(corrlla_del[,-c(category_idx)], Fuel)

# 2. �н��� �����Ϳ� ������ ������ ����
set.seed(12345) # �н��� �����͸� �����ϰ� ����
corolla_trn_idx <- sample(1:nCar, round(0.7*nCar)) # �н��� ������ �ε��� ���ø�
corolla_trn_data <- corolla_mlr_data[corolla_trn_idx,] # �н��� ������
corolla_val_data <- corolla_mlr_data[-corolla_trn_idx,] # ������ ������

# 3. �н��� �����͸� �̿��� ȸ�� �м�
mlr_corolla <-lm(Price ~ ., data = corolla_trn_data)
mlr_corolla
summary(mlr_corolla)

# 4. �ð�ȭ

# 4-1. ������ �����ϴ��� Ȯ��
plot(mlr_corolla)

# 4-2. ���� �����Ϳ� ������ �� ������ ���� Ȯ��
plot(corolla_trn_data$Price, fitted(mlr_corolla), 
     xlim = c(4000,35000), ylim = c(4000,35000))
abline(0,1,lty=3) # ���� �׸�


# =====���Լ� �Ǵ�===== #

# 1. ������ ���� ��հ� ǥ������ ���
corolla_resid <- resid(mlr_corolla)
m <- mean(corolla_resid)
std <- sqrt(var(corolla_resid))

# 2. moment ��Ű���� �̿��� ���Լ� �Ǵ�
skewness(corolla_resid)
kurtosis(corolla_resid)

# 3. ������ �̿��� ������׷��� Ŀ�� ����
hist(corolla_resid, density=20, breaks=50, prob=TRUE, 
     xlab="x-variable", main="normal curve over histogram")
curve(dnorm(x, mean=m, sd=std), 
      col="darkblue", lwd=2, add=TRUE, yaxt="n")


# =====���� ��===== #

# 1 ���� �򰡸� ���� �Լ� ����
pref_eval_reg <- function(tgt_y, pre_y){
  # RMSE
  rmse <- sqrt(mean((tgt_y - pre_y)^2))
  # MAE
  mae <- mean(abs(tgt_y - pre_y))
  # MAPE
  mape <-  100*mean(abs((tgt_y - pre_y)/tgt_y))
  
  return(c(rmse, mae, mape))
}

# 2. �����򰡿� ���� ������ �ʱ�ȭ
perf_mat <- matrix(0, nrow = 1, ncol = 3)
rownames(perf_mat) <- c("Toyota Corolla")
colnames(perf_mat) <- c("RMSE", "MAE", "MAPE")
perf_mat

# 3. ���� �� ����
mlr_corolla_haty <- predict(mlr_corolla, newdata = corolla_val_data) # ������ �����Ϳ� ���� ������ ����
perf_mat[1,] <- pref_eval_reg(corolla_val_data$Price, mlr_corolla_haty) # ������ �����Ϳ� ������ �����Ϳ� ���� ���� ��
perf_mat