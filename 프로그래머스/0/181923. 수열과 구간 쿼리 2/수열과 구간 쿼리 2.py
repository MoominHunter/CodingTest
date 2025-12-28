def solution(arr, queries):
    answer = []
    for s, e, k in queries:
        best = 10**9 
        for i in range(s, e + 1):
            v = arr[i]
            if v > k and v < best:
                best = v
        answer.append(best if best != 10**9 else -1)
    return answer
