# 필요한 모듈(패키지) 로드
install.packages("moments")
library(moments)

setwd("C:/workspaces/multivariate/Study/MultipleLinearRegression_R") # 파일 경로 지

# 성능 평가를 위한 함수 정의
pref_eval_reg <- function(tgt_y, pre_y){
  # RMSE
  rmse <- sqrt(mean((tgt_y - pre_y)^2))
  # MAE
  mae <- sqrt(mean(abs(tgt_y-pre_y)))
  # MAPE
  mape <-  100*mean(abs((tgt_y - pre_y)/tgt_y))
}

# 1. 데이터 로드 및 전처리

# 1-1. 데이터 로드
corolla <- read.csv("ToyotaCorolla.csv") # 데이터 로드
nCar <- nrow(corolla) # 행 갯수 반환
nVar <- nrow(corolla) # 열 갯수 반환

# 1-2. 필요없는 변수 제거
id_idx <-c(1,2)
corrlla_del <- corolla[,-c(id_idx)]

# 1-3. 카테고리형(명목형) 변수를 이진형 변수로 변환

## 각각의 카테고리에 대한 인덱스 가져오기
p_idx <- which(corrlla_del$Fuel_Type == "Petrol")
d_idx <- which(corrlla_del$Fuel_Type == "Diesel")
c_idx <- which(corrlla_del$Fuel_Type == "CNG")

## 인덱스에 해당하면 1, 아니면 0을 가지고 있는 백터 행렬 생성
dummy_p <- rep(0, nCar)
dummy_d <- rep(0, nCar)
dummy_c <- rep(0, nCar)

dummy_p[p_idx] <- 1
dummy_d[d_idx] <- 1
dummy_c[c_idx] <- 1

## 만들어진 벡터를 이용한 데이터 프레임 생성 (이름은 카테고리별로 지정)
Fuel <- data.frame(dummy_p, dummy_d, dummy_c)
names(Fuel) <- c("Petrol","Diesel","CNG")

## 생성한 이진형 데이터프레임을 적용하여 데이터 변경
category_idx <- 6 # 카테고리 변수 인덱스
corolla_mlr_data <- cbind(corrlla_del[,-c(category_idx)], Fuel)

# 2. 학습용 데이터와 검증용 데이터 분할
set.seed(12345) # 학습용 데이터를 일정하게 뽑음
corolla_trn_idx <- sample(1:nCar, round(0.7*nCar)) # 학습용 데이터 인덱스 샘플링
corolla_trn_data <- corolla_mlr_data[corolla_trn_idx,] # 학습용 데이터
corolla_val_data <- corolla_mlr_data[-corolla_trn_idx,] # 검증용 데이터

# 3. 학습용 데이터를 이용한 회귀 분석
mlr_corolla <-lm(Price ~ ., data = corolla_trn_data)
mlr_corolla
summary(mlr_corolla)

# 4. 시각화

# 4-1. 가정을 만족하는지 확인
plot(mlr_corolla)

# 4-2. 실제 데이터와 추정된 값 사이의 관계 확인
plot(corolla_trn_data$Price, fitted(mlr_corolla), 
     xlim = c(4000,35000), ylim = c(4000,35000))
abline(0,1,lty=3) # 선을 그림

# 5. 정규성 판단

# 6. 성능 평가
