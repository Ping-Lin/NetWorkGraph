#!/usr/bin/sage
from sage.all import *

l=[[1,2,12],[3,4,9],[2,5,10],[1,3,7],[2,4,1],[2,5,100],[4,5,34],[2,3,21]]

#initial the edge colors
R = rainbow(len(l))
edge_colors = {}   #the dictionary initial

#create the graph
g = DiGraph({}, loops=True, multiedges=True)

for i in xrange(len(l)):
	for a, b, c in [(l[i][0], l[i][1], l[i][2])]:
		edge_colors[R[i]] = [(a, b, c)]
		g.add_edge(a, b, c)


g.plot(edge_labels=True, edge_colors=edge_colors, edge_style='solid').show(filename="test.png", figsize=(8,8), title="network")

