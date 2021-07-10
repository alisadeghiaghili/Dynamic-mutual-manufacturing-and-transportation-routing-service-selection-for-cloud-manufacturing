function [AllowedGeneValues,NumOfAllowedGeneValues] = GenerateAllowedGeneValues(TaskOperation, CityOperation)
% AllowedGeneValues: each column contains all valid values for
% corresponding Gene (each task operation could perform on which cities)
% NumOfAllowedGeneValues: is a vector which each value indicates the number
% of valid values for corresponding gene (how many cities are available to
% perform this task)
% Example: Problem in main paper - > TaskOperation = 5*10, CityOperation = 10*10
% AllowedGeneValues =
% [1,1,0,1,1,1,0 ...;
%  2,2,0,3,2,3,0 ...;
%  3,3,0,4,3,5,0 ...;
%  4,4,0,5,5,6,0 ...;
%  6,5,0,7,6,7,0 ...;
%  8,6,0,8,7,8,0 ...;
%  9,7,0,9,8,9,0 ...;
%  10,8,0,10,9,10,0 ...;
%  0,10,0,0,0,0,0 ...;
%  0,0,0,0,0,0,0 ...]
% NumOfAllowedGeneValues =
% [8,9,0,8,8,8,0 ...]

NumOfTasks = size(TaskOperation,2);
NumOfOperations = size(TaskOperation,1);
NumOfCities = size(CityOperation,2);

AllowedGeneValues = zeros(NumOfCities, NumOfTasks * NumOfOperations);

for t=1:NumOfTasks
    for op=1:NumOfOperations
        %if this operation is not required for this task just skip it
        if(TaskOperation(op,t) == 0)
            continue;
        end
        
        %find column index of current operation in AllowedGeneValues
        %(find which task-operation are we talking about)
        index = (t - 1) * NumOfOperations + op;
        %find all NonZero CityOperation
        GeneValues = find(CityOperation(op,:))';
        %set AllowedGeneValues 
        AllowedGeneValues(1:size(GeneValues,1),index) = GeneValues;
    end
end

NumOfAllowedGeneValues = sum(AllowedGeneValues > 0);