
% if k>n, subspace becomes dependent on circshift function, Matlab doesn't compute daub(k,1) for k>49
n = 14; % computations will take place on Gr(n,2n)
k = 1; % The Daub we wish to start from
p = [n,n];
t = 0:0.01:1;
resizeFactor = 10;


RandomPath('MNISTExample.png',k,t,resizeFactor)

