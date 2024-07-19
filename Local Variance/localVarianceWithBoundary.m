
function [locVar] = localVarianceWithBoundary(k,n)
    if ( (2*k+1) >= n)
        locVar = n*eye(n) - ones(n);
    else
        locVar = zeros(n);
        % Creating the boundary cases.
        for i = 1:k
            locVar(i,i) =  k + i - 1;
            locVar(n-i+1,n-i+1) = k+i-1;
            for j = 1:i-1
                locVar(i,j) = -1;
                locVar(n-i+1,n-j+1)=-1;
            end
            for j = 1:k
                locVar(i,i+j) = -1;
                locVar(n-i+1,n-i+1-j)=-1;
            end
        end
        % Create the rest of the matrix. Begin with the vector that we will
        % create.
        tempVec = zeros(1,n);
        for i=1:k
            tempVec(i) = -1;
            tempVec(i+k+1) = -1;
        end
        tempVec(k+1) = 2*k;
        
        for i = k+1:n-k
            locVar(i,:) = circshift(tempVec,i-k-1);
        end
    end
end