#A simple program to test out the simulation stuff

#Instr	#Stack

1	#1
2	#2 1
4	#4 2 1
8	#8 4 2 1
ADD	#12 2 1
ADD	#14 1
ADD	#15

44	#44 15
65	#65 44 15

ROT	#15 65 44
DUP	#15 15 65 44
RDS	#15 65 44

DROP	#65 44
SWAP	#44 65
OVER	#65 44 65
ADD	#109 65
SWAP	#65 109
DROP	#109
DROP	#
%

