import re

def process_file(file_path):
    # Read the contents of the file
    with open(file_path, 'r') as file:
        corrupted_memory = file.read().replace("\n", " ")
    
    # Regular expression patterns
    mul_pattern = r"mul\((\d+),(\d+)\)"  # Matches valid mul(n1,n2)
    do_pattern = r"do\(\)"               # Matches do()
    dont_pattern = r"don't\(\)"          # Matches don't()
    
    # Initialize state
    is_enabled = True  # Multiplications are enabled by default
    total_sum = 0      # Total sum of valid mul results
    pos = 0            # Position tracker in the string

    # Process the corrupted memory
    while pos < len(corrupted_memory):
        # Search for the next relevant pattern
        next_mul = re.search(mul_pattern, corrupted_memory[pos:])
        next_do = re.search(do_pattern, corrupted_memory[pos:])
        next_dont = re.search(dont_pattern, corrupted_memory[pos:])
        
        # Determine the closest match
        next_matches = [
            (next_mul, "mul"),
            (next_do, "do"),
            (next_dont, "don't")
        ]
        next_matches = [(m, t) for m, t in next_matches if m]  # Filter out None matches
        if not next_matches:
            break  # No more matches, stop processing
        
        # Get the earliest match
        next_match, match_type = min(next_matches, key=lambda x: x[0].start())
        start, end = next_match.span()
        match_text = corrupted_memory[pos + start:pos + end]
        
        if match_type == "mul" and is_enabled:
            # Process a valid mul instruction
            n1, n2 = map(int, next_match.groups())
            total_sum += n1 * n2
        elif match_type == "do":
            # Enable processing
            is_enabled = True
        elif match_type == "don't":
            # Disable processing
            is_enabled = False
        
        # Move position past the current match
        pos += end
    
    return total_sum

# Example usage
file_path = "day0302.txt"  # Replace with the actual file path
result = process_file(file_path)
print(f"The total sum of valid multiplications is: {result}")
