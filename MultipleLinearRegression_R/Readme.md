# R - Multiple Linear Regression
  - Toyota Corolla : 중고차 가격 예측에 대한 회귀분석

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
---

## Multiple Linear Regression
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
    - ex> 마력(HP)의 경우 1이 증가할때마다 20 만큼 증가
  - `Std.Error` : 추정된 회귀 계수의 표준편차
  - `t-value` : 해당 변수의 유의미함에 대한 통계량
  - `Adjusted R-squared` : 회귀식의 선형성
    - 이 데이터의 경우 90% 의 선형성을 띈다. (즉, 이 데이터는 __높은 선형성__ 을 지니고 있다.)

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/MultipleLinearRegression_R/picture/lm.png)

  ### 5. 시각화 및 결과 분석
  - `그림 1` : 추정된 값과 잔차 사이의 관계
    - 추정된 값과 잔차는 상관관계가 없어야 한다. (특정한 trend 가 존재하지 않아야 한다.)
    - 아래 그림에서 종속변수 Y에 대한 잔차는 설명 변수 값의 범위에 관계없이 일정하므로 __가정을 만족__ 한다고 생각할 수 있다.
  - `그림 2` : QQ-plot
    - 선형성을 띄다가 점점 틀어지는 것을 볼 수 있다.
    - 이것이 언제 틀어지냐에 따라 정규분포를 따르는 지 알 수 있다. (99%를 만족하려면  `+- 1.96` 밖에서 틀어지는지 확인)
    - 아래 그림의 경우 +2, -2 정도에서 틀어지므로 99% 이상의 신뢰수준으로 __가정을 만족__ 한다고 생각할 수 있다.
  - `그림 3` : 실제 데이터와 추정된 값 사이의 관계 확인
    - `x축` : 실제 데이터(y)
    - `y축` : 추정된 값(y^)
    - 아래 그림을 보게 되면 __선형성이 큰 것__ 을 확인할 수 있다.
    - 참고 : `xlim` : x축의 범위, `ylim` : y축의 범위


  ```bash
  # 그림 1 및 그림 2 (그 외에도 2개 더 있지만 나중에.)
  plot(mlr_corolla)

  # 그림3
  plot(corolla_trn_data$Price, fitted(mlr_corolla),
       xlim = c(4000,35000), ylim = c(4000,35000))
  abline(0,1,lty=3) # 선을 그림
  ```

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/MultipleLinearRegression_R/picture/visual1.png)

---
## 정규성 판단
  ### 1.  잔차에 대한 평균과 표준편차 계산
  - 위에서 계산한 잔차를 가지고 평균과 표준편차를 계산한다.

  ```bash
  corolla_resid <- resid(mlr_corolla) # 잔차를 가져옴
  m <- mean(corolla_resid)            # 평균
  std <- sqrt(var(corolla_resid))     # 표준편차
  ```

  ### 2. 잔차를 이용해 히스토그램과 커브 생성
  - `hist` : 히스토그램을 그림
  - `curve` : 커브를 그림
  - `dnorm` : 평균, 표준편차를 이용해서 데이터를 만든다.
  - 결론
    - 이 그림은 정규분포를 따른다고 가정할 수 있다.
    - 만약, 틀어져 있다면 가정을 만족하지 않다고 생각할 수 있다.

  ```bash
  hist(corolla_resid, density=20, breaks=50, prob=TRUE, # 잔차(corolla_resid)를 가지고 / 음영처리를 20 (100이 밝음) / 막대(density)를 50개 / 함수를 True
       xlab="x-variable", main="normal curve over histogram") # x축 label 명 : x-variable / title은 normal curve over histogram

  curve(dnorm(x, mean=m, sd=std), #  평균은 m, 표준편차는 std 인 x 를 만든다
        col="darkblue", lwd=2, add=TRUE, yaxt="n") # 폭은 2 / add= true : 원래 그림에 갖다 붙여라
  ```

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/MultipleLinearRegression_R/picture/hist.png)

  ### 3. moment 패키지를 이용한 (엄밀한) 정규성 판단
  - `skewness` : 중심을 파악하며 정규분포의 경우 __0__ 에 가까워야 한다.
  - `kurtosis` : 뾰족한 정도를 파악하며 정규분포의 경우 __3__ 에 가까워야 한다.
  - 결과
    - 중심 :  `-0.14`
    - 뾰족한 정도 :  `8.63`
    - 즉, 이 데이터의 경우 __대칭성을 가지고__ 있는 정규분포에는 가깝지만 __뾰족한 정도는 맞지 않는다.__
    - but> 이를 너무 따지게 되면 실제 적용할 데이터는 거의 존재하지 않는다.

  ```bash
  skewness(corolla_resid) # 중심 파악
  kurtosis(corolla_resid) # 뾰족한 정도 파악
  ```

---
## 성능 평가
  ### 1. 성능평가를 위한 함수 생성
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

  ### 2. 성능평가에 대한 행렬 초기화
  - 한개의 데이터셋, 세개의 평가를 만든다.

  ```bash
  perf_mat <- matrix(0, nrow = 1, ncol = 3)
  rownames(perf_mat) <- c("Toyota Corolla")
  colnames(perf_mat) <- c("RMSE", "MAE", "MAPE")
  perf_mat
  ```

  ### 3. 성능 평가 수행
  - 머신러닝 관점에서 보는 성능평가
  - 이 데이터가 새로운 데이터를 얼마나 잘 관측하는지에 대해 평가함
  - `predict` : 만들어진 회귀식을 가지고 새로운 데이터의 값을 예측
  - 그 후 추정된 데이터가 실제 데이터를 얼마나 잘 예측했는지 검증

  ```bash
  mlr_corolla_haty <- predict(mlr_corolla, newdata = corolla_val_data) # 검증용 데이터에 대한 추정값 생성
  perf_mat[1,] <- pref_eval_reg(corolla_val_data$Price, mlr_corolla_haty) # 검증용 데이터와 추정된 데이터에 대한 성능 평가
  perf_mat
  ```

  ### 4. 결과 분석
  - MAE : 평균적으로 자동차 가격을 예측하는데 있어 __814 유로정도 틀린다.__
  - MAPE : 평균 대비 __8% 틀린다__ (오차가 8% 정도 난다.)
  - RSME : (의미분석 어려움!!)

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/MultipleLinearRegression_R/picture/performance.png)

---
## 참고 - 보스턴 집값에 관한 데이터의 경우
  ### 1. 선형 회귀 결과
  - `R²` 값이 `0.7` 로 선형성이 덜하다.
  - 잔차와의 관계
    - 그림 1 : 추정된값(x) 에 상관없이 잔차(Y) 가 __uniform 하지 않다__ (2차항 그래프랑 비슷)
    - 그림 2 : 굉장히 빠르게 틀어지고 있다. (30~40% 정도 정규분포를 따르지 않을 것이다.)
    - 그림 3 : 선형에서 떨어진 것들이 많이 보인다.
    - 그림 4 : 아래의 코드로 잔차를 확인한 결과 잔차가 큰 것을 알 수 있다.

  ```bash
  plot(fitted(mlr_boston), resid(mlr_boston),
       xlab="Fitted values", ylab="Residuals")
  ```

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/MultipleLinearRegression_R/picture/visual2.png)

  ### 2. 정규성 확인
  - 그림을 보면 상대적으로 정규분포를 따르지 않는 것처럼 보인다.
  - `skewness` 은 `1.6` 으로 0보다 매우 크다
  - `kurtosis` 은 `8.6` 으로 3보다 매우 크다
  - 즉, 엄밀하게 말하면 이 데이터는 선형회기 분석이 가져야 하는 가정을 만족하지 못한다고 생각할 수 있다. (회귀분석으로 분석하기는 부적합한 데이터이다.)

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/MultipleLinearRegression_R/picture/hist2.png)

  ### 3. 성능 평가
  - MAE : 차이는 `3.834064` 정도 난다.
  - MAPE : 오차가 `19.2762` 로 거의 20% 정도 발생

  ### 4. 결론
  - 보스턴 집에 대한 데이터는 __선형회귀분석으로 적합하지 않다.__
