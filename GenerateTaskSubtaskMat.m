function [Operations] = GenerateTaskSubtaskMat(NumOfSubTasks, NumOfTasks,SubtaskPorb, FirstRun)

if(SubtaskPorb <= 0 || SubtaskPorb>1)
    SubtaskPorb = 0.7;
end

if (FirstRun)
    %each task should have some subtasks
    %rng('default');
    rng(1);
    %rng(2);
    Operations = rand(NumOfSubTasks, NumOfTasks) < SubtaskPorb;
    
else
    rng('shuffle');
    Operations = rand(NumOfSubTasks, NumOfTasks) < SubtaskPorb;
    
end