def solution(l, r):
    ans = []
    max_len = len(str(r))

    def dfs(s):
        # s는 현재 만든 문자열
        if s:
            if s[0] != '0':  # leading zero 방지
                x = int(s)
                if l <= x <= r:
                    ans.append(x)

        if len(s) == max_len:
            return

        dfs(s + '0')
        dfs(s + '5')

    dfs("")  # 빈 문자열에서 시작
    ans.sort()
    return ans if ans else [-1]
