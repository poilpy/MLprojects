function idx = findClosestCentroids(X, centroids)

% Set K
K = size(centroids, 1);

idx = zeros(size(X,1), 1);


for i = 1:size(X,1);
  k = 1;
  minDist = sum((X(i,:) - centroids(1,:)) .^ 2);
  for j = 2:K
    dist = sum((X(i,:) -  centroids(j, :)) .^2);
    if(dist < minDist)
      minDist = dist;
      k = j;
    end
  end
  idx(i) = k;
end

end

