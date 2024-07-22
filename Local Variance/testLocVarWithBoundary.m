
l =1;
j = 10;



test = localVarianceWithBoundary(l,28);

[V,D] = eig(test);

test2 = localVariance(l,28);
[V2,D2] = eig(test2);

I = im2double( imread("MNISTExample.png"));

testCase = V(:,1:9);

testProj = testCase*testCase';

testImage = kron(testProj*I*testProj,ones(13));


checkTemp = [V(:,1:j) normrnd(0,1,28,14-j)];

checkTemp = gramSchmidt(checkTemp,14);


checkTempProj = checkTemp*checkTemp';

checkTempImage = kron(checkTempProj*I*checkTempProj ,ones(13));

% imshow(testImage)
checkDaub = gramSchmidt(dauboMat(8,14),14);

[U,S,W] = svd(checkDaub'*V(:,1:j));

imshow(checkTempImage)