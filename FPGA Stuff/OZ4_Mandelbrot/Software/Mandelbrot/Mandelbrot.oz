#The actual Mandelbrot generation code, just a test for now.

#Test coordinates: X = 0.4, Y = 0.55
#X binary: 0000 0110 0110 0110
#X unsigned int: 107347968
#Y binary: 0000 1000 1100 1100
#Y unsigned int: 147587072

#Memory:
#0: A
#1: B
#2: CHK
#3: I

2147483648
WRPRT								#Turn on the run light

107347968	#Push X (A)				#Writing X and Y into memory
0			#Push 0 (A addr)
WRMEM

147587072	#Push Y (B)
1			#Push 1 (B addr)
WRMEM

147587072	#Push Y (B)	#Y/B		#Initializing the stack
DUP						#Y/B Y/B
FPMUL					#YY

107347968	#Push X (A)	#X/A YY
DUP						#X/B X/B YY
FPMUL					#E F

147587072	#Push Y (B)	#B E F
147587072	#Push Y (D)	#D B E F
107347968 	#Push X (C)	#C D B E F

#Initial stuff all set up, ready to start the loop
label MAINLOOP

	#Calculating and placing H, which is the next D
	FPMUL				#CD B E F
	536870912	#2.0	#2.0 CD B E F
	FPMUL				#2CD B E F
	ADD					#H E F
	NROT				#E F H

	#Calculating and placing G, which is the next C
	0		#Push (A)	#(A) E F H
	RDMEM				#A E F H
	NROT				#E F A H
	SUB					#(E-F) A H
	ADD					#G/C H/D
	SWAP				#D C

	#Calculating F, which is D squared
	DUP					#D D C
	DUP 				#D D D C
	FPMUL				#F(DD) D C

	#Storing F in the CHK variable, which is used to store CC + DD to check the exit condition
	DUP					#F F D C
	2		#Push (CHK)	#2 F F D C
	WRMEM				#F D C
	NROT				#D C F

	#Calculating E, which is C squared
	OVER				#C D C F
	DUP					#C C D C F
	FPMUL				#E(CC) D C F

	#This whole thing brings CHK back out, adds E (C squared) to it, and stores it again
		#Read CHK
		DUP					#E E D C
		2		#Push (CHK)	#2 E E D C F
		RDMEM				#CHK E E D C F

		#Add CHK and E, then store it back
		ADD					#(CHK+E) E D C F
		2		#Push (CHK)	#2 CHK E D C F
		WRMEM				#E D C F

	#Bringing B back in and readying the stack for the next iteration
	NROT				#D C E F
	SWAP				#C D E F
	1		#Push (B)	#1 C D E F
	RDMEM				#B C D E F
	NROT				#C D B E F

	#This whole thing checks to see if I is 255, then exits the loop if it is
		#Read I
		3		#Push (I)	#3 C D B E F
		RDMEM				#I C D B E F

		#Increment I and compare it to 255
		1					#1 I C D B E F
		ADD					#I++ C D B E F
		255					#255 I C D B E F
		CP					#255 I C D B E F

		#Drop 255 back out and store I back in memory
		DROP				#I C D B E F
		3		#Push (I)	#3 I C D B E F
		WRMEM				#C D B E F
		
		#Check to see if they were equal, branch if they were
		2		#Push (CD)	#2 C D B E F
		EXIT	#Push EXIT	#EXIT 2 C D B E F
		BRN					#C D B E F

		#Load CHK and compare it to 4.0
		2		#Push (CHK)	#2 C D B E F
		RDMEM				#CHK C D B E F
		1073741824 #4.0		#4.0 CHK C D B E F
		CP					#4.0 CHK C D B E F

		#Drop 4.0 and CHK out
		DROP				#CHK C D B E F
		DROP				#C D B E F

		#Push the condition code for less than (if 4.0 is less than CHK) and branch if it is
		3		#Push (CD)	#3 C D B E F
		EXIT	#Push EXIT	#EXIT 3 C D B E F
		BRN					#C D B E F

		#If the branch didn't go through, jump back to the top and do another iteration
		MAINLOOP			#MAINLOOP C D B E F
		JP					#C D B E F
label EXIT

#Reading the final I value and displaying it
3
RDMEM
WRPRT

#End
label END
END
JP
%
