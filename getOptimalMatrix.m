function [optimalMatrix,R] = getOptimalMatrix(optimalConfig,minG)
    for i=1:length(optimalConfig)
        optimalMatrix(:,i)=minG(optimalConfig{i}(1),optimalConfig{i}(2),:);
    end
    R=corr(optimalMatrix);
end

