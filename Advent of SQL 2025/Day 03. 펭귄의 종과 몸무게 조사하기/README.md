# [Day 03] 펭귄의 종과 몸무게 조사하기

[문제 링크](https://solvesql.com/problems/species-and-mass-of-penguins/) 

### 제출 일자

2025년 12월 3일 23:56

### 문제 설명

Palmer Penguins 데이터베이스는 남극 Palmer Archipelago 지역에 서식 중인 펭귄의 종, 서식지, 신체 특징 정보가 들어있습니다.

펭귄의 종과 펭귄의 몸무게의 관계에 대해서 알아보기 위해 기초 데이터를 추출하려고 합니다. penguins 테이블에서 펭귄의 종, 몸무게 정보가 담긴 열을 출력하는 쿼리를 작성해주세요. 펭귄의 종 또는 몸무게 데이터가 없는 개체는 쿼리 결과에서 제외해주세요.

결과는 펭귄의 몸무게가 무거운 순서대로 정렬하고, 만약 몸무게가 같다면 펭귄의 종 이름으로 오름차순 정렬해주세요. 쿼리 결과에는 아래 컬럼이 포함되어 있어야 합니다.


species: 펭귄의 종
body_mass_g: 펭귄의 몸무게(g)

---
### 정답

```sql
SELECT species, body_mass_g
FROM penguins
WHERE (species IS NOT NULL) & (body_mass_g IS NOT NULL)
ORDER BY body_mass_g DESC, species ASC
;
```
