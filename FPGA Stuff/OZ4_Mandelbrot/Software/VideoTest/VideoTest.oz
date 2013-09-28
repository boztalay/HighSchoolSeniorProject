#A quick test to make sure the video buffer and memory controller work

#Hit the run light
1
0
WRPIN

0	#ctr

#Set the memory controller's mode
1	#1 ctr
1	#1 1 ctr
WRPIN #ctr

#Video writing loop, just red

label VIDLP

	#Write to the address register
	DUP		#ctr ctr
	WRPRT	#ctr
	#Toggle MC_addrwe
	0	#0 ctr
	4	#4 0 ctr
	1	#1 4 0 ctr
	4	#4 1 4 0 ctr
	WRPIN #4 0 ctr
	WRPIN #ctr
	
	#Write in the pixels as red
	224	#224 ctr
	WRPRT #ctr
	#Toggle MC_pix1we
	0	#0 ctr
	2	#2 0 ctr
	1	#1 2 0 ctr
	2	#2 1 2 0 ctr
	WRPIN #2 0 ctr
	WRPIN #ctr
	
	#Write in the other pixel as blue
	3	#3 ctr
	WRPRT #ctr
	#Toggle MC_pix2we
	0	#0 ctr
	3	#3 0 ctr
	1	#1 3 0 ctr
	3	#3 1 3 0 ctr
	WRPIN #3 0 ctr
	WRPIN #ctr
	
	#Lastly, load it all into the big register
	0	#0 ctr
	5	#5 0 ctr
	1	#1 5 0 ctr
	5	#5 1 5 0 ctr
	WRPIN #5 0 ctr
	WRPIN #ctr
	
	#Check to see if we've written enough, 153600 addresses
	
	#Increment counter
	1	#1 ctr
	ADD #ctr
	DUP #ctr ctr
	153599 #153599 ctr ctr
	CP	#153599 ctr ctr
	DROP #ctr ctr
	DROP #ctr
	1	#1 ctr
	VIDLP #VIDLP 1 ctr
	BRN	#ctr
	
	NOP

#Reset the mode of the memory controller
0
1
WRPIN
#End
label END
END
JP

%

