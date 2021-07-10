function [NewChromosomes] = NewRandomValueMutation(Chromosomes,MutationProb,...
                                           AllowedGeneValues,NumOfAllowedGeneValues)

NumOfChromosomes = size(Chromosomes,1);
NumOfGenes = size(Chromosomes,2);

NewChromosomes = Chromosomes;

for co = 1:NumOfChromosomes
    for g=1:NumOfGenes
        if(rand(1)<MutationProb && NumOfAllowedGeneValues(1,g)>1)
            NewGeneValue = Chromosomes(co,g);
            while(NewGeneValue == Chromosomes(co,g))
                rnd_num = ceil(rand(1)*NumOfAllowedGeneValues(1,g));
                NewGeneValue = AllowedGeneValues(rnd_num,g);
            end
            NewChromosomes(co,g) = NewGeneValue;
        end
    end
end