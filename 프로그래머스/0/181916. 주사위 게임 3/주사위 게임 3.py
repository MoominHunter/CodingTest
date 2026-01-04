from collections import Counter

def solution(a, b, c, d):
    cnt = Counter([a, b, c, d])
    items = sorted(cnt.items(), key=lambda x: (-x[1], -x[0]))  # (눈, 개수) 개수↓, 눈↓
    
    # 1) 네 개 모두 같음
    if len(cnt) == 1:
        p = items[0][0]
        return 1111 * p
    
    # 2) 세 개 같고 하나 다름
    if len(cnt) == 2:
        (p, cp), (q, cq) = items[0], items[1]
        if cp == 3:  # 3개-1개
            return (10 * p + q) ** 2
        else:        # 2개-2개
            return (p + q) * abs(p - q)
    
    # 3) 한 쌍 + 나머지 서로 다름
    if len(cnt) == 3:
        p = items[0][0]  # 2개 나온 값
        others = [x for x, c_ in cnt.items() if c_ == 1]  # q, r
        return others[0] * others[1]
    
    # 4) 모두 다름
    return min(a, b, c, d)
