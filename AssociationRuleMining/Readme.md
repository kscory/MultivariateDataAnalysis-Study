# Association Rule Mining
  - 연관규칙 분석
  - priori algorithm
  - 규칙평가
    - Support
    - Confidence
    - Lift

---

## 연관규칙분석 기본
  ### 1. 목적 및 특징
  - 연관규칙분석이란 과거의 일을 가지고 다음을 예측하는 것
    - 'affinity analysis' 혹은 'market basket analysis' 로 널리 알려짐
  - __목적__
    - 어떤 두 아이템 집합이 빈번히 발생하는 가를 알려주는 일련의 규칙들을 생성
    - Produce rules that define "what goes with what"
  - __특징__
    - 추천 시스템에 많이 사용됨 (X구매시 Y를 추천해줌)
    - `Row` 가 `transaction` 이다.

  ### 2. 데이터 속성
  - 두 가지의 형태의 데이터가 존재
    - 공통적으로 각 행(rows)은 `record` 이며, 트랜잭션의 형태를 가진다.
  - list 형태
    - 이마트 영수증과 같이 여러 종류중 산 것들을 나열한다.
  - matrix 형태
    - 대부분의 셀이 0의 값을 갖는 희소행렬(sparse matrix) 이므로 __약간 비효율적__ 이다.
    - 그러나 대부분의 알고리즘이 사용하는 데이터는 `matrix` 형태를 띈다.

  ### 3. 용어 및 규칙 생성
  - 용어
    - `Antecedent` : (조건절) IF 파트
    - `Consequent` : (결과절) THEN 파트
    - `Item set` : 조건절 또는 결과절을 구성하는 아이템들의 집합
    - ※ 조건절 item set 과 결과절 item set 은 disjoint(상호배반) => 조건절과 결과절에 같은 아이템이 있을 수 없다.
  - 규칙생성
    - 다양한 규칙 생성이 가능하다.
    - ex1> 계란을 구매하면 라면도 구매
    - ex2> 계란과 라면을 구매하면 참치도 구매
    - ex3> etc..

  ### 4. 규칙의 효용성 지표 (A → B 인 경우)
  - `Support` : 지지도
    - 조건절에 속하는 아이템 집합이 발생할 확률
    - frequent item sets(빈발 아이템 집합) 를 판별하는데 사용
  - `Confidence` : 신뢰도
    - 조건절이 발생했다는 가정 하에 결과절이 발생할 조건부 확률
    - 의미있는 규칙인지(아이템 집합 간에 연관 있는지) 측정하는데 사용
  - `Lift` : 향상도
    - Confidence 를 Support로 나눈 확률
    - 생성된 규칙이 유용한지, 효용가치가 있는지 판별하는데 사용

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/AssociationRuleMining/picture/association1.png)

---

## 규칙의 생성 방법(priori algorithm)
  ### 1. 규칙 생성 방법
  - Brute-force approach
    - 가장 이상적
    - 가능한 모든 규칙을 나열한 뒤 모든 규칙의 Support, Confidence, Lift 를 측정하여 유용한 규칙들(minsup, mincof threshold)을 찾아냄
    - but> 계산에 소요되는 시간이 데이터가 크면 급격히 증가
  - priori algorithm
    - "빈발 아이템 집합" 만을 고려하여 규칙 생성
    - `minimum support` 값을 설정하여 이 이상의 아이템 집합만을 고려
    - minimum support 를 모두 계산하지 않고 하위집합은 항상 이를 만족할 수 없으므로 하위집합도 제거 </br>(Support of an item set never exceeds the support of its subsets, which is known as anti-monotone property of support)

    ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/AssociationRuleMining/picture/association2.png)

  ### 2. priori algorithm
  -

  ### 3. priori algorithm 예시
  - ㅇㅇ

---

## 규칙 평가
  ### 1. Confidence (신뢰도)
  - ㅇㅇ

  ### 2. Lift (지지도)
  - ㅇㅇ

  ### 3. 결과 분석 예시
  - ㅇㅇ
