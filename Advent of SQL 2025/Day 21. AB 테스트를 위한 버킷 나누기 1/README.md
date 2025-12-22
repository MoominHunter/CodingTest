# [Day 21] A/B 테스트를 위한 버킷 나누기 1

[문제 링크](https://solvesql.com/problems/ab-testing-buckets-1/)

### 제출 일자

2025년 12월 22일 23:37

### 문제 설명

Store Sales in Winter 데이터베이스는 어떤 쇼핑몰 프랜차이즈의 2018년부터 2023년까지의 11월, 12월 상품 판매 기록을 담은 데이터베이스 입니다.

당신은 온라인 쇼핑몰의 지표 개선을 위해 웹사이트 디자인의 개편을 준비하고 있습니다. 새로운 디자인이 지표 개선을 이끄는지 확인하기 위해 신규 디자인을 전체 10% 사용자에게만 먼저 새로운 디자인을 적용하는 A/B 테스트를 진행하기로 했습니다.

당신은 고객 ID가 연속된 정수라는 점에 착안해 10으로 나눈 나머지가 0인 사용자를 그룹 A, 나머지 사용자를 그룹 B에 배정하고 A 그룹에 배정된 사용자만 신규 디자인을 보도록 작업하고자 합니다.

데이터베이스를 조회해 전체 고객별 할당된 그룹을 구하는 쿼리를 작성해주세요. 쿼리 결과에는 아래 컬럼이 있어야 하고, 고객 ID 기준 오름차순 정렬되어 있어야 합니다.


- customer_id: 고객 ID
- bucket: 할당된 사용자 그룹 (A, B)

---

### 정답

```sql

-- A: customer_id % 10 = 0 -> new_design
-- B: others
SELECT
  DISTINCT customer_id
  , IF(customer_id % 10 = 0, 'A', 'B') AS 'bucket'
FROM
  transactions
ORDER BY
  customer_id
;

```

### 새로 배운 것
- DISTINCT를 잘 활용하기
- 처음으로 IF문을 직접 작성했다!
