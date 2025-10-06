def solution(left, right):
    # 초기값 설정
    answer = 0
    
    # left부터 right까지의 수들, 각각 약수의 개수를 세기
    for i in range(left, right+1):
        
        # 약수를 구하는 코드 -> 1부터 n까지 나눠보고 나머지 0이면 약수임.
        count_num = 0   # 약수의 개수 초기값
        
        for j in range(1, i+1):
            if i % j == 0:
                count_num += 1

        # 만약 개수가 짝수면, answer += i
        if count_num % 2 == 0:
            answer += i
        # 개수가 홀수면, answer -= i
        else:
            answer -= i
    
    return answer

