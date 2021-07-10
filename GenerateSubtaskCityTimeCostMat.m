function [Times, Costs] = GenerateSubtaskCityTimeCostMat(NumOfSubTasks, NumOfCities, NonZeroPorb, ...
                              TimeMin, TimeMax, CostMin, CostMax)
%make sure NonZeroPorb is between 0 and 1
if(NonZeroPorb <= 0 || NonZeroPorb>1)
    NonZeroPorb = 0.8;
end

%set value for args if there is less than 4 values
if(nargin < 4)
    TimeMin = 3;
    TimeMax = 8;
    CostMin = 20;
    CostMax = 90;
end

%make sure TimeMin is not less than zero and TimeMax is bigger than TimeMin
if(TimeMax < TimeMin || TimeMin < 0)
    TimeMin = 3;
    TimeMax = 8;
end

%make sure CostMin is not less than zero and CostMax is bigger than CostMin
if(CostMax < CostMin || CostMin < 0)
    CostMin = 20;
    CostMax = 90;
end

%set which subtasks could be done on wich cities?
rng('default');
mask = rand(NumOfSubTasks, NumOfCities) < NonZeroPorb;

%set time and cost to mask(operatable subtasks)
rng('default');
Times = mask .* round((rand(NumOfSubTasks, NumOfCities) * (TimeMax - TimeMin) + TimeMin));
Times(Times > 8) = 8;

rng('default');
Costs = mask .* (rand(NumOfSubTasks, NumOfCities) * (CostMax - CostMin) + CostMin);
