%% 
% Seth Ireland, Anthony Caine and Brian Collery 
function [rowTangent] = Daubechies(imagePath,D1,D2,path,resizeFactor )
    I= imread(imagePath);
    [row, column, depth] = size(I);
    rowMatD1 = makeD2k(D1,row/2);
    rowMatD2 = makeD2k(D2,row/2);
    columnMatD1 = makeD2k(D1,column/2);
    columnMatD2 = makeD2k(D2,column/2);
    
    [rowTangent, rowStart] = geodesicMat(rowMatD1,...
        rowMatD2,[row/2,row/2]);
    [columnTangent, columnStart] = geodesicMat(columnMatD1,...
        columnMatD2,[column/2,column/2]);
    frameMaker(rowStart,columnStart, rowTangent, columnTangent,...
        row,column,depth, imagePath, path,resizeFactor);
end



