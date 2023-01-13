# omega and alpha values based on Grannell, Griggs, Murphy - Some New Perfect Steiner Triple Systems (1998)
V = [79, 139, 367, 811, 1531, 25771, 50923, 61339, 69991]
Omega = [3, 2, 6, 3, 2, 2, 2, 2, 3]
Alpha = [29, 25, 112, 18, 84, 4525, 12999, 630, 7175]

for i in range(len(V)):
	v = V[i]
	alpha = Alpha[i]
	omega = Omega[i]
	print("Generating STS(" + str(v) + ")")

	with open("sts" + str(v) + ".txt", "w") as f:
		for n in range((v-1)//6):
			for m in range(v):
				f.write( str(m) + " " + str((pow(omega, 6*n, v) + m)%v) + " " + str((pow(omega, 6*n, v)*alpha + m)%v) + "\n")

