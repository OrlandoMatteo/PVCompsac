disp('PV panel floorplanning: an EDAGroup tool...')

clear all 
close all 
clc

addpath /home/sara/POLITO/PVSim/PVSim/Journal
addpath scripts
addpath matrici
addpath /dati/PVSimJournalData/
% addpath newModel % necessary only for ISCAS model

warning off;

% 1) TRACE BUILDER
disp(' - Handle input data')

%% tetto piccolo 
fileName = 'Piccolo.mat'; 
roofName = strsplit(fileName,'.'); 
roofName = strsplit(roofName{1},'_'); 
roofName = roofName{1}; 
N = 16;
S = uint8(8);
perLine = S; 

% load weather data from traces
load(fileName)

matrix = permute(matrix,[2,3,1]); 

%% tetto carcere
fileName = 'carcere.mat'; 
roofName = strsplit(fileName,'.'); 
roofName = strsplit(roofName{1},'_'); 
roofName = roofName{1}; 
N = 64; 
S = uint8(16);
perLine = S; 

%% tetto costruito da DATE 18
% COME COSTRUITO: 
load('terzo_20.mat')
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

sizeOfMatrix = size(matrix);
timesteps = sizeOfMatrix(3);
clear sizeOfMatrix

tempG = zeros(rows,cols,timesteps);

for i = 1:1:timesteps
    tempG(:,:,i) = imcrop(imrotate(matrix(:,:,i),19), areaOfInterest);
end

% area = [area(:,1:150) area(:,250:end)];
% 
% 
% matrix = [tempG(:,1:89,:) tempG(:,223:end,:)];


load('artificial.mat'); 
roofName = 'artificial'; 
[ area, rows, cols, timesteps, G ] = identifyArea( matrix) ; %, customArea ) ;
N = uint8(36); 
S = 6; 
perLine = 2*S; 


%% FROM HERE ON RUNS FOR ALL CONFIGS! 

clear matrix
