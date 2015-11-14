# Our First Assembly Program
#   Compute the average of 4 inputs

# Input operands
addi $t0, $zero, 14
addi $t1, $zero, 5
addi $t2, $zero, 7
addi $t3, $zero, 10

# Compute average, store in $t5
add	$t5, $t0, $t1	# $t5 = $t0 + $t1
add	$t5, $t5, $t2	# $t5 += $t2 
add	$t5, $t5, $t3	# $t5 += $t3
sra 	$t5, $t5, 2	# $t5 /= 4
