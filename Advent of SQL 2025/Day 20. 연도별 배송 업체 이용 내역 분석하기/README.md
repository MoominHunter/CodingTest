# [Day 20] 연도별 배송 업체 이용 내역 분석하기

[문제 링크](https://solvesql.com/problems/yearly-shipping-usage/)

### 제출 일자

2025년 12월 20일 23:35

### 문제 설명

Store Sales in Winter 데이터베이스는 어떤 쇼핑몰 프랜차이즈의 2018년부터 2023년까지의 11월, 12월 상품 판매 기록을 담은 데이터베이스 입니다.

최근 온라인 쇼핑몰의 판매량이 오프라인 지점들의 판매량을 추월했기에 배송 업체와 계약을 유리한 조건으로 하는 것이 실적 개선에 중요한 부분이 되었습니다. 현재 온라인 쇼핑몰에서 제공하고 있는 배송 옵션은 일반 배송(Standard), 빠른 배송(Express), 익일 특급(Overnight) 세 종류 입니다.

내년도 배송 업체 계약을 위해 연도별 배송 업체 이용 건수의 통계를 집계하려고 합니다. 온라인 쇼핑몰의 판매 내역에서 반품이 발생할 경우, 반품 회수를 위해 '일반 배송(Standard)' 서비스가 추가로 1회 이용됩니다. 데이터베이스에는 반품된 거래에 대한 추가 배송 기록이 없기 때문에 고객이 선택한 원래 배송 옵션과 별개로 반품 건수를 일반 배송 이용 실적에 합산하여 집계해야 합니다.

데이터베이스를 조회해 배송 업체 이용 건수를 배송 옵션 별로 집계하는 쿼리를 작성해주세요. 쿼리 결과는 아래 컬럼이 있어야 하고, 연도 기준 오름차순 정렬이 되어있어야 합니다.


- year: 연도
- standard: 일반 배송 이용 건수
- express: 빠른 배송 이용 건수
- overnight: 익일 배송 이용 건수


결과 테이블 예시

|year |standard	| express	| overnight |
| -- | -- |-- | -- |
| 2018	| ... | 	...| 	..|
|...	|...	|...	|..|


---

### 정답

```sql
SELECT
  YEAR(purchased_at) AS 'year',
  -- standard = 기본 배송 + 반품 추가
  SUM(CASE WHEN shipping_method = 'Standard' THEN 1 ELSE 0 END)
+ SUM(CASE WHEN is_returned = 1 THEN 1 ELSE 0 END) AS standard,

  SUM(CASE WHEN shipping_method = 'Express' THEN 1 ELSE 0 END) AS express,
  SUM(CASE WHEN shipping_method = 'Overnight' THEN 1 ELSE 0 END) AS overnight
FROM transactions
WHERE is_online_order = 1
GROUP BY YEAR(purchased_at)
ORDER BY YEAR(purchased_at)
;
```

### 새로 배운 것
- 반품 내역에 대한 집계를 어떻게 더해야 할지 고민했다. SQL에서 연산은 안 되는 줄 알았는데 CASE 문을 사용하여 SELECT 문에서도 연산이 가능함을 알게 되었다.
- 문법에만 집중하지 않고, 윈도우 함수를 더 확실히 공부해야 함을 느꼈다. 그래야 풀이 방법이 막히지 않고 바로 머릿속에 떠오를 것 같다.
