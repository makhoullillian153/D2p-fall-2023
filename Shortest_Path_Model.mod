set NODES;  # intersections

param start symbolic in NODES; # starting location
param stop symbolic in NODES;  # ending location

set paths within NODES cross NODES;

param val {NODES} >= 0; # value of searching next node

param N >= 0; # Determines the number of nodes we can visit

var X {(i,j) in paths} >= 0;   # 1 iff (i,j) in shortest path

minimize Total_Cost: 
	sum {(i,j) in paths} val[j] * X[i,j];

subject to Start:  
	sum {(start,j) in paths} X[start,j] = 1; # Must leave start, necessary in case of start = stop

subject to End:
  sum {(j,stop) in paths} X[j,stop] = 1; # Make sure we end with the last node

subject to Balance {k in NODES diff {start,stop}}: 
   sum {(i,k) in paths} X[i,k] = sum {(k,j) in paths} X[k,j]; 
   # diff {start,stop} excludes the starting and ending node from this constraint
   # This allows flow to stop at the starting and ending nodes

subject to Urgency:
	sum {(i,j) in paths} X[i,j] <= N; # Makes sure the length of the path we take is less than 
									  #	or equal to the number of steps we have available



