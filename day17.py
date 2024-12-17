import re
from copy import deepcopy
def parse_data(my_file) -> tuple:
    with open(my_file) as f:
        registers, program = f.read().split('\n\n')
        registers = {(x:=re.match('Register (\w): (\d+)',reg).groups())[0]:int(x[1]) for reg in registers.split('\n')}
        registers |= {str(num):num for num in range(4)}
        program = [int(num) for num in re.findall('\d',program)]
        return registers,program
def run_prog(regs:dict, program:list) -> list:
    combos = '0123ABC'
    idx = 0
    out = []
    while idx < len(program):
        opcode = program[idx]
        operand = program[idx+1]
        idx+=2
        match opcode:
            case 0|6|7:
                regs['A.....BC'[opcode]] = regs['A']//2**regs[combos[operand]]
            case 1|4:
                regs['B'] = regs['B'] ^ (operand if opcode == 1 else regs['C'])
            case 2:
                regs['B'] = regs[combos[operand]] % 8
            case 3:
                if regs['A'] != 0:
                    idx = operand
            case 5:
                out.append(regs[combos[operand]]%8)
    return out
def part1(data: tuple) -> str:
    return ','.join(str(num) for num in run_prog(*deepcopy(data)))
def part2(data:tuple) -> int:
    program = data[1]
    final_As = [0]
    for level in range(-1,-17,-1):
        step = 8**(len(program)+level)
        new_As = []
        for final_A in final_As:
            for idx in range(8):
                regs = deepcopy(data[0])
                new_A = final_A + step * idx 
                regs['A'] = new_A
                if run_prog(regs,program)[level:] == program[level:]:
                    new_As.append(new_A)
        final_As = new_As
    return final_As[0]

data = parse_data('day17.txt')
print('Part 1: ', part1(data))
print('Part 2: ', part2(data))