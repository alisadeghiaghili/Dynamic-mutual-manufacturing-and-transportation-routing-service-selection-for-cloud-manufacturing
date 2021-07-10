function [CostVector] = OptimalGetChromosomeCosts(Chromosomes, NumOfTasks, ...
                  NumOfOperations, Times, Costs, Productivity, Distances, LogisticCost)

NumOfChromosomes = size(Chromosomes,1);
CostVector = zeros(NumOfChromosomes,1);
NumOfCities = size(Distances,1);

% declare each gene is for wich task
Tasks = ceil((1:NumOfTasks*NumOfOperations) / NumOfOperations - 0.0001);
% declare each gene is for wich operation
Operations = mod((1:NumOfTasks*NumOfOperations), NumOfOperations);
Operations(Operations==0) = NumOfOperations;

% find NonZero columns (genes)
ValidPosition = sum(Chromosomes) > 0;

% omit zeros
ShortChromosomes = Chromosomes(:,ValidPosition);
%%% replace tasks to remove zero columns
Tasks = Tasks(ones(1,NumOfChromosomes),ValidPosition);
%%% replace operations to remove zero columns
Operations = Operations(ones(1,NumOfChromosomes),ValidPosition);



for ch = 1:size(ShortChromosomes,2)
    % sub2ind takes a size, row index(es) & column index(es) and
    % returns linear index for each pair!!!
    OpCityIndex = sub2ind([NumOfOperations,NumOfCities],Operations(:,ch),ShortChromosomes(:,ch));
    ProductIndex = sub2ind([1,NumOfCities],ones(NumOfChromosomes,1),ShortChromosomes(:,ch));
    OC = Times(OpCityIndex) .* Costs(OpCityIndex) ./ (Productivity(ProductIndex))';
    LC = zeros(NumOfChromosomes, 1);
    if(ch < size(ShortChromosomes,2))
        if(Tasks(1,ch)==Tasks(1,ch+1))
            LogisticIndex = sub2ind([NumOfCities,NumOfCities],ShortChromosomes(:,ch),ShortChromosomes(:,ch + 1));
            LC = LogisticCost * Distances(LogisticIndex);
        end
    end
    CostVector = CostVector + OC + LC;
   
end





% NumOfChromosomes = size(Chromosomes,1);
% CostVector = zeros(NumOfChromosomes,1);
% 
% for ch = 1:NumOfChromosomes
%     for t = 1:NumOfTasks
%         CurrentTask = Chromosomes(ch,(t-1)*NumOfOperations+1:t*NumOfOperations);
%         TaskOperations = find(CurrentTask>0);
%         TaskCities = CurrentTask(1,TaskOperations);
%         % Operation Costs
%         OC = 0;
%         for op = 1:size(TaskOperations,2)
%             NewCost = Times(TaskOperations(1,op),TaskCities(1,op)) ...
%                     * Costs(TaskOperations(1,op),TaskCities(1,op)) ...
%                     / Productivity(1,TaskCities(1,op));
%             OC = OC + NewCost;
%         end
%         
%         % Logistic Costs
%         LC = 0;
%         for op = 1:size(TaskOperations,2)-1
%             NewCost = LogisticCost * Distances(TaskCities(1,op),TaskCities(1,op+1));
%             LC = LC + NewCost;
%         end
%         CostVector(ch,1) = CostVector(ch,1) + OC + LC;
%     end
% end
