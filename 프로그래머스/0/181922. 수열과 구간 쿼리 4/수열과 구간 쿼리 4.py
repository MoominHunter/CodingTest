def solution(arr, queries):
    for s, e, k in queries:
        # k는 1~5 이므로 0으로 나누는 케이스는 없음(문제 조건)
        for i in range(s, e + 1):
            if i % k == 0:
                arr[i] += 1
    return arr
