%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% Helper Functions declarations  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [FDist, FInd] = ClustDistMembership(MeanColors, FCClusters, FCovs, FWeights)
% CLUSTDISTMEMBERSHIP - Calcuates FG and BG Distances
% Authors - Mohit Gupta, Krishnan Ramnath
% Affiliation - Robotics Institute, CMU, Pittsburgh
% 2006-05-15

NumFClusters = size(FCClusters,2);
numULabels = size(MeanColors,1);

FDist = zeros(numULabels,1);
FInd = zeros(numULabels,1);

Ftmp = zeros(numULabels, NumFClusters);

for k = 1:NumFClusters
    M = FCClusters(:,k);
    CovM = FCovs(:,:,k);
    W = FWeights(1,k);

    V = MeanColors - repmat(M',numULabels,1);
    Ftmp(:,k) = -log((W / sqrt(det(CovM))) * exp(-( sum( ((V * inv(CovM)) .* V),2) /2)));

end



