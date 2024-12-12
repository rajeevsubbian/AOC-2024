# Function to check if a report is safe
is_safe <- function(report) {
  # Calculate the differences between consecutive levels
  diffs <- diff(report)
  
  # Check if all differences are within [-3, -1] (decreasing) or [1, 3] (increasing)
  if (all(diffs >= 1 & diffs <= 3) || all(diffs <= -1 & diffs >= -3)) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

# Read data from a file (adjust the filename as needed)
# Each line in the file contains a space-separated list of numbers
data <- readLines("~/Documents/R/Advent24/day2advent03.txt")

# Parse each line into a numeric vector
reports <- lapply(data, function(line) as.numeric(unlist(strsplit(line, " "))))

# Check each report and count the safe ones
safe_count <- sum(sapply(reports, is_safe))

# Output the result
cat("Number of safe reports:", safe_count, "\n")
