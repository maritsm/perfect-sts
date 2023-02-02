#!/usr/bin/env sage
from sage.all import *
import json

STS_NUMBERS = [7, 9, 25, 33, 79, 139, 367, 811, 1531, 25771, 50923, 61339, 69991]

def readGraphFromFile(filename):
    """
    Read the graph from the file, and return it as a sage `Graph` object.
    """
    l = []
    try:
        with open(filename, "r") as f:
            for line in f:
                l.append(line.split())
    except FileNotFoundError:
        print(f"Graph for STS({v}) was not found in ./graphs. Continuing...")
        return None
    return Graph(l, format="list_of_edges")

def printFinding(v, x, d):
    """
    Print the finding that "the perfect STS on `v` vertices as `x` different colorings",
    and take note of this in the dictionary `d`
    """
    print(f"The edge graph of STS({v}) has {x} distinct coloring(s)")
    d[v] = x
    """ #older way of saving findings to files
    with open("findings/findings" + str(v) + ".txt", "w") as f:
        f.write(str(x))
    """
    with open(f"findings/findings.json", "w") as f:
        json.dump(d, f)

def saveAllColorings(v, colorings):
    """
    Save the list of colorings as a json dump in the file `findings/all_colorings_sts{v}.json`
    """
    with open(f"findings/all_colorings_sts{v}.json", "w") as f:
        json.dump(colorings, f)

if __name__ == "__main__":
    findings = {}

    for v in STS_NUMBERS:
        print("###############################")
        print(f"Graph for STS({v})")
        # Read the graph for STS(v) from the file
        G = readGraphFromFile("graphs/graph" + str(v) + ".txt")
        if G == None:
            continue
        # Create line graph
        L = sage.graphs.line_graph.line_graph(G)
        #print(L)

        all_colorings = [i for i in sage.graphs.graph_coloring.all_graph_colorings(L,3)]
        x = len(all_colorings)//6 #we divide by 6 to account for permutations of the 3 colors
        #print(all_colorings)
        
        # Print results, save results
        findings[v] = x
        printFinding(v, x, findings)
        saveAllColorings(v, all_colorings)
        print()
