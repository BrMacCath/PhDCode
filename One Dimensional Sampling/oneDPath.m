function [startPoint]=oneDPath(f,daubechiesNumbers,sampleDomain,path)
    dim = length(sampleDomain);
    flagType =[dim/2,dim/2];
    A = makeD2k(daubechiesNumbers(1),dim/2);
    B = makeD2k(daubechiesNumbers(2),dim/2);
    samplePoints = f(sampleDomain)';
    [tangent,startPoint] = geodesicMat(A,B,flagType);  
    frameMakerOneD(startPoint,tangent,samplePoints,sampleDomain,flagType,path);
end

