function[frameName]= makeFrameName(frameNumber)
if( frameNumber < 10 )
    frameName =strcat('frame00',int2str(frameNumber),'.png');
else if( frameNumber < 100)
    frameName =strcat('frame0',int2str(frameNumber),'.png');
else
    frameName =strcat('frame',int2str(frameNumber),'.png');
end

end