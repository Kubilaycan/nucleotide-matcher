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
		
		li $t0, 0 # t0 = row index
		li $t1, 0 # t1 = column index
		jal calculateIndex
		
		lb $t3, ($t2)      # t3 = value at index
		
		# End program
		li $v0, 10
		syscall
		
		
	calculateIndex:
		mul  $t2, $t0, $a2 # t2 = rowIndex * columnSize
		add  $t2, $t2, $t1 # t2 = rowIndex * columnSize + columnIndex
		mul  $t2, $t2, 1   # t2 = (rowIndex * columnSize + columnIndex) * dataSize
		add  $t2, $t2, $a0 # t2 = baseAddress + (rowIndex * columnSize + columnIndex) * dataSize
		
		jr $ra
		
		
