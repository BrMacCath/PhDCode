% Written by Brian Collery

% This code will use a path along a Grassmannian and a fucntion project it at
% different points in order to 
path = 0:0.01:1;
f=@(x) sin(x);
daubechiesNumbers = [1,5,3];
sampleDomain = 0:0.2:2*pi;
t = length(sampleDomain);
a = .5;
b = .5;
c = .5;

if (mod(t,2) ~= 0)
    sampleDomain = sampleDomain(1:t-1);
end

oneDChangePath(f,daubechiesNumbers,sampleDomain,path,a,b,c);
