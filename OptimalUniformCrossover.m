function [NewChromosomes] = OptimalUniformCrossover(Chromosomes)

[NumOfChromosomes, NumOfGenes] = size(Chromosomes);
CrossoverMask = rand( floor(NumOfChromosomes / 2) , NumOfGenes) > 0.5;

ParentGroup1 = Chromosomes(1:2:NumOfChromosomes,:);
ParentGroup2 = Chromosomes(2:2:NumOfChromosomes,:);

ChildGroup1 = ParentGroup1;
ChildGroup2 = ParentGroup2;

ChildGroup1(CrossoverMask) = ParentGroup2(CrossoverMask);
ChildGroup2(CrossoverMask) = ParentGroup1(CrossoverMask);

NewChromosomes = [ChildGroup1;ChildGroup2];

% [NumOfChromosomes, NumOfGenes] = size(Chromosomes);
% NumOfCrossovers = floor(NumOfChromosomes / 2);
% 
% NewChromosomes = zeros(NumOfChromosomes, NumOfGenes);
% 
% for co = 1:NumOfCrossovers
%     CrossoverMask = rand(1,NumOfGenes) > 0.5;
%     NewChromosomes(co*2-1,CrossoverMask) = Chromosomes(co*2-1,CrossoverMask);
%     NewChromosomes(co*2-1,CrossoverMask) = Chromosomes(co*2,~CrossoverMask);
%     
%     NewChromosomes(co*2,CrossoverMask) = Chromosomes(co*2-1,~CrossoverMask);
%     NewChromosomes(co*2,CrossoverMask) = Chromosomes(co*2,CrossoverMask);
% end