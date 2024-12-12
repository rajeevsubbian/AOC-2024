with open('day09.txt', 'r') as f:
    disk_map = [int(x) for x in f.readlines()[0]]

memory1 = []
is_file = True
id_num = 0
for num in disk_map:
    if is_file:
        for _ in range(num):
            memory1.append(id_num)
        id_num += 1
    else:
        for _ in range(num):
            memory1.append(None)
    is_file = not is_file
memory2 = memory1[:]

def checksum(mem):
    result = 0
    for i, id_num in enumerate(mem):
        if id_num is not None:
            result += i*id_num
    return result

# part 1
def defrag1(mem):
    p_free = 0
    p_file = len(mem)-1
    while True:
        # push p_free forwards
        while p_free < p_file and mem[p_free] is not None:
            p_free += 1
        # pull p_file back
        while p_free < p_file and mem[p_file] is None:
            p_file -= 1
        if p_free >= p_file:
            return
        mem[p_free], mem[p_file] = mem[p_file], mem[p_free]

defrag1(memory1)
print(checksum(memory1))

