# [Day 15] 한국 감독의 영화 찾기

[문제 링크](https://solvesql.com/problems/find-movies-by-korean-artists/)

### 제출 일자

2025년 12월 15일 00:35

### 문제 설명
Museum of Modern Art Collection 데이터베이스는 미국 뉴욕의 근현대 미술관인 MoMA의 작품과 작가 정보를 담고 있습니다. MoMA는 미술품이나 조각상과 같은 물리적인 형태가 있는 작품 이외에도 비디오 아트나 영화 같은 무형의 작품도 소장하고 있습니다.

데이터베이스를 조회해 MoMA가 소장하고 있는 작품 중 한국 감독의 영화를 찾아, 감독 이름과 작품명을 출력하는 쿼리를 작성해주세요. 영화는 artworks 테이블의 classification 컬럼이 Film으로 시작하는 작품입니다.

쿼리 결과에는 아래 컬럼이 포함되어 있어야 합니다.


- artist: 감독 이름
- title: 작품명


---

### 정답

```sql
WITH
  film AS (
    SELECT
      artwork_id,
      title
    FROM
      artworks
    WHERE
      classification LIKE 'Film%'
  )
SELECT
  a.name AS 'artist',
  f.title AS 'title'
FROM
  artworks_artists aa
  JOIN film f ON aa.artwork_id = f.artwork_id
  JOIN artists a ON aa.artist_id = a.artist_id
WHERE
  a.nationality LIKE 'Korean';
```

