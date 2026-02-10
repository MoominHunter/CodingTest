def solution(intStrs, k, s, l):
    answer = []
    
    for i in intStrs:       # i: "01234....", "987654..."
        num = int(i[s:s+l])
        if k < num:
            answer.append(num)
        
    
    return answer