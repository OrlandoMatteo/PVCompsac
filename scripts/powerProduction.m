function [ P, I, V ] = powerProduction( G, T )
%POWERPRODUCTION Given min value of G over the PV module and average T, 
% returns operating point in terms of current and power
%   G irradiance in W/m^2
%   T temperature in Celsius
%   C current in Ampere 
%   P power in Watt
%   can operate on matrices

% determine V 
V = 0.0006667 .* G + 22.73; 
V = squeeze(V);
V((isnan(V(:,:))) | (V(:,:) < 0)) = 0;
             
p00 =  45.43;
p10 =  -12.67;
p01 =  -0.08475;
p20 =  2.969;
p11 =  0.01869;
p02 =  4.913e-05;
p30 =  -0.27; 
p21 =  -0.001918;
p12 =  -2.492e-06;
p40 =  0.01054;
p31 =  0.0001177;
p22 =  1.972e-07;
p50 = -0.0001502;
p41 = -2.326e-06;
p32 = -5.239e-09;

P = p00 + p10 * V + p01 * G + p20 * (V.^2) + p11 * V .* G + p02 * (G.^2) + p30 * (V.^3) ...
                    + p21 * (V.^2) .* G + p12 * V .* (G.^2) + p40 * (V.^4) + p31 * (V.^3) .* G ... 
                    + p22 * (V.^2) .* G.^2 + p50 * (V.^5) + p41 * (V.^4) .* G ... 
                    + p32 * (V.^3) .* G.^2; 
P = squeeze(P); 
P((isnan(P(:,:))) | (P(:,:) < 0)) = 0;

I = P./V; 

end

