function [production] = calculateProduction(config,Gmin)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
global N
global S;
h=S;
w=N/h;
k=1;
series=zeros(w,h,16076);

for i=1:h:w*h
    for j=0:h-1
        panelIndex=i+j;
        panel=config(panelIndex,:);
        series(k,j+1,:)=Gmin(panel{1}(1),panel{1}(2),:);
    end
    k=k+1;
end
productionSeries=zeros(w,16076);
for i=1:h
    for j=1:16076
    productionSeries(i,j)=min(series(:,i,j));
    end
end
    production=sum(productionSeries);
        
end

