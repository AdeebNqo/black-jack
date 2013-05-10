def main():
	f = open("stop-at.csv")
	lines  = f.readlines()
	for line in lines:
		vals = line.split(',')
		count = 0
		for num in vals:
			if (num=='1'):
				count = count + 1
		print(count/float(1000))
if __name__=='__main__':
	main()
