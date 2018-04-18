# R - Clustering
  - Hierarchical Clustering with R

---

## 공통 부분
  ### 1. 모듈 설치 및 라이브러리 사용
  - `clValid` : Silhouette 등 군집타당성 지표들을 계산할 수 있는 기능을 담고 있는 패키지
  - R 에서 제공하는 `hclust` 이용

  ```bash
  install.packages("clValid")

  library(clValid)
  ```

---

## Hierarchical Clustering - 개인 신용대출 데이터

  ### 1. 데이터 로드 및 전처리
  - 필요없는 열 삭제
    - ID 관련변수(1열) / zip code 변수(5열)
    - 10열은 종속변수이므로 군집화 사용 X
  - `data scaling` (데이터 정규화) 작업 : 평균을 0으로, 표준편차를 1로 해서 distance를 구할 때 각 변수를 동등하게 취급하도록 한다.
    - `center = TRUE` : 평균을 0으로
    - `scale = TRUE` : 표준편차를 1로

  ```bash
  # 데이터 로드
  ploan <- read.csv("Personal Loan.csv")
  # 필요없는 열 삭제
  ploan_x <- ploan[,-c(1,5,10)]
  # 데이터 정규화
  ploan_x_scaled <- scale(ploan_x, center = TRUE, scale = TRUE)
  ```

  ### 2. 거리행렬 생성
  - 두 개체간 유사성을 계산하기 위해 상관계수 이용
    - 각각의 거리는 거리를 직접 잴 수도 있지만 __각도__ 에 따라서 달라 질 수 있다는 것을 생각할 수 있다.
    - 각각의 변수의 cos 값을 가져오고 이것이 클수록 두 객체는 비슷하다는 것을 알 수 있다.
  - `cor()` : 상관계수를 구해줌
    - `t(데이터)` : 원래 데이터에서 transpose 수행
    - `method = spearman` : 이상치에 덜 민감한 spearman coefficient 를 사용한다.
  - `as.dist()` : 효율적으로 거리행렬 정보 저장을 지원 (거리행렬에서 대각선 아래 부분 혹은 윗부분만 가져온다.)
    - 상관계수는 유사성 지표이므로 클 수록 유사하다고 생각되지만, 거리는 클수록 달라지므로 `1-coefficient` 를 수행

  ```bash
  # 상관계수 구하기
  cor_Mat <- cor(t(ploan_x_scaled), method = "spearman")
  # 거리 행렬 저장
  dist_ploan <- as.dist(1-cor_Mat)
  ```

  ### 3. Hierarchical Clustering 수행 및 Dendrogram 도시
  - `hclust()` : 계층적 군집화를 수행
    - Arg 1 : 거리 행렬 (계층 구조는 데이터셋이 아니라 거리행렬이 들어가야 함에 주의)
    - `method = "complete"` : complete linkage 를 사용 (다른 것도 사용 가능)
    - `members = NULL` : 군집의 수를 처음에 결정하지 않음
  - plot() : 그림을 그린다. (여기서는 덴드로그램을 그린다.)

  ```bash
  # 계층적 군집화 수행
  hr <- hclust(dist_ploan, method = "complete", members=NULL)

  # 덴드로그램 도시
  plot(hr)  # 일반적인 덴드로그램
  plot(hr, hang = -1) # 말단 개체들을 병합된 순서에 따라 다르게 표시
  plot(as.dendrogram(hr), edgePar=list(col=3, lwd=4), horiz=T)  # 좌우 방식의 덴드로그램, 선의 굵기와 색상도 변경
  ```

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering_R_2/picture/ex1.png)

  ### 4. 군집 수 결정 및 군집 생성
  - `clvalid()` : 지표를 이용해서 적당한 군집의 개수를 구해줌 (여기서 2가 나왔지만 편의상 10으로 군집을 만들었다..)
    - 데이터셋 / 클러스터링 종류 / method / 지표 / 군집 내 최대 수 지정
    - maxitems 를 넣지 않으면 오류날때가 있다.
  - `cutree()` : 군집을 생성하는 함수
    - `hr` : 덴드로그램을 넣음
    - `k=10` : 10개의 군집을 생성
  - `rect.hclust()` : 덴드로그램과 함께 생성한 군집을 직사각형으로 표시
    - `border = "red"` : 군집을 빨간색 선으로 나눔

  ```bash
  # Evaluating the cluster validity measures
  ploan_clValid <- clValid(ploan_x_scaled, 2:15, clMethods = "hierarchical", method = "complete",
                          validation = c("internal", "stability"), maxitems=nrow(ploan_x_scaled))
  summary(ploan_clValid)

  # Make the clusters
  mycl <- cutree(hr, k=10)
  mycl

  # divde by border
  plot(hr)
  rect.hclust(hr, k=10, border="red")
  ```

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering_R_2/picture/ex2.png)


  ### 5. 각 군집별 특징 비교
  - 각 군집별로 변수들의 평균값을 산출
  - 각 군집별 대출 고객 비율(Loan Ratio) 계산함 (데이터 전처리때 없앤... 종속 변수를 가져와봄)
  - 코드 참고 (hc_summary)
    - 1번 변수부터 col 번까지의
    - `tapply` : factor 형으로 적용
    - cluster id 별로
    - 평균(mean)을 계산하여 row를 바인딩
    - 이를 반복

  ```bash
  # make dataframe
  ploan_hc <- data.frame(ploan_x_scaled, ploanYN = ploan[,10],
                           clusterID = as.factor(mycl))
  hc_summary <- data.frame()

  # cluster id 별 평균을 매김
  for (i in 1:(ncol(ploan_hc)-1)){
    hc_summary = rbind(hc_summary,
                       tapply(ploan_hc[,i], ploan_hc$clusterID, mean))
  }

  # col / row name 을 지정
  colnames(hc_summary) <- paste("cluster", c(1:10))
  rownames(hc_summary) <- c(colnames(ploan_x), "LoanRatio")

  hc_summary
  ```

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering_R_2/picture/ex3.png)

  ### 6. 군집별 Radar chart 도시
  - 각각의 군집의 특징을 알 수 있다.
  - 각각의 방사형 축이 변수명, 숫자는 변수의 값, 좀전의 centroid 값을 이음
  - 코드는 아래 변수 참고
  - 참고
    - mfrow와 mfcol 은 배열에 있어서 차이가 있다. (참고)

  ```bash
  par(mfrow = c(2,5)) # 2행 5열로 구성된 그림 도시를 선언
  for (i in 1:10){
    plot_title <- paste("Radar Chart for Cluster", i, sep=" ") # 이름을 설정
    radial.plot(hc_summary[,i], labels = rownames(hc_summary),  # 변수값, 변수 설정
                radial.lim=c(-2,2), rp.type = "p", main = plot_title, #범위, 타입, 타이틀
                line.col = "red", lwd = 3, show.grid.labels=1) #색, 두께, 레이블1 로
  }
  dev.off()  # 앞에 정의된 par() 의 설정 초기화
  ```

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering_R_2/picture/ex4.png)

  ### 7. 가설 검정 수행
  - 신용대출 이용률이 가장 낮은 군집(7)과 높은 군집(8) 을 비교
  - __H0__ : 군집 7의 변수 평균 = 군집 8의 변수평균
  - __H1__
    - 군집 7의 변수 평균 ≠ 군집 8의 변수평균
    - 군집 7의 변수 평균 > 군집 8의 변수평균
    - 군집 7의 변수 평균 < 군집 8의 변수평균
  - `t-test()` : 두 집단에 대한 Student's t-test를 수행해주는 함수
    - Arg 1, 2 : 집단 1의 변수값, 집단 2의 변수값
    - Arg 3 : 가설 ("two-sided" : 양측검정, "greater" & "less" : 단측 검정)
    - `$p.value` : 가설검정 결과의 유의 확률 (p value)

  ```bash
  # 클러스터를 뽑아냄
  hc_cluster7 <- ploan_hc[ploan_hc$clusterID == 7, c(1:11)]
  hc_cluster8 <- ploan_hc[ploan_hc$clusterID == 8, c(1:11)]

  # t_test 수행
  hc_t_result <- data.frame()
  for (i in 1:11){

    hc_t_result[i,1] <- t.test(hc_cluster7[,i], hc_cluster8[,i],
                                alternative = "two.sided")$p.value

    hc_t_result[i,2] <- t.test(hc_cluster7[,i], hc_cluster8[,i],
                                alternative = "greater")$p.value

    hc_t_result[i,3] <- t.test(hc_cluster7[,i], hc_cluster8[,i],
                                alternative = "less")$p.value
  }
  ```

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/Clustering_R_2/picture/ex5.png)
