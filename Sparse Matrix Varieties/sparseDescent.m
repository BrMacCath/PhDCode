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
thetaNum=1;
delta = .01;

%% Here is where we figure out the direction we move in
% Figure out the energy of the original starting point.
circVec = zeros(n,1);
circVec(1:2*k) = components;
origCircMat = circulantMatrixGen(circVec,n);
origProjMat = origCircMat*origCircMat';
origProjection = origProjMat*Im*origProjMat;
newEnergy = trace(origProjection'*origProjection);

energy = 0;
Energies = [];
Steps =[];
while newEnergy - energy > .01
    % Update the energy
    energy = newEnergy;
    
    % Figure out the which way it goes in the first direction
    delta = .01;
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
    newEnergy = trace(moveProjection'*moveProjection);
    direction =sign(newEnergy - origEnergy);
    delta = delta*direction;
    rotationMat = [cos(delta) -sin(delta); sin(delta) cos(delta)];

    if direction <0
        newDaub = rotationMat*components;
        circVec = zeros(n,1);
        circVec(1:2*k) = newDaub;
        moveCircMat = circulantMatrixGen(circVec,n);
        moveProjMat = moveCircMat*moveCircMat';
        moveProjection = moveProjMat*Im*moveProjMat;
        newEnergy = trace(moveProjection'*moveProjection);
    end
    while newEnergy - origEnergy >0.01
        components = newDaub;
        origEnergy = newEnergy;
        newDaub = rotationMat*components;
        circVec = zeros(n,1);
        circVec(1:2*k) = newDaub;
        moveCircMat = circulantMatrixGen(circVec,n);
        moveProjMat = moveCircMat*moveCircMat';
        moveImage = moveProjMat*Im*moveProjMat;
        newEnergy = trace(moveImage'*moveImage);
%         moveImage = kron(moveImage,ones(13));
%         thetaName = makeThetaName(thetaNum);
%         saveas(imshow(moveImage),thetaName);
%         Energies = [Energies newEnergy];
        Steps =[Steps thetaNum];
        thetaNum = thetaNum +1;
    end

    % Figure out the which way it goes in the second direction
    delta = .01;
    circVec = zeros(n,1);
    circVec(1:2*k) = components;
    origCircMat = circulantMatrixGen(circVec,n);
    origProjMat = origCircMat*origCircMat';
    origProjection = origProjMat*Im*origProjMat;
    origEnergy = trace(origProjection'*origProjection);
    newDaub = components;
    newDaub(2,1) = components(2,3);
    newDaub(2,3) = components(2,1);
    
    rotationMat = [cos(delta) -sin(delta); sin(delta) cos(delta)];
    newDaub = rotationMat*newDaub;
    temp = newDaub(2,1);
    newDaub(2,1) =newDaub(2,3);
    newDaub(2,3)=temp;

    circVec = zeros(n,1);
    circVec(1:2*k) = newDaub;
    moveCircMat = circulantMatrixGen(circVec,n);
    moveProjMat = moveCircMat*moveCircMat';
    moveProjection = moveProjMat*Im*moveProjMat;
    newEnergy = trace(moveProjection'*moveProjection);
    direction =sign(newEnergy - origEnergy);
    delta = delta*direction;
    rotationMat = [cos(delta) -sin(delta); sin(delta) cos(delta)];

    if direction < 0
        newDaub = components;
        newDaub(2,1) = components(2,3);
        newDaub(2,3) = components(2,1);
        
        newDaub = rotationMat*newDaub;
        temp = newDaub(2,1);
        newDaub(2,1) =newDaub(2,3);
        newDaub(2,3)=temp;
    
        circVec = zeros(n,1);
        circVec(1:2*k) = newDaub;
        moveCircMat = circulantMatrixGen(circVec,n);
        moveProjMat = moveCircMat*moveCircMat';
        moveProjection = moveProjMat*Im*moveProjMat;
        newEnergy = trace(moveProjection'*moveProjection); 
    end


    while newEnergy - origEnergy > 0.01
        components = newDaub;
        origEnergy = newEnergy;
        newDaub(2,1) = components(2,3);
        newDaub(2,3) = components(2,1);
        newDaub = rotationMat*newDaub;
        temp = newDaub(2,1);
        newDaub(2,1) =newDaub(2,3);
        newDaub(2,3)=temp;

        circVec = zeros(n,1);
        circVec(1:2*k) = newDaub;
        moveCircMat = circulantMatrixGen(circVec,n);
        moveProjMat = moveCircMat*moveCircMat';
        moveProjection = moveProjMat*Im*moveProjMat;
        newEnergy = trace(moveProjection'*moveProjection);
        moveImage = kron(moveProjection,ones(13));
        Energies = [Energies newEnergy];
        Steps =[Steps thetaNum];
%         thetaName = makeThetaName(thetaNum);
%         saveas(imshow(moveImage),thetaName);
        thetaNum = thetaNum +1;
    end

    % The third Direction
    a = components(:,1);
    a= 1/(sqrt(a'*a))*a;
    b = components(:,3);
    b= 1/(sqrt(b'*b))*b;
    orthBasis= [a b];
    tempComponents = orthBasis'*components;
    directionMatrix = makeDirectionMat(tempComponents);
    rotationMat = [cos(delta) -sin(delta); sin(delta) cos(delta)];
    tempDaub = rotationMat*directionMatrix;
    newDaub = extendDirectionMat(tempDaub,orthBasis);
    circVec = zeros(n,1);
    circVec(1:2*k) = newDaub;
    moveCircMat = circulantMatrixGen(circVec,n);
    moveProjMat = moveCircMat*moveCircMat';
    moveProjection = moveProjMat*Im*moveProjMat;
    
    newEnergy = trace(moveProjection'*moveProjection);
    
    direction =sign(newEnergy - origEnergy);
    
    delta = delta*direction;
    rotationMat = [cos(delta) -sin(delta); sin(delta) cos(delta)];


    if direction <0
        tempComponents = orthBasis'*components;
        directionMatrix = makeDirectionMat(tempComponents);
        tempDaub = rotationMat*directionMatrix;
        newDaub = extendDirectionMat(tempDaub,orthBasis);
        circVec = zeros(n,1);
        circVec(1:2*k) = newDaub;
        moveCircMat = circulantMatrixGen(circVec,n);
        moveProjMat = moveCircMat*moveCircMat';
        moveProjection = moveProjMat*Im*moveProjMat;
        newEnergy = trace(moveProjection'*moveProjection);
    end

    while newEnergy - origEnergy > 0.01
        origEnergy = newEnergy;
        components = newDaub;
        a = components(:,1);
        a= 1/(sqrt(a'*a))*a;
        b = components(:,3);
        b= 1/(sqrt(b'*b))*b;
        orthBasis= [a b];
        tempComponents = orthBasis'*components;
        directionMatrix = makeDirectionMat(tempComponents);
        rotationMat = [cos(delta) -sin(delta); sin(delta) cos(delta)];
        tempDaub = rotationMat*directionMatrix;
        newDaub = extendDirectionMat(tempDaub,orthBasis);
        circVec = zeros(n,1);
        circVec(1:2*k) = newDaub;
        moveCircMat = circulantMatrixGen(circVec,n);
        moveProjMat = moveCircMat*moveCircMat';
        moveProjection = moveProjMat*Im*moveProjMat;
        moveImage = kron(moveProjection,ones(13));
        Energies = [Energies newEnergy];
        Steps =[Steps thetaNum];
%         thetaName = makeThetaName(thetaNum);
%         saveas(imshow(moveImage),thetaName);
%        
%         newEnergy = trace(moveProjection'*moveProjection);
        thetaNum = thetaNum +1;
    end
  
end
components
thetaNum
Energies;
Steps;

c1 = zeros(n,1);
c1(1:6) = components;
g1 = circulantMatrixGen(c1,n);
c2 = zeros(n,1);
c2(1:6) = dbaux(3);
c2 = (1/sqrt(trace(c2'*c2)))*c2;
g2 = circulantMatrixGen(c2,n);
[U,S,V] = svd(g1'*g2);

diag(S)
angles = acos(diag(S));

scatter(1:n/2,angles,"*")
xlabel("number")
ylabel("Angle")
title("Plotting principal angles.")

% 
% plot(Steps, Energies)
% xlabel('Steps')
% ylabel('Energy')
% title('Finding a local max.')

% rotationMat = [cos(delta) -sin(delta); sin(delta) cos(delta)];
% tempDaub = rotationMat*directionMatrix;
% newDaub = extendDirectionMat(tempDaub,orthBasis);
% circVec = zeros(n,1);
% circVec(1:2*k) = newDaub;
% moveCircMat = circulantMatrixGen(circVec,n);
% moveProjMat = moveCircMat*moveCircMat';
% moveProjection = moveProjMat*Im*moveProjMat;
% 
% moveEnergy = trace(moveProjection'*moveProjection);
% 
% direction =sign(moveEnergy - origEnergy);
% 
% delta = delta*direction;
% 
% theta = delta;
% 
% 
% path = 0:2*pi/100:2*pi;


% for theta= 0:100
%     tempComp = orthBasis'*components;
%     
%     rotationMat = [cos(theta*2*pi/100) -sin(theta*2*pi/100); sin(theta*2*pi/100) cos(theta*2*pi/100)];
%     tempDaub = rotationMat*directionMatrix;
%     newDaub = extendDirectionMat(tempDaub,orthBasis);
%     circVec = zeros(n,1);
%     newDaub(:,2)'*newDaub(:,2)
%     circVec(1:6) = newDaub;
%     genMat = zeros(n,n/2);
%     for i = 1:n/2
%         genMat(:,i) = circshift(circVec,2*i-2);
%     end
%     ProjMat = genMat*genMat';
%     tempImage = ProjMat*Im*ProjMat;
%     points(thetaNum) = trace(tempImage'*tempImage);
%     tempImage = kron(tempImage,ones(13));
%     thetaName = makeThetaName(thetaNum);
%     saveas(imshow(tempImage),thetaName);
%     thetaNum = thetaNum +1;
% end
% length(path)
% length(points)
% plot(path, points)

% rotationMat
% newDaub


function[smallMat] = makeDirectionMat(Mat)
    smallMat = zeros(2,2);
    smallMat(1,1) = Mat(1,1);
    smallMat(2,1) = Mat(2,2);
    smallMat(1,2) = Mat(1,2);
    smallMat(2,2) = Mat(2,3);
end

function[SparseMatVar] = extendDirectionMat(dirMat,Basis)
    SparseMatVar = zeros(2,3);
    SparseMatVar(1,1) = dirMat(1,1);
    SparseMatVar(2,2) = dirMat(2,1);
    SparseMatVar(1,2) = dirMat(1,2);
    SparseMatVar(2,3) = dirMat(2,2);
    SparseMatVar = Basis*SparseMatVar;
end





