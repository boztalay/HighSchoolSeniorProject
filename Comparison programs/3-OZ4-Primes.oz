1
1
2
2
3
3
WRMEM
WRMEM
WRMEM

4 #addr
0 #0 addr
WRMEM

4 #cur
0 #wrk cur
2 #div wrk cur

label OUTOUTLOOP

	label OUTLOOP

		#copy current number
					#div wrk cur
		SWAP		#wrk div cur
		DROP		#div cur
		OVER		#wrk div cur

		label INLOOP

			#subtract divisor from working number
						#wrk div cur
			OVER		#div wrk div cur
			SWAP 		#wrk div div cur
			SUB			#wrk div cur

			#check working number for being zero, jump to outer loop to get new current number
			0			#0 wrk div cur
			CP			#0 wrk div cur
			DROP		#wrk div cur
			2			#cd wrk div cur
			OUTLOOPEXIT	#jad cd wrk div cur
			BRN			#wrk div cur
			NOP

			#check working number for being less than the divisor, if so go get a new divisor
			CP			#wrk div cur
			3	 		#cd wrk div cur
			INLOOPEXIT	#jad cd wrk div cur
			BRN			#wrk div cur
			NOP			

			#jump to top of INLOOP
			INLOOP		#jad wrk div cur
			JP			#wrk div cur
			NOP

		label INLOOPEXIT

		#increment divsor
					#wrk div cur
		SWAP		#div wrk cur
		1			#1 div wrk cur
		ADD			#div wrk cur
		
		#if divisor is equal to the number, jump to outer loop to get new current number
		CP			#div wrk cur
		SWAP		#wrk div cur
		2			#2 wrk div cur
		OUTLOOPEXIT #jad 2 wrk div cur
		BRN			#wrk div cur
		NOP

		#if divisor is 11 (greater than ten), jump to outer loop to get new current number
		SWAP		#div wrk cur
		11			#11 div wrk cur
		CP			#11 div wrk cur
		DROP		#div wrk cur
		SWAP		#wrk div cur
		2			#2 wrk div cur
		OUTLOOPEXIT	#jad 2 wrk div cur
		BRN			#wrk div cur
		NOP

		#jump back to OUTLOOP to reset the working number
		SWAP		#div wrk cur
		OUTLOOP
		JP
		NOP

	label OUTLOOPEXIT

	#reset divisor to 2
				#wrk div cur
	SWAP		#div wrk cur
	DROP		#wrk cur
	2			#div wrk cur
	SWAP		#wrk div cur

	#if the working number is zero, the number isn't prime. go get a new number ant jump to OUTOUTLOOP
	0			#0 wrk div cur
	CP			#0 wrk div cur 
	DROP		#wrk div cur
	DROP		#div cur			#we don't need wrk anymore
	2			#cd div cur
	NOWRITE		#jad cp div cur
	BRN			#div cur
	NOP

	#otherwise, store the current number in memory, increment the address, and get a new number/jump to OUTOUTLOOP
	SWAP		#cur div
	DUP			#cur cur div
	0			#0 cur cur div
	RDMEM		#adr cur cur div
	DUP			#adr adr cur cur div
	ROT			#adr cur adr cur div
	WRMEM		#adr cur div
	1			#1 adr cur div
	ADD			#adr cur div
	0			#0 adr cur div
	WRMEM		#cur div
	SWAP		#div cur	

	#if the number wasn't prime, don't write it, get a new one and move on
	label NOWRITE
			#div cur
	SWAP		#cur div
	1			#1 cur div
	ADD			#cur div
	0			#wrk cur div
	ROT			#div wrk cur

	#jump back to the top of OUTOUTLOOP
	OUTOUTLOOP
	JP
	NOP

label END
END
JP
NOP
%



		
