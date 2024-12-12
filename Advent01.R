# Read the CSV file
data <- read.csv("~/Documents/R/Advent24/advent01.csv")

# Extract the left and right lists
left <- data$left
right <- data$right

# Sort both lists
sorted_left <- sort(left)
sorted_right <- sort(right)

# Calculate the total distance
total_distance <- sum(abs(sorted_left - sorted_right))

# Output the result
cat("The total distance between the lists is:", total_distance, "\n")
