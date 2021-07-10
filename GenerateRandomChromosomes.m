function [Chromosomes] = GenerateRandomChromosomes(NumOfChromosomes, ...
         AllowedGeneValues,NumOfAllowedGeneValues)
% All Genes of all Choromosomes get random values from AllowedGeneValues

%how many genes (task * operation) do we have? 
NumOfGenes = size(NumOfAllowedGeneValues,2);

%make a zero matrix with size of population * number of genes
Chromosomes = zeros(NumOfChromosomes, NumOfGenes);

for ch = 1:NumOfChromosomes
    for g=1:NumOfGenes
        %if this operation subtask is not required just skip it!
        if(NumOfAllowedGeneValues(1,g)==0)
            continue;
        end
        
        %randomly select a city th
        rnd_num = ceil(rand(1)*NumOfAllowedGeneValues(1,g));
        %assign subtask to a city
        Chromosomes(ch,g) = AllowedGeneValues(rnd_num,g);
    end
end