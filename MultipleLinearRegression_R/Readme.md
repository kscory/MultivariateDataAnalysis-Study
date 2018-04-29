# R - Multiple Linear Regression
  - Multiple Linear Regression with R

---

## 공통 부분
  ### 1. 모듈 설치 및 라이브러리 사용
  - `moments` : Moments, cumulants, skewness, kurtosis 등에 관한 것을 계산하기 위한 패키지 (정규분포 확인시 사용할 것)
    - `skewness` : 중심이 왼쪽에 있는지 오른쪽에 있는지 가운데 있는지 확인 (정확한 정규분포는 0)
    - `kurtosis` : 뾰족함의 정도 확인 (정확한 정규분포는 3)

  ```bash
  install.packages("moments")
  library(moments)
  ```

  ### 2. 성능평가를 위한 함수 생성
  - RMSE, MAE, MAPE 를 만들어주는 함수 생성
  - `tgt_y` 은 정답벡터, `pre_y` 는 추정된 값을 넣어서 확인

  ```python
  perf_eval_reg <- function(tgt_y, pre_y){
    # RMSE
    rmse <- sqrt(mean((tgt_y - pre_y)^2))
    # MAE
    mae <- mean(abs(tgt_y - pre_y))
    # MAPE
    mape <- 100*mean(abs((tgt_y - pre_y)/tgt_y))
    return(c(rmse, mae, mape))
  }
  ```

---

## Multiple Linear Regression - Toyota Corolla : 중고차 가격 예측
  ### 1. 데이터 로드 및 전처리
  - 데이터 로드 및, 행/열 갯수 확인

  ```python
  corolla <- read.csv("ToyotaCorolla.csv") # 데이터 로드
  nCar <- nrow(corolla) # 행의 개수를 반환
  nVal <- ncol(corolla) # 열의 갯수를 반환
  ```

  - 분석에 필요 없는 변수 제거
    - id 와 모델명

  ```python
  # 필요없는 변수 제거
  id_idx <-c(1,2)
  corrlla_del <- corolla[-c(id_idx)]
  ```

  - 카테고리형(명목형) 변수를 이진형 변수로 변환(I-of-C coding process)
    - 카테고리가 3개로 나눠져 있으므로 3가지의 이진형 변수를 만들어 변형시켜 준다.
    - `rep(a,b)` : a를 b번 반복해서 벡터 생성
    - `cbind` : column 에 데이터를 붙인다.

  ```python
  # 각각의 카테고리에 대한 인덱스 가져오기
  p_idx <- which(corrlla_del$Fuel_Type == "Petrol")
  d_idx <- which(corrlla_del$Fuel_Type == "Diesel")
  c_idx <- which(corrlla_del$Fuel_Type == "CNG")

  # 인덱스에 해당하면 1, 아니면 0을 가지고 있는 백터 행렬 생성
  dummy_p <- rep(0, nCar)
  dummy_d <- rep(0, nCar)
  dummy_c <- rep(0, nCar)

  dummy_p[p_idx] <- 1
  dummy_d[p_idx] <- 1
  dummy_c[p_idx] <- 1

  # 만들어진 벡터를 이용한 데이터 프레임 생성
  Fuel <- data.frame(dummy_p, dummy_d, dummy_c)
  names(Fuel) <- c("Petrol","Diesel","CNG")

  # 생성한 이진형 데이터프레임을 적용하여 데이터 변경
  category_idx <- 6 # 카테고리 변수 인덱스
  corolla_mlr_data <- cbind(corrlla_del[,-c(category_idx)], Fuel)
  ```

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/MultipleLinearRegression_R/picture/dataprocess.png)

  ### 2. 학습용 데이터와 검증용 데이터 분할
  - ㅇㅇ

  ### 3. 학습용 데이터를 이용한 회귀 분석
  - ㅇㅇ

  ### 4. 시각화 및 결과 해석
  - ㅇㅇ

  ### 5. 정규성 판단
  - ㅇㅇ

  ### 6. 성능 평가
  - ㅇㅇ
