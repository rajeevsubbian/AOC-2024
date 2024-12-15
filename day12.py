def load_and_pad_input(filename):
    grid = []
    with open(filename, "rt") as fin:
        for line in fin:
            grid.append(line.strip() + ".")  # padding to not care about indexing
        grid.append("." * len(grid[0]))  # more padding
    return grid


def dfs(grid, start):
    plant_type = grid[start[0]][start[1]]
    visited = set()
    queue = set()
    queue.add(start)

    while queue:
        row, col = queue.pop()
        if (row, col) in visited:
            continue

        visited.add((row, col))

        if grid[row - 1][col] == plant_type:
            queue.add((row - 1, col))
        if grid[row + 1][col] == plant_type:
            queue.add((row + 1, col))
        if grid[row][col - 1] == plant_type:
            queue.add((row, col - 1))
        if grid[row][col + 1] == plant_type:
            queue.add((row, col + 1))

    return visited


def fence_cost(grid, region, plant_type):
    perimeter, shared_borders = 0, 0

    for row, col in region:
        # up
        if grid[row - 1][col] != plant_type:
            perimeter += 1
            # left neighbor
            if grid[row][col - 1] == plant_type and grid[row - 1][col - 1] != plant_type:
                shared_borders += 1
        # down
        if grid[row + 1][col] != plant_type:
            perimeter += 1
            # left neighbor
            if grid[row][col - 1] == plant_type and grid[row + 1][col - 1] != plant_type:
                shared_borders += 1
        # left
        if grid[row][col - 1] != plant_type:
            perimeter += 1
            # up neighbor
            if grid[row - 1][col] == plant_type and grid[row - 1][col - 1] != plant_type:
                shared_borders += 1
        # right
        if grid[row][col + 1] != plant_type:
            perimeter += 1
            # up neighbor
            if grid[row - 1][col] == plant_type and grid[row - 1][col + 1] != plant_type:
                shared_borders += 1

    return len(region) * perimeter, len(region) * (perimeter - shared_borders)


def main():
    grid = load_and_pad_input("day12.txt")
    plot_positions = {(row, col) for row in range(len(grid) - 1) for col in range(len(grid[0]) - 1)}
    cost_part1, cost_part2 = 0, 0

    while plot_positions:
        start = plot_positions.pop()
        region = dfs(grid, start)
        p1, p2 = fence_cost(grid, region, grid[start[0]][start[1]])
        cost_part1 += p1
        cost_part2 += p2
        plot_positions -= region

    print(f"Part 1: {cost_part1}")
    print(f"Part 2: {cost_part2}")


# Part 1: 1457298
# Part 2: 921636

if __name__ == "__main__":
    main()