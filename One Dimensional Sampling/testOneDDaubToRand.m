

path = 0:.01:1;
f=@(x) sin(x);
daubechiesNumber = 1;
sampleDomain = 0:0.2:2*pi;
t = length(sampleDomain);
resizeFactor = 10;

if (mod(t,2) ~= 0)
    sampleDomain = sampleDomain(1:t-1);
end


oneDDaubToRand(f,daubechiesNumber,sampleDomain,path);

