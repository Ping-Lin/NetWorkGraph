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
	
	#initial graph
	g = Graph({}, loops = False, multiedges=False)
	for i in xrange(len(l)):
		for a, b in [(l[i][0], l[i][1])]:
			g.add_edge(a, b)

	#gridy method to find every maximum clique
	while g.size() != 0:   #when the remaining graph is 0	
		findMax = g.cliques_maximum()   #find the max clique
		g.delete_vertices(findMax[0])

		#add into remainging graph
		print "%d" %findMax[0][0],
		for num in findMax[0][1:]:
			print ", %d" %num,
		print
			
def main():
	cliqueFunc();	

if __name__ == "__main__":
	main()

