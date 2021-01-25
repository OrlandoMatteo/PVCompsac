function [ power, topology ] = fakeApplyTopology( config )
%APPLY TOPOLOGY Estimate power production given series/parallel connections
%   P power trace
%   topology matrix of positions
%   config a possible solution of the placement algorithms

global timesteps;
% global panelSize;
global minG;
global N;
% global maxP;
global S; 

S = uint8(S); 
topology = cell(idivide(N,S), S); 
power = zeros(idivide(N,S),S,timesteps);
current = zeros(N,S,timesteps);
voltage = zeros(N,S,timesteps);
Pseries = zeros(idivide(N,S),timesteps); 
Vseries = zeros(idivide(N,S),timesteps); 
Iseries = zeros(idivide(N,S),timesteps); 
P = zeros(timesteps,1); 
V = zeros(timesteps,1); 
I = zeros(timesteps,1); 

% now I can apply the topology and calculate power 
for k = 1:1:idivide(N,S)
   for l = 1:1:S
        
       position = config{(uint8(k)-1)*S + uint8(l)};  
       topology{k, l} = config{(uint8(k)-1)*S + uint8(l)};
       [power(k,l,:), current(k,l,:), voltage(k,l,:)] = powerProduction(squeeze(minG(position(1), position(2), :)));
   end  
   % series composition
%    Vseries(k,:) = sum(voltage(:,:)); 
%    Iseries(k,:) = min(current(:,:)); 
%    Pseries(k,:) = V(k,:).*I(k,:);    
end

% % parallel composition 
% V = (min(Vseries(:,:)))';
% I = (sum(Iseries(:,:)))';
% P = V.*I;

end


