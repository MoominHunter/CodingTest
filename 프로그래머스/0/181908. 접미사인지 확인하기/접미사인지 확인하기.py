def solution(my_string, is_suffix):
    
    # 접미사를 담은 list 만들기
    li1 = []
    
    for i in range(0, len(my_string)):
        li1.append(my_string[i:])
        
    # is_suffix가 list안에 있는지 확인하기
    if is_suffix in li1:
        return 1
    else:
        return 0