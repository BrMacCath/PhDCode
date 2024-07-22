%% This script is to get a gradiant condition going. It will be split into two parts. Getting the direction to go in and then the stop condition.


% Can we keep orthogonality with column operations too?
% Initial condition
d = dbaux(3,1);
n=28;
k = 3;
components = zeros(2,k);

d = OrthogonalCircVectorGen(2,k,n);
for i=1:k
    components(:,i)= d(2*(i-1)+1:2*i);
end
imagePath="MNISTExample.png";
I= imread(imagePath);
Im = im2double(I);
components;
thetaNum=1;
delta = .01;

% Here is where we figure out the direction we move in
circVec = zeros(n,1);
circVec(1:2*k) = components;
origCircMat = circulantMatrixGen(circVec,n);
origProjMat = origCircMat*origCircMat';
origProjection = origProjMat*Im*origProjMat;
origEnergy = trace(origProjection'*origProjection);


rotationMat = [cos(delta) -sin(delta); sin(delta) cos(delta)];
newDaub = rotationMat*components;
circVec = zeros(n,1);
circVec(1:2*k) = newDaub;
moveCircMat = circulantMatrixGen(circVec,n);
moveProjMat = moveCircMat*moveCircMat';
moveProjection = moveProjMat*Im*moveProjMat;

moveEnergy = trace(moveProjection'*moveProjection);

direction =sign(moveEnergy - origEnergy);

delta = delta*direction;

theta = delta;


path = 0:2*pi/100:2*pi;

for theta= 0:100
    tempComp = components;
    tempComp(2,1) = components(2,3);
    tempComp(2,3) = components(2,1);
    rotationMat = [cos(theta*2*pi/100) -sin(theta*2*pi/100); sin(theta*2*pi/100) cos(theta*2*pi/100)];
    newDaub = rotationMat*tempComp;
    circVec = zeros(n,1);
    temp = newDaub(2,1);
    newDaub(2,1) =newDaub(2,3);
    newDaub(2,3)=temp;
    
    circVec(1:6) = newDaub;
    genMat = zeros(n,n/2);
    for i = 1:n/2
        genMat(:,i) = circshift(circVec,2*i-2);
    end
    ProjMat = genMat*genMat';
    tempImage = ProjMat*Im*ProjMat;
    points(thetaNum) = trace(tempImage'*tempImage);
    tempImage = kron(tempImage,ones(13));
    thetaName = makeThetaName(thetaNum);
    saveas(imshow(tempImage),thetaName);
    thetaNum = thetaNum +1;
end
length(path)
length(points)
plot(path, points)

% rotationMat
% newDaub

function[genMat] = circulantMatrixGen(circVec,n)
genMat = zeros(n,n/2);
for i = 1:n/2
    genMat(:,i) = circshift(circVec,2*i-2);
end
end


function[frameName]= makeThetaName(thetaNumber)
if( thetaNumber < 10 )
    frameName =strcat('theta00',int2str(thetaNumber),'.png');
elseif( thetaNumber < 100)
    frameName =strcat('theta0',int2str(thetaNumber),'.png');
else
    frameName =strcat('theta',int2str(thetaNumber),'.png');
end
end