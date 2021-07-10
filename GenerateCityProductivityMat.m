function [Productivity] = GenerateCityProductivityMat(NumOfCities, MinProductivity, MaxProductivity)

if(MinProductivity <= 0 || MinProductivity > 1)
    MinProductivity = 0.7;
end

if(MaxProductivity <= 0 || MaxProductivity > 1 || MaxProductivity < MinProductivity)
    MaxProductivity = 1;
end
%set productivity for doing tasks in cities
rng('default');
Productivity = rand(1,NumOfCities) * (MaxProductivity - MinProductivity) + MinProductivity;