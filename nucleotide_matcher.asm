.data
	chains: .byte 'A','T','G','A','T','G','A','T','G','C'
		.byte 'T','C','G','C','G','C','T','A','G','C'
		.byte 'C','G','T','C','G','T','A','A','A','C'
		.byte 'T','A','T','T','T','A','C','G','A','A'
		.byte 'T','A','C','T','A','C','T','A','C','G'

		
	adenine:  .byte 'A'
	guanine:  .byte 'G'
	cytosine: .byte 'C'
	thymine:  .byte 'T'
		
	size:   .word 5
	length: .word 10

.text
	main:
		la $a0, chains  # a0 = base address
		lw $a1, size    # a1 = row size
		lw $a2, length  # a2 = column size
		
		
		li $s0, 0 # i index
		li $s1, 0 # j index
		li $s2, 0 # k ındex
		
		loopI:
			loopJ:
				loopK: # calculate ik(s0 s2) and jk(s1 s2) 
				beq $s0, $s1, loopKout
				
				jal calculateIndexIK
				lb $s3, ($t2) # s3 = first char
				
				lb $s4, adenine
				beq $s3, $s4, compareT
				
				lb $s4, thymine
				beq $s3, $s4, compareA
				
				lb $s4, guanine
				beq $s3, $s4, compareC
				
				lb $s4, cytosine
				beq $s3, $s4, compareG			
				
				endOfCompare:
				
				addi $s2, $s2, 1
				beq $s2, 10, endProgram
				
				ble $s2, 9, loopK
			loopKout:
			addi $s1, $s1, 1
			li $s2, 0
			ble $s1, 4, loopJ
		addi $s0, $s0, 1
		li $s1, 0
		ble $s0, 4, loopI
		



	endProgram:
		# End program
		addi $s0, #s0, 1
		addi $s1, $s1, 1
		li $v0, 10
		syscall

	compareA:
		jal calculateIndexJK
		lb $s3, ($t2)
		lb $s4, adenine
		beq $s3, $s4, endOfCompare
		
		jal loopKout 
	
	compareT:
		jal calculateIndexJK
		lb $s3, ($t2)
		lb $s4, thymine
		beq $s3, $s4, endOfCompare
		
		jal loopKout 
	
	compareG:
		jal calculateIndexJK
		lb $s3, ($t2)
		lb $s4, guanine
		beq $s3, $s4, endOfCompare
		
		jal loopKout 
	
	compareC:
		jal calculateIndexJK
		lb $s3, ($t2)
		lb $s4, cytosine
		beq $s3, $s4, endOfCompare
		
		jal loopKout 

		
	calculateIndexIK:
		mul  $t2, $s0, $a2 # t2 = rowIndex * columnSize
		add  $t2, $t2, $s2 # t2 = rowIndex * columnSize + columnIndex
		mul  $t2, $t2, 1   # t2 = (rowIndex * columnSize + columnIndex) * dataSize
		add  $t2, $t2, $a0 # t2 = baseAddress + (rowIndex * columnSize + columnIndex) * dataSize
		
		jr $ra
	
	calculateIndexJK:
		mul  $t2, $s1, $a2 # t2 = rowIndex * columnSize
		add  $t2, $t2, $s2 # t2 = rowIndex * columnSize + columnIndex
		mul  $t2, $t2, 1   # t2 = (rowIndex * columnSize + columnIndex) * dataSize
		add  $t2, $t2, $a0 # t2 = baseAddress + (rowIndex * columnSize + columnIndex) * dataSize
		
		jr $ra
