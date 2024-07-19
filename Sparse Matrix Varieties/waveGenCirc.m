%%
% Written by Brian Collery

%% Purpose of Script
% The goal of this script is to try randomly generate a sparse circulant orthogonal
% matrix. The number of non zero entries is 2*d and the dimensions of the
% matrix is n,n/2

function [genMat] =waveGenCirc(d,n)
    %% Step 1: Generate the vector that will form the orthogonality
    % Creat the vector of length n with 2*d non zero components and then
    % normalise them.
    circVec = zeros(n,1);
    circVec(1:2*d) =normrnd(0,1,2*d,1);
    circVec = circVec/sqrt(circVec'*circVec);
    
    %% Step 2: Make sure the components are orthogonal on d subspaces to each other
    
    components = zeros(2,d);
    for i=1:d
        components(:,i) = circVec(2*i-1:2*i);
    end
    if d == 2
        components(:,1) = components(:,1) /sqrt(components(:,1)'*components(:,1) );
        components(:,2) = components(:,2) - (components(:,2)'*components(:,1))*components(:,1)
    end
    if d ==3
        components(:,1) = components(:,1) /sqrt(components(:,1)'*components(:,1) ); 
        components(:,3) = components(:,3) - (components(:,3)'*components(:,1))*components(:,1);
        tempVec = components(:,1) +components(:,3);
        components(:,2) = components(:,2) - (1/(tempVec'*tempVec))*(tempVec'*components(:,2))*tempVec;
    end


    if d==4
        components(:,1) = components(:,1) /sqrt(components(:,1)'*components(:,1) ); 
        components(:,4) = components(:,4) - (components(:,4)'*components(:,1))*components(:,1);
        tempProd1 = components(:,3)'*components(:,1);
        tempProd2 = components(:,4)'*components(:,2);
        alpha = -tempProd1/tempProd2;
        components(:,2) = alpha*components(:,2);
        tempProd1 = components(:,2)'*components(:,1) +components(:,3)'*components(:,2) + components(:,3)'*components(:,4);
        tempVec = zeros(2,1);
        tempVec_2 = components(:,4);
        tempVec(1) = -tempVec_2(2);
        tempVec(2) = tempVec_2(1);
        tempProd2 = tempVec'*(components(:,1)+components(:,3));
        alpha = -tempProd1/tempProd2;
        components(:,2) = components(:,2) + alpha*tempVec;
    end

    for i=1:d
        circVec(2*i-1:2*i) =components(:,i);
    end

    %% Step 3: Normalise the vector

    circVec = circVec/sqrt(circVec'*circVec);
    
    %% Step 3: Create the circulant matrix from the vector
    % This step is to take the vector that has 
    genMat = zeros(n,n/2);
    for i = 1:n/2
        genMat(:,i) = circshift(circVec,2*i-2);
    end
    genMat'*genMat;

end
