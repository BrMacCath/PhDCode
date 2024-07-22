
function [Q] = makeD2k(k,n)
    D = dauboMat(k,n);
    Q = gramSchmidt(D,n);
end
