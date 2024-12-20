from collections import deque
def parse_data(my_file) -> list:
    with open(my_file) as f:
        return [tuple(int(num) for num in line.split(',')) for line in f.readlines()]
def part1(corrupted:set, end: tuple = (70,70)) -> int:
    dirs = [(1,0),(-1,0),(0,1),(0,-1)]
    start = (0,0)
    candidates = deque()
    candidates.append(start)
    visited = {start:0}
    while candidates:
        current = candidates.popleft()
        x, y = current
        new_steps = visited[current]+1
        valid = {new for dx,dy in dirs if (0<=(new:=(x+dx,y+dy))[0]<=end[0] and 0<=new[1]<=end[1] and new not in visited)} - corrupted
        if end in valid:
            return new_steps
        candidates.extend(valid)
        visited |= {v:new_steps for v in valid}
    return None
def part2(data:list, min_idx: int =1024, end: tuple = (70,70)) -> str:
    max_idx = len(data)-1
    while min_idx < max_idx:
        idx = (max_idx+min_idx)//2
        if part1(set(data[:idx+1]), end):
            min_idx = idx+1
        else:
            max_idx = idx-1
    return (','.join(str(num) for num in data[max_idx]))

data = parse_data('day18.txt')
print('Part 1: ', part1(set(data[:1024])))
print('Part 2 incorrect answer refer next program: ', part2(data))