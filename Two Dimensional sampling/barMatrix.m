function [G1Bar,G2Bar] =barMatrix(G1Bar,G2Bar,flagType)
    l = length(flagType);
    pAlt =altSyntax(flagType);
    % We need to add the bar to the first section in a different manner
    % than the other sections as there is no zeroth element in a vector in
    % matlab. This is more of a coding issue than a math issue.

    % We will bar the first section by itself

    G1Slice = G1Bar(:,1:flagType(1));
    G2Slice = G2Bar(:,1:flagType(1));
    
    [U,S,V ] = svd(G1Slice'*G2Slice);
    G1Bar(:,1:flagType(1)) = G1Slice*U;
    G2Bar(:,1:flagType(1)) = G2Slice*V;
    
    for i =1:(l-1)
        G1Slice = G1Bar(:,(pAlt(i)+1):(pAlt(i+1)));
        G2Slice = G2Bar(:,(pAlt(i)+1):(pAlt(i+1)));
        [U,S,V ] = svd(G1Slice'*G2Slice);
        G1Bar(:,(pAlt(i)+1):(pAlt(i+1))) = G1Slice*U;
        G2Bar(:,(pAlt(i)+1):(pAlt(i+1))) = G2Slice*V;
    end
end