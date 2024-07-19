%%
% Written by Brian Collery

% Converts an element of the Sparse matrix variety
% into a sparse Matrix.

function[genMat] = circulantMatrixGen(circVec,n)
genMat = zeros(n,n/2);
for i = 1:n/2
    genMat(:,i) = circshift(circVec,2*i-2);
end
end