# R - Clustering
  - K-Means Clustering with R

---

## 공통 부분
  ### 1. 모듈 설치 및 라이브러리 사용
  -
  - `clValid` : Silhouette 등 군집타당성 지표들을 계산할 수 있는 기능을 담고 있는 패키지
  - `plotrix` : (Radar)차트를 보여줄 수 있는 패키지
  - R 에서 (K-Means) 클러스터링 기능 자동 제공

  ```bash
  install.packages("clValid")
  install.packages("plotrix")

  library(clValid)
  library(plotrix)
  ```

---

## K-Means Clustering - wine : 비슷한 wine 끼리 묶기
  ### 1. 데이터 로드 및 전처리
  - 필요없는 열 삭제
  - `data scaling` (데이터 정규화) 작업 : 평균을 0으로, 표준편차를 1로 해서 distance를 구할 때 각 변수를 동등하게 취급하도록 한다.
    - `center = TRUE` : 평균을 0으로
    - `scale = TRUE` : 표준편차를 1로

  ```bash
  # 데이터 로드
  wine <- read.csv("wine.csv")

  # 와인에 대한 설명만 쓸 것이므로 class 제거
  wine_class <- wine[,1]
  wine_x <- wine[,-1]

  # 데이터 정규화
  wine_x_scaled <- scale(wine_x, center = TRUE, scale = TRUE) # center=true : 평균0, scale=true : 표준편차 1
  ```

  ### 2. 군집 타당성 지표를 통한 최적 군집 수 결정
  - `clValid` : 어떤 군집을 사용하는 것이 좋은지 판단해준다.(군집 타당성 지표 계산)
    - 첫번째 인자 : 군집화 사용할 데이터 셋
    - 두번째 인자 : 후보 군집의 수
    - 세번째 인자 : 검증할 알고리즘 세팅
    - 네번째 인자 : 사눌할 타당성 지표의 카테고리
  - 즉, 아래는 `wine_x_scaled` 데이터 셋을 군집의 갯수가 `2~10` 까지 `K-Means Clustering` 을 했을 때 `internal` 지표, `stability` 지표에 대해 계산해 달라는 것

  ```bash
  wine_clValid <- clValid(wine_x_scaled, 2:10, clMethods = "kmeans",
                             validation = c("internal", "stability"))
  summary(wine_clValid)
  ```

  - 적용 결과

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering_R/picture/ex1.png)

  - 결론 : 군집을 3개로 결정

  ### 3. K-Means 클러스터링 수행
  - 군집의 개수 3개로 k-means 클러스터링 수행
  - `$centers` : 각 군집의 중심 좌표 (k 평균 군집화는 첫번째 centroid를 랜덤으로 잡으므로 여러가지의 centroid의 결론을 낼수도 있다.)
  - `$size` : 각 군집에 할당된 개체 수
  - `$cluster` : 각 개체가 할당된 군집 번호 (군집의 순서는 상관 없다 => 하지만 군집의 순서에 따른 centroid 는 중요!!)

  ```bash
  # K-Means Clustering 시작
  wine_kmc <- kmeans(wine_x_scaled, 3)

  # K-Means Clustering 결과물
  wine_kmc$centers
  wine_kmc$size
  wine_kmc$cluster
  ```

  - 적용 결과

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering_R/picture/ex2.png)

  ### 4. 실제 범주와 할당된 군집 비교
  - 정답정보와 한번 비교 해 봄
    - 품종 정보를 정하지 않았음에도 동질적인 성질이 클러스터 됨
  - 정규화된 데이터와 각 개체가 할당된 군집 정보로 구성된 데이터 프레임 생성
  - 코드 참고 (kmc_summary)
    - 1번 변수부터 col 번까지의
    - `tapply` : factor 형으로 적용
    - cluster id 별로
    - 평균(mean)을 계산하여 row를 바인딩
    - 이를 반복

  ```bash
  # 정답 정보와 비교해보기
  real_class <- wine_class
  kmc_cluster <- wine_kmc$cluster
  table(real_class, kmc_cluster)

  # Compare each cluster for KMC
  cluster_kmc <- data.frame(wine_x_scaled, clusterID = as.factor(wine_kmc$cluster))
  kmc_summary <- data.frame() # # kmc 값을 넣기 위해 데이터를 초기화

  # kmc_summary 에 rbinding
  for (i in 1:(ncol(cluster_kmc)-1)){
    kmc_summary = rbind(kmc_summary,
                       tapply(cluster_kmc[,i], cluster_kmc$clusterID, mean))
  }

  # name 붙이기
  colnames(kmc_summary) <- paste("cluster", c(1:3))
  rownames(kmc_summary) <- colnames(wine_x)
  kmc_summary
  ```

  - 적용 결과

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering_R/picture/ex3.png)

  ### 5. Radar Chart로 도시
  - 각각의 군집의 특징을 알 수 있다.
  - 각각의 방사형 축이 변수명, 숫자는 변수의 값, 좀전의 centroid 값을 이음
  - 코드는 아래 변수 참고
  - 참고
    - mfrow와 mfcol 은 배열에 있어서 차이가 있다. (참고)

  ```bash
  par(mfrow = c(1,3)) # 1행 3열로 구성된 그림 도시를 선언
  for (i in 1:3){
    plot_title <- paste("Radar Chart for Cluster", i, sep=" ") # 이름을 설정
    radial.plot(kmc_summary[,i], labels = rownames(kmc_summary), # 변수값, 변수 설정
                radial.lim=c(-2,2), rp.type = "p", main = plot_title, #범위, 타입, 타이틀
                line.col = "red", lwd = 3, show.grid.labels=1) #색, 두께, 레이블1 로
  }
  dev.off() # 앞에 정의된 par() 의 설정 초기화
  ```

  - 적용 결과

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering_R/picture/ex4.png)

  ### 6. 통계적 가설 검정 수행
  - 정말로 1번과 2번이 통계적으로 유의미한가??? 를 검증
  - H0를 군집 1의 변수 평균 = 군집 2의 변수평균 으로 둔다.
    - H1 은 아래 코드와 같이 3가지!! (≠, >, <)

  ```
  # 실제 데이터에서 1, 2 를 가지고 따로 set 을 만듦
  kmc_cluster1 <- wine_x[wine_kmc$cluster == 1,]
  kmc_cluster2 <- wine_x[wine_kmc$cluster == 2,]

  # t_test_result
  kmc_t_result <- data.frame()

  for (i in 1:13){

    kmc_t_result[i,1] <- t.test(kmc_cluster1[,i], kmc_cluster2[,i],
                                alternative = "two.sided")$p.value  # 양측검정 pvalue

    kmc_t_result[i,2] <- t.test(kmc_cluster1[,i], kmc_cluster2[,i],
                                alternative = "greater")$p.value  # 1번이 더 크다는 것에 대한 pvalue

    kmc_t_result[i,3] <- t.test(kmc_cluster1[,i], kmc_cluster2[,i],
                                alternative = "less")$p.value   # 1번이 더 작다는 것에 대한 pvalue
  }

  kmc_t_result
  ```

  - 적용 결과

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering_R/picture/ex5.png)
