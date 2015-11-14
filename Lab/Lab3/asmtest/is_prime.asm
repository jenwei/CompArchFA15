# $a0 is N
# $t0 is a possible factor of N
# $t1 is multiples of $t0
addi $a0, $zero, 100


addi $t0, $zero, 1
beq $a0, 0 NOTPRIME
beq $a0, 1 NOTPRIME 
NEXT_FACT:
addi $t0, $t0, 1
beq $t0, $a0, PRIME
add $t1, $t0, $zero
ADD_LOOP:
add $t1, $t1, $t0
blt $t1, $a0, ADD_LOOP
beq $t1, $a0, NOTPRIME
bgt $t1, $a0, NEXT_FACT
NOTPRIME:
#return that N is not prime
addi $v0, $zero, 0xb00b
j END
PRIME:
#return that N is prime
addi $v0, $zero, 0x666
END: