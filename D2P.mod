set NODES;

param start in NODES;
param stop in NODES;

param N >= 0; # pattern length

set paths within (NODES) cross (NODES);

param val {NODES} >0;

#param s {NODES} >= 0;

# This defines the paths between Nodes that we will use
var X {(i,j) in paths} >= 0;

# This defines the subtour elimination constraint variables
var t {i in 0..N-1} >= 0;

minimize Value:
	sum {(i,j) in paths} val[j]*X[i,j];
	
subject to Start:
	sum {(start, j) in paths} X[start, j] = 1;

subject to Balance {k in NODES}:
	sum {(i,k) in paths} X[i,k] = sum {(k,j) in paths} X[k,j];

subject to GoTo {i in NODES}:
	sum {(i,j) in paths} X[i,j] = 1;
	
subject to ComeFrom {j in NODES}:
	sum {(i,j) in paths} X[i,j] = 1;
	
subject to Subtour {i in NODES, j in NODES: i<>j}:
	t[j] >= t[i] + 1 - N*(1-X[i,j]);

subject to whatevername:
	t[0] = 0;
	