#!/usr/bin/sage
import sys, getopt
import networkx as nx
#import matplotlib.pyplot as plt
import pygraphviz as pg

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
	global inputFile   #set up the input file name
	inputFile = sys.argv[1]

	try:
		f = open(inputFile, 'r')
	except IOError:
		print "[Error]: \"%s\" file open error" %inputFile
		exit()
	else:
		with f:   #this can change to read csv file
			for line in f:
				cut = [x.strip() for x in line.strip().split(",")]
				l.append(cut)

	return l

def main():
	#read the input and draw the graph
	checkArguments()
	l = readFile()
	#initial the edge colors
	edge_colors = {}   #the dictionary initial
	#create the graph

	G = pg.AGraph()
	G.node_attr.update(color = "black", shape = "point", height = 0.3)

	for i in xrange(len(l)):
		for a, b, c in [(l[i][0], l[i][1], l[i][2])]:
			x = str(int(c)*1.0/500)
			G.add_edge(a, b, len = x, color = "blue")

	G.draw('hi.svg', format = 'svg', prog = 'neato')

if __name__ == "__main__":
	main()



"""if ifDirected is True:
		g = DiGraph({}, loops = True, multiedges=ifMultiedges)
	else:
		g = Graph({}, loops = True, multiedges=ifMultiedges)
	for i in xrange(len(l)):
		for a, b, c in [(l[i][0], l[i][1], l[i][2])]:
			g.add_edge(a, b, c)
			if ifColor is True:
				edge_colors[R[i]] = [(a, b, c)]

	g.plot(vertex_size = 8, edge_labels=True, edge_colors=edge_colors, edge_style='solid').show(filename="test.png", figsize=(20,20), title="network")"""
