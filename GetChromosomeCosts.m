function [CostVector] = GetChromosomeCosts(Chromosomes, NumOfTasks, ...
                  NumOfOperations, Times, Costs, Productivity, Distances, LogisticCost)
% this function calculates costs of solutions introduced by chromosome

NumOfChromosomes = size(Chromosomes,1);
CostVector = zeros(NumOfChromosomes,1);

for ch = 1:NumOfChromosomes
    for t = 1:NumOfTasks
        CurrentTask = Chromosomes(ch,(t-1)*NumOfOperations+1:t*NumOfOperations);
        TaskOperations = find(CurrentTask>0);
        TaskCities = CurrentTask(1,TaskOperations);
        % Operation Costs
        OC = 0;
        for op = 1:size(TaskOperations,2)
            NewCost = Times(TaskOperations(1,op),TaskCities(1,op)) ...
                    * Costs(TaskOperations(1,op),TaskCities(1,op)) ...
                    / Productivity(1,TaskCities(1,op));
            OC = OC + NewCost;
            if(isinf(NewCost)) % Check invalid gene assignments
                disp(strcat('Operation City Massmatch',...
                            ' , Task: ',num2str(t),...
                            ' , Operation: ',num2str(TaskOperations(1,op)),...
                            ' , City: ',num2str(TaskCities(1,op))...
                           )...
                    );
            end
        end
        
        % Logistic Costs
        LC = 0;
        for op = 1:size(TaskOperations,2)-1
            NewCost = LogisticCost * Distances(TaskCities(1,op),TaskCities(1,op+1));
            LC = LC + NewCost;
            if(isinf(NewCost)) % Check invalid gene assignments
                disp(strcat('Operation City Massmatch',...
                            ' , Task: ',num2str(t),...
                            ' , Operation: ',num2str(TaskOperations(1,op)),...
                            ' , City: ',num2str(TaskCities(1,op))...
                           )...
                    );
            end
        end
        CostVector(ch,1) = CostVector(ch,1) + OC + LC;
    end
end
