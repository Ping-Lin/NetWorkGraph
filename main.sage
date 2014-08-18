#!/usr/bin/sage
from sage.all import *
import sys, getopt
inputFile=""
ifMultiedges=False
ifDirected = False
ifColor = False

#usage message
def usage():
	print("[Usage]: %s inputFile [-h|--help] [-m|--multiedges] [-d|--directed] [-c|--color]" %sys.argv[0])

#deal with arguments
def checkArguments():	#need the least two argument
	if len(sys.argv) < 2:
		usage()
		exit()
	
	global inputFile   #set up the input file name
	inputFile = sys.argv[1]

	try:
		opts, args = getopt.getopt(sys.argv[2:], "hmdc", ["help", "multiedges", "directed", "color"])
	except getopt.GetoptError as err:
		#print str(err)
		usage()
		sys.exit()
	
	for opt, args in opts:
		if opt in ("-h", "--help"):
			usage()
			sys.exit()
		elif opt in ("-m", "--multiedges"):
			global ifMultiedges
			ifMultiedges = True
		elif opt in ("-d", "--directed"):
			global ifDirected
			ifDirected = True
		elif opt in ("-c", "--color"):
			global ifColor
			ifColor = True
		"""else:
			print opt, "!!"
			assert False, "unhandled option"   #if there is True for something in else statement, then output...
			usage()"""
	
#read the input file
def readFile():
	l=[]
	global inputFile
	with open(inputFile, 'r') as f:
		for line in f:
			cut = [x.strip() for x in line.strip().split(",")]
			l.append(cut)
	return l

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
					if cut[i+1] is not "" and float(cut[i+1]) >= 0.95:
						l.append([int(cut[0]), i+1])
	
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
			if flag is True:
				modifiedL.append(l[i]);

		#add into remainging graph
		l = modifiedL

		for num in findMax[0]:
			print num,",",
		print
			
def main():
	#test grid2DGraph
	"""g = graphs.Grid2dGraph(12,10)
	g.plot(color_by_label=True, edge_style='solid').show(filename="1.png", figsize=(15,15), title="network")
	sys.exit(1)"""
	#read the input and draw the graph
	"""	
	checkArguments()
	l = readFile()
	#initial the edge colors
	R = rainbow(len(l))
	edge_colors = {}   #the dictionary initial
	#create the graph
	if ifDirected is True:
		g = DiGraph({}, loops = True, multiedges=ifMultiedges)
	else:
		g = Graph({}, loops = True, multiedges=ifMultiedges)
	for i in xrange(len(l)):
		for a, b, c in [(l[i][0], l[i][1], l[i][2])]:
			g.add_edge(a, b, c)
			if ifColor is True:
				edge_colors[R[i]] = [(a, b, c)]

	g.plot(vertex_size = 8, edge_labels=True, edge_colors=edge_colors, edge_style='solid').show(filename="test.png", figsize=(50,50), title="network")"""
	
	cliqueFunc();	


if __name__ == "__main__":
	main()

