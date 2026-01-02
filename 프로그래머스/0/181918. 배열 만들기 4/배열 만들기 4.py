def solution(arr):
    stk = []
    i = 0

    while i < len(arr):
        if not stk:              # stk가 비었으면
            stk.append(arr[i])
            i += 1
        elif stk[-1] < arr[i]:   # 마지막 원소가 더 작으면 push
            stk.append(arr[i])
            i += 1
        else:                    # 마지막 원소가 크거나 같으면 pop
            stk.pop()

    return stk
