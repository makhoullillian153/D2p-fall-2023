set NODES;

set paths within (NODES) cross (NODES); 

param start in NODES; # starting location
param stop in NODES;  # ending location

param val {NODES} >= 0; # value of searching next node

var X {(i,j) in paths} >= 0; # 1 iff (i,j) in shortest path
							 # Again, not defined as binary, 
							 # but the model solves it as though
							 # it were a binary variable.

minimize Value:
	sum {(i,j) in paths} val[j]*X[i,j];

# Must leave the starting node
subject to Start:
  sum {(start,j) in paths} X[start,j] = 1;
  
# Must visit the ending node
subject to End:
  sum {(j,stop) in paths} X[j,stop] = 1;
 
# No flow gets lost along the way 
subject to Balance {k in NODES diff {start,stop}}: 
   sum {(i,k) in paths} X[i,k] = sum {(k,j) in paths} X[k,j]; 

    
 
 
