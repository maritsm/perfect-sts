# perfect-sts

## Definitions

- Steiner Triples System (STS): Point set [0..n-1], set B of triples (blocks, lines).
- Perfect STS of size 7, 9, 25, 33, 79, 139, 367, 811, 1531, 25771, 50923, 61339, 69991
- Automorphism group, block transitive automorphism group
- Examples

## Goals

# TODO

## 15/01/2023

- Based on the papers [...] we can generate the known perfect STS, see `generate_sts*.py`. Store them in the file `sts$n.txt` by listing the blocks. 
- We can read them by `graph_from_sts.py` and generate the cubic graph corresponding to the first block. The cubic graphs are saved in `graph$n.txt`.
- In `edge_colorings.sage.py`, we read the cubic graphs, and compute the number of colorings of their line graph with three colors. We print the number of colorings, divided by 6=3!. 
- We save the results for orders 7,9,25,33,79 in the files `findings$n.txt`. For order 139, no results were found in 8 hours of CPU time.
- Usage: `cd [...]/perfect-sts && sage edge_colorings.sage.py`

## 31/01/2023

- `edge_colorings.sage.py` uses Knuth's DLX. With `count_only==True`, the search tree is traversed, without saving the results. 
- For n<=79, we want to compute all colorings and study the resulting cubic graphs and STSs. 
  
# References