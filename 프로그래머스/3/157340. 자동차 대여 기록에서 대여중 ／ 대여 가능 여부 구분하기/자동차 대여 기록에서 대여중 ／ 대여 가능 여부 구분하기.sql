-- CAR_RENTAL_COMPANY_RENTAL_HISTORY: HISTORY_ID, CAR_ID, START_DATE, END_DATE

-- 컬럼 추가: 2022년 10월 16일에 대여 중인 자동차는 '대여중', 아닐 경우 '대여 가능'
select CAR_ID, case when car_id in (select CAR_ID 
                          from CAR_RENTAL_COMPANY_RENTAL_HISTORY 
                          where start_date <= '2022-10-16' and end_date >= '2022-10-16' 
                          group by car_id
                          ) then '대여중'
                else '대여 가능' end AVAILABILITY
from CAR_RENTAL_COMPANY_RENTAL_HISTORY 
group by car_id
order by car_id desc