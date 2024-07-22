function [A,G1Bar,G2Bar] = geodesicMat(G1,G2,flagType)
    n = sum(flagType);
    if (length(flagType) == 2)
        [A,G1Bar,G2Bar] = GrassShortPath(G1,G2,flagType);
    else     
        % This will need to be re eddited later
        % Get the SVD decom of their product.
        B = G1'*G2;
        [U,S,V] = svd(B);
        % Thicken the bar of each grassmannian
        % respectively. I.e multiply them by their
        % SVD vector decomp respectively and then find their complement.
        G1Bar = Thicken(G1,flagType);
        G2Bar = Thicken(G2,flagType);
        [G1Bar,G2Bar] = barMatrix(G1Bar,G2Bar,flagType);
        G = G1Bar'*G2Bar;
        if (det(G) < 0)
            G2Bar(:,flagType(1)) = G2Bar(:,flagType(1))*(-1);
            G = G1Bar'*G2Bar;
        end
        A = logm(G);
        A = real(A);
    end
end