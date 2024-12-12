process_file <- function(file_path) {
  # Read the contents of the file
  corrupted_memory <- paste(readLines(file_path), collapse = " ")
  
  # Regular expression patterns
  mul_pattern <- "mul\\((\\d+),(\\d+)\\)"  # Matches valid mul(n1,n2)
  do_pattern <- "do\\(\\)"                 # Matches do()
  dont_pattern <- "don't\\(\\)"            # Matches don't()
  
  # Initialize state
  is_enabled <- TRUE  # Multiplications are enabled by default
  total_sum <- 0      # Total sum of valid mul results
  pos <- 1            # Position tracker in the string
  
  while (pos <= nchar(corrupted_memory)) {
    # Search for the next relevant pattern
    next_mul <- regexpr(mul_pattern, substr(corrupted_memory, pos, nchar(corrupted_memory)))
    next_do <- regexpr(do_pattern, substr(corrupted_memory, pos, nchar(corrupted_memory)))
    next_dont <- regexpr(dont_pattern, substr(corrupted_memory, pos, nchar(corrupted_memory)))
    
    # Check if any pattern matches
    next_matches <- list()
    
    if (next_mul != -1) next_matches <- append(next_matches, list(list(next_mul, "mul")))
    if (next_do != -1) next_matches <- append(next_matches, list(list(next_do, "do")))
    if (next_dont != -1) next_matches <- append(next_matches, list(list(next_dont, "don't")))
    
    # If no more matches, stop
    if (length(next_matches) == 0) break
    
    # Extract the positions of the matches
    match_positions <- sapply(next_matches, function(x) x[[1]])
    
    # Find the smallest position (the next match)
    next_match_pos <- min(match_positions)
    
    # Find the match with the smallest position
    next_match <- next_matches[[which(match_positions == next_match_pos)]]
    match_type <- next_match[[2]]
    
    # Extract match position
    match_start <- attr(next_match[[1]], "match.start")
    match_end <- attr(next_match[[1]], "match.end")
    
    # Process the match based on its type
    if (match_type == "mul" && is_enabled) {
      # Extract the two numbers from the mul instruction
      mul_instruction <- substr(corrupted_memory, pos + match_start - 1, pos + match_end - 2)
      nums <- as.numeric(unlist(strsplit(gsub("[^0-9,]", "", mul_instruction), ",")))
      total_sum <- total_sum + (nums[1] * nums[2])
    } else if (match_type == "do") {
      # Enable future mul instructions
      is_enabled <- TRUE
    } else if (match_type == "don't") {
      # Disable future mul instructions
      is_enabled <- FALSE
    }
    
    # Move the position past the current match
    pos <- pos + match_end - 1
  }
  
  return(total_sum)
}

# Example usage
file_path <- "~/Documents/R/Advent24/corrupted_memory2.txt"
result <- process_file(file_path)
cat("The total sum of valid multiplications is:", result, "\n")