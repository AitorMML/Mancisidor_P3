.text

	nop
	addi $s0, $zero, 8
	addi $s1, $zero, 0x10010000
	addi $s3, $zero, 0x10010004
	nop
	sw $s0, 0($s1)
	nop
	nop
	lw $s2, 0($s1)
	sw $s2, 0($s3)







	nop
	addi $s0, $zero, 5

	add $s1, $zero, $s0
	add $s2, $s0, $zero
