text:
	.text
	.align 2
	.global main
loop:
	adr r6 ,main
	add r6, r6, #32	
	sub r1, r7, r6

	@Condition Check
	ldr r0, [r7]
	and r0, #0xF0000000
	mov r0, r0, lsr #28
	
	cmp r0, #15
	ldreq r2, =conditionNV

	cmp r0, #14
	ldreq r2, =conditionAL

	cmp r0, #13
	ldreq r2, =conditionLE

	cmp r0, #12
	ldreq r2, =conditionGT

	cmp r0, #11
	ldreq r2, =conditionLT

	cmp r0, #10
	ldreq r2, =conditionGE

	cmp r0, #9
	ldreq r2, =conditionLS

	cmp r0, #8
	ldreq r2, =conditionHI

	cmp r0, #7
	ldreq r2, =conditionVC

	cmp r0, #6
	ldreq r2, =conditionVS

	cmp r0, #5
	ldreq r2, =conditionPL

	cmp r0, #4
	ldreq r2, =conditionMI

	cmp r0, #3
	ldreq r2, =conditionCCLO

	cmp r0, #2
	ldreq r2, =conditionCCHI

	cmp r0, #1
	ldreq r2, =conditionNE

	cmp r0, #0
	ldreq r2, =conditionEQ

	@Instruction Check
	ldr r0, [r7]

	and r0 ,#0x0E000000
	mov r0, r0, lsr #25
	
	cmp r0, #5
	bne DataMovement
	ldr r0, [r7]
	and r0, r0, #0x01000000
	mov r0, r0, lsr #24
	cmp r0,#1
	beq LabelBL
	bne LabelB
	bl OutputNormal

LabelBL:
	ldr r3, =instructionBL
	bl OutputBranch
LabelB:
	ldr r3, =instructionB
	bl OutputBranch
DataMovement:	
	ldr r0,[r7]
	and r0, r0, #0x0C000000
	mov r0, r0, lsr #26
	cmp r0, #1
	bne DataProcess
	ldr r0, [r7]
	and r0, r0, #0x00500000
	mov r0, r0, lsr #20

	cmp r0, #0
	ldreq r3,=instructionSTR
	cmp r0, #1
	ldreq r3,=instructionLDR
	cmp r0, #2
	ldreq r3,=instructionERR
	cmp r0, #3
	ldreq r3,=instructionERR
	cmp r0, #4
	ldreq r3,=instructionSTRB
	cmp r0, #5
	ldreq r3,=instructionLDRB
	bl OutputNormal

DataProcess:	
	ldr r0,[r7]
	and r0, r0, #0x0C000000
	mov r0, r0, lsr #26
	cmp r0, #0
	bne undefine
	ldr r0, [r7]
	and r0, #0x01E00000
	mov r0, r0, lsr #21

	@compare
	cmp r0, #0
	ldreq r3, =instructionAND

	cmp r0, #1
	ldreq r3, =instructionEOR

	cmp r0, #2
	ldreq r3, =instructionSUB

	cmp r0, #3
	ldreq r3, =instructionRSB

	cmp r0, #4
	ldreq r3, =instructionADD

	cmp r0, #5
	ldreq r3, =instructionADC

	cmp r0, #6
	ldreq r3, =instructionSBC

	cmp r0, #7
	ldreq r3, =instructionRSC

	cmp r0, #8
	ldreq r3, =instructionTST

	cmp r0, #9
	ldreq r3, =instructionTEQ

	cmp r0, #10
	ldreq r3, =instructionCMP

	cmp r0, #11
	ldreq r3, =instructionCMN

	cmp r0, #12
	ldreq r3, =instructionORR

	cmp r0, #13
	ldreq r3, =instructionMOV

	cmp r0, #14
	ldreq r3, =instructionBIC

	cmp r0, #15
	ldreq r3, =instructionMVN
	bl OutputNormal

undefine:
	ldr r3, =instructionUND
OutputNormal:	
	@mov r4, r3
	@end instruction
	ldr r0, =printformat
	bl printf

	add r7, r7, #4
	cmp r7, r8
	bleq EXIT
	blne loop

OutputBranch:
	ldr r0, =printformatbranch
	bl printf
	ldr r0, =buffer
	adr r1, main
	add r1, r1, #32
	adr r9, L1
	sub r1, r9, r1
	ldr r0, =printAddr
	bl printf

	add r7, r7, #4
	cmp r7, r8
	bleq EXIT
	blne loop

main:
	stmfd sp!,{r0-r8,fp,lr}
	ldr r0, =title
	bl printf

	adr r8, EXIT
	sub r8,r8,#4
	adr r7, main
	add r7, r7, #32
	bl start_deasm
	.include "test.s"

start_deasm:	
	bl loop

EXIT:
	ldmfd sp!, {r0-r8,fp,lr}		
	bx lr	
title:
	.ascii "PC\tcondition\tinstruction\n\0"

@condition table
conditionEQ:
	.ascii "EQ\0"	

conditionNE:
	.ascii "NE\0"	

conditionCCHI:
	.ascii "CC/HI\0"			

conditionCCLO:
	.ascii "CC/LO\0"		

conditionMI:
	.ascii "MI\0"

conditionPL:
	.ascii "PL\0"	

conditionVS:
	.ascii "VS\0"	

conditionVC:
	.ascii "VC\0"		

conditionHI:
	.ascii "HI\0"	

conditionLS:
	.ascii "LS\0"	

conditionGE:
	.ascii "GE\0"		

conditionLT:
	.ascii "LT\0"				

conditionGT:
	.ascii "GT\0"

conditionLE:
	.ascii "LE\0"	

conditionAL:
	.ascii "AL\0"		

conditionNV:
	.ascii "NV\0"

	
@instruction table
instructionB:
	.ascii "B\0"

instructionBL:
	.ascii "BL\0"

instructionSTR:
	.ascii "STR\0" 

instructionLDR:
	.ascii "LDR\0" 

instructionERR:
	.ascii "ERR\0" 

instructionLDRB:
	.ascii "LDRB\0"

instructionSTRB:
	.ascii "STRB\0"


instructionAND:
	.ascii "AND\0"

instructionEOR:
	.ascii "EOR\0"

instructionSUB:
	.ascii "SUB\0"

instructionRSB:
	.ascii "RSB\0"

instructionADD:
	.ascii "ADD\0"

instructionADC:
	.ascii "ADC\0"

instructionSBC:
	.ascii "SBC\0"

instructionRSC:
	.ascii "RSC\0"

instructionTST:
	.ascii "TST\0"

instructionTEQ:
	.ascii "TEQ\0"

instructionCMP:
	.ascii "CMP\0"

instructionCMN:
	.ascii "CMN\0"

instructionORR:
	.ascii "ORR\0"

instructionMOV:
	.ascii "MOV\0"	

instructionBIC:
	.ascii "BIC\0"

instructionMVN:
	.ascii "MVN\0"

instructionUND:
	.ascii "UND\0" 	

printformat:
	.asciz "%d\t%s\t\t%s\n\0"
printformatbranch:
	.asciz "%d\t%s\t\t%s\t"
printAddr:
	.asciz "%d\n"
buffer:
	.space 128
