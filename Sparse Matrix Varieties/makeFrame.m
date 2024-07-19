%%
% Written by Brian Collery

% Produces the frame and saves it.


function makeFrame(tempImage,thetaNum)
    tempImage = kron(tempImage,ones(13));
    thetaName = makeThetaName(thetaNum);
    saveas(imshow(tempImage),thetaName);
end