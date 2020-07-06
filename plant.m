function dfz = plant(u, z)

A = [0 1;
     0 0];
B = [0;
     1];
 
dfz = A*z + B*u;
end