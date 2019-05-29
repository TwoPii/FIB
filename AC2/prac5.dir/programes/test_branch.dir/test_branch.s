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
# test the branch instructions
#------------------------------------------------------------------------------
	addiu	$27,$0,8	# r27 = 8
	jal	.L1		# r31 = B, call L1
	addiu	$25,$31,8	# r25 = B + 8

	beq	$0,$0,.L3	# instr. addr. B, taken
	nop
	break

.L6:	addu	$1,$0,$0	# r1 = 0
	or	$31,$30,$30
	jr	$31
	nop
	break

.L5:	nor	$10,$0,$25	# r10 = - r25 = -2
	blez	$10,.L6		# not taken
	nop
	break

.L3:	bne	$0,$0,.L4	# not taken
	xor	$25,$25,$25	# r25 = 0
	addiu	$25,$25,1	# r25 = 1
	bgtz	$25,.L5		# taken
	nop
	break

.L4:	break			# unreachable


.L1:	subu	$26,$25,$27	# r26 = B + 8 - 8 = B
	add	$28,$0,$31	# r28 = r31 = B
	lui	$29,%hi(.L2)	# 
	ori	$29,$29,%lo(.L2)	# r29 = L2
	jalr	$31,$29		# call L2, r31 = A
	nop

	jr	$31		# instr. addr. A, return to B
	nop
	break

.L2:	subu	$22,$31,$0	# r22 = A
	jr	$31		# return to A
	add	$31,$0,$28	# r31 = B
	break



	.end main        

#------------------------------------------------------------------------------
# end of test branch instructions
#------------------------------------------------------------------------------

