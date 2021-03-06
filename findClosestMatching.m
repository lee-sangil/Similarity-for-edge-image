function [leftCost, leftMatched, leftPair] = findClosestMatching(leftImage, rightImage, rightCost, rightMatched, rightPair, Param)

E = Param.E;
D = Param.D;
Z = Param.Z;

leftCost = zeros(size(leftImage));
leftMatched = false(size(leftImage));
leftPair = cell(size(leftImage));

[M, N] = size(leftImage);

for r = 1:M
	for c = 1:N
		if leftImage(r,c) > 0 && isempty(leftPair{r,c})
			d_max = D(1,1);
			
			[subToImage, valid] = advancedRange(rightImage, [r;c], d_max);
			
			if ~any(any(subToImage))
				leftCost(r,c) = 1;
				leftPair{r,c} = [];
				continue;
			end
			
			localCost = 1 - E(D+1) .* ( 1 - abs( subToImage - leftImage(r,c) )/Z );
			
			Dtemp = D;
			Dtemp(valid==0 | subToImage==0) = inf;
			[minColumnD,r_idx_] = min(Dtemp);
			[~,c_idx] = min(minColumnD);
			r_idx = r_idx_(c_idx);
			cost = localCost(r_idx,c_idx);
			
			r_idx = r_idx + r - d_max - 1;
			c_idx = c_idx + c - d_max - 1;
			
			if ~isempty(rightPair{r_idx,c_idx})
				if isequal(rightPair{r_idx,c_idx},[r,c])
					leftCost(r,c) = cost;
					leftPair{r,c} = [r_idx, c_idx];
					
					leftMatched(r,c) = true;
					rightMatched(r_idx,c_idx) = true;
				else
					leftCost(r,c) = 1;
					leftPair{r,c} = [];
				end
			else
				leftCost(r,c) = cost;
				leftPair{r,c} = [r_idx, c_idx];
			end
		end
	end
end