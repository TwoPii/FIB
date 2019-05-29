#------------------------------------------------------------------------------
# A simple diagnostic that will execute most instructions
# at least once and them dump the register file so that you
# can see it on the memory output bus
#------------------------------------------------------------------------------

	.text
#	.set noat
	.set noreorder
	.set nomacro
	.set mips32
	.set noat
	.global main .text
	.ent main

main:	add $30, $0, $31	# guardem adr. retorn

#  Try modifying R0
	addi $0, $0, 1		# R0 had better still be 0         

#------------------------------------------------------------------------------
# misc ALU tests
#------------------------------------------------------------------------------
# addsub
	sub   $24, $0, $0	#  r24 = 0               
	addi  $2, $0, 1		#  r2=1               
	addi  $3, $0, -1	#  r3=-1               
	add   $4, $3, $2	#  r4=0 (no exceptions)               
	andi  $5, $3, 255	#  r5=255=0x000000FF               
	addu  $6, $5, $2	#  r6=256=0x00000100               
	addiu $7, $6, 768	#  r7=1024=0x00000400               
	subu  $8, $7, $6	#  r8=768=0x00000300            
# logic
	ori   $9, $0, 21845	#  r9=21845=0x00005555               
	or    $9, $9, $0	#  r9=21845=0x00005555 =unchanged               
	and   $9, $9, $3	#  r9=21845=0x00005555 =unchanged               
	nor   $10, $9, $0	#  r10=-21846=0xFFFFAAAA               
	xor   $11, $10, $10	#  r11=0 =0x00000000              
	xori  $12, $9, 65522	#  r12=0x0000AAA7           
# shift
	sll   $13, $9, 8	#  r13=5592320=0x00555500               
	sllv  $14, $2, $2	#  r14=2        =0x00000002       
	srl   $15, $10, 5	#  r15=134217045=0x07fffD55               
	srlv  $16, $9, $2	#  r16=10922=0x00002AAA               
	sra   $17, $3, 4	#  r17=-1=0xFFFFFFFF               
	srav  $18, $9, $14	#  r18=5461=0x00001555               
	slt   $19, $9, $9	#  r19=0=0x00000000               
	slt   $20, $5, $6	#  r20=0=0x00000001               
	sltu  $21, $4, $3	#  r21=1=0x00000001               
	sltiu $22, $3, 0	#  r22=0=0x00000000               
# conditional move
	movz $1, $3, $2		#  r1 no canvia
	movn $1, $5, $2		#  r1=255
	movz $1, $2, $0		#  r1=1
	movn $1, $6, $0		#  r1 no canvia

#------------------------------------------------------------------------------
# test the jump instructions
#------------------------------------------------------------------------------
	addi  $23,$0,0		# set register 23 to zero
	j .Ljok
	nop
#	addi  $23,$0,-1		# -1 in r23 means jump failed
	break				# no ha de parar
	nop
.Ljok:	addi  $24,$0,0		# initialize  register 24 to zero
	jal .Ljalok		# this is taken w/$31 = PC
	nop
	addi  $24,$24,1		# should not come here after jal, but will after jr below
	lui $29, %hi(.Ljalok)
	ori $29, $0, %lo(.Ljalok)
	jalr $31,$29		# torna a cridar 
	nop
	j .Lout
	nop 
.Ljalok:  
	addi  $24,$0,100        # re-init $24 to 100
	jr  $31                 # now jump back 3 instructions
      nop 
.Lout:                          # will test jr below

#------------------------------------------------------------------------------
# test branch instructions
# for these test r2 = 1, r3 = -1 (see above)
#------------------------------------------------------------------------------

	beq   $3,$3,.L0		# taken branch: PC moves ahead by 8
        nop
.Lfail:	break			# don't execute this instruction
	nop
.L0:	beq   $3, $2, .Lfail	# no take branch (failures get stuck)
        nop

	bne   $3,$2,.L1		# taken branch: PC moves ahead by 8
        nop
	break			# don't execute this instruction
	nop
.L1:	bne   $3, $3, .Lfail	# no take branch (failures get stuck)
        nop

	bltz  $3, .L2		# taken branch: PC moves ahead by 8
	nop
	break			# don't execute this instruction
	nop
.L2:	bltz  $2, .Lfail	# no take branch (failures get stuk)
        nop

	blez  $0, .L3		# taken branch: PC moves ahead by 8
	nop
	break			# don't execute this instruction
	nop
.L3:	blez  $2, .Lfail	# no take branch (failures get stuck)
	nop
        blez  $3, .L4		# taken branch: PC moves ahead by 8
	nop
	break			# don't execute this instruction
        nop

.L4:	bltzal  $3, .L5		# taken branch: PC moves ahead by 8
        nop
	break			# don't execute this instruction
	nop
.L5:	bltzal   $2, .Lfail	# no take branch (failures get stuck);
	nop 
	add $25, $0, $31	# link address in r25

	bgtz   $2, .L6		# taken branch: PC moves ahead by 8
	nop
	break			# don't execute this instruction
	nop
.L6:	bgtz   $3, .Lfail	# no take branch (failures get stuck)
 	nop

	bgez   $0, .L7		# taken branch: PC moves ahead by 8
	nop
	break			# don't execute this instruction
	nop
.L7:	bgez   $3, .Lfail	# no take branch (failures get stuck)
	nop
	bgez   $2, .L8		# taken branch: PC moves ahead by 8
	nop
	break			# don't execute this instruction
        nop

.L8:	bgezal  $2, .L9		# taken branch: PC moves ahead by 8
	nop
	break			# don't execute this instruction
	nop
.L9:	bgezal  $3, .Lfail	# no take branch (failures get stuck); 
	nop
	add $26, $0, $31	# link address in r26

# restaura adr.retorn
	add $31, $0, $30

#------------------------------------------------------------------------------
# test load/store
#------------------------------------------------------------------------------
	lui $30, %hi(scrat)
	addiu $30,$30,%lo(scrat)
	sw  $17,4($30)
	sh  $17,10($30)
	sb  $17,11($30)
        
	lw  $25,4($30)		# r25 = 0xffffffff
	lhu $26,4($30)		# r26 = 0x0000ffff
	lbu $27,4($30)		# r27 = 0x000000ff
	lh  $28,4($30)		# r28 = 0xffffffff
	lb  $29,4($30)		# r29 = 0xffffffff
        
#	sub $30,$0,$0		# r30 = 0
#	lui   $1, 2		# r1 = 0x00020000

#------------------------------------------------------------------------------
# this is your output..
#------------------------------------------------------------------------------
	lui $30, %hi(breg)
	addiu $30,$30,%lo(breg)
	sw $0, 0($30)
	sw $1, 4($30)                   
	sw $2, 8($30)                   
	sw $3, 12($30)                   
	sw $4, 16($30)                   
	sw $5, 20($30)                   
	sw $6, 24($30)                   
	sw $7, 28($30)                   
	sw $8, 32($30)                   
	sw $9, 36($30)                   
	sw $10, 40($30)                  
	sw $11, 44($30)                  
	sw $12, 48($30)                  
	sw $13, 52($30)                  
	sw $14, 56($30)                  
	sw $15, 60($30)                  
	sw $16, 64($30)                  
	sw $17, 68($30)                  
	sw $18, 72($30)                  
	sw $19, 76($30)                  
	sw $20, 80($30)                  
	sw $21, 84($30)                  
	sw $22, 88($30)                  
	sw $23, 92($30)                  
	sw $24, 96($30)                  
	sw $25, 100($30)                  
	sw $26, 104($30)                  
	sw $27, 108($30)                  
	sw $28, 112($30)                  
	sw $29, 116($30)
	sw $30, 120($30)
	sw $31, 124($30)                 
        
	jr   $31
	nop
	.end main        

	.data
	.type breg, @object
	.type scrat, @object
	.size breg, 128
	.size scrat, 16
breg:	.space 128, -1
scrat:	.space 16, 0
#str: .asciiz "simple test\n"

#------------------------------------------------------------------------------
# end of simple test
#------------------------------------------------------------------------------

