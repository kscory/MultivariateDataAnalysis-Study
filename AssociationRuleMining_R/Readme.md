# R - Association Rule Mining
  - titanic
    - 특정조건에 따라 살아남은 연관 규칙 분석
  - grocery shopping data

---

## 공통 부분
  ### 1. 모듈 설치 및 라이브러리 사용
  - `arules` : 연관 규칙 분석 패키지
  - `arulesViz` : 시각화를 도와주는 패키지
  - `wordcloud` : 그리는 것을 도와주는 패키지
  - 참고
    - `dependencies = TRUE` : 의존성이 있으면 모두 설치
    - `library(패키지)` : 인스톨 시킨 패키지를 실행

  ```bash
  install.packages("arules", dependencies = TRUE)
  install.packages("arulesViz", dependencies = TRUE)
  install.packages("wordcloud", dependencies = TRUE)

  library(arules)
  library(arulesViz)
  library(wordcloud)
  ```
---

## 예제 1 - titanic : 조건에 따라 살아남은 연관 규칙 분석
  ### 1. 데이터 로드
  - 현재 디렉토리에 있는 데이터 파일을 불러온다.(Session -> Set working directory 에서 상대경로 설정 후 진행)
    - delimeter로 된 파일을 불러오며 "," 로 구분하겠다 하는 것
  - 참고
    - `str` : 해당하는 데이터의 스트럭쳐를 보여준다.
    - `head` : 데이터를 보여준다.

  ```bash
  # 데이터 로드
  titanic <- read.delim("titanic.txt", dec=",")
  # 데이터 스트럭쳐 보여줌
  str(titanic)
  # 데이터를 보여줌
  head(titanic)
  ```

  - 적용 결과

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/AssociationRuleMining_R/picture/ex11.png)

  ### 2. 데이터 변형
  - 이름은 타이타닉의 생존여부와 관련 없으므로 삭제
  - 어린 아이들이 더 많이 살아남았다고 가졍하고 나이를 (adult, children, unknown) 의 세가지 경우로 바꾼다.
  - 그 후 모든 요인들을 Factor 형태로 변형
  - 참고
    - `which(titanic_ar$Age < 20)` : "titanic_ar" 의 데이터 중 나이가 20보다 착은 행들의 번호들을 가져옴 (안될경우 `as.numeric` 이용)
    - `as.factor` : 데이터를 factor 의 형태로 변형
    - `as.integer` : 데이터를 int 형태로 변형

  ```bash
  # 이름 삭제 후 모두 가져옴
  titanic_ar <- titanic[,2:5]

  # 나이를 세 경우로만 나눠서 저장
  ## 세가지의 배열로 저장
  titanic_ar$Age <- as.integer(titanic_ar$Age) # 이는 Age가 factor 형태로 되어 있기 때문에 오류 해결을 위해 int 형으로 변형
  c_idx <- which(as.numeric(titanic_ar$Age) < 20)
  a_idx <- which(as.numeric(titanic_ar$Age) >= 20)
  na_idx <- which(is.na(titanic_ar$Age))
  ## age 값을 변형
  titanic_ar$Age[c_idx] <- "Child"
  titanic_ar$Age[a_idx] <- "Adult"
  titanic_ar$Age[na_idx] <- "Unknown"

  # 데이터를 factor 형태로 바꿈
  titanic_ar$Age <- as.factor(titanic_ar$Age)
  titanic_ar$Survived <- as.factor(titanic_ar$Survived)
  ```

  - 적용 결과

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/AssociationRuleMining_R/picture/ex12.png)


  ### 3. apriori algorithm 을 이용하여 rule 생성
  - `apriori(data, parameter, appearance)` 함수 이용
    - data : 분석에 사용할 데이터셋
    - parameter : list로 minimum support, minimum confidence, minimum length(ex> a,b-> 가능, g->h 불가능) 를 지정
    - appearance : list로 특정 조건인 경우의 데이터만 불러올 수 있다. (아래는 결과절은 Survived 에 대해서만 보여주도록 함)
  - `inspect(rules)` : 이를 분석해줌
  - default 세팅을 이용할 수도 있다.

  ```bash
  # apriori 함수 디폴트 값 적용
  rules <- apriori(titanic_ar)
  inspect(rules)

  # apriori 함수 커스터마이징
  rules <- apriori(
      titanic_ar,
      parameter = list(minlen = 3, support = 0.1, conf = 0.8),
      appearance = list(rhs = c("Survived=0", "Survived=1"), default="lhs")
  )
  inspect(rules)
  ```

  - 적용 결과

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/AssociationRuleMining_R/picture/ex13.png)

  ### 4. 시각화
  - `plot` 함수를 이용하여 데이터를 시각화
  - `plot(rules, method="scatterplot")`
    - 산점도를 그림
    - 내가 가진 데이터를 가지고 연관규칙분석을 했을 때, support confidence 등 전반적인 것을 보여준다
  - `plot(rules, method="graph", control=list(type = "items", alpha = 1))`
    - 그래프를 그림 (동그라미 하나가 규칙, 들어오는 화살표가 조건, 나가는게 결과)
  - `plot(rules, method="paracoord", control=list(reorder=TRUE))`

  ```bash
  # 데이터를 plot 함수로 시각화
  plot(rules, method="scatterplot")
  plot(rules, method="graph", control=list(type = "items", alpha = 1))
  plot(rules, method="paracoord", control=list(reorder=TRUE))
  ```

  - 적용 결과

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/AssociationRuleMining_R/picture/ex14.png)

---
## 예제 2 - Groceries : 쇼핑 연관 규칙 찾기
  ### 1. 데이터 불러오기 및 빈도수 구하기
  - Groceries 데이터를 불러옴
  - 결과 해석
    - 9834 X 169 데이터 존재
    - 흰 우유는 2513 번 구매 ... 등등
    - 하나만 산 사람(영수증)은 2159개 (하나는 의미 없지만 모수 계산시에 쓰인다.)
    - 두개 산 영수증은 1643개, 32개(max) 산 영수증은 1개

  ```bash
  # 데이터 불러오기
  data("Groceries")
  summary(Groceries)
  str(Groceries)
  inspect(Groceries)
  ```

  - 적용 결과 (summary 결과)

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/AssociationRuleMining_R/picture/ex21.png)

  ### 2. 빈발 빈도수 차트 그리기(가져오기) - 참고
  - minimum support 값을 정하여 빈발 아이템의 빈도수를 구할 수 있다.

  ```bash
  # 빈발 아이템셋 차트 그리기
  itemFrequencyPlot(Groceries, support = 0.05, cex.names=0.8)
  ```

  - 적용 결과

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/AssociationRuleMining_R/picture/ex22.png)

  ### 3. apriori algorithm 을 이용하여 rule 생성 및 분석
  - `minimum support` 를 0.001 , `minimum confidence` 를 0.5 로 설정
  - 특정 조건에 따라 정렬 가능(ex> lift!!!)

  ```bash
  # rule 생성
  rules <- apriori(Groceries, parameter=list(support=0.001, confidence=0.5))
  rules # 출럭 : 5668

  # lift를 기준으로 앞 3개 출력
  inspect(head(sort(rules, by="lift"),3))
  ```

  - 적용 결과

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/AssociationRuleMining_R/picture/ex23.png)

  ### 4. 데이터 꺼내기(csv 파일로 꺼내기) - 참고
  - 만들어진 규칙을 파일로 뺄 수 있다.

  ```bash
  # 데이터 csv 로 저장
  write.csv(as(rules, "data.frame"), "Groceries_rules.csv", row.names = FALSE)
  ```

  ### 5. 시각화
  - plot 함수 이용

  ```bash
  # plot 함수를 이용한 시각화
  plot(rules)
  plot(rules, method="grouped")
  ```

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/AssociationRuleMining_R/picture/ex24.png)

---

## 참고1 - 예제 2 에서 빈도수로 wordcloud 그리기
  ### 1. 사용할 네임과 빈도수 구하기
  - `itemLabels` : Groceries 에서 Name 집합을 가져옴
  - `itemFrequency` : 각각의 네임마다 빈도수를 구함

  ```bash
  # 사용할 조건 정함
  itemName <- itemLabels(Groceries)
  itemCount <- itemFrequency(Groceries)*9835
  ```

  ### 2. wordcloud 그리기
  - `brewer.pal` : 칼라 팔레트, 보통 이미 지정되어 있는것을 사용
  - wordcloud(데이터셋, 빈도수, 최소개수, 글자크기, 색, 랜덤순서)
    - 글자크기 : scale 로 아래는 최대크기 5, 최소크기 0.2 로 설정

  ```bash
  # wordcloud 그리기
  col <- brewer.pal(8, "Dark2")
  wordcloud(words = itemName, freq = itemCount, min.freq = 1, scale = c(5, 0.2), col = col , random.order = FALSE)
  ```

  ![](https://github.com/Lee-KyungSeok/MultivariateDataAnalysis-Study/blob/master/AssociationRuleMining_R/picture/ex25.png)
