# Check if a report is safe
is_safe <- function(levels) {
  differences <- diff(levels)
  all_increasing <- all(differences > 0 & differences <= 3)
  all_decreasing <- all(differences < 0 & differences >= -3)
  return(all_increasing || all_decreasing)
}

# Check if removing one level makes the report safe
can_be_safe_by_removal <- function(levels) {
  n <- length(levels)
  for (i in 1:n) {
    modified_levels <- levels[-i]  # Remove the i-th level
    if (is_safe(modified_levels)) {
      return(TRUE)
    }
  }
  return(FALSE)
}

# Process reports and count safe ones
process_reports <- function(file_path) {
  data <- readLines(file_path, warn = FALSE)
  safe_count <- 0
  
  for (line in data) {
    levels <- as.numeric(unlist(strsplit(line, " ")))
    if (is_safe(levels) || can_be_safe_by_removal(levels)) {
      safe_count <- safe_count + 1
    }
  }
  
  return(safe_count)
}

# Main program
file_path <- "~/Documents/R/Advent24/day2advent04.txt"
safe_reports <- process_reports(file_path)
cat("Number of safe reports:", safe_reports, "\n")
