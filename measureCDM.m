function similarity = measureCDM(refImage, estImage)

E = [1 0.9 0.69 0.5]; % normalized weighting function
Z = 1; % 1 - binary image, 255 - gray image

% Chess-board distance
dMax = length(E)-1;
[X,Y] = meshgrid(-dMax:dMax, -dMax:dMax);
D = bsxfun(@max, abs(X), abs(Y));

[M, N] = size(refImage);
[M_, N_] = size(estImage);

if M ~= M_ || N ~= N_
	error('Unmatched size!');
end

Param.E = E;
Param.D = D;
Param.Z = Z;

EstCost = zeros([M,N]);
EstMatched = false([M,N]);
EstPair = cell([M,N]);

[RefCost, RefMatched, RefPair] = findClosestMatching(refImage, estImage, EstCost, EstMatched, EstPair, Param);
[EstCost, EstMatched, EstPair] = findClosestMatching(estImage, refImage, RefCost, RefMatched, RefPair, Param);
[RefCost, RefMatched, RefPair] = findClosestMatching(refImage, estImage, EstCost, EstMatched, EstPair, Param);

similarity = calculateSimilarity(refImage, estImage, RefCost, RefMatched, EstMatched);