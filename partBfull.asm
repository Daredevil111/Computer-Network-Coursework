.data
MYARRAY: .word 14, 15, 17, 19, 21, 24, 26, 28, 29, 30
INPUT_A1_START: .word 0
INPUT_A2_END: .word 9
Prompt: .asciiz "\n$a2 contains: "
Return: .asciiz "\n"

.text
main:
    # Initialize array address, start index, and end index
    la $a3, MYARRAY
    la $a1, INPUT_A1_START
    lw $a1, 0($a1)
    la $a2, INPUT_A2_END
    lw $a2, 0($a2)

# Initialize count to 0
li $t0, 0

# Loop to iterate over the segment of the array
loop:
    bge $a1, $a2, end_loop  # exit loop if index >= end index

    # Check if i is congruent to 3 mod 4 and a[i] is odd
    li $t5, 4
    div $a1, $t5
    mfhi $t1
    li $t4, 3        # Load the value 3
    beq $t1, $t4, is_congruent
    bnez $t4, not_congruent  # if not congruent to 3 mod 4, skip

    is_congruent:
    lw $t2, 0($a3)  # load the value at array[i]
    andi $t3, $t2, 1  # check if a[i] is odd
    beqz $t3, not_odd  # if not odd, skip

    # Increment count if both conditions are satisfied
    addi $t0, $t0, 1

    not_odd:
    not_congruent:
       
    # Move to the next element
    addi $a1, $a1, 1
    addi $a3, $a3, 4
    j loop

    end_loop:
    # Store the count in $a2
    move $a2, $t0
    # Printout
    la $a0, Prompt
    li $v0, 4
    syscall

    li $v0, 1
    move $a0, $a2
    syscall  # print $a2

    la $a0, Return
    li $v0, 4
    syscall

    li $v0, 10
    syscall  # exit

# End of program