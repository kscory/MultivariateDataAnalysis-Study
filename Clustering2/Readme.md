# Clustering 기법
  - K-Means Clustering
  - Hierarchical Clustering

---

## K-Means Clustering
  ### 1. K-Means Clustering 이란?
  - 대표적인 Partitional Clustering 알고리즘 이자 교집합이 존재하지 않는 Hard Clustering의 한 종류
  - 각 군집은 하나의 centroid(중심) 을 가지며 각 개체는 가장 가까운 중심에 할당되면서 같은 중심에 할당된 개체들이 모여 하나의 군집을 생성
  - __사전에 군집의 수(k)가 정해져야 함__ 에 주의!!
  - 수식

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering2/picture/kmeans.png)

  ### 2. K-Means Clustering 수행 절차
  - K-Means Clustering 의 경우 centroid를 정하고 군집을 할당하는 행위를 반복적으로 수행한 뒤 서로 최적의 값으로 수렴하면 행위를 종료한다.
  - 수행절차
    - K개(ex> 2개)의 초기 centroid 를 랜덤으로 설정 (빨간색 점)</br>
  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering2/picture/kmeans2.png)
    - 모든 개체들을 가장 가까운 중심으로 할당 (Expectation 스텝)</br>
  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering2/picture/kmeans3.png)
    - 할당된 개체들을 이용하여 군집 중심 재설정 (Maximization 스텝)</br>
  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering2/picture/kmeans4.png)</br>
    - 다시 모든 개체를 가장 가까운 중심으로 할당
  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering2/picture/kmeans5.png)</br>
    - 다시 할당된 개체들을 이용하여 군집 중심 재설정
  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering2/picture/kmeans6.png)</br>
    - 군집 중심과 개체 할당에 변화가 없으므로 알고리즘 종료

  ### 3. K-Means Clustering 결과
  - 초기 중심이 잘 설정된 경우 => 결과가 잘 나옴
  - 초기 중심이 잘 설정되지 않은 경우 => 이상한 결과가 나옴
  - 따라서 초기 중심 설정에 따라 다르게 나타난다.

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering2/picture/kmeans7.png)

  ### 4. 초기 Centroid 설정 문제 해결
  - 가장 간단한 방법 충분히 많은 횟수로 실험한 뒤 자주 나오는 결과물을 최종 결과물로 선택하는 것!
  - 그 외
    - 전체 데이터 중 일부만 샘플링하여 계층적 군집화 수행한 후 초기 군집 중심 설정
    - 데이터 분포의 정보를 사용하여 초기 중심 설정

  ### 5. K-Means Clustering의 문제점
  - 군집의 크기가 다를 경우 제대로 작동하지 않을 수 있다.
  - 군집의 밀도가 다른 경우 잘 찾아내지 못한다.
  - 구형이 아닌 데이터 분포가 특이한 케이스도 군집이 잘 이루어지지 않는다.

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering2/picture/kmeans8.png)

---

## Hierarchical Clustering
  ### 1. Hierarchical Clustering 이란?
  - 계층적 트리모형을 이용하여 개별 개체들을 순차적/계층적으로 유사한 개체 및 그룹과 통합하여 군집화를 수행하는 알고리즘
  - `Dendrogram` 을 통해 시각화 가능
    - 덴드로그램을 생성한 후 적절한 수준에서 트리를 자르면 전체 데이터를 몇 개 군집으로 나눌 수 있게 된다.
  - 계층적 군집화는 사전에 군집의 수를 정하지 않아도 수행 가능 (Dendrogram을 보고 적절하게 나누면 된다.)

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering2/picture/hierarchical.png)

  ### 2. Hierarchical Clustering 방식
  - 상향식(Agglomerative) 클러스터링
    - 초기에 모든 개체들을 개별적인 군집으로 가정
    - 각 단계에서 유사한 개체/군집 끼리 결합하는 과정을 반복하면서 하나의 군집으로 통합되면 완료
  - 하향식(Divisive) 클러스터링
    - 모든 개체가 하나의 군집으로 이루어진 상태에서 출발
    - 각 단계에서 가장 유의미하게 구분되는 지점을 판별하여 지속적으로 데이터를 분할

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering2/picture/hierarchical2.png)

  ### 3. 상향식 Clustering 알고리즘1-유사도/거리 측정
  - 두 군집 사이의 유사도/거리 측정
    - __Single linkage__ : (minimum distance) 각 군집에 속한 개체들 사이의 거리중 가장 가까운 값을 군집간 거리로 정의
    - __Complete linkage__ : (maximum distance) 각 군집에 속한 개체들 사이의 거리중 가장 먼 값을 군집간 거리로 정의
    - __Average linkage__ : (mean distance) 각 군집에 속한 개체들 사이의 거리 평균값을 군집간 거리로 정의(group)
    - __Centroid linkage__ : (distance with centroid) 각 군집의 중심간 거리를 군집간 거리로 정의

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering2/picture/hierarchical3.png)

  ### 4. 상향식 Clustering 알고리즘2-Ward's method
  - 두 군집간의 거리를 군집이 병합된 이후의 Sum of Squared Error (SSE) 와 개별 군집의 SSE의 합과 차이로 정의
  - 예시

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering2/picture/hierarchical4.png)

  ### 5. Hierarchical Clustering 수행 절차
  - 군집간 거리 행렬을 만들어 유사도(거리) 가 가장 가까운것끼리 이어가는 작업을 반복하면서 Dendrogram을 만든다.
    - 모든 개체에 대한 군집간 거리 행렬 계산
    ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering2/picture/hierarchical5.png)
    - 가장 가까운 두 개의 군집을 하나의 군집으로 통합
    ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering2/picture/hierarchical6.png)
    - 군집간 거리 행렬 업데이트
    ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering2/picture/hierarchical7.png)
    - (반복) 가장 가까운 두 개의 군집을 하나의 군집으로 통합
    ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering2/picture/hierarchical8.png)
    - (반복) 군집간 거리 행렬 업데이트
    ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering2/picture/hierarchical9.png)
    - (반복) 가장 가까운 두 개의 군집을 하나의 군집으로 통합
    ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering2/picture/hierarchical10.png)
    - 모든 개체가 하나의 군집이 되었으므로 종료
    ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering2/picture/hierarchical11.png)

---

## 참고
  ### 1. K-Means vs Hierarchical
  - dd
