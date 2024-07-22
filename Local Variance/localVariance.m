
function [locVar] = localVariance(k,n)
if ( (2*k+1) >= n)
    locVar = eye(n) - (ones(n)/n);
else
    tempVec = zeros(1,n);
    locVar = zeros(n);
    tempVec(1) = 1;
    for i =1:k
        tempVec(1+i) = 1;
        tempVec(n-i+1) = 1;
    end
    for i =1:n
        locVar(i,:) = circshift(tempVec,i-1);
    end
    locVar = locVar *(1/(2*k+1));
    locVar = eye(n) - locVar;
end
end