# Clustering
  - Clustering 기본
  - K-Means Clustering
  - Hierarchical Clustering

---

## Clustering 기본
  ### 1. Clustering(군집화) 이란?
  - 전체 데이터 셋 안에서 동질 집단을 찾아내는(판별하는) 분석
  - 군집 내 분산(같은 집단 내 관측치) 최소화
  - 군집 간 분산(다른 집단 간 관측치) 최대화

  ### 2. 분류 vs 군집화
  - 분류(Classification)
    - 범주의 수, 각 개체의 범주 정보를 알고 있다.
    - 개체의 input value 로부터 범주 정보를 유추하여 새로운 개체에 대해 가장 적합한 범주로 할당하는 문제
  - 군집화(Clustering)
    - 군집의 수, 속성, 맴버십 등을 모른다.
    - 주어진 데이터를 특징 지을 수 있는 최적의 구조(구분)을 찾는 문제

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering/picture/classification.png)

  ### 3. 군집화를 사용하는 이유
  - 데이터에 대한 이해
    - 웹브라우징을 위한 관련된 문서들 표시
    - 유사한 기능을 수행하는 유전자/단백질 집합
    - 유사한 추세를 나타내는 주식
  - 데이터의 요약화 가능
    - 많은 데이터 셋의 크기 감소 가능
    - 시각화와 매우 밀접해 있을 수 있음
  - 전략 수립
    - 군집화를 통한 자산관리(asset management): (ex> 과거 수익률 및 변동성을 변수로 개별 stock의 6개월 수익률에 대한 계층적 군집화 수행 => 최대 퍼포먼스와 최소 변동성을 선택해서 포트폴리오 구성)
    - 경쟁사와의 특허 문서 분석을 통한 장단점 파악
  - 표면 분석
    - 불량 패턴의 군집화

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering/picture/clustering.png)

  ### 4. 군집화 종류
  - Hard Clustering
    - 서로 겹치지 않는 군집 생성
    - 각 개체는 오직 하나의 군집으로만 할당
  - Soft Clustering
    - 겹치는 군집 생성 가능
    - 한 개체는 여러 개의 군집에 확률적인 할당 될 수 있음

  ### 5, 군집화 알고리즘
  - Partitional Clustering
    - 전체 데이터 영역을 특정 기준에 의해 동시에 구분
    - 각 개체들은 __사전에 정의된 군집 수__ 에 속함
    - 대표적으로 `K-Means Clustering` 이 존재
  - Hierarchical Clustering
    - 개체들을 가까운 집단부터 묶어 나감
    - 유사한 개체들이 결합되는 dendrogram 도 생성
  - Self-Organizing Map(SOM)
    - 뉴럴넷 기반의 군집화 알고리즘
    - 2차원 격자에 각 개체들이 대응하도록 인공신경망과 유사한 학습을 통해 군집 도출
  - DBSCAN (밀도 기반 클러스터링)
    - 데이터 분포를 기반으로 높은 밀도를 갖는 세부 영역들로 전체를 구분

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering/picture/clustering2.png)

  ### 6. 군집화 수행 절차 ([참고](http://web.itu.edu.tr/sgunduz/courses/verimaden/paper/validity_survey.pdf))
  - Feature Selection
    - 어떤 변수를 사용할 것인지 결정
    - 최대한 많은 정보에 관해서 수행할 수 있는 적절한 변수를 선택
  - Clustering Algorithm Selection
    - 정의한 데이터 셋에 관련될 수 있는 적절한 알고리즘을 선택
  - Validation of the results
    - 적절한 기준과 기술을 사용하여 클러스터링의 결과가 옳은지 증명
  - Interpretation of the results
    - 올바른 결론을 보여줄 수 있도록 결과를 보여줌

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering/picture/clustering3.png)

---

## Clustering 고려 사항
  ### 1. 최적의 군집 수 결정
  - ㅇ

  ### 2. 군집화 결과 평가 방법
  - ㅇ

  ### 3. 군집화 평가를 위한 세 가지 지표
  - ㅇ

  ### 4. 군집화 평가 지표 1 - Dunn Index
  - ㅇ

  ### 5. 군집화 평가 지표 2 - Silhouette
  - ㅇ

---

## K-Means Clustering
  ### 1. K-Means Clustering 이란?
  - ㅇㅇ

  ### 2. K-Means Clustering 수행 절차
  - ㅇㅇ

  ### 3. K-Means Clustering 결과
  - ㅇㅇ

  ### 4. 초기 Centroid 설정의 중요성
  - ㅇㅇ

  ### 5. K-Means Clustering의 문제점
  - ㅇㅇ

---

## Hierarchical Clustering
  ### 1. Hierarchical Clustering 이란?
  - ㅇ

  ### 2. Hierarchical Clustering 방식
  - ㅇㅇ

  ### 3. 상향식 Clustering 알고리즘1-유사도/거리 측정
  - ㅇㅇ

  ### 4. 상향식 Clustering 알고리즘2-Ward's method
  - ㅇㅇ

  ### 5. Hierarchical Clustering 수행 절차
  - ㅇㅇ

---

## 참고
  ### 1. K-Means vs Hierarchical
  - dd
