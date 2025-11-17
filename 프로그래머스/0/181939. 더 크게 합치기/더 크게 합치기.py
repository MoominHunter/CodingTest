def solution(a, b):
    
    a = str(a)
    b = str(b)
    
    ab = int(a+b)
    ba = int(b+a)
    
    if ab > ba:
        answer = ab
    else:
        answer = ba
    
    return answer