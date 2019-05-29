	.text
#	.set noat
	.set noreorder
	.set nomacro
	.set mips32
	.set noat
	.global main .text
	.ent main

main:	add $30, $0, $31	# guardem adr. retorn

#------------------------------------------------------------------------------
# test the alu instructions
#------------------------------------------------------------------------------
	addi	$0,$0,1		 
	addiu	$7,$0,-1	 
	addu	$2,$7,$7	 
	subu	$6,$7,$2	
	xor	$6,$6,$7
	or	$6,$2,$6
	slt	$6,$6,$7
	slti	$9,$6,3
	xor	$0,$0,$0
	srl	$10,$2,2
	movn	$9,$6,$0	# r9 no es modifica
	movz	$9,$9,$0	 

	or	$31,$30,$0
	jr	$31
	nop	


	.end main        

#------------------------------------------------------------------------------
# end of alu test instructions
#------------------------------------------------------------------------------

