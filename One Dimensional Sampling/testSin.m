k = 13;
n = 28;

vec = zeros(n,1);


for i=1:n
    vec(i) = sin(2*pi*k*(i-1)/n);
end

magnitude = sqrt(vec'*vec);

vec = vec/magnitude


potentialDiff=2*(1-cos(2*pi*k/n))

pD2 = potentialDiff/magnitude