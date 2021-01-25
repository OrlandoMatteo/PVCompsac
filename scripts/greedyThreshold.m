
function [maxP, topology] = greedyThreshold(possible,threshold)

global timesteps;
global panelSize;
global minG;
global statsMinG;
global N;
global cols;
global optimalConfig;
global S;

sizeOfMinG = size(minG);
rows = 52; 

% extensive data analysis

% order by 75th percentile
tableData = cell(sizeOfMinG(1)*sizeOfMinG(2),2);

for i = 1:1:sizeOfMinG(1)
    for j = 1:1:sizeOfMinG(2)
        if(possible(i,j) == 255)
            tableData{(i-1)*sizeOfMinG(2)+j,1} = [i j];
            tableData{(i-1)*sizeOfMinG(2)+j,2} = round(statsMinG(i, j));
        else
            tableData{(i-1)*sizeOfMinG(2)+j,1} = [i j];
            tableData{(i-1)*sizeOfMinG(2)+j,2} = NaN;
        end
    end
end

% order by 75th percentile
tableResult = cell2table(tableData,'VariableNames',{'Position','Percentile'});
tableOrdered = tableResult(~any(ismissing(tableResult),2),:);
tableOrdered = sortrows(tableOrdered,[2],'descend');

k = 0;
maxP = 0;
optimalConfig = cell(N,1);

maxDistance = sizeOfMinG(1)+sizeOfMinG(2);
tempRemoved=[];
while k < N
    
    selected = tableOrdered.Percentile == max(tableOrdered.Percentile);
    
    if(k == 24)
        %disp('ecco')
    end
    
    if(mod(k,S) == 0)
        
        % first panel of the series
        % I don't have to worry about the distance
        result = tableOrdered.Position(selected,:);
        position = result(1,:); 
        
        if(possible(position(1),position(2)) ~= 255)
            removePositions = tableOrdered.Position == position;
            removePositions = removePositions(:,1) & removePositions(:,2);
            tableOrdered(removePositions,:) = [];
        else
            k = k+1;
            oldPosition=position;
            optimalConfig{uint8(k),1} = position;
            
            possible(max(1,(position(1)-panelSize(1)+1)):min(rows,(position(1)+panelSize(1)-1)), ...
                max(1,(position(2)-panelSize(2)+1)):min(cols,(position(2)+panelSize(2)-1))) = 0;
            
            removePositions = tableOrdered.Position == position;
            removePositions = removePositions(:,1) & removePositions(:,2);
            tableOrdered(removePositions,:) = [];
        end
        
    else
        
        result = tableOrdered.Position(selected,:);
        sizeOfResult = size(result);
        positions = zeros(sizeOfResult(1), sizeOfResult(2)+1);
        positions(:,1) = result(:,1);
        positions(:,2) = result(:,2);
        
        for(l = 1:1:sum(selected))
            % positions(l,3) = calculateDistance(optimalConfig{idivide(k,S)*S+1},[positions(l,1) positions(l,2)],panelSize);
            positions(l,3) = calculateDistance(optimalConfig{1},[positions(l,1) positions(l,2)],panelSize);
        end
        if(min(positions(:,3)) > 11*S)
            
            for(l = 1:1:sum(selected))
                
                position = positions(l,1:2);
                removePositions = tableOrdered.Position == position;
                removePositions = removePositions(:,1) & removePositions(:,2);
                
                tableOrdered(removePositions,:) = [];
            end
        else
            index = min(find(positions(:,3) == min(positions(:,3))));
            
            position = positions(index,1:2);
            if(possible(position(1),position(2)) ~= 255)
                removePositions = tableOrdered.Position == position;
                removePositions = removePositions(:,1) & removePositions(:,2);
                
                tableOrdered(removePositions,:) = [];
            else
                %Se il coefficiente di correlazione è maggiore di un valore
                %dato in input alla funzione il pannello viene aggiunto
                %alla serie, altrimenti viene scartato
                if (corrcoef(minG(oldPosition(1),oldPosition(2),:),minG(position(1),position(2),:)))>threshold
                    %oldPosition=position;
                    k = k+1;
                    optimalConfig{uint8(k),1} = position;

                    possible(max(1,(position(1)-panelSize(1)+1)):min(rows,(position(1)+panelSize(1)-1)), ...
                        max(1,(position(2)-panelSize(2)+1)):min(cols,(position(2)+panelSize(2)-1))) = 0;

                    removePositions = tableOrdered.Position == position;
                    removePositions = removePositions(:,1) & removePositions(:,2);

                    tableOrdered(removePositions,:) = [];
                        if (~isempty(tempRemoved))
                            
                            tableOrdered=[tempRemoved;tableOrdered];
                            tempRemoved=[];
                        end
                else
                    removePositions = tableOrdered.Position == position;
                    removePositions = removePositions(:,1) & removePositions(:,2);
                    tempRemoved=[tempRemoved  ;tableOrdered(removePositions,:)];
                    tableOrdered(removePositions,:) = [];
                    
                end
            end
        end
    end
    
end

P = zeros(timesteps,1);
V = zeros(timesteps,1);
I = zeros(timesteps,1);

[P, topology] = applyTopology(optimalConfig);

%disp(strcat('Max. power with percentile: ',num2str(sum(P))))

maxP = sum(P);
end
