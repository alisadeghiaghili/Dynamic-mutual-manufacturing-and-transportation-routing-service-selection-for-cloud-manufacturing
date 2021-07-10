function [SelectionProbs, AccumulativeProbs] = GenerateRankBasedSelectionProb(FitnessVector,Coef)

SelectionProbs = ones(size(FitnessVector,1),1);
RankOfFitnesses = ones(size(FitnessVector,1),1);
AccumulativeProbs = zeros(size(FitnessVector,1),1);

%Sort fitness vector and keep indexes 
[~,I] = sort(FitnessVector,'descend');
%Calculate rank of fitness
for a = 1:size(FitnessVector,1)
    RankOfFitnesses(I(a,1),1) = a;
end
%
SelectionProbs = SelectionProbs .* (Coef .^ RankOfFitnesses);
SelectionProbs = SelectionProbs / sum(SelectionProbs);

AccumulativeProbs(1,1) = SelectionProbs(1,1);
for a = 2:size(FitnessVector,1)
    AccumulativeProbs(a,1) = AccumulativeProbs(a-1,1) + SelectionProbs(a,1);
end

