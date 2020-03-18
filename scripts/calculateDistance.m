function [ distance ] = calculateDistance( positionA, positionB, panelSize )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

rowDistance = abs((positionA(1)+panelSize(1)-1)-(positionB(1)+panelSize(1)-1)); 
colDistance = abs((positionA(2)+1)-(positionB(2)+panelSize(2)-2));

distance = rowDistance + colDistance;

end

