# perfect-sts

# Definitions

- Steiner Triples System (STS): Point set [0..n-1], set B of triples (blocks, lines).
- Perfect STS of size 7, 9, 25, 33, 79, 139, 367, 811, 1531, 25771, 50923, 61339, 69991
- Automorphism group, block transitive automorphism group
- Examples

# Usage

Clone the repo, then

```sh
cd perfect-sts

python3 generate_sts25.py
python3 generate_sts33.py
python3 generate_sts_large_.py #takes long

python3 graph_from_sts.py #takes long

sage edge_coloring.sage.py #takes long
```

# References

[1] M. J. Grannell, T. S. Griggs, and J. P. Murphy, “Some new perfect Steiner triple systems,” J. Combin. Designs, vol. 7, no. 5, pp. 327–330, 1999, doi: 10.1002/(SICI)1520-6610(1999)7:5<327::AID-JCD3>3.0.CO;2-S.

[2] A. D. Forbes, M. J. Grannell, and T. S. Griggs, “On 6-sparse Steiner triple systems,” Journal of Combinatorial Theory, Series A, vol. 114, no. 2, pp. 235–252, Feb. 2007, doi: 10.1016/j.jcta.2006.04.003.
