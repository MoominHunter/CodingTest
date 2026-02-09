def solution(my_string, queries):
    
    for i in queries:
        s = i[0]  # 2, 0
        e = i[1]  # 3, 7

        # 역순으로 저장
        str1 = my_string[s:e+1][::-1]  
        
        # my_string의 원래 위치[s:e]에 str1 대치
        my_string = my_string[:s] + str1 + my_string[e+1:]
        
        
    return my_string