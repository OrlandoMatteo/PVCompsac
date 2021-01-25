clear all
addpath scripts
addpath matrici
load('secondo_20.mat')
global matrix
Ns=8:8:72
energyPrice=0.22/1000;
panelCost=250;
maintCost=0.015/1000;
nOfYears=1:9;
global N

efficiency=1;
degradationRate=0.996;
for i=1:length(Ns)
    N=Ns(i);
    disp(strcat('N = ',num2str(N)))
    [bestTopology{i},yearRevenue(i)]=calcRevenue(maintCost,energyPrice);
end
for i=1:length(Ns)
   installationCost=Ns(i)*panelCost;
%    y=1;
%    f_yearRevenue=0;
%    while installationCost-f_yearRevenue>0
%        f_yearRevenue=yearRevenue(i)*degradationRate^y
%        installationCost=installationCost-f_yearRevenue;
%        y=y+1;
%    end
%   PT(i)=y+installationCost/f_yearRevenue; 
   PT(i)=installationCost/yearRevenue(i); 
   en_pot(i)=((yearRevenue(i)/energyPrice)/0.25)/(Ns(i)*250);

end
Roi=yearRevenue./(Ns*panelCost);
%enerigaprodotta/potenza installata
% 3 tetti vecchia e nuova disposizione
% dato lo stesso numero di pannelli set classico percentile e nuovo
% confronto


%Tagliare tetto come da foto su skype eliminando dal secondo la parte
%centrale

        
