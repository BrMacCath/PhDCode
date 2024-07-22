% This code is written by Brian Collery.

% This code allows you to move between the spherical triangle of three
% Daubecies wavelets embedded within any Gr(n,2n) and see what the path looks like 
% through the associated projection matrix applied to an image.
n= 14;
flagType = [n,n];
k = [1,5,3]; % the 3 k values we want to measure distance between
a = .5;
b = .5;
c = .5;
path = 0:0.01:1;
resizeFactor = 10;


ChangePath(a,b,c,'MNISTExample.png',flagType ,k,resizeFactor,path)