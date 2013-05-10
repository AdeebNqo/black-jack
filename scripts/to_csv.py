def main():
	inputfile = open('stop-at-test.txt')
	output = open('stop-at.csv','w')
	
	lines = inputfile.readlines()
	for i in lines:
		i = i.lstrip()
		i = i.replace('\n','')
		if (i==''):
			output.write('\n')
		else:
			if (i=='#f'):
				output.write('0')
			elif (i=='#t'):
				output.write('1')
			output.write(',')
if __name__ == '__main__':
	main()
