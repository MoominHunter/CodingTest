def solution(num_list):
    
    a = 1
    b = 0
    
    for i in num_list:
        a *= i
        b += i
    
    b = b * b

    if a <  b:
        return 1
    elif a > b:
        return 0
    