
function [] = oneDChangePath(f,daubechiesNumbers,sampleDomain,path,a,b,c)
    dim = length(sampleDomain);
    flagType =[dim/2,dim/2];

    A = makeD2k(daubechiesNumbers(1),dim/2);
    B = makeD2k(daubechiesNumbers(2),dim/2);
    C = makeD2k(daubechiesNumbers(3),dim/2);
    size(A)
    size(B)

    [P,path1,ABar] =pathProgress(A,B,a/(a+b),flagType);
    size(P)
    [Q,path2,PBar] = pathProgress(P,C,c,flagType);
    samplePoints = f(sampleDomain)';
    midpoint = frameMakerOneD(ABar,path1,samplePoints,sampleDomain,flagType,path);
    frameMakerOneD(PBar,path2,samplePoints,sampleDomain,flagType,path,midpoint);
end
