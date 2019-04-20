function similarity = measureCDM(estImage, refImage)

E = [1 0.9 0.69 0.5]; % normalized weighting function
Z = 1; % 1 - binary image, 255 - gray image

% Chess-board distance
dMax = length(E)-1;
[X,Y] = meshgrid(-dMax:dMax, -dMax:dMax);
D = bsxfun(@max, abs(X), abs(Y));

[M, N] = size(estImage);
[M_, N_] = size(refImage);

if M ~= M_ || N ~= N_
	error('Unmatched size!');
end

sumCost = 0;
for r = 1:M
	for c = 1:N
		if estImage(r,c) > 0
			cost = costOfClosest(refImage, estImage, [r,c], E, D, Z);
			sumCost = sumCost + cost;
		end
	end
end

numOfPixels = sum(sum(estImage | refImage));
similarity = 100 * (1 - sumCost/numOfPixels);