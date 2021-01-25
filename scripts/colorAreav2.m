function [ coloredArea ] = colorArea( topology, area, panelSize, roofName, kind )
%COLORAREA make figure with resulting placement
%   coloredArea is a matrix with colored rectangles representing the PV
%   modules; reclangles with the same color belong to the same string

sizeOfTopology = size(topology); 
rows = sizeOfTopology(1); 
S = sizeOfTopology(2); 
N = rows*S; 

clear sizeOfTopology rows

coloredArea = area; 
coloredArea(coloredArea == 255) = 200; 

value = 40; 
panelId=1;
for i = 1:1:(N/S)
    for j = 1:1:S
        %position = topology{i,j, 1};
        %direction = topology{i,j,2};
        position = topology{i,j};
        %coloredArea(position(1):(position(1)+panelSize(direction)-1), ... 
         %   position(2):(position(2)+panelSize(3-direction)-1)) = value; 
         coloredArea(position(1):(position(1)+panelSize(1)-1), ... 
            position(2):(position(2)+panelSize(2)-1)) = value; 
        textPositions(panelId,:)=[position(1)+2 position(2)+1];
        panelId=panelId+1;
    end
    value = value + 20; 
end
textStr=string(1:40);
figure 
h4 = imshow(coloredArea(:,67:end), 'ColorMap',colorcube);

set(h4,'alphadata',~isnan(coloredArea(:,67:end)))
caxis([0, 255])
%title(strcat('Identified locations: ', roofName,'fontweight','normal')
%image(coloredArea)
%axis equal
%textPositions=int16(textPositions);
for i=1:40
    text(textPositions(i,2)-67,textPositions(i,1),textStr(i),'FontSize',8)
end


end

