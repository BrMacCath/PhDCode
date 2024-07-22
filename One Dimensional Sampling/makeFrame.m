function makeFrame(tempImage,thetaNum)
    tempImage = kron(tempImage,ones(13));
    thetaName = makeThetaName(thetaNum);
    saveas(imshow(tempImage),thetaName);
end