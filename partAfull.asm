.data
Prompt1: .asciiz "$a1 contains: "
Prompt2: .asciiz "\n$a2 contains: "
Return: .asciiz "\n"

.text
main:
lui $a3, 4096 # We are going to save inputs to the start of the user data segment
li $a2 5
sw $a2 0($a3) # Save x
li $a2 6
sw $a2 4($a3) # Save y
li $a2 7
sw $a2 8($a3) # Save z
li $a2 8
sw $a2 12($a3) # Save w

##### Paste your code after this line
lw $t0, 0($a3)     # Load x into $t0
lw $t1, 4($a3)     # Load y into $t1
lw $t2, 8($a3)     # Load z into $t2
lw $t3, 12($a3)    # Load w into $t3

# Expression 1: (z-6) + (w*x)
subu $t4, $t2, 6        # z - 6
mul $t5, $t0, $t3     # w * x
add $a1, $t4, $t5     # Result is stored in $a1

# Expression 2: (((z+17)*4)-((y%w)/4))
addi $t2, $t2, 17       # z + 17
sll $t2, $t2, 2        # (z + 17) * 4 using shift left
div $t1, $t3           # y / w (using div)
mfhi $t6               # This gets the modulus from HI
srl $t6, $t6, 2        # (y % w) / 4 using shift right
sub $a2, $t2, $t6      # Result is stored in $a2

##### Start of diagnostics
la $a0,Prompt1
li $v0,4
syscall

li $v0 1
move $a0 $a1
syscall # print $a1

la $a0,Prompt2
li $v0 4
syscall

li $v0 1
move $a0 $a2
syscall # print $a2

la $a0, Return
li $v0 4
syscall

li $v0 10
syscall # exit
# End of program


        