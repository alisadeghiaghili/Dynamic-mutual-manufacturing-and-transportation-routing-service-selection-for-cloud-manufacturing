function [NewChromosomes] = UniformCrossover(Chromosomes)

NumOfChromosomes = size(Chromosomes,1);
NumOfGenes = size(Chromosomes,2);
NumOfCrossovers = floor(NumOfChromosomes / 2);

NewChromosomes = zeros(NumOfChromosomes, NumOfGenes);

for co = 1:NumOfCrossovers
    CrossoverMask = round(rand(1,NumOfGenes));
    Parent1 = Chromosomes(co*2-1,:);
    Parent2 = Chromosomes(co*2,:);
    for g=1:NumOfGenes
        if(CrossoverMask(1,g) == 0)
            NewChromosomes(co*2-1,g) = Parent2(1,g);
            NewChromosomes(co*2,g) = Parent1(1,g);
        else
            NewChromosomes(co*2-1,g) = Parent1(1,g);
            NewChromosomes(co*2,g) = Parent2(1,g);
        end
    end
end