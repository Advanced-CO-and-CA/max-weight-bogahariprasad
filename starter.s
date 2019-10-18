/******************************************************************************
* file: starter.s
* author: Hariprasad Boga
* Guide: Prof. Madhumutyam IITM, PACE
* Guide: G S Nitesh Narayana
******************************************************************************/

  @ BSS section
      .bss

  @ DATA SECTION
      .data
@data_start: 0x205A15E3 ;(0010 0000 0101 1010 0001 0101 1101 0011 – 13)
@            0x256C8700 ;(0010 0101 0110 1100 1000 0111 0000 0000 – 11)
@data_end:   0x295468F2 ;(0010 1001 0101 0100 0110 1000 1111 0010 – 14)

data_start: .word 0x205A15E3, 0x256C8700
data_end:   .word 0x295468F2
NUM:    .word 0
WEIGHT: .word 0

  @ TEXT section
      .text

.globl _main

_main:

	    @ Assembly	program	to compute the maximum and minimum values
        @ in  a	given set of non-zero unsigned integer numbers.	This program also	
	    @ computes the total number of integers present in the set (other than
        @ the terminating 0). This program scan through all the
        @ elements of the set only once. Assumption is that, the memory locations starting at	
        @ address data_items contains the given	set	of integers.	

		LDR R3,=data_start        @Load address data_start into R3
		LDR R9,=data_end          @Load address data_end into R9
		MOV R7,#0				  @Load final max count value in R7
		MOV R8,#0                 @Load final max value value in R8
		MOV R2,#0                 @Initialize the intermediate count value in register R2
		LDR R6,[R3]				  @Initialize maximum number in R6
		MOV R0, R6

CountOnes:                        @CountOnes is a subroutine to count number of ones in number.
		MOV R2, #0
LOOP:	SUB R1, R0, #1
		AND R0, R1
		ADD  R2, R2, #1
		CMP R0, #0
		BNE LOOP
		
		CMP R2,R7                 @Compare with maximum count so far and update the results accordingly.
		LDRGT R8, [R3]
		CMP R2,R7
		MOVGT R7, R2
		
		ADD R3, R3, #4            @Read the next element from data.
		CMP R3, R9
		BGT OUT
		LDR R6,[R3]	
		MOV R0, R6
		BL CountOnes
OUT:
		LDR R5,=NUM            @Load address maximum into R5
		STR R8,[R5]            @Store maximum weight value R8 into NUM.
		LDR R5,=WEIGHT         @Load address count into R5
		STR R7,[R5]            @Store maximum count R7 into WEIGHT.
		SWI 0x11