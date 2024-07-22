% Written By Brian Collery

% The purpose of this code is to save the image of each image along the
% path by the path 

function [frameNum] = frameMakerOneD(startPoint,tangent,samplePoints,sampleDomain,flagType,path,frameNum)
    dim = flagType(1);
    checkStart = exist('frameNum','var');
    if (checkStart~= 1)
        frameNum = 1;
    end
    
    for i = 1:length(path)
        colMat = startPoint*expm(tangent*path(i));
        colMat = colMat(:,1:dim);
        colProj = colMat*colMat';
        sampleProjection = colProj*samplePoints;
        plotName = makeFrameName(frameNum);
        saveas(plot(sampleDomain,sampleProjection),plotName);
        frameNum = frameNum +1;
    end

end