def count_xmas_occurrences(grid):
    word = "XMAS"
    word_len = len(word)
    count = 0
    rows = len(grid)
    cols = len(grid[0])

    # Check horizontal (left to right and right to left)
    for r in range(rows):
        for c in range(cols - word_len + 1):
            if grid[r][c:c + word_len] == list(word):  # Left to right
                count += 1
            if grid[r][c:c + word_len][::-1] == list(word):  # Right to left
                count += 1
    
    print("count1 :" count)

    # Check vertical (top to bottom and bottom to top)
    for c in range(cols):
        for r in range(rows - word_len + 1):
            # Collect vertical word from top to bottom
            vertical_word = [grid[r + i][c] for i in range(word_len)]
            if vertical_word == list(word):  # Top to bottom
                count += 1
            if vertical_word[::-1] == list(word):  # Bottom to top
                count += 1

    # Check diagonals (both directions)
    for r in range(rows - word_len + 1):
        for c in range(cols - word_len + 1):
            # Diagonal: top-left to bottom-right
            diagonal_lr = [grid[r + i][c + i] for i in range(word_len)]
            if diagonal_lr == list(word):  # top-left to bottom-right
                count += 1
            if diagonal_lr[::-1] == list(word):  # bottom-right to top-left
                count += 1
            # Diagonal: top-right to bottom-left
            diagonal_rl = [grid[r + i][c + (word_len - i - 1)] for i in range(word_len)]
            if diagonal_rl == list(word):  # top-right to bottom-left
                count += 1
            if diagonal_rl[::-1] == list(word):  # bottom-left to top-right
                count += 1

    return count


def read_grid_from_file(file_path):
    with open(file_path, 'r') as file:
        # Read each line, strip newline characters, and convert it to a list of characters
        grid = [list(line.strip()) for line in file.readlines()]
    return grid


# Example usage:
# Provide the path to your file
file_path = 'day0401.txt'

# Read the grid from the file
grid = read_grid_from_file(file_path)

# Call the function to count occurrences of 'XMAS'
result = count_xmas_occurrences(grid)

# Print the result
print("Total occurrences of 'XMAS':", result)