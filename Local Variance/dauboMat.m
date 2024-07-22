



function [D] = dauboMat(k,n)
    d = dbaux(k,1);
    v = zeros(2*n,1);
    v(1:2*k)=d'; % this is the basic column...now need to circshift it
    for i=1:n
        D(:,i) = circshift(v,2*i-2); % no matter where we start the circshift, we get same subspace (as long as k<=n)
    end
    D = D(1:2*n,:);
end
