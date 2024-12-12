# Function to calculate the sum of valid mul instructions from the file
calculate_mul_sum <- function(file_path) {
  # Read the contents of the text file
  corrupted_memory <- readLines(file_path)
  
  # Combine all lines into a single string (if the file has multiple lines)
  corrupted_memory <- paste(corrupted_memory, collapse = " ")
  
  # Regular expression to match valid mul instructions
  pattern <- "mul\\((\\d{1,3}),\\s*(\\d{1,3})\\)"
  
  # Find all matches for the pattern in the corrupted memory
  matches <- regmatches(corrupted_memory, gregexpr(pattern, corrupted_memory))
  
  # Flatten the list of matches and extract the numbers from the match
  valid_muls <- unlist(matches)
  
  # Initialize sum
  total_sum <- 0
  
  # Loop through each valid mul instruction
  for (mul_instruction in valid_muls) {
    # Extract the two numbers from the instruction
    nums <- as.numeric(unlist(strsplit(gsub("[^0-9,]", "", mul_instruction), ",")))
    
    # Calculate the product and add to the total sum
    total_sum <- total_sum + (nums[1] * nums[2])
  }
  
  return(total_sum)
}

# Example usage
file_path <- "~/Documents/R/Advent24/corrupted_memory.txt"  # Path to your text file
result <- calculate_mul_sum(file_path)
cat("The total sum of valid multiplications is:", result, "\n")