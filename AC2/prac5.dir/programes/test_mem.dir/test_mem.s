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
# test the memory instructions
#------------------------------------------------------------------------------
	addi	$17,$0,-1
	lui	$3,%hi(datos) 
	ori	$3,$3,%lo(datos)
	sw	$17,4($3)
	sh	$17,10($3)
	sb	$17,11($3)
	lw	$25,4($3)	# r25 = 0xFFFFFFFF
	lhu	$26,4($3)	# r26 = 0x0000FFFF
	lbu	$27,4($3)	# r27 = 0x000000FF
	lh	$28,4($3)	# r28 = 0xFFFFFFFF
	lb	$29,4($3)	# r29 = 0xFFFFFFFF
	addi	$16,$0,4	# r16 = 0x00000004
	sh	$16,4($3)
	lw	$20,4($3)	# r20 = 0xFFFF0004
	lhu	$21,4($3)	# r21 = 0x00000004
	sb	$21,7($3)
	lw	$22,4($3)	# r22 = 0x04FF0004
	lhu	$23,6($3)	# r23 = 0x000004FF
	lb	$24,7($3)	# r24 = 0x00000004
	addu	$25,$24,$24	# r25 = 0x00000008
	sb	$25,7($3)
	lb	$26,7($3)	# r26 = 0x00000008
	

	or	$31,$30,$0
	jr	$31
	nop	


	.end main        

	.data
	.type datos, @object
	.size datos, 16
datos:	.space 16, 0

#------------------------------------------------------------------------------
# end of test memory instructions
#------------------------------------------------------------------------------

