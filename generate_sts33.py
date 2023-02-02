#!/usr/bin/python3

def no(x):
	return str(x%33)

with open("sts/sts33.txt", "w") as f:
	for i in range(33):
		f.write( no(i) + " " + no(i+1) + " " + no(i+7) + "\n")
		f.write( no(i) + " " + no(i+2) + " " + no(i+21) + "\n")
		f.write( no(i) + " " + no(i+3) + " " + no(i+20) + "\n")
		f.write( no(i) + " " + no(i+4) + " " + no(i+28) + "\n")
		f.write( no(i) + " " + no(i+8) + " " + no(i+18) + "\n")
		if i < 11: #this type only generates 11 distinct blocks, not 33
			f.write( no(i) + " " + no(i+11) + " " + no(i+22) + "\n")
