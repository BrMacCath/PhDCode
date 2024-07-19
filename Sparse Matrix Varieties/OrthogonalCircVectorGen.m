%%
% Written by Brian Collery

%% Script to take a vector and make it piecewise orthogonal along d parts to itself
% Strip the vector into d components of length k and make each part
% that is recieved through circulation orthogonal. Do so in a way that
% only changes one component at a time.

% Test case: My first case is going to try do this with either 2
% components or three. The hope is that by seeing how to do this for
% small scale the method of extending this will stretch.
function [circVec] = OrthogonalCircVectorGen(k,d,n)
    circVec = zeros(n,1);
    circVec(1:2*d) =normrnd(0,1,2*d,1);
    circVec = circVec/sqrt(circVec'*circVec);

    components = zeros(k,d);
    for i=1:d
        components(:,i) = circVec(k*i-1:k*i);
    end
    if d == 2
        components(:,1) = components(:,1) /sqrt(components(:,1)'*components(:,1) );
        components(:,2) 
        components(:,2) = components(:,2) - (components(:,2)'*components(:,1))*components(:,1)
    end
    if d ==3
        components(:,1) = components(:,1) /...
            sqrt(components(:,1)'*components(:,1) ); 
        components(:,3) = components(:,3) - (components(:,3)'*components(:,1))*components(:,1)
        tempVec = components(:,1) +components(:,3);
        components(:,2) = components(:,2) - (1/(tempVec'*tempVec))*(tempVec'*components(:,2))*tempVec;
    end
    % Succeeded with the 2 and three case. Time for 4!     

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
        circVec(k*i-1:k*i) =components(:,i);
    end
    circVec = circVec/sqrt(circVec'*circVec);


end


    