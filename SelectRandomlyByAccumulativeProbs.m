function [SelectedIndices] = SelectRandomlyByAccumulativeProbs(AccumulativeProbs,N)

SelectedIndices = zeros(N,1);
ProbNum = size(AccumulativeProbs,1);

for a=1:N
    rnd_num = rand(1);
    for b=1:ProbNum
        if(rnd_num<=AccumulativeProbs(b,1))
            SelectedIndices(a,1) = b;
            break;
        end
    end
end