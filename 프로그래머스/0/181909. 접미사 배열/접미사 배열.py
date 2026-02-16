def solution(my_string):
    answer = []
    
    # [-1:] [-2:] [-3:] ,,, [-len(my_string):] 
    for i in range(1, len(my_string)+1):
        answer.append(my_string[-i:])
    
    # 알파벳 순으로 배열(set의 특징 이용)
    answer.sort()
    
    return answer