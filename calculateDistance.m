function [output] = calculateDistance(optimalConfig,positions,panelSize)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
output=sqrt((optimalConfig(1)-positions(1))^2+(optimalConfig(2)-positions(2))^2);

end

