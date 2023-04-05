# Graph coloring by DLX

April 2, 2023

## Exact cover problem

**Input:** Subsets $S_1,\ldots,S_m$ of $\{1,\ldots,n\}$.

**Output:** Indices $i_1,\ldots, i_k$ such that $S_{i_1},\ldots,S_{i_k}$ is a partition of  $\{1,\ldots,n\}$.

**Fact:** The exact cover problem is NP complete.

Often, the exact cover problem is represented by an $m\times n$ matrix with entries $0$ and $1$. The rows are characteristic vectors of the subsets $S_i$. The goal is to find a subset of the rows that sums up to the all-one vector.

## DLX: Dancing links algorithm by Donald Knuth

http://www-cs-staff.stanford.edu/~uno/papers/dancing-color.ps.gz

## Graph coloring with $n$ colors 

**Input:** Simple graph $G=(V,E)$, integer $n$.

**Output:** A map $c: V \to \{1,\ldots,n\}$ such that $c(v)\neq c(u)$ for $vw\in E$.

**Fact:** Graph coloring with $n$ colors  is an NP complete problem.

## Graph coloring to exact cover

Given $G=(V,E)$ and $n$. Define the set $X=V\cup E\times \{1,\ldots,n\}$. For $v\in V$, $i\in \{1,\ldots,n\}$, define the subsets

$S_{v,i} = \{v\} \cup \{(e,i) \mid v \in e \}$.

For $e\in E$, $i\in \{1,\ldots,n\}$, define the singletons $T_{e,i}=\{(e,i)\}$. 

**Claim:** Graph colorings of $G$ with $n$ colors correspond to exact coverings of $X$ with subsets $S_{v,i}$ and $T_{e,i}$. 

## Description from SageMath documentation

https://doc.sagemath.org/html/en/reference/graphs/sage/graphs/graph_coloring.html#sage.graphs.graph_coloring.all_graph_colorings

Given a simple graph $G=(V,E)$, and and integer $n$. SageMath applies Knuth's DLX to a 0/1 matrix, that corresponds to the exact cover problem given above.

> The construction works as follows. Columns:
>
> * The first $|V|$ columns correspond to a vertex -- a $1$ in this column indicates that this vertex has a color.
> * After those $|V|$ columns, we add $n|E|$ columns -- a $1$ in these columns indicate that a particular edge is incident to a vertex with a certain color.
>
> Rows:
>
> * For each vertex, add $n$ rows; one for each color $c$. Place a $1$ in the column corresponding to the vertex, and a $1$ in the appropriate column for each edge incident to the vertex, indicating that that edge is incident to the color $c$.
>   
> * If $n > 2$, the above construction cannot be exactly covered since each edge will be incident to only two vertices (and hence two colors) - so we add $n|E|$ rows, each one containing a $1$ for each of the $n|E|$ columns. These get added to the cover solutions "for free" during the backtracking.
>
> Note that this construction results in $n|V| + 2n|E| + n|E|$ entries in the matrix.  The Dancing Links algorithm uses a sparse representation, so if the graph is simple, $|E| \leq |V|^2$ and $n \leq |V|$, this construction runs in $O(|V|^3)$ time.  Back-conversion to a coloring solution is a simple scan of the solutions, which will contain $|V| + (n-2)|E|$ entries, so runs in $O(|V|^3)$ time also. For most graphs, the conversion will be much faster -- for example, a planar graph will be transformed for $4$-coloring in linear time since $|E| = O(|V|)$.









