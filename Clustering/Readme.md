# Basic Clustering
  - Clustering 기본 개념
  - Clustering 고려 사항

---

## Clustering 기본 개념
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
  - 아래의 그림과 같이 군집을 2개로, 4개로, 6개로 나눌 수 있으며 이에 우열관계는 지표의 성격에 따라 달라지게 된다.
    - But> 만약 2개, 6개로 나누어야 한다면 아래와 같이 나눠야 함은 틀림없다 !!
  - 다양한 군집수 대해 성능평가 지표를 이용하여 최적의 군집수를 선택한다.
  - Elbow point에서 최적 군집수가 자주 결정 된다.

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering/picture/consider.png)

  ### 3. 군집화 평가 카테고리
  - 군집화 결과에 대한 평가는 모든 상황에서 적용 가능한 성능평가 지표가 존재하지 않고 얼마나 유용한지 따지는 타당성 지표가 존재
  - 세가지 카테고리
    - External : 정답과 비교를 통해 성능 평가
    - Internal : 군집이 컴펙트한지(무엇이 더 중요한지)에 초점
    - Relative : 컴펙트한지, 군집끼리 얼마나 다른지에 초점. 즉, 무엇이 중요한지, 군집기리 서로 얼마나 떨어져 있는지 확인

  ### 4. 군집 타당성 지표 (3가지)
  - 군집 간 거리
    - 군집간의 거리는 여러가지가 있지만 가장 __짥은__ 것을 군집간 거리로 설정
    - 군집간의 거리는 멀수록 잘 분류된 것
  - 군집의 지름
    - 군집내에서 가능한 거리는 여러가지가 있지만 가장 __긴__ 것을 군집의 지름으로 설정
    - 군집의 지름은 짦을 수록 좋다.
  - 군집의 분산
    - 군집들이 얼마나 퍼져있는지 확인
    - 군집의 분산은 작을 수록 좋다.

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering/picture/consider2.png)

  ### 4. 군집화 평가 지표 1 - Dunn Index
  - 군집내 거리 중 가장 작은 것이 분자
    - 군집화가 잘 되려면 가장 짧은 거리가 멀수록 좋다는 컨셉
  - 군집의 지름 중 가장 큰 것이 분모
    - 위와 반대..
  - 즉, Dunn Index는 __클수록__ 군집화가 잘되었다고 할 수 있다.

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering/picture/consider3.png)

  ### 5. 군집화 평가 지표 2 - Silhouette
  - 개체 수준에서 숫자 계산을 한다.(모든 개체마다 설명하는 작업을 한다.)
  - `a(i)` : i 라는 개체와 같은 군집 내에 있는 다른 모든 개체들 사이의 평균거리 => 작을수록 좋다.
  - `b(i)` : i 라는 개체가 속한 군집을 제외하고 다른 군집에 속한 개체들 사이의 평균거리 중 가장 작은 값 => 클수록 좋다.
  - s(i) 의 경우 이론적으로 `-1 ~ 1`  사이의 값을 가진다. (a(i) 가 1인 경우 최상, b(i) 가 0 인경우 최악)

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering/picture/silhouette.png)

  - Silhouette 계산 방법 예시

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering/picture/silhouette2.png)
