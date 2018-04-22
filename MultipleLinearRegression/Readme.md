# Multiple Linear Regression
  - 다중 선형 회귀 분석

---

## Regression
  ### 1. (다중)회귀분석이란?
  - 종속 변수 __Y__ 와 설명변수 집합 __X₁, X₂ ... Xp__ 사이의 관계를 __선형으로 가정__ 하고 이를 가장 잘 설명할 수 있는 회귀 계수를 데이터로부터 추정하는 모델
  - `y=F*(X)` (X로 설명되는 함수식 y) 는 항상 있다고 가정한다.
    - 결과를 설명할수 있는 부분과 설명되지 않는 부분으로 나뉜다.
    - 즉, 가정된 식은 오차(노이즈)를 포함하고 있는 식이며  목표는 이를 제거하는 것이 아니라 단순히 가장 적은, 근접한 식을 발견하는 것임에 주의

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/MultipleLinearRegression/picture/regression.png)

  ### 2. Explanatory Regression vs Predictive Regression
  - __Explanatory(탐색적) Regression__ : 정통 통계학 관점에서의 다중회귀분석 접근
    - 데이터가 잘 맞아 떨어지고, 변수들이 모델을 잘 설명하는가?
    - __β__ 들의 개념을 해석 (β 관점에서 해석)
  - __Predictive(예측적) Regression__ : 머신러닝 관점에서의 다중회귀분석 접근
    - 실제 상황에 얼마나 잘 적용할 수 있으며, 가정을 몇가지나 맞출 수 있는가?
    - __Y__ (종속변수) 관점에서 해석
  - 즉, Predictive 관점에서는 __충분히 쓸만한 가치가 있다면__ Regression 을 사용하자는 관점

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/MultipleLinearRegression/picture/regression2.png)

  ### 3. 회귀분석의 형태
  - 회귀분석은 __변수의 수__ 와 추정되는 __함수의 형태__ 에 따라 구분 가능

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/MultipleLinearRegression/picture/regression3.png)

  ### 4. (다중)선형회귀분석이란?
  - Input varialbe 과 target variable 의 관계는 항상 선형(1차식) 이라고 가정하고 이를 표현
  - 선형 회귀분석의 장점(핵심)
    - 선형회귀분석은 회기계수(β^) 의 통계적 유의성을 알려줄 수 있다. (by pvalue)
    - 해당 대응하는 설명변수의 변화에 따른 종속변수의 변화량을 제공한다.

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/MultipleLinearRegression/picture/regression4.png)

---

## Ordinary Least Squares (최소자승법)
  ### 1. Ordinary Least Squares(OLS) 란?
  - 추정된 회귀식에 의해 결정된 값과 실제 종속변수 값의 차이를 최소화

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/MultipleLinearRegression/picture/ols.png)

  ### 2. OLS 를 이용한 회귀계수의 추정
  - 오차 제곱항을 최소화 (2로 나누는 이유는.. 미분시 계수를 없애기 위해)
  - 즉, `cost function` 을 최소화

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/MultipleLinearRegression/picture/ols2.png)

  ### 3. 행렬의 활용
  - __X__ : `n X (d+1)` matrix
    - 한개의 관측치당 d+1 개의 계수가 존재
  - __y__ : `n X 1` vector
    - n 개의 주어진 관측치 존재
  - __β__ : `(d+1) X 1` vector (__β^__ 도 동일)
    - 계수를 포함하여 전체 계수는 `(d+1)` 개가 존재

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/MultipleLinearRegression/picture/ols3.png)

  ### 4. 결론
  - __β^__ 은 X 와 y 만으로 계산 가능
  - 즉, 특정 데이터에 대한 회귀식은 __오직 1개__ 만 존재한다. (누가 계산하던지간에 같은 값이 나온다.) => 중요!!!

---

## 회귀모형의 적합도(Goodness-of-fit) : (Adjusted) R²
  ### 1. 회귀계수 __β__ 의 최적해 판단
  - 판단 방법
    - 오차항 ε 이 정규분포를 따름 => but> 거의 맞지 않음
    - 설명변수와 종속변수 사이에 선형관계가 성립 => but> 실제로 선형관계가 성립하고 있는지 알 방법 없음
    - 각 관측치들은 서로 독립 => but> 위와 동일
    - 종속변수 Y 에 대한 오차항(residual, 잔차)은 설명변수 값의 범위에 관계없이 일정함
  - 따라서 __β__ 가 쓸만한지, 즉 얼마나 적합한지(선형을 따르는지)에 대한 __적합도__ 를 판단하게 된다.

  ### 2. Sum-of-Squares Decomposition
  - SST : total sum of squares about mean
    - 실제치와 평균이 얼마나 차이가 나는지를 보여주는 총변동의 개념
  - SSR : regression sum of squares
    - 추정치와 평균과의 차이의 제곱
    - X로 Y의 변동을 설명하는 정도를 측정
  - SSE : residual(error) sum of squares
    - 실제치와 추정치의 차이의 제곱 (잔차의 제곱)

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/MultipleLinearRegression/picture/gof.png)

  ### 2. 결정계수 : R²
  - 반응변수 `Y`의 전체 변동 중 예측변수 `X`가 차지하는 변동의 비율
    - 종속변수의 변동을 독립변수의 변동으로 얼마나 설명 가능한지 측정한 것
    - 높을수록 좋은 모델
  - 해석 (R² 의 범위 : `0 ≤ R² ≤ 1`)
    - `R² = 1` : 회귀직선으로 Y의 총 변동이 완전히 설명됨 (모든 점이 회귀 직선 위에 존재)
    - `R² = 0` : 추정된 회귀직선은 X와 Y의 관계를 전혀 설명하지 못함

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/MultipleLinearRegression/picture/gof2.png)

  ### 3. 수정 결정 계수 : (Adjusted) R²
  - R² 의 경우 유의하지 않은 변수가 추가 될때마다 점점 커지는 문제점이 존재
  - Adjusted R² 은 penalty 를 부과하여 이르 보정
  - 즉, penalty를 상쇄하기 위해서는 변수를 추가했을때 SSE 의 감소량이 유의미 해야 한다는 것을 뜻함.

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/MultipleLinearRegression/picture/gof3.png)

  ### 4. 결론
  - `R²` 가 1에 가까울수록 이 변수들은 __선형성__ 이 크다.
  - 여기서 절대로 __모형을 잘 만들었다__ 라고 생각해서는 안된다.
    - R² 값은 data 에 따라 달라질 뿐, 분석을 잘한것이 절대 아니다.
    - 단순히 회귀식이 잘 나온 것 뿐이다.
  - 즉, data 가 선형성을 따르는지 아닌지만 판단하도록 한다.

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/MultipleLinearRegression/picture/gof4.png)

---

## 모델 적합도(Model fit) 평가
  ### 1. 모형의 검토
  - 예측변수와 반응변수 간 관계가 선형인지.
  - 오차항들이 서로 독립인지,
  - 오차항의 평균이 0이며 분산이 일정한 정규분포를 따르는지 검토

  ### 2. Residual Plot
  - 종속변수 Y에 대한 잔차(Residual) 는 설명변수 값의 범위에 관계없이 일정함(homoskedasticity)을 유지하는지 평가
  - (a) 의 경우 특정 pattern 을 보이고 있음을 알 수 있으며, 따라서 가정을 만족시키지 못한다.
  - (d) 의 경우 설명변수 값의 범위에 관계없이 일정함을 유지하고 있다는 것을 알 수 있다.

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/MultipleLinearRegression/picture/model.png)

  ### 3. 잔차의 정규성
  - `Histogram` : 잔차가 얼마나 정규성을 따르는지 파악 가능 (easy..)
  - `QQ Plot`
    - x축 : 데이터가 정규분포를 따른다 했을 때 가지는 값
    - y축 : 실제 잔차가 가지는 값 (실제 데이터 값)
    - 여기서 잔차가 벗어나는 구간이 정규분포를 따르지 않는다고 보며, 이 값이 99% 등을 정하고 이에 틀어졌을 경우 정규분포를 따르지 않는다고 가정한다.

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/MultipleLinearRegression/picture/model2.png)

---

## 회귀분석 성능 평가
  ### 0. 들어가기 전에..
  - 회귀분석을 수행할 때 보통 전체 데이터 중 70%는 학습용 데이터, 30%는 예측데이터로 사용한다.
  - data
    - `Trn`(학습용 데이터) : 모델을 만들 때 사용, R² 는 이를 확인하는 작업(학습용 data를 평가하는 것)
    - `Tst` : 실제 확인할 때 사용
  - 즉, 학습용 데이터의 결과가 예측 데이터를 얼마나 잘 예측하는지 평가한다.

  ### 1. Average error
  - 실제 값에 비해 과대/과소 추정 여부를 판단
  - 단, 부호로 인해 잘못된 결론 내릴 위험 존재

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/MultipleLinearRegression/picture/eval.png)

  ### 2. Mean absolute error (MAE) vs Mean absolute percentage error (MAPE)
  - MAE
    - 실제 값과 예측 값 사이의 절대적인 오차의 평균을 이용
    - 추천 system 과 같이 퍼센테이지가 중요하지 않은 곳에 사용된다.
  - MAPE
    - 실제값 대비 얼마나 예측 값이 차이가 있는지를 % 로 표현
    - 상대적인 오차를 추정하는데 주로 사용됨
    - 제조업에서 spec 을 만들때 주로 이용된다.(불량품)

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/MultipleLinearRegression/picture/eva2.png)

  ### 4. (Root) Mean squared error ((R)MSE)
  - 부호의 영향을 제거하기 위해 제곱을 취함
  - 연구관점에서 미분이 가능하다는 장점 존재
  - 실제는 보통 절댓값을 이용

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/MultipleLinearRegression/picture/eva3.png)

---

## 분석 예시
  ### 1. 데이터
  - ㅇ

  ### 2. 전처리
  - ㅇㅇ

  ### 3. 결과
  - ㅇㅇ
