function [roof] = compareRoof(a,b)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
area=size(a);
w=area(1);
h=area(2);
for i=1:w
    for j=1:h
        if a(i,j)==b(i,j)
            roof(i,j)=a(i,j);
        elseif a(i,j)>b(i,j)
            roof(i,j)=100;
        elseif a(i,j)<b(i,j)
            roof(i,j)=200;
        end
    end
end

