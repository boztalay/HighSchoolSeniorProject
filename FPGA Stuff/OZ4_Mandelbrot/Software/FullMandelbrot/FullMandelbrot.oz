#Generating a full frame Mandelbrot, no zooming

#X starts at -2.0, 0 and increments by 0.00625. Ends at 2.0, 639
#	-2.0: 1110 0000 0000 0000 : 3758096384
#	0.00625: 0000 0000 0001 1001 : 1638400
#
#Y starts at 2.0, 0, and decrements by 0.00833. Ends at -2.0, 479
#
#	2.0: 0010 0000 0000 0000 : 536870912
#	-0.00833: 1111 1111 1101 1110 : 4292739072

#Memory:
#0: A (Xmand)
#1: B (Ymand)
#2: CHK
#3: I
#4: Xpix
#5: Ypix
#6: Addr
#7: Upper/Lower

#I/O:
#Oport to MC data
#Opin0 : Run light
#Opin1 : MC mode
#Opin2 : MC pix1 we
#Opin3 : MC pix2 we
#Opin4 : MC addr we
#Opin5 : MC big we

#Hit the run light
1
0
WRPIN

#Set the memory controller's mode
1
1
WRPIN

#Init memory

#A/Xmand
3758096384 #-2.0
0
WRMEM
#B/Ymand
536870912 #2.0
1
WRMEM
#Reset the rest to 0
2
WRMEM
3
WRMEM
4
WRMEM
5
WRMEM
6
WRMEM
7
WRMEM

#The vertical loop/Y loop
label YLOOP

	#Reset the X pixel and mandelbrot coordinates

	#A/Xmand
	3758096384 #-2.0
	0
	WRMEM
	#Xpix
	0
	4
	WRMEM

	#The horizontal loop/X loop
	label XLOOP

		#Reset I and CHK
		#I
		0
		3
		WRMEM
		#CHK
		0
		2
		WRMEM	

		#Set up the stack for the pixel calculations
		1						#Pull Y from memory
		RDMEM					#Y/B
		DUP						#Y/B Y/B
		FPMUL					#YY
		
		0						#Pull X from memory
		RDMEM					#X/A YY
		DUP						#X/A X/A YY
		FPMUL					#E F
		
		1						#Pull Y from memory
		RDMEM					#B E F
		DUP						#D B E F
		0						#Pull X from memory
		RDMEM					#C D B E F
		
		
		#Initial stuff all set up, ready to start the loop
		label PIXLOOP
		
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
		
			#This whole thing checks to see if I is 255, then exits the loop if it is. Also checks CHK
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
				PIXEXIT				#PIXEXIT 2 C D B E F
				BRN					#C D B E F
				NOP
		
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
				PIXEXIT				#PIXEXIT 3 C D B E F
				BRN					#C D B E F
				NOP
		
				#If the branch didn't go through, jump back to the top and do another iteration
				PIXLOOP				#PIXLOOP C D B E F
				JP					#C D B E F
				NOP
		label PIXEXIT

		#Writing the pixel data (I) to the memory controller
		7		#7			#Grab Upper/Lower from memory
		RDMEM	#UL
		0		#0 UL		#If it's zero, branch off
		CP		#0 UL	
		DROP	#UL
		DROP	#
		2		#CDE
		WRPIXNOWR #addr CDE
		BRN		#
		NOP		#

		#If UL is 1:
			3				#Grab I from memory
			RDMEM	#I
			WRPRT	#		#Send it to the MC
			0		#0		#Toggle MC_pix2we
			3		#3 0
			1		#1 3 0
			3		#3 1 3 0
			WRPIN 	#3 0
			WRPIN	#

			6				#Grab Addr from memory
			RDMEM	#Addr
			DUP		#Addr Addr
			WRPRT	#		#Send it to the MC
			0		#0		#Toggle MC_addrwe
			4		#4 0
			1		#1 4 0
			4		#4 1 4 0
			WRPIN 	#4 0
			WRPIN	#Addr
			1		#1 Addr	#Increment Addr
			ADD		#Addr
			6		#6 Addr
			WRMEM
	
			0		#0		#Toggle MC_bigwe to start write
			5		#5 0
			1		#1 5 0
			5		#5 1 5 0
			WRPIN 	#5 0
			WRPIN	#

			0				#Set UL to 0
			7
			WRMEM

			WRPIXEXIT		#Exit the IF statement
			JP
			NOP

		#If UL is 0
		label WRPIXNOWR
			3				#Grab I from memory
			RDMEM	#I
			WRPRT	#		#Send it to the MC
			0		#0		#Toggle MC_pix1we
			2		#2 0
			1		#1 2 0
			2		#2 1 2 0
			WRPIN 	#2 0
			WRPIN	#

			1				#Set UL to 1
			7
			WRMEM

		label WRPIXEXIT

		#Increment the X mandelbrot and X pixel coordinates
		0					#Xmand
		RDMEM
		1638400	#0.00625
		ADD
		0
		WRMEM

		4					#Xpix
		RDMEM
		1
		ADD
		DUP
		4
		WRMEM		#Xpix left on stack

		#Check the exit condition of getting to the end of the horizontal line
		640		#640 Xpix
		CP		#640 Xpix
		DROP	#Xpix
		DROP	#
		2		#CDE
		XLPEXIT	#XLPEXIT CDE
		BRN		#
		NOP

		#Otherwise, loop back to the X loop
		XLOOP
		JP
		NOP

	label XLPEXIT

	#Increment Y pixel coord, decrement Y mandelbrot coord
	1				#Ymand
	RDMEM
	4292739072 #-0.00833
	ADD
	1
	WRMEM

	5				#Ypix
	RDMEM
	1
	ADD
	DUP
	5
	WRMEM		#Ypix left on stack

	#Check the exit condition of getting to the bottom of the screen
	480		#480 Ypix
	CP		#480 Ypix
	DROP	#Ypix
	DROP	#
	2		#CDE
	YLPEXIT	#YLPEXIT CDE
	BRN		#
	NOP

	#Otherwise, loop back to the X loop
	YLOOP
	JP
	NOP

label YLPEXIT

#Reset the mode of the memory controller
0
1
WRPIN

#End
label END
END
JP
NOP
%

#Profit.
#Ben Oztalay 2011
