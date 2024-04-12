.data
# Task 1: 3-byte UTF-8 to code point: INPUT 0x00e8aa9e OUTPUT 0x00008a9e
INPUT: .word 0x00e8aa9e
TARGET: .word 0x00008a9e
SUCCESS_MSG: .asciiz "Test successful\n"
FAIL_MSG: .asciiz "Test failed\n"

.text
main:
  # Load the address of INPUT into $a3
  la $a3 INPUT
  # Load the value at the address in $a3 into $a3
  lw $a3 0($a3)

  # your code here

  # Extracting relevant bits to construct the code point
  srl $t0, $a3, 16     	     # Extracts first byte 
  andi $t1, $a3, 0xFF00      # Extract the second byte 
  srl $t1, $t1, 8            # Extract the second byte 
  sll $t2, $a3, 24           # Extracts the third byte
  srl $t2, $t2, 24           # Extracts the third byte 
	
  # removing the frame
  andi $t0, $t0, 0x0F         # Removes the first four bits from first byte 
  andi $t1, $t1, 0x3F         # Remove the first two bits from the second byte 
  andi $t2, $t2, 0x3F         # Remove the first two bits from the third byte 
 
  # Combining the bytes to construct the code point
  sll $t0, $t0, 12           # Shift the first byte to the left
  sll $t1, $t1, 6            # Shift the second byte to the left
  or $a2, $t0, $t1           # Combine the first and second bytes
  or $a2, $a2, $t2           # Combine the result with the third byte


  # your code ends

  # Load the address of TARGET into $a3
  la $a3 TARGET
  # Load the value at the address in $a3 into $a3
  lw $a3 0($a3)

  # Check if the result matches the target
  beq $a2 $a3 SUCCESS
  # Print failure message
  la $a0, FAIL_MSG
  li $v0 4
  syscall
  b END

SUCCESS:
  # Print success message
  la $a0, SUCCESS_MSG
  li $v0 4
  syscall

END:
  li $v0 10
  syscall # exit
# End of program