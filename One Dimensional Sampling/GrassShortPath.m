function [A,G1Bar,G2Bar] = GrassShortPath(G1,G2,flagType)
    n = sum(flagType);
    G1Bar = Thicken(G1,flagType);
    G2Bar = Thicken(G2,flagType);
    G1Slice1 = G1Bar(:,1:flagType(1));
    G2Slice1 = G2Bar(:,1:flagType(1));
    [U,S,V] = svd(G1Slice1'*G2Slice1);
    G1Slice1 =G1Slice1*U;
    G2Slice1 =G2Slice1*V;
    G1Slice2 = G1Bar(:,flagType(1)+1:n);
    G2Slice2 = G2Bar(:,flagType(1)+1:n);
    [U,S,V] = svd(G1Slice2'*G2Slice2);
    G1Slice2 =G1Slice2*U;
    G2Slice2 =G2Slice2*V;
    G1Bar = [G1Slice1 G1Slice2];
    G2Bar = [G2Slice1 G2Slice2];
    A = logm(G1Bar'*G2Bar);
end