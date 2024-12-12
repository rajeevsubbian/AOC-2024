# Function to count X-MAS X-shapes in the grid
count_xmas_x_shape <- function(grid) {
  rows <- nrow(grid)
  cols <- ncol(grid)
  count <- 0
  
  # Iterate through the grid, avoiding edges
  for (r in 2:(rows - 1)) {  # Start at row 2 and end at rows-1
    for (c in 2:(cols - 1)) {  # Start at column 2 and end at cols-1
      # Check if the center is 'A'
      if (grid[r, c] == "A") {
        # Check diagonals for the X-MAS pattern
        if (grid[r - 1, c - 1] == "M" && grid[r + 1, c + 1] == "S" &&
            grid[r + 1, c - 1] == "S" && grid[r - 1, c + 1] == "M") {
          count <- count + 1
        }
      }
    }
  }
  
  return(count)
}

# Function to read the grid from a file
read_grid_from_file <- function(file_path) {
  lines <- readLines(file_path)
  grid <- do.call(rbind, lapply(lines, function(line) strsplit(line, "")[[1]]))
  return(grid)
}

# Main execution
file_path <- "~/Documents/R/Advent24/day0402.txt"  # Replace with your actual file path

# Read the grid from the file
grid <- read_grid_from_file(file_path)

# Count the occurrences of X-MAS X-shapes
result <- count_xmas_x_shape(grid)

# Print the result
cat("Total occurrences of X-MAS X-shape:", result, "\n")
