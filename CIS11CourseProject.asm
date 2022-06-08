; Team members: Jessica Luevano, Brandon Corona
; CIS-11 Course Project
; Option A: Bubble Sort
; Program functionality:	
;			This LC-3 program implements 
;			Bubble Sort with the input of
;			of 8 numbers ranging 0-100 
;			from the user, and displays
;			sorted values in ascending 
;			in console.

; Initialize

.ORIG X3000

; Initialize pointer and I/O counter

LD R3, POINTER_VAL
LD R6, COUNTER_VAL


; Loop for prompt message
LEA R0, PROMPTMSG			;Load first prompt for user input
PUTS					;Displaying the prompt message
AND R0, R0, #0				;Clear R0
LD R0, NEWLINE				;New line
OUT					;Displaying the new line
AND R0, R0, #0				;Clear R0
LEA R0, PROMPTEX			;Loading the prompt example
PUTS					;Displaying the prompt example

USERINPUT

;Used for first, second and third digit for each number
;The first digit will contain 3 digits(100)
	IN				;Getting the users input for the first digit
	AND R5, R5, #0			;Clearing R5
	LD R5, HUNDREDTH		;Load 100 to R5 for hundrenths place
	AND R2, R2, #0			;Clearing R2
	LD R2, NEGASCII			;Loading R2 to a negative offset
	ADD R0, R0, R2			;Adding the negative offset to R0
	AND R2, R2, #0			;Clearing R2
	ADD R2, R0, #0			;Having R0 move to R2
	AND R0, R0, #0			;Clearing R0

	DIGIT_ONE				;The first multiplication loop
		ADD R0, R0, R2		;Multiplication being used
		ADD R5, R5, #-1		;Going down by one with counter
		BRp DIGIT_ONE		;Will keep looping 100 times if the digit is pos

	ADD R1, R0, #0			;The first digit will be R1
	AND R0, R0, #0			;Clear R0

;The second digit will contain 2 digits(20)
	IN				;Getting the users input for the second digit
	AND R5, R5, #0			;Clearing R5
	LD R5, TENTH			;Load 10 to R5 for tenths place
	AND R2, R2, #0			;Clearing R2
	LD R2, NEGASCII			;Loading R2 to negative offset
	ADD R0, R0, R2			;Adding the negative offset to R0
	AND R2, R2, #0			;Clear R2
	ADD R2, R0, #0			;Having R0 move to R2
	AND R0, R0, #0			;Clear R0

	DIGIT_TWO			;The second multiplication loop
		ADD R0, R0, R2		;Multiplication being used
		ADD R5, R5, #-1		;Going down by one with counter
		BRp DIGIT_TWO		;Will keep looping 100 times if the digit is pos

	ADD R4, R0, #0			;R4 will now be the second digit
	AND R0, R0, #0			;Clear R0

;the third digit will contain 1 digit(1)
	IN				;Getting the users input for the third digit
	AND R2, R2, #0			;Clear R2
	LD R2, NEGASCII			;Loading the negative offset to R2
	ADD R0, R0, R2			;Adding negative offset to R0
	AND R2, R2, #0			;Clear R2

;Getting the one 3 digit number
	ADD R2, R1, R4			;Adding R1 and R4
	ADD R2, R0, R2			;Adding R1,R2 and R0
	STR R2, R3, #0			;Storing the 3 digit in R2 in a array R3 pointer
	ADD R3, R3, #1			;Going up with pointer
	ADD R6, R6, #-1			;Going down loop R6 by the counter
	BRp USERINPUT			;The loop will keep going if the counter is pos

;Calling the sort subroutine
JSR BUBBLE_SORT

;Calling the output subroutine
JSR FINAL_LOOP

HALT

;Sort subroutine
BUBBLE_SORT
	;Clearing counters and pointers for sorting the loops
	AND R3, R3, #0			;Clear R3
	LD R3, POINTER_VAL		;Resetting register in pointer
	AND R4, R4, #0			;Clear R4
	LD R4, COUNTER_VAL		;Resetting register in counter
	AND R5, R5, #0			;Clear R5
	LD R5, COUNTER_VAL		;Resetting counter

	;The outer part of an array loop(multiple times)
	LOOP_OUT
		ADD R4, R4, #-1		;Making loop running 8 times, going down 1 constantly
		BRnz SORT		;Checking condition, if value starts with 0 then its sorted
		ADD R5, R4, #0		;Having R4 move into R5 with respect to functions
		LD R3, POINTER_VAL	;Moving pointer to the front of the array loop

	;The inner part of an array loop(once and sorts)
	LOOP_IN
		LDR R0, R3, #0		;Load the first 3 digit number with pointer and store to R0
		LDR R1, R3, #1		;Load the second 3 digit number with pointer and store to R1
		AND R2, R2, #0		;Clear R2
		NOT R2, R1		;2's compliment
		ADD R2, R2, #1		;R2 is now negative
		ADD R2, R0, R2		;Subtract second from first 3 digit number
		BRnz SWAP		;swap if negative. first is smaller then second
		;Performing the swap
		STR R1, R3, #0		;The second 3 digit number is now first
		STR R0, R3, #1		;The first 3 digit number is now second

	;Swapping the 3 digit numbers in ascending order
	SWAP
		ADD R3, R3, #1		;Going up point R3 to look at next set
		ADD R5, R5, #-1		;Going down loop in counter
		BRp LOOP_IN		;Continue procedding if pos
		BRzp LOOP_OUT		;Go back to loop out if pos/0

	;Array must be returned once sorted
	SORT	RET

	RET

;Output subroutine
FINAL_LOOP
	LEA R0, OUTPROMPT		;Loading the output prompt
	PUTS				;Displaying the prompt
	LD R3, POINTER_VAL		;Pointer being resetted
	LD R6, COUNTER_VAL		;Counter being resetted

	;Output loop
	OUT_LOOP

		AND R1, R1, #0		;Clearing R1
		AND R4, R4, #0		;Clearing R2
		AND R5, R5, #0		;Clearing R4
		AND R0, R0, #0		;Clearing R5

		LD R0, NEWLINE		;loading ouput for clear console
		OUT			;Display with New line

		AND R0, R0, #0		;Clear R0
		LDR R0, R3, #0		;Loading R3 into R0 using pointer

		;Format to use division by 100
		AND R2, R2, #0		;Clearig R2
		LD R2, HUNDREDTH	;Loading R2 to 100
		NOT R2, R2		;2's compliment
		ADD R2, R2, #1		;R2 is now -100

		;First subtraction loop being divided by hundredths(100)
		SUB_LOOP1
			ADD R1, R1, #1	;Knowing R1 with fill
			ADD R0, R0, R2	;value - 100, will store R0
			BRzp SUB_LOOP1	;the remiander will be found if pos/0
		
		;Find remainder
		REMAIN1
			AND R2, R2, #0	;Clear R2
			LD R2,HUNDREDTH ;Reloading R2 is 100
			ADD R0, R0, R2	;Result+100 is pos remainder
			ADD R1, R1, #-1	;-1 from sub counter
			STI R1, NUM1	;Store to num1 if it is R1

		;Now divide by the tenths (10)
		AND R2, R2, #0		;Clear R2
		LD R2, TENTH		;Loading R2 to 10
		NOT R2, R2		;2's compliment
		ADD R2, R2, #1		;R2 is now -10

		;Second subtraction loop, divide by tenths(10)
		SUB_LOOP2
			ADD R4, R4, #1	;counter being counted however many times
			ADD R0, R0, R2	;Remain -10 then it being stored inR0
			BRzp SUB_LOOP2	;Find remainder if it is negative/0

		;Find remainder for second and third digit
		REMAIN2
			AND R2, R2, #0	;Clear R2
			LD R2, TENTH	;Loading R2 to 10
			ADD R5, R0, R2	;Remainder being added to 10
			STI R5, NUM3	;Store num3 to third digit in R5
			ADD R4, R4, #-1	;Getting a positive num from num of times being sub
			STI R4, NUM2	;Storing num2 when the second digit is in R4

		;Displaying digit 1
		AND R0, R0, #0		;Clearing R0
		LDI R0, NUM1		;R0 will be loading to first dig
		AND R2, R2, #0		;Clearing R2
		LD R2, POSASCII		;Loading positive offset to R2
		ADD R0, R0, R2		;R0+R2 is the R0
		OUT			;Display digit 1

		;Displaying digit 2
		AND R0, R0, #0		;Clearing R0
		LDI R0, NUM2		;R0 will be loading to second dig
		AND R2, R2, #0		;Clearing R2
		LD R2, POSASCII		;Loading positive offset to R2
		ADD R0, R0, R2		;R0+R2 is the R0
		OUT			;Display digit 2

		;Displaying digit 3
		AND R0, R0, #0		;Clearing R0
		LDI R0, NUM3		;R0 will be loading to third dig
		AND R2, R2, #0		;Clearing R2
		LD R2, POSASCII		;Loading positive offset to R2
		ADD R0, R0, R2		;R0+R2 is the R0
		OUT			;Display digit 3

		ADD R3, R3, #1
		ADD R6, R6, #-1
		BRp OUT_LOOP

	HALT				;Pausing the program

	RET				;Return calling program








PROMPTMSG	.STRINGZ	"Welcome! Please input 8 numbers in the range (0-100)"
PROMPTEX	.STRINGZ	"Input 11 as 011"
OUTPROMPT	.STRINGZ	"The ascending list:"
NEWLINE		.FILL		x000A	;Adds new line between the output
HUNDREDTH	.FILL		x0064	;Used for range of 100 to the hundrenths place
NEGASCII	.FILL		xFFD0	;-48 offset in ascii
POSASCII	.FILL		x0030	;48 offset in ascii
TENTH		.FILL		x000A	;Used for the tenths place
POINTER_VAL	.FILL		x4000	;This is the array starting point
COUNTER_VAL	.FILL		#8	;For the counters
NUM1		.FILL		x400A	;A storing place for the first digit
NUM2		.FILL		x400B	;A storing place for the second digit
NUM3		.FILL		x400C	;A storing place for the third digit
.END					;End of the program