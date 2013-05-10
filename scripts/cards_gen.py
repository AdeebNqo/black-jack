from random import randint
suit = {1:'c', 2:'d', 3:'s', 4:'h'}
numbers ={
		1:'A',
		2:'2',
		3:'3',
		4:'4',
		5:'5',
		6:'6',
		7:'7',
		8:'8',
		9:'9',
		10:'K',
		11:'Q',
		12:'J'
	}
def main():
	print("Hello World")
	print(gen_card())

#method for generating a hand
def gen_hand()
#Method for generating a random card
def gen_card():
	return '('+numbers[gen_num(1,12)]+' '+suit[gen_num(1,4)]+')'
#Method for generating a number between Min and Max(inclusive)
def gen_num(Min, Max):
	return randint(Min,Max)
if __name__=='__main__':
	main()
