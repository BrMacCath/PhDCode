
function [A,P] = ChangePath(a,b,c,Im,flagType,daubechiesNumbers,resizeFactor,path)
    
    dim = sum(flagType);
    % Make the three Daubechies points.


    
    A = makeD2k(daubechiesNumbers(1),dim/2);
    B = makeD2k(daubechiesNumbers(2),dim/2);
    C = makeD2k(daubechiesNumbers(3),dim/2);

    [P,path1,ABar] =pathProgress(A,B,a/(a+b),flagType);

    [Q,path2,PBar] = pathProgress(P,C,c,flagType);

    midpoint = frameMaker(ABar,ABar,path1,path1,dim,dim,1,Im,path,resizeFactor);

    frameMaker(PBar,PBar,path2,path2,dim,dim,1,Im,path,resizeFactor,midpoint);

    

end