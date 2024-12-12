# Load data from CSV
data <- read.csv("~/Documents/R/Advent24/advent02.csv") 

# Extract the left and right lists
left_list <- data$left
right_list <- data$right

# Calculate the similarity score
similarity_score <- 0

for (num in left_list) {
  # Count occurrences of 'num' in the right list
  frequency <- sum(right_list == num)
  
  # Add to the similarity score
  similarity_score <- similarity_score + (num * frequency)
}

# Print the similarity score
cat("The total similarity score is:", similarity_score, "\n")
