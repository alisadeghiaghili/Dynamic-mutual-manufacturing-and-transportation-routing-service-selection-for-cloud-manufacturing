function [NewChromosomes] = OptimalRandomValueMutation(Chromosomes,MutationProb,...
                                           AllowedGeneValues,NumOfAllowedGeneValues)

[NumOfChromosomes, NumOfGenes] = size(Chromosomes);
MutationMask = rand(NumOfChromosomes, NumOfGenes) < MutationProb;
[R,C] = find(MutationMask);
NewChromosomes = Chromosomes;
if(isempty(R))
    return;
end

for i=1:size(R,1)
    if(NumOfAllowedGeneValues(1,C(i)) <= 1)
        continue;
    end
    CurrentVal = Chromosomes(R(i),C(i));
    RandIndex = ceil(rand(1) * (NumOfAllowedGeneValues(1,C(i)) - 1));
    if(AllowedGeneValues(RandIndex,C(i)) == CurrentVal)
        NewChromosomes(R(i),C(i)) = AllowedGeneValues(RandIndex + 1,C(i));
    else
        NewChromosomes(R(i),C(i)) = AllowedGeneValues(RandIndex,C(i));
    end
end
% NumOfChromosomes = size(Chromosomes,1);
% NumOfGenes = size(Chromosomes,2);
% 
% NewChromosomes = Chromosomes;
% 
% for co = 1:NumOfChromosomes
%     for g=1:NumOfGenes
%         if(rand(1)<MutationProb && NumOfAllowedGeneValues(1,g)>1)
%             NewGeneValue = Chromosomes(co,g);
%             while(NewGeneValue == Chromosomes(co,g))
%                 rnd_num = ceil(rand(1)*NumOfAllowedGeneValues(1,g));
%                 NewGeneValue = AllowedGeneValues(rnd_num,g);
%             end
%             NewChromosomes(co,g) = NewGeneValue;
%         end
%     end
% end


