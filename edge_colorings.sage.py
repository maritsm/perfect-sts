#!/usr/bin/env sage
from sage.all import *

STS_NUMBERS = [7, 9, 25, 33, 79, 139, 367, 811, 1531, 25771, 50923, 61339, 69991]

def readGraphFromFile(filename):
    l = []
    try:
        with open(filename, "r") as f:
            for line in f:
                l.append(line.split())
    except FileNotFoundError:
        print(f"...skipping {filename}, file not found")
        return None
    return Graph(l, format="list_of_edges")

def printFinding(v, x):
    print(f"The edge graph of STS({v}) has {x} distinct coloring(s)")
    with open("findings" + str(v) + ".txt", "w") as f:
        f.write(str(x))

if __name__ == "__main__":
    findings = {}
    for v in STS_NUMBERS:
        print(f"Graph for STS({v})")
        G = readGraphFromFile("graph" + str(v) + ".txt")
        if G == None:
            continue
        L = sage.graphs.line_graph.line_graph(G)
        print(L)
        x = sage.graphs.graph_coloring.number_of_n_colorings(L,3)//6 #we divide by 6 to account for permutations of the 3 colors
        findings[v] = x
        printFinding(v,x)
    print(findings)
