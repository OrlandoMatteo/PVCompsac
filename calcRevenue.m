function [bestTopology, revenue] = calcRevenue(maintananceCost,energyPrice)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

%disp('PV panel floorplanning: an EDAGroup tool...')
addpath scripts
addpath matrici

global N
global timesteps;
global rows; 
global cols; 
global minG;
global statsMinG; 
global panelSize;
global optimalConfig;
%Conten of file
global matrix

% disp(' - Han%dle input data')
%CVSFileName = 'primo_20.mat';
%CVSFileName = 'secondo_20.mat';
%CVSFileName = 'terzo_20.mat';
%CVSFileName = 'carcere.mat';

load('border3.mat')

global maxP;
maxP = 0;
% N = 16; 
%N= 56;
%N=56; 
%N = 64;
%N =96;%
%N=152;
global S;
S = uint8(8);
%8

optimalConfig = cell(N,1);

% roof top management
% get to an horizontal roof area
% NaN = empty/not available space
% 255 = available space

area = matrix(:,:,100);
area(find(isnan(area) == 0)) = 255;
area = imrotate(area,19);
area(find((area == 0))) = NaN;

[rows, cols] = find(area == 255);
areaOfInterest = [min(cols) min(rows) (max(cols) - min(cols)) (max(rows) - min(rows))];
area = imcrop(area, areaOfInterest);

sizeOfArea = size(area);
rows = sizeOfArea(1);
cols = sizeOfArea(2);
% for i=1:51
%     area(i,1:limit(i))=NaN;
% end
%irradiance trace management

sizeOfMatrix = size(matrix);
timesteps = sizeOfMatrix(3);
clear sizeOfMatrix

G = zeros(rows,cols,timesteps);

for i = 1:1:timesteps
    G(:,:,i) = imcrop(imrotate(matrix(:,:,i),19), areaOfInterest);
end

% minG generation: irradiance trace if each location is top left position
% of panel - min value of all irradiance values under the panel
minG = zeros(rows, cols, timesteps);
statsMinG = zeros(rows,cols);
possible = zeros(rows, cols);
panelSize = [8,4];

for i = 1:1:rows
    for j = 1:1:cols
        if(~((i > (sizeOfArea(1) - panelSize(1) + 1)) | (j > (sizeOfArea(2) - panelSize(2) + 1))) & ...
                ~(any(isnan(reshape(area(i:i+(panelSize(1)-1), j:(j+panelSize(2)-1)),1,uint8(panelSize(1)*panelSize(2))))) == 1))
            possible(i,j) = 255;
            minG(i,j,:) = min(reshape(G(i:i+(panelSize(1)-1), j:(j+panelSize(2)-1),:),uint8(panelSize(1)*panelSize(2)), timesteps,1));
        end
    end
end

minG(isnan(minG)) = 0;
minG(minG < 0) = 0;
%secondo patch


for i = 1:1:rows
    for j = 1:1:cols
        if(possible(i,j) == 255)
            statsMinG(i,j) = prctile(minG(i,j,:),75);
%             medianMinG(i,j) = median(minG(i,j,:)); 
%             avgMinG(i,j) = mean(minG(i,j,:)); 
        end
    end
end
%terzo modifier


clear i j ans areaOfInterest

disp(' - Launching exploration')

%roof 2 cut
minG(:,65:135,:)=[];
possible(:,65:135)=[];
statsMinG(:,65:135)=[];


 algorithm = 1; % greedy
% algorithm = 2; % exhaustive

% if(algorithm == 1)
%     disp('Greedy algorithm');
%     [maxP, topology] = greedyAlgorithm(possible);    
%ths=0.5;
topology = cell(idivide(N,S), S);
ths=0:0.01:0.94;
%ths=[0 0.69]
for i=1:length(ths)
    ths(i)
	%optimalConfig = greedyThreshold(possible,ths(i));
    [maxP, topology]=greedyThreshold(possible,ths(i));
    prod(i)=maxP;
    topologies{i}=topology;
	%filename=replace("Thresh"+num2str(ths( i )),'.','_')
	%writecell(optimalConfig,filename+'.dat')
end
[maxYearProduction, I]=max(prod);
bestTopology=topologies{I};
revenue=maxYearProduction*energyPrice*0.25-maintananceCost*maxYearProduction;

end


