function [FitnessVector] = GetChromosomeFitnesses(Chromosomes, NumOfTasks, ...
                  NumOfOperations, Times, Costs, Productivity, Distances, LogisticCost)

NumOfChromosomes = size(Chromosomes,1);
FitnessVector = zeros(NumOfChromosomes,1);
              
for ch = 1:NumOfChromosomes
    for t = 1:NumOfTasks
        CurrentTask = Chromosomes(ch,(t-1)*NumOfOperations+1:t*NumOfOperations);
        TaskOperations = find(CurrentTask>0);
        TaskCities = CurrentTask(1,TaskOperations);
        % Operation Costs
        OC = 0;
        for op = 1:size(TaskOperations,2)
            OC = OC + Times(TaskOperations(1,op),TaskCities(1,op)) ...
                    * Costs(TaskOperations(1,op),TaskCities(1,op)) ...
                    / Productivity(1,TaskCities(1,op));
        end
        
        % Logistic Costs
        LC = 0;
        for op = 1:size(TaskOperations,2)-1
            
        end
        
    end
end
