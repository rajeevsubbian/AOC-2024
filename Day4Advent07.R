# Function to count occurrences of 'XMAS' in the grid
count_xmas_occurrences <- function(grid) {
  word <- "XMAS"
  word_len <- nchar(word)
  count <- 0
  rows <- nrow(grid)
  cols <- ncol(grid)
  
  # Check horizontal (left to right and right to left)
  for (r in 1:rows) {
    for (c in 1:(cols - word_len + 1)) {
      if (paste(grid[r, c:(c + word_len - 1)], collapse = "") == word) {
        count <- count + 1
      }
      if (paste(rev(grid[r, c:(c + word_len - 1)]), collapse = "") == word) {
        count <- count + 1
      }
    }
  }
  
  # Check vertical (top to bottom and bottom to top)
  for (c in 1:cols) {
    for (r in 1:(rows - word_len + 1)) {
      vertical_word <- paste(grid[r:(r + word_len - 1), c], collapse = "")
      if (vertical_word == word) {
        count <- count + 1
      }
      if (paste(rev(strsplit(vertical_word, NULL)[[1]]), collapse = "") == word) {
        count <- count + 1
      }
    }
  }
  
  # Check diagonals (both directions)
  for (r in 1:(rows - word_len + 1)) {
    for (c in 1:(cols - word_len + 1)) {
      # Diagonal: top-left to bottom-right
      diagonal_lr <- paste(diag(grid[r:(r + word_len - 1), c:(c + word_len - 1)]), collapse = "")
      if (diagonal_lr == word) {
        count <- count + 1
      }
      if (paste(rev(strsplit(diagonal_lr, NULL)[[1]]), collapse = "") == word) {
        count <- count + 1
      }
      
      # Diagonal: top-right to bottom-left
      diagonal_rl <- paste(diag(grid[r:(r + word_len - 1), (c + word_len - 1):c]), collapse = "")
      if (diagonal_rl == word) {
        count <- count + 1
      }
      if (paste(rev(strsplit(diagonal_rl, NULL)[[1]]), collapse = "") == word) {
        count <- count + 1
      }
    }
  }
  
  return(count)
}

# Function to read the grid from a file
read_grid_from_file <- function(file_path) {
  # Read the file and split each line into a vector of characters
  lines <- readLines(file_path)
  grid <- sapply(lines, function(line) unlist(strsplit(line, NULL)))
  grid <- t(grid)  # Transpose to create a matrix
  return(grid)
}

# Example usage
file_path <- "~/Documents/R/Advent24/day0401.txt"  # Path to the input file
grid <- read_grid_from_file(file_path)

# Call the function to count occurrences of 'XMAS'
result <- count_xmas_occurrences(grid)

# Print the result
cat("Total occurrences of 'XMAS':", result, "\n")
