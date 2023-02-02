#!/usr/bin/python3

def no(x,y):
	return str((x%5)*5 + (y%5))

with open("sts/sts25.txt", "w") as f:
	for i in range(5):
		for j in range(5):
			f.write( no(i,j) + " " + no(i, j+1) + " " + no(i+1,j) + "\n")
			f.write( no(i,j) + " " + no(i, j+2) + " " + no(i+2,j+1) + "\n")
			f.write( no(i,j) + " " + no(i+1, j+1) + " " + no(i+2,j+3) + "\n")
			f.write( no(i,j) + " " + no(i+1, j+3) + " " + no(i+3,j+3) + "\n")
