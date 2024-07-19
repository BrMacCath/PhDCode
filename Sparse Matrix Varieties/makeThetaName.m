%%
% Written by Brian Collery

% Produces the name of the file to be stored.

function[thetaName]= makeThetaName(thetaNumber)
if( thetaNumber < 10 )
    thetaName =strcat('theta00',int2str(thetaNumber),'.png');
elseif( thetaNumber < 100)
    thetaName =strcat('theta0',int2str(thetaNumber),'.png');
else
    thetaName =strcat('theta',int2str(thetaNumber),'.png');
end
end