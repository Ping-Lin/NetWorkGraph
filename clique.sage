#!/usr/bin/sage
from sage.all import *
import sys

#this function is calculating the clique number, the input is the correlation table
def cliqueFunc():
	l=[]   #the graph two dimension array

	#read file
	with open("correlation_total.csv", 'r') as f:
		tmp = f.readline()   #the first line we don't want
		for line in f:
			cut = [x.strip() for x in line.strip().split(",")]
			for i in xrange(len(cut)-1):
				if i+1 > int(cut[0]):
					if cut[i+1] != "" and float(cut[i+1]) >= 0.95:
						l.append([int(cut[0]), i+1])
	
	f = open(argv[1], 'wt')

	#gridy method to find every maximum clique
	while len(l) != 0:   #when the remaining graph is 0
		g = Graph({}, loops = False, multiedges=False)

		for i in xrange(len(l)):
			for a, b in [(l[i][0], l[i][1])]:
				g.add_edge(a, b)
	
		modifiedL=[]   #store the list no remove

		findMax = g.cliques_maximum()   #find the max clique
		for i in xrange(len(l)):
			flag = True
			for num in findMax[0]:   #becase there is posibility of multiple max cliques
				if l[i][0] == num or l[i][1] == num:
					flag = False
					break
			if flag == True:
				modifiedL.append(l[i]);

		#add into remainging graph
		l = modifiedL

		for num in findMax[0]:
			print num,",",
		print
			
def main():
	cliqueFunc();	

if __name__ == "__main__":
	main()

