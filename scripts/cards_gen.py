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
	print(gen_file(1000))
#method for making a list of lists
def gen_file(n):
	defin = '(define myfile \n\'('
	for i in range(n):
		defin += '('+gen_hand()+' '+gen_card()+')\n'
	defin += '))'
	return defin

#method for generating a hand
def gen_hand():
	size = randint(2,4)
	hand = '('
	for i in range(size):
		hand += gen_card() +' '
	hand += ')'
	return hand
#Method for generating a random card
def gen_card():
	return '('+numbers[gen_num(1,12)]+' '+suit[gen_num(1,4)]+')'
#Method for generating a number between Min and Max(inclusive)
def gen_num(Min, Max):
	return randint(Min,Max)
if __name__=='__main__':
	main()
