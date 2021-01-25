%clear all
addpath scripts
addpath matrici
%load results/terzo.mat
global N
global S
N=40;
S=uint8(8);
global timesteps;
timesteps=16076;
% [standardP ,standardTopology]=fakeApplyTopology(standardVector);
% [thP , thTopology]=fakeApplyTopology(thVector);
% [percP , percTopology]=fakeApplyTopology(percVector);
[standardP ,standardTopology]=applyTopology(standardVector);
[thP , thTopology]=applyTopology(thVector);
[percP , percTopology]=applyTopology(percVector);
percentageProd=[(sum(standardP)-sum(standardP))/sum(standardP) (sum(percP)-sum(standardP))/sum(standardP) (sum(thP)-sum(standardP))/sum(standardP)];
for w=1:5
    for j=2:8
    temp=corrcoef(minG(standardTopology{w,j}(1),standardTopology{w,j}(2),:),minG(standardTopology{w,1}(1),standardTopology{w,1}(2),:));
    standardCorr(w,j)=temp(2,1);

    temp=corrcoef(minG(percTopology{w,j}(1),percTopology{w,j}(2),:),minG(percTopology{w,1}(1),percTopology{w,1}(2),:));
    percCorr(w,j)=temp(2,1);

    temp=corrcoef(minG(thTopology{w,j}(1),thTopology{w,j}(2),:),minG(thTopology{w,1}(1),thTopology{w,1}(2),:));
    thCorr(w,j)=temp(2,1);
    end
end
figure
subplot(3,1,1)
heatmap(standardCorr,'ColorMap',hot)
subplot(3,1,2)
heatmap(percCorr,'ColorMap',hot)
subplot(3,1,3)
heatmap(thCorr,'ColorMap',hot)