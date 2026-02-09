def solution(number):
    answer = 0
    
    for i in range(len(number)):
        answer += int(number[i])
        
    answer %= 9
    
    return answer