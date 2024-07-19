%% Setting the parameters
% The first three correspond to the variance amount, the ammount of vectors
% to take and the fraction of vectors to take. The fraction part is going
% to subsume the amount part.
l =28;
j = 1;
frac = 14/28;

%% Creating a local variance matrix
% Thi is the current version but we are hoping to replace it with a
% fractional version that will work on any image.

test = localVariance(l,28);
[V,D] = eig(test);


%% Getting the information from the image

I = im2double( imread("MNISTExample.png"));
[row column depth] = size(I) 

%% Creating the local Variance matrix for each side.
% Creating it for the rows.

rowAmount   = ceil(row*frac)

rowVar = localVariance(l,row);
[VRow,D] = eig(rowVar);
rowMat = [VRow(:,1:rowAmount) normrnd(0,1,column,row/2 - rowAmount)];
rowProj = rowMat*rowMat';

rowProj = gramSchmidt(rowProj,row/2);

% Creating it for the columns.

columnAmount= ceil(column*frac);

colVar = localVariance(l,column);
[VCol,D] = eig(colVar);
colMat = [VCol(:,1:columnAmount) normrnd(0,1,row,column/2 - columnAmount)];
colProj = colMat*colMat';





checkTemp = [V(:,1:j) normrnd(0,1,28,14-j)];

checkTemp = gramSchmidt(checkTemp,14);

checkTempProj = checkTemp*checkTemp';

checkTempImage = kron(checkTempProj*I*checkTempProj ,ones(13));

% imshow(testImage)
checkDaub = gramSchmidt(dauboMat(1,14),14);
trace(checkTempProj*test)
[U,S,W] = svd(checkDaub'*V(:,1:j));
S
% frameName = "local"+ l+ "_"+ j+"vectors.png"
frameName = "temp";
saveas(imshow(checkTempImage),frameName)