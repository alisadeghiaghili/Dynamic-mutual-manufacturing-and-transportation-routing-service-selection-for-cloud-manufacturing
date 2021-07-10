function [NewChromosomes] = SinglePointCrossover(Chromosomes)

NumOfChromosomes = size(Chromosomes,1);
NumOfGenes = size(Chromosomes,2);
NumOfCrossovers = floor(NumOfChromosomes / 2);

NewChromosomes = zeros(NumOfChromosomes, NumOfGenes);

for co = 1:NumOfCrossovers
    CrossPoint = ceil(rand(1) * (NumOfGenes-1));
    Parent1 = Chromosomes(co*2-1,:);
    Parent2 = Chromosomes(co*2,:);
    for g=1:CrossPoint
        NewChromosomes(co*2-1,g) = Parent1(1,g);
        NewChromosomes(co*2,g) = Parent2(1,g);
    end
    for g=CrossPoint+1:NumOfGenes
        NewChromosomes(co*2-1,g) = Parent2(1,g);
        NewChromosomes(co*2,g) = Parent1(1,g);
    end
end