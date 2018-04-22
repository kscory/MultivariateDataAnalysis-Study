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
  ### 1. Sum-of-Squares Decomposition
  - dd

  ### 2. 결정계수 : R²
  - ㅇㅇ

  ### 3. 그래프적인 해석
  - ㅇㅇ

  ### 4. 수정 결정 계수 : (Adjusted) R²
  - ㅇㅇ

---

## 모델 적합도(Model fit) 평가
  ### 1. 모형의 검토
  - dd

  ### 2. Residual Plot
  - ㅇㅇ

  ### 3. 잔차의 정규성
  - ㅇㅇ

---

## 회귀분석 성능 평가
  ### 1. Average error
  - dd

  ### 2. Mean absolute error (MAE)
  - dd

  ### 3. Mean absolute percentage error (MAPE)
  - dd

  ### 4. (Root) Mean squared error ((R)MSE)
  - dd

---

## 예시
