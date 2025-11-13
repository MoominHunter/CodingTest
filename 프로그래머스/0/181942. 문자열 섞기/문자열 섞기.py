def solution(str1, str2):
    answer = ''
    i = 0
    
    while (len(answer) < (len(str1)+len(str2))):
        answer += str1[i]
        answer += str2[i]
        i += 1
    
    return answer
