function [roof] = deployConfig(sizeOfMinG,panelSize,config)
    for w=1:sizeOfMinG(1)
        for h=1:sizeOfMinG(2)
            roof(w,h)=1;
        end
    end
    for panel=1:length(config)
        roof(config(panel,1):config(panel,1)+panelSize(1),config(panel,2):config(panel,2)+panelSize(2))=255;
    end
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

end

