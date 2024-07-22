function [] = oneDDaubToRand(f,daubechiesNumber,sampleDomain,path)
    dim = length(sampleDomain);
    flagType =[dim/2,dim/2];
    samplePoints = f(sampleDomain)';
    rowMatD1 = makeD2k(daubechiesNumber,dim/2);
    randomPoint = specialOrtho(dim);

    [tangent,startPoint] = geodesicMat(rowMatD1,randomPoint(:,1:dim/2),flagType); 
    frameMakerOneD(startPoint, tangent,samplePoints,sampleDomain,flagType,path);
end