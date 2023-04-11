#!/usr/bin/env sage
from sage.all import *

# omega and alpha values based on Grannell, Griggs, Murphy - Some New Perfect Steiner Triple Systems (1998)
V = [79, 139, 367, 811, 1531, 25771, 50923, 61339, 69991]
Omega = [3, 2, 6, 3, 2, 2, 2, 2, 3]
Alpha = [29, 25, 112, 18, 84, 4525, 12999, 630, 7175]

def large_perfect_sts(v,omega,alpha):
    bls = []
    for n in range((v-1)//6):
        for m in range(v):
            b = [m,(pow(omega, 6*n, v) + m)%v,(pow(omega, 6*n, v)*alpha + m)%v]
            b.sort()
            bls.append(b)
    bls.sort()
    return bls
	
bls = large_perfect_sts(V[0],Omega[0],Alpha[0])
des = designs.BlockDesign(V[0],bls)

def graph_from_sts(des,b):
    if not b in des.blocks():
        print("# error: <b> is not a block")
        return 
    vertices = [x for x in range(des.num_points()) if not x in b]
    edges = []
    for c in des.blocks():
        c = set(c).difference(set(b))
        if len(c)==2:
            edges.append(list(c))
    return Graph([vertices,edges])

gra = graph_from_sts(des,bls[0])
lgra = gra.line_graph()

cols = [c for c in sage.graphs.graph_coloring.all_graph_colorings(lgra,3)]