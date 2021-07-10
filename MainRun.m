clc
clear

% GetRawDistanceMatFromLatLong('IR_CityCoordinates.xlsx');
%% Loading data & Preprocessing
NumOfTasks = 5;
NumOfSubTasks = 20;
Howmany = 10;

LogisticCost = 0.3;
SubtaskPorb = 0.7;
NonZeroPorb = 0.8;
MinProductivity = 0.7;
MaxProductivity = 1;
TimeMin = 3;
TimeMax = 8;
CostMin = 20;
CostMax = 90;

% other params
Coef = 0.98;
X1DegreeDis = 200;
Y1DegreeDis = 200;

%run params
% runs = 30;
TimeInterval = 10;

%GA params 
MutationProb = 0.002;
PopulationSize = 610;
IterationNum = 25;

[Distances,CityNames] = GetRawDistanceMatFromLatLong('IR_CityCoordinates.xlsx', X1DegreeDis, Y1DegreeDis, Howmany);
NumOfCities = size(Distances,1);

[Operations] = GenerateTaskSubtaskMat(NumOfSubTasks, NumOfTasks, SubtaskPorb, true);
[Productivity] = GenerateCityProductivityMat(NumOfCities, MinProductivity, MaxProductivity);
[Times, Costs] = GenerateSubtaskCityTimeCostMat(NumOfSubTasks, NumOfCities, NonZeroPorb, ...
                              TimeMin, TimeMax, CostMin, CostMax);
                      
rng('shuffle');
%%%% new part
%AllRuns{runs, 1} = [];
AllRuns{10000, 1} = [];

% setting running amount of time
iniTime = clock;
limit = 343;  % Seconds 
run = 1;
tic;

while etime(clock, iniTime) < limit
%for run = 1:runs  
    Costs(Costs==inf) = 0;
    Times(Times==inf) = 0;

    [AllowedGeneValues,NumOfAllowedGeneValues] = GenerateAllowedGeneValues(Operations, Costs);

    % set inoperable subtasks Costs and Time to inf
    Costs(Costs==0) = inf;
    Times(Times==0) = inf;

    %% GA Initialization

    [Chromosomes] = GenerateRandomChromosomes(PopulationSize,AllowedGeneValues,NumOfAllowedGeneValues);

    %% GA Main Body
    AllGenerations{IterationNum+1,1} = [];
    AllGenerations{1,1} = Chromosomes; % AllGenerations contain population of all generations

    for i=1:IterationNum
        [CostVector] = OptimalGetChromosomeCosts(Chromosomes, size(Operations,2), ...
            size(Operations,1), Times, Costs, Productivity, Distances, LogisticCost);
        [~, AccumulativeProbs] = GenerateRankBasedSelectionProb(-CostVector,Coef);
        [SelectedIndices] = SelectRandomlyByAccumulativeProbs(AccumulativeProbs,PopulationSize);
        ParentList = Chromosomes(SelectedIndices,:);
        ChildList = OptimalUniformCrossover(ParentList);
        MutantChildList = OptimalRandomValueMutation(ChildList,MutationProb,...
            AllowedGeneValues,NumOfAllowedGeneValues);

        Chromosomes = MutantChildList;
        AllGenerations{i+1,1} = Chromosomes;
    end
    
    [~,I] = sort(CostVector);

    bestChromosome = Chromosomes(I(1, 1),:);

    NumOfTasks = size(Operations, 2);

    bestChromosomeMatEdited = reshape(bestChromosome, [NumOfSubTasks, NumOfTasks]);
    bestChromosomeMatInitial = bestChromosomeMatEdited;

    for task = 1:NumOfTasks
        time = TimeInterval;
        for subtask = 1: NumOfSubTasks
            city = bestChromosomeMatEdited(subtask, task);
            
            if (city == 0)
                continue;
            end

            time = time - Times(subtask, city);
            
            if (time < 0)
                break;
            end
            
            bestChromosomeMatEdited(subtask, task) = 0;

        end
    end

    AllRuns{run, 1} = bestChromosomeMatInitial - bestChromosomeMatEdited;

    bestChromosomeMatEdited(bestChromosomeMatEdited ~= 0) = 1;

%     if (run ~= runs) 
%         Operations = [bestChromosomeMatEdited,...
%             GenerateTaskSubtaskMat(NumOfSubTasks, 1, SubtaskPorb)];
%     end
    Operations = [bestChromosomeMatEdited,...
                  GenerateTaskSubtaskMat(NumOfSubTasks, 1, SubtaskPorb, false)];
    run = run + 1;
end

TotalTime = toc;
disp(['Elapsed Time: ' num2str(TotalTime)]);
disp('########## Best Solution ##########');

currentTotal = 0;
totalDoneTasks = 0;

%finding non empty cells
notEmptyCells = find(~cellfun('isempty', AllRuns));

for run=1:size(notEmptyCells, 1)
    disp(['######### Run ' num2str(run) '#########']);
    
    currentRun = AllRuns{run, 1};
    
    currentTotal = currentTotal + ShowChromosomeCostDetails(reshape(currentRun, [1, size(currentRun, 2) * size(currentRun, 1)]),... 
                                                            size(currentRun, 2),...
                                                            size(currentRun, 1), Times, Costs,...
                                                            Productivity, Distances, LogisticCost,...
                                                            CityNames);
                                                         
    totalDoneTasks = totalDoneTasks + sum(sum(currentRun > 0));
    
    disp('================================================================');
    disp(['---- ' num2str(sum(sum(currentRun > 0))) ' Operations done in current run']);
    disp(['-- ' num2str(totalDoneTasks) ' Operations done so far']);
    disp(['-- ' num2str(size(find(~sum(currentRun)), 2)) ' Tasks done so far']);
    disp(['-- ' num2str(size(find(~sum(Operations)), 2)) ' Total Tasks done ']);
    disp(['-- ' num2str(size(find(~sum(Operations)), 2) * NumOfSubTasks + sum(sum(currentRun > 0))) ' Total Operations done ']);
    disp(['-- Total cost so far is ' num2str(currentTotal)]);
    disp(['-- Total Number of Tasks: ' num2str(size(currentRun, 2))]);
    disp('================================================================');
end


