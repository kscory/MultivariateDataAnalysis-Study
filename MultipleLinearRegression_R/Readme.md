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
  corrlla_del <- corolla[,-c(id_idx)]
  ```

  - 카테고리형(명목형) 변수를 이진형 변수로 변환(I-of-C coding process)
    - 카테고리가 3개로 나눠져 있으므로 3가지의 이진형 변수를 만들어 변형시켜 준다.
    - `rep(a,b)` : a를 b번 반복해서 벡터 생성
    - `cbind` : column 에 데이터를 붙인다.

  ```bash
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
  - 70% 의 학습용 데이터, 30% 의 검증용 데이터로 분할한다.
    - `seed(value)` : 어느 pc에서든 난수가 동일하게 나오도록 수정 가능 (실제로는 사용하지 않는다.)
    - `sample` : 데이터를 랜덤으로 샘플링 한다. (위에서 seed 생성시 정해진 변수를 샘플링)

  ```bash
  set.seed(12345) # 학습용 데이터를 일정하게 뽑음
  corolla_trn_idx <- sample(1:nCar, round(0.7*nCar)) # 학습용 데이터 인덱스 샘플링
  corolla_trn_data <- corolla_mlr_data[corolla_trn_idx,] # 학습용 데이터
  corolla_val_data <- corolla_mlr_data[-corolla_trn_idx,] # 검증용 데이터
  ```

  ### 3. 학습용 데이터를 이용한 회귀 분석
  - `lm((종속변수) ~ (설명변수), data)` : linear module의 약자로 Formula 형태
    - ex 1> `lm(y ~ x1 + x2, data=sample)` : y를 종속변수, x1, x2 를 설명변수
    - ex 2> `lm(formula = y ~ I(x1 + x2), data=sample)` : y 를 종속변수, (x1+x2) 를 설명변수,
    - ex 3> `lm(formula = y ~ ., data=sample)` : y 를 종속변수, y를 제외하고 다른 모든 변수는 설명변수,

  ```bash
  mlr_corolla <-lm(Price ~ ., data = corolla_trn_data) # Price 를 제외한 다른 모든 변수를 설명변수로 설정
  mlr_corolla
  summary(mlr_corolla)
  ```

  ### 4. 결과(summary) 해석
  - `Pr(>|t|)` : p-value 값
    - `*` : 하나 이상 있는 것들이 통계적으로 유의수준에서 중요한 변수(유의미한 변수) 라는 의미
  - `NA` : 설명 변수중에 다른 변수랑 상관관계가 있는 변수
    - 중복된 변수라 판단할 수 있으므로 사용하지 않는다는 것을 의미
    - ex1 > `CNG = 1-Petrol-Diesel`
    - ex2 > `Mfg_Year Age랑 비례`
  - `Estimate` : 회귀 계수의 값
    - `+` 인 경우 양의 비례 관계, `-` 인 경우 음의 비례 관계
    - 1 만큼 증가함에 따라 종속변수가 변하는 량
    - ex> 마력(HP)의 경우 1이 증가할때마다 20(유로)가 증가
  - `Adjusted R-squared` : 회귀식의 선형성
    - 이 데이터의 경우 90% 의 선형성을 띈다. (즉, 이 데이터는 높은 선형성을 지니고 있다.)

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/MultipleLinearRegression_R/picture/lm.png)

  ### 4. 시각화 및 결과 분석
  - ㅇㅇ

  ### 5. 정규성 판단
  - ㅇㅇ

  ### 6. 성능 평가
  - ㅇㅇ
